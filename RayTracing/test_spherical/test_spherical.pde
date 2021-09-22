void setup(){
  size(1000,1000);
}

float sph_dist(float theta1, float phi1, float theta2, float phi2){
  // theta 0 2PI
  // phi 0 PI
  return acos(sin(theta1)*sin(theta2)+cos(theta1)*cos(theta2)*cos(phi2-phi1));
}


void draw(){
  translate(500,500);
 draw_1();
 noLoop();
}

void draw_1(){
  float r = 400;
  int npoints =100;
  float frac = TAU/npoints;
  for (int i=0; i<npoints; i++){
    float theta = frac*i;
    float phi = 0;
    float dis = sph_dist(0,0, theta, 0);
    dis = dis/4. * 255;
    println(dis);
    stroke(dis, 0,0);
    strokeWeight(15);
    point(r*cos(theta), r*sin(theta));
  }
}
