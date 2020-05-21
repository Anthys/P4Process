#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float fraction;
uniform float u_time;
uniform vec2 u_resolution;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;


void main() {
	vec2 st = gl_FragCoord.xy/u_resolution.xy;
	st.x *= u_resolution.x/u_resolution.y;

	vec3 color = vec3(0.6, 0.0824, 0.0824);
	gl_FragColor = vec4(color,0);
}