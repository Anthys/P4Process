const float Air = 1.0;
const float Glass = 1.51714;

const float Eta = Air / Glass;

const float R0 = ((Air - Glass) * (Air - Glass)) / ((Air + Glass) * (Air + Glass));

uniform mat4 transform;
uniform mat4 modelview;
uniform mat3 normalMatrix;

attribute vec4 vertex;
attribute vec3 normal;

varying vec3 v_reflection;
varying vec3 v_refraction;
varying float v_fresnel;

void main(void){

    vec4 t_vertex = modelview * vertex;

    vec3 incident = normalize(vec3(t_vertex));

    vec3 t_normal = normalMatrix * normal;

    v_refraction = refract(incident, t_normal, Eta);
    v_reflection = reflect(incident, t_normal);

    v_fresnel = R0 + (1.0 - R0) * pow((1.0 - dot(-incident, t_normal)), 5.0);

    gl_Position = transform * t_vertex;
}