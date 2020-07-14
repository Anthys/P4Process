void setup(){
  size(500,500);
  draw_();
}

void draw(){
}

void keyPressed(){
  draw_();
}

color[] palette = new color[]{#A22B2B,#C98C08,#757ACB,#5CACD3,#E88623,#DB7507};

void draw_(){
  background(200);
  //circle(0,0,40);
  int n_shape = 500;
  for (int i=0;i<n_shape;i++){
    noiseSeed((int)random(300));
    
    float part =(float)i/n_shape;
    
    float xx = part;
    float yy = part*part;
    
    float s0 = part*.5;
    color c0 = palette[(int)random(palette.length)];
    
    if (i>=1){
      float xpre = (float)(i-1)/n_shape;
      float ypre = xpre*xpre;
      PVector dir = new PVector(xx-xpre, yy-ypre);
      PVector normal = new PVector(-dir.y, dir.x);
      float mxdist = 90*sin(part*PI*2);
      float dist = mnoise(i*10)*mxdist;
      s0 = dist/mxdist*.5;
      xx = xx+normal.x*dist;
      yy = yy+normal.y*dist;
    }
    push();
    draw_shape(xx*width,height-yy*height, s0,c0);
    pop();
  }
}

float mnoise(float x, float y){
  return noise(x,y)*2-1;
}

float mnoise(float x){
  return mnoise(x,0);
}

void draw_shape(float x0, float y0){
  draw_shape(x0,y0,1);
}

void draw_shape(float x0, float y0, float s0){
  draw_shape(x0,y0,s0,color(255));
}

void draw_shape(float x0, float y0, float s0,color c0){
  strokeWeight(.1);
  //noStroke();
  translate(x0, y0);
  fill(c0);
  float shearx = random(.5,2);
  float sheary = random(.5,2);
  int n_points = 20;
  PVector[] shape = new PVector[n_points];
  for (int i=0; i<n_points;i++){
    float a = (float)i/n_points*TAU;
    float r = 100;
    r += 100*mnoise(a);
    shape[i] = new PVector(r*cos(a)*shearx*s0, r*sin(a)*sheary*s0);
  }
  
  
  
  beginShape();
  for (int i=0; i<shape.length;i++){
    PVector p = shape[i];
    curveVertex(p.x,p.y);
  }
  curveVertex(shape[0].x,shape[0].y);
  curveVertex(shape[1].x,shape[1].y);
  curveVertex(shape[2].x,shape[2].y);
  
  endShape();
}
