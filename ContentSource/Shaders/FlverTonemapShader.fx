﻿#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_5_0
	#define PS_SHADERMODEL ps_5_0
#endif

Texture2D SpriteTexture;

sampler2D SpriteTextureSampler = sampler_state
{
	Texture = <SpriteTexture>;
};

float Epsilon = 0.0000001;

struct VertexShaderOutput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
	float2 TextureCoordinates : TEXCOORD0;
};

float4 MainPS(VertexShaderOutput input) : COLOR
{
    float4 color = tex2D(SpriteTextureSampler,input.TextureCoordinates);
    //color /= color * 0.25 + 1.0;
    //color *= 1.25 / (color + 1.0);
    
    //color *= 4;
    
    color = float4(saturate(float3(1,1,1) - exp2(max(color.rgb, Epsilon) * -1.44269502)), 1);
    
    //color = float4(pow(color.rgb, 2.2), 1);
    
    //float A = 0.30; // Shoulder strength 
    //float B = 0.50; // Linear strength
    //float C = 0.10; // Linear angle
    //float D = 0.20; // Toe strength
    //float E = 0.02; // Toe numerator
    //float F = 0.30; // Toe denominator
    //color.a = 4;
    //color = ((color * (A * color + C * B) + D * E) / (color * (A * Color + B) + D * F)) - (E / F);
    //color.rgb *= 1.0 / color.a;
    
    //color = sqrt(color);
    
	return float4(color.rgb, 1);
}

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};