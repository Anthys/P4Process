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

//	Simplex 3D Noise 
//	by Ian McEwan, Ashima Arts
//
vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}

float snoise(vec3 v){ 
  const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i  = floor(v + dot(v, C.yyy) );
  vec3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min( g.xyz, l.zxy );
  vec3 i2 = max( g.xyz, l.zxy );

  //  x0 = x0 - 0. + 0.0 * C 
  vec3 x1 = x0 - i1 + 1.0 * C.xxx;
  vec3 x2 = x0 - i2 + 2.0 * C.xxx;
  vec3 x3 = x0 - 1. + 3.0 * C.xxx;

// Permutations
  i = mod(i, 289.0 ); 
  vec4 p = permute( permute( permute( 
             i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0 )) 
           + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

// Gradients
// ( N*N points uniformly over a square, mapped onto an octahedron.)
  float n_ = 1.0/7.0; // N=7
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z *ns.z);  //  mod(p,N*N)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );

  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), 
                                dot(p2,x2), dot(p3,x3) ) );
}



float fbm( in vec2 x, in float H , in int numOctaves)
{   
    float G = exp2(-H);
    float f = 1.0;
    float a = 1.0;
    float t = 0.0;
    for( int i=0; i<numOctaves; i++ )
    {
        t += a*snoise(f*x);
        f *= 2.0;
        a *= G;
    }
    return t;
}

float fbmt( in vec2 x, in float H , in int numOctaves, in float tt)
{   
    float G = exp2(-H);
    float f = 1.0;
    float a = 1.0;
    float t = 0.0;
    for( int i=0; i<numOctaves; i++ )
    {
        t += a*snoise(vec3(f*x.x, f*x.y, tt));
        f *= 2.0;
        a *= G;
    }
    return t;
}

float fbm1(in vec2 x)
{
	return fbm(x,1.,1);
}

float fbmt1(in vec2 x, float t)
{
	return fbmt(x,1.,2, t);
}

float patternA( in vec2 p )
{
    return fbm1( p );
}

float patternB( in vec2 p )
{
    vec2 q = vec2( fbm1( p + vec2(0.0,0.0) ),
                   fbm1( p + vec2(5.2,1.3) ) );

    return fbm1( p + 4.0*q );
}


float patternC( in vec2 p )
{
    vec2 q = vec2( fbm1( p + vec2(0.0,0.0) ),
                   fbm1( p + vec2(5.2,1.3) ) );

    vec2 r = vec2( fbm1( p + 4.0*q + vec2(1.7,9.2) ),
                   fbm1( p + 4.0*q + vec2(8.3,2.8) ) );

    return fbm1( p + 4.0*r );
}

float patternD( in vec2 p , in float tt)
{
    vec2 q = vec2( fbm1( p + vec2(0.0,0.0) ),
                   fbm1( p + vec2(5.2,1.3) ) );

    return fbmt1( p + 4.0*q, tt );
}

float patternE( in vec2 p , in float tt)
{
    vec2 q = vec2( fbmt1( p + vec2(0.0,0.0) ,tt),
                   fbmt1( p + vec2(5.2,1.3) ,tt));

    return fbmt1( p + 4.0*q, tt );
}

float patternF( in vec2 p , in float tt)
{
    vec2 q = vec2( fbmt1( p + vec2(0.0,0.0) ,tt),
                   fbmt1( p + vec2(5.2,1.3) ,tt/50));

    return fbmt1( p + 4.0*q, cos(tt/1000)*10-50 );
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution.xy;
	st.x *= u_resolution.x/u_resolution.y;

	vec3 color = vec3(0.0);

	// Scale the space in order to see the function
	st *= 10.;

	color = vec3(snoise(st)*.5+.5);
	//float a  = fbm(st,1,1);
	float a = patternF(st, u_time);
	color = vec3(a*.5+.5);
	gl_FragColor = vec4(color, 1.);
}