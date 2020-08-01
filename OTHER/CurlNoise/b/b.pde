ParticleGroup part;

void setup(){
  size(500,500);
  part = new ParticleGroup(100);
}

void draw(){
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
