float x1,x2,y1,y2;
float A,B,C,D;
int cstate;

ArrayList<Particle> particles;

class Particle{
  PVector pos;
   color c;
  
  Particle(float x, float y, color c_){
  pos = new PVector(x, y);
  c = c_;
  }
}

void setup(){
  size(1000,1000);
  cstate = 0;
  float sq = 5;
  x1 = -2;
  x2 = 2;
  y1 = -2;
  y2 = 2;
  
  if (sq != 0){
    x1 = y1= -sq;
    x2 = y2 = sq;
  }
  particles = new ArrayList<Particle>();
  init();
}

void draw(){
  strokeWeight(2);
  float a = A;
  float b = B;
  float c = C;
  float d = D;
  float e = .005;
  for (int i=0;i<1;i++){
  for (Particle p:particles){
    //a = c = sin(p.x);
    //b = d = 1.;
    stroke(p.c);
    float x = p.pos.x;
    float y = p.pos.y;
    float xx = sin(a*y)-cos(b*x);
    float yy = sin(c*x)-cos(d*y);
    x = lerp(x,xx,e) ;
    y = lerp(y,yy, e);
    p.pos.x = x;
    p.pos.y = y;
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
  /*A = 1.641;
  B = 1.902;
  C = 0.316;
  D = 1.525;
  
  A = 1.4;
  B = -2.3;
  C = 2.4;
  D = -2.1;
  */
  particles.clear();
  float n = 5000;
  float ccc = (cstate==0)?0:255;
  stroke(ccc, 100);
  //background(200);
  for (int i = 0; i < n; i++){
    float x = random(x1,x2);
    float y = random(y1,y2);
    float res = 4;
    float vv = noise((x-x1)/(x2-x1)*res, res*(y-y1)/(y2-y1));
    color c = color(vv*255, 100, 200, 10);
    particles.add(new Particle(x,y, c));
  }
    //color c = color(0);
    //particles.set(0, new Particle(random(x1,x2) ,random(y1,y2), c));
}

void keyPressed(){
  if (keyCode == 32){
    cstate = (cstate+1)%2;
    init();
}
  
}
