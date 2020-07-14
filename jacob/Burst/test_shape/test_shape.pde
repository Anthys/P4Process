void setup(){
  size(500,500);
  draw_();
}

void draw(){
}

void keyPressed(){
  draw_();
}

void draw_(){
  background(200);
  noiseSeed((int)random(100));
  circle(0,0,40);
  push();
  draw_shape();
  pop();
}

float mnoise(float x, float y){
  return noise(x,y)*2-1;
}

float mnoise(float x){
  return mnoise(x,0);
}

void draw_shape(){
  strokeWeight(5);
  translate(width/2, height/2);
  float shearx = random(.5,2);
  float sheary = random(.5,2);
  int n_points = 20;
  PVector[] shape = new PVector[n_points];
  beginShape();
  for (int i=0; i<n_points;i++){
    float a = (float)i/n_points*TAU;
    float r = 100;
    r += 100*mnoise(a);
    shape[i] = new PVector(r*cos(a)*shearx, r*sin(a)*sheary);
  }
  
  
  
  for (int i=0; i<shape.length;i++){
    PVector p = shape[i];
    curveVertex(p.x,p.y);
  }
  curveVertex(shape[0].x,shape[0].y);
  curveVertex(shape[1].x,shape[1].y);
  curveVertex(shape[2].x,shape[2].y);
  
  endShape();
}
