import peasy.*;

PeasyCam cam;

ArrayList<PVector> particles;

void setup(){
  size(1000,1000, P3D);
  particles = new ArrayList<PVector>();
  init();
  cam = new PeasyCam(this, 600);
}

void draw(){
  rotateX(90);
  rotateY(90);
  background(200);
  draw_();
  saveFrame("out/out-####.tif");
}

void draw_(){
  float res = 5;
  for (PVector p:particles){
    PVector pos = p.copy();
    PVector dir = pos.copy().normalize();
    float noi = noise(dir.x*res, res*dir.y, res*dir.z+float(frameCount)/10);
    noi = noise((dir.x+500)*res, res*(dir.z+500), res*(dir.y+500)+float(frameCount)/10);
    //stroke(noi*255, 100, 200 + noi*50);
    strokeWeight(noi*5);
    pos.add(dir.mult(100*noi));
    //pos.add(dir.mult(10*randomGaussian()));
    point(pos.x, pos.y, pos.z);
  }
}


void init(){
  float poww = 1;
  strokeWeight(3);
  int n = 100000;
  float r = 200;
  float fract = (1+sqrt(5))/2;
  for (int j =0; j <n;j++){
    float tt = pow(float(j)/(n-1.), poww);
    float inclination = acos(1-2*tt);
    float azimuth = 2*PI*fract*j;
    float x = r*sin(inclination)*cos(azimuth);
    float y = r*sin(inclination)*sin(azimuth);
    float z = r*cos(inclination);
    PVector p = new PVector(x, y, z);
    particles.add(p);
  }
}
    
    
