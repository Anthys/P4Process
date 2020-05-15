uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;
uniform vec2 u_resolution;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {
  gl_Position = transform * position;
  float x = position.x/u_resolution.x;
  vec4 r = vec4(x, 0., 0., 1.);
  vertColor = r;
  //vertNormal = normalize(normalMatrix * normal);
  //vertLightDir = -lightNormal;
}