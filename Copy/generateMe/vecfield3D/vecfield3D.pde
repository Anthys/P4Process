import peasy.*;

ArrayList<PVector> points = new ArrayList<PVector>();
 
// colors used for points
color[] pal = {
  color(0, 91, 197),
  color(0, 180, 252),
  color(23, 249, 255),
  color(223, 147, 0),
  color(248, 190, 0)
};
 
// global configuration
float vector_scale = 0.01; // vector scaling factor, we want small steps
float time = 0; // time passes by
PeasyCam cam;
 
void setup() {
  cam = new PeasyCam(this, width/2, height/2, height/2,200);
  size(800, 800, P3D);
  strokeWeight(5);
  background(0, 5, 25);
  noFill();
  //smooth(8);
 
  // noiseSeed(1111); // sometimes we select one noise field
 
  // create points from [-3,3] range
  float step = 0.5;
  for (float x=-3; x<=3; x+=step) {
    for (float y=-3; y<=3; y+=step) {
      for (float z = -3; z<=3; z += step){
        // create point slightly distorted
        PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003, z+randomGaussian()*0.003);
        points.add(v);
      }
    }
  }
}
 
void draw() {
  background(0,5,25);
  int point_idx = 0; // point index
  for (PVector p : points) {
    // map floating point coordinates to screen coordinates
    float xx = map(p.x, -6.5, 6.5, 0, width);
    float yy = map(p.y, -6.5, 6.5, 0, height);
    float zz = map(p.z, -6.5, 6.5, 0, height);
 
    // select color from palette (index based on noise)
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
    stroke(pal[cn]);
    point(xx, yy, zz); //draw
 
    // placeholder for vector field calculations
 
    // v is vector from the field
    // placeholder for vector field calculations

PVector a = new PVector(p.x, p.y, p.z);
 
PVector v = computeCurl3D(a);
//v.normalize();
 
    p.x += vector_scale * v.x;
    p.y += vector_scale * v.y;
    p.z += vector_scale * v.z;
 
    // go to the next point
    point_idx++;
  }
  time += 0.001;
}

PVector computeCurl(PVector p){
  PVector out = new PVector();
  float eps = 1;
  float n1,n2,a,b;
  float x = p.x;
  float y = p.y;
  n1 = noise(x, y+eps);
  n2 = noise(x, y-eps);
  a = (n1-n2)/(2*eps);
  
  n1 = noise(x+eps,y);
  n2 = noise(x-eps, y);
  b = (n1-n2)/(2*eps);
  
  out = new PVector(a, -b);
  
  return out;
}

PVector computeCurl3D(PVector p){
  PVector out = new PVector();
  float eps = 1;
  float n1,n2,a,b;
  float x = p.x;
  float y = p.y;
  float z = p.z;
  
  n1 = noise(x, y+eps, z);
  n2 = noise(x, y-eps, z);
  a = (n1-n2)/(2*eps);
  
  n1 = noise(x,y, z+eps);
  n2 = noise(x, y, z-eps);
  b = (n1-n2)/(2*eps);
  
  out.x = a-b;
  
  n1 = noise(x,y, z+eps);
  n2 = noise(x, y, z-eps);
  a = (n1-n2)/(2*eps);
  
  
  n1 = noise(x+eps,y, z);
  n2 = noise(x-eps, y, z);
  b = (n1-n2)/(2*eps);
  
  out.y = a-b;
  
  
  n1 = noise(x+eps,y, z);
  n2 = noise(x-eps, y, z);
  a = (n1-n2)/(2*eps);
  
  n1 = noise(x, y+eps, z);
  n2 = noise(x, y-eps, z);
  b = (n1-n2)/(2*eps);
  
  out.z = a-b;
  
  
  return out;
}
