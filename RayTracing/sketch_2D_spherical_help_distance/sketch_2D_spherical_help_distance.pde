import peasy.*;

PeasyCam cam;


void setup(){
  size(1000,1000, P3D);
  cam = new PeasyCam(this, 400);
  //cam.setMinimumDistance(50);
  //cam.setMaximumDistance(500);
}


float r = 300;
sphVec pos = new sphVec(0,0);
sphVec vos = new sphVec(0,0);
int u_time = 0;
void draw(){
  u_time += 1;
  
  //translate(500,500);
  //rotateZ(float(u_time)/50);
  //rotateY(float(u_time)/100);
  pos.add(vos);
  vos.mult(.9);
  background(204);
  rayTrace(pos);
}
sphVec pos1 = new sphVec(PI/2, PI/2);

float sdAll(sphVec p){
  sphVec pos1 = new sphVec(PI/2, PI/2);
  sphVec pos2 = new sphVec(-250, 250);
  sphVec pos3 = new sphVec(-250, -250);
  sphVec pos4 = new sphVec(250, -250);
  sphVec pos5 = new sphVec(300, 0);
  
  return sdCircle(sphVec.add(p, pos1), .3);
}

void rayTrace(sphVec p){
  stroke(0,0,0);
  strokeWeight(15);
  int ntheta  = 100;
  int nphi = 100;
  float phifrac = PI/nphi;
  float thetafrac = TAU/ntheta;
  for (int i = 0; i<ntheta;i++)
  for (int j = 0; j<nphi;j++){
    float theta = thetafrac*i;
    float phi = phifrac*j;
    sphVec sph = new sphVec(theta, phi);
    PVector vec = sphVec.sph2cart(sph);
    float val = sph_dist(0,0,theta,phi)/4*255;
    stroke(val);
    point(vec.x, vec.y, vec.z);
  }
  
}


float factor_key_pressed = .1;
void keyPressed(){
  if (key == 'n'){
    pos.theta += PI/2;
  }
  if (key == 'b'){
    pos.phi += PI/2;
  }
  if (keyCode == DOWN){
    vos.theta += 1*factor_key_pressed;
  }
  if (keyCode == UP){
    vos.theta -= 1*factor_key_pressed;
  }
  if (keyCode == RIGHT){
    vos.phi += 1*factor_key_pressed;
  }
  if (keyCode == LEFT){
    vos.phi -= 1*factor_key_pressed;
  }
}
