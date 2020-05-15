#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform samplerCube cubemap;

varying vec3 v_refraction;
varying vec3 v_reflection;
varying float v_fresnel;

void main(void){
    vec4 refractionColor = textureCube(cubemap, normalize(v_refraction));
    vec4 reflectionColor = textureCube(cubemap, normalize(v_reflection));

    gl_FragColor = mix(refractionColor, reflectionColor, v_fresnel);
}