#version 460 core

layout (quads, fractional_odd_spacing, cw) in;

layout (location = 0) in vec2 inUV[];

layout (location = 0) out vec2 outUV;

layout (std430, binding = 1) buffer ssbo {
    mat4 worldMatrix;
    int uvScale;
    int tessFactor;
    float tessSlope;
    float tessShift;
    float displacementScale;
    int highDetailRange;
    float choppiness;
    float kReflection;
    float kRefraction;
    int windowWidth;
    int windowHeight;
    float reflectionBlendFactor;
    vec3 waterColor;
    float fresnelFactor;
    float capillarStrength;
    float capillarDownsampling;
    float dudvDownsampling;
};


void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec4 position =
        ((1 - u) * (1 - v) * gl_in[12].gl_Position +
         u * (1 - v) * gl_in[0].gl_Position +
         u * v * gl_in[3].gl_Position +
         (1 - u) * v * gl_in[15].gl_Position);

    vec2 uv =
        ((1 - u) * (1 - v) * inUV[12] +
         u * (1 - v) * inUV[0] +
         u * v * inUV[3] +
         (1 - u) * v * inUV[15]);

    outUV = uv * uvScale;
    gl_Position = position;
}
