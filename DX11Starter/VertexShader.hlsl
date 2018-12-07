cbuffer externalData : register(b0)
{
	matrix world;
	matrix view;
	matrix projection;
};

struct VertexShaderInput
{ 
	float3 position		: POSITION;
	float2 uv			: TEXCOORD;
	float3 normal		: NOMRAL;
	float3 tangent		: TANGENT;
};

struct VertexToPixel
{
	float4 position		: SV_POSITION;
	float3 normal		: NORMAL;
	float3 tangent		: TANGENT;
	float3 worldPos		: POSITION;
	float3 uv			: TEXCOORD;
};

VertexToPixel main( VertexShaderInput input )
{
	// Set up output struct
	VertexToPixel output;

	matrix worldViewProj = mul(mul(world, view), projection);
	output.position = mul(float4(input.position, 1.0f), worldViewProj);

	// Get the normal to the pixel shader
	output.normal = mul(input.normal, (float3x3)world);
	output.tanget = mul(input.tangent, (float3x3)world);

	// Get world position of vertex
	output.worldPos = mul(float4(input.position, 1.0f), world).xyz;

	// Pass through the uv
	output.uv = input.uv;

	return output;
}