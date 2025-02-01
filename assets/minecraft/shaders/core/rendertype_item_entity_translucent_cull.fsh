#version 150

#moj_import <minecraft:fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    if (color.a < 0.1) {
        discard;
    }

    //so if opacity is exactly 254, skip the shading
    if (int(color.a * 255.0 + 0.5) != 254.){
        color *= vertexColor * ColorModulator;
    }

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}