#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float fraction;
uniform float u_time;
uniform vec2 u_resolution;

uniform sampler2D texture;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;


void main() {
	vec2 uv = gl_FragCoord.xy/u_resolution.xy;
	uv.x *= u_resolution.x/u_resolution.y;

	vec3 color = vec3(0.6, 0.0824, 0.0824);
    float seuil = .2;
    vec2 dir  = uv-vec2(.5, .5);
    float dist = length(dir);
    if (dist < seuil){
        uv = vec2(.5, .5)-dir;
    }
	gl_FragColor = texture2D(texture, uv);
}