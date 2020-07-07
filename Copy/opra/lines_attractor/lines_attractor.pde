float t, x, y, a;
void setup(){
  size(1000,1000);
  init();
  draw_();
}

void init(){
  t = 1 ;
  x = width/2+random(-100,100);
  y = height/2+random(-100,100);
  a = random(TAU);
}

void draw_(){
  background(200);
  
  float aa = a;
  int n = 2000 ;
  float r = 3;
  float xx = x;
  float yy = y;
  float aspeed = 0.01;
  for (int i = 0; i < n; i++){
    xx += sin(aa)*r;
    yy += cos(aa)*r;
    aa += aspeed;
    aspeed += .0001;//+t*.0001;
    point(xx,yy);
  }
}


void draw(){
  t += .1;
  draw_();
}

void keyPressed(){
  init();
  draw_();
}
