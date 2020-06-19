precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D u_texture_0;

#define MARCHINGITERATIONS 64

#define MARCHINGSTEP 0.5
#define SMALLESTSTEP 0.1

#define DISTANCE 3.0

#define MAXMANDELBROTDIST 1.5
#define MANDELBROTSTEPS 64

// cosine based palette, 4 vec3 params
vec3 cosineColor( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}
vec3 palette (float t) {
    return cosineColor( t, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(0.01,0.01,0.01),vec3(0.00, 0.15, 0.20) );
}

// distance estimator to a mandelbulb set
// returns the distance to the set on the x coordinate 
// and the color on the y coordinate
vec2 DE(vec3 pos) {
    float Power = 8.0;//+4.0*(sin(iTime/30.0)+1.0);
	vec3 z = pos;
	float dr = 1.0;
	float r = 0.0;
	for (int i = 0; i < MANDELBROTSTEPS ; i++) {
		r = length(z);
		if (r>MAXMANDELBROTDIST) break;
		
		// convert to polar coordinates
		float theta = acos(z.z/r);
		float phi = atan(z.y,z.x);
		dr =  pow( r, Power-1.0)*Power*dr + 1.0;
		
		// scale and rotate the point
		float zr = pow( r,Power);
		theta = theta*Power;
		phi = phi*Power;
		
		// convert back to cartesian coordinates
		z = zr*vec3(sin(theta)*cos(phi), sin(phi)*sin(theta), cos(theta));
		z+=pos;
	}
	return vec2(0.5*log(r)*r/dr,50.0*pow(dr,0.128/float(MARCHINGITERATIONS)));
}

// MAPPING FUNCTION ... 
// returns the distance of the nearest object in the direction p on the x coordinate 
// and the color on the y coordinate
vec2 map( in vec3 p )
{
    //p = fract(p); 
   	vec2 d = DE(p);

  

   	return d;
}


// TRACING A PATH : 
// measuring the distance to the nearest object on the x coordinate
// and returning the color index on the y coordinate
vec2 trace  (vec3 origin, vec3 ray) {
	
    //t is the point at which we are in the measuring of the distance
    float t =0.0;
    float c = 0.0;
    
    for (int i=0; i<MARCHINGITERATIONS; i++) {
    	vec3 path = origin + ray * t;	
    	vec2 dist = map(path);
    	// we want t to be as large as possible at each step but not too big to induce artifacts
        t += MARCHINGSTEP * dist.x;
        c += dist.y;
        if (dist.y < SMALLESTSTEP) break;
    }
    
    return vec2(t,c);
}

void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy/u_resolution.xy;
	// Pixel coordinates from -1 to 1
    uv = uv * 2.0 - 1.0;
    // Adjusting aspect ratio
    uv.x *= u_resolution.x / u_resolution.y;
    
    //ray direction (camera is at (0,0,0), view plane is at 0,0,1)
    vec3 ray = normalize(vec3 (uv,1.0));

    //ROTATING THE CAMERA (rotating the ray)
    float rotAngle = 0.4+u_time/40.0 + 6.28*u_mouse.x / u_resolution.x;
    //rotation matrix around the y axis
    ray.xz *= mat2(cos(rotAngle), -sin(rotAngle), sin(rotAngle), cos(rotAngle));
    
    //camera position (rays origin)
    float camDist = DISTANCE * u_mouse.y / u_resolution.y;
    if (u_mouse.xy==vec2(0)) camDist = DISTANCE*0.55;
    vec3 origin = vec3 (camDist * sin(rotAngle),0.0,-camDist *cos(rotAngle));           
    
    //tracing the ray (getting the distance of the closest object in the ray direction)
	vec2 depth = trace(origin,ray);
	
    //rendering with a fog calculation (further is darker)
	float fog = 1.0 / (1.0 + depth.x * depth.x * 0.1);
	
    //frag color
    vec3 fc = vec3(fog);
    
    
    // Output to screen
    //gl_FragColor = vec4(palette(depth.y)*fog,0.0);
    gl_FragColor = vec4(palette(depth.y)*fog,1.0);
}