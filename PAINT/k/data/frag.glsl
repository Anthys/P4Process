#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float fraction;
uniform float u_time;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {
	vec4 r = vec4(1.0,0.0,0.0,1.0);
	gl_FragColor = vertColor;//vec4(abs(sin(u_time)),0.0,0.0,1.0);
}