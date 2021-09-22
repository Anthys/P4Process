void setup(){
  size(1000,1000);
}

float R = 90;
void draw(){
  for (int i = 0;i<10000;i++){
    random_point_sphere(width/5, height/2);
    random_point_sphereB(width/5*2, height/2);
    random_point_sphereC(width/5*3, height/2);
    random_point_sphereD(width/5*4, height/2);
    random_point_sphereE(width/5, height/2+R*2+50);
  }
  noLoop();
}

void random_point_sphere(float x0,float y0){
  float a = random(TAU);
  float r = random(1)*R;
  point(x0+r*cos(a), y0+r*sin(a));
}
void random_point_sphereB(float x0,float y0){
  float u = random(1)+random(1);
  float a = random(TAU);
  float r = u>1?2-u:u;
  point(x0+R*r*cos(a), y0+R*r*sin(a));
}
void random_point_sphereC(float x0,float y0){
  float a = random(TAU);
  float r = sqrt(random(1));
  r = R*r;
  point(x0+r*cos(a), y0+r*sin(a));
}
void random_point_sphereD(float x0,float y0){
  float a = random(TAU);
  float r = pow(random(1), .1);
  r = R*r;
  point(x0+r*cos(a), y0+r*sin(a));
}
void random_point_sphereE(float x0,float y0){
  float a = TAU*random(1);
  float r = pow(random(1), .1)*a/TAU;
  r = R*r;
  point(x0+r*cos(a), y0+r*sin(a));
}
