
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;


uniform vec2 central;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D u_texture_4;

vec3 permute(vec3 x) { return mod(((x*34.0)+1.0)*x, 289.0); }

float snoise(vec2 v){
  const vec4 C = vec4(0.211324865405187, 0.366025403784439,
           -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod(i, 289.0);
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
  + i.x + vec3(0.0, i1.x, 1.0 ));
  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy),
    dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}

void main(){
  vec4 coord = vec4(gl_FragCoord.x, gl_FragCoord.y, gl_FragCoord.z, gl_FragCoord[3]);
  vec2 uv = gl_FragCoord.xy/u_resolution.xy;
  vec2 uvc = central/u_resolution.xy;
  vec2 block = uv/50.;
  float dist = length(uv-uvc);
  float t = floor(u_time/.051);
  float r = snoise(vec2(t*2005., block.y*2000.));
  float r2 = snoise(vec2(t*2005., block.y*1.));
  float r3 = snoise(vec2(t*2005., block.y*4000.));
  r = step(r,-0.6);
  vec2 middle = (vec2(.5,.5)+uvc)/2.;
  float d1 = length(vec2(.5,.5)-uv);
  float d2 = length(uvc-uv);
  float inter = (d1*d2)*10.;

  vec4 col = vec4(r,r,r,1.);
  vec2 dir2 = (uv-uvc);
  vec2 dir = (vec2(.5,.5)-uv);
  float distc = length(dir);
  float sn = snoise(uv/10.)/10.*dist*distc;
  float d = step(dist, .1);
  d = step(inter, .1);
  d = inter;
  //uv = uv +.5*r2*vec2(r,0.)*( -1.*( d-1. ) ) + d*(-uv+dir2+vec2(.5,.5));
  gl_FragColor = texture2D(texture, uv);
  //gl_FragColor = vec4(1.);
}

