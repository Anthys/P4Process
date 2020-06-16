float x1,x2,y1,y2;
float A,B,C,D;

ArrayList<PVector> particles;

void setup(){
  size(1000,1000);
  float sq = 5;
  x1 = -2;
  x2 = 2;
  y1 = -2;
  y2 = 2;
  
  if (sq != 0){
    x1 = y1= -sq;
    x2 = y2 = sq;
  }
  particles = new ArrayList<PVector>();
  init();
}

void draw(){
  strokeWeight(2);
  float a = A;
  float b = B;
  float c = C;
  float d = D;
  float e = .01;
  for (int i=0;i<100;i++){
  for (PVector p:particles){
    stroke(0, 100);
    //a = c = sin(p.x);
    //b = d = 1.;
    float x = p.x;
    float y = p.y;
    float xx = sin(a*y)-cos(b*x);
    float yy = sin(c*x)-cos(d*y);
    x = xx;//lerp(x,xx,e) ;
    y = yy;//lerp(y,yy, e);
    p.x = x;
    p.y = y;
    xx = map(x, x1+2, x2-2, 0, width);
    yy = map(y, y1+2, y2-2, 0, height);
    point(xx,yy);
  }}
}


void init(){
  
  
  A = random(-3,3);
  B = random(-3,3);
  C = random(-3,3);
  D = random(-3,3);
  A = 1.641;
  B = 1.902;
  C = 0.316;
  D = 1.525;
  
  A = 1.4;
  B = -2.3;
  C = 2.4;
  D = -2.1;
  
  particles.clear();
  float n = 1000;
  background(200);
  for (int i = 0; i < n; i++){
    particles.add(new PVector(random(x1,x2) ,random(y1,y2)));
  }
    particles.set(0, new PVector(0,0));
}

void keyPressed(){
  if (keyCode == 32){
  init();
}
  
}
