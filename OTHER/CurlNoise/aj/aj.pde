void setup(){
  size(500,500);
  int ne = 10;
  float res = 10;
  for (int i=0; i<width; i+=ne)
  for (int j=0; j<height; j+=ne){
    float x = res*float(i)/width;
    float y = res*float(j)/height;
    color col = color(computeCurl(new PVector(x, y)).y*255);
    stroke(col);
    strokeWeight(ne);
    rect(i, j, ne, ne);
  }
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
