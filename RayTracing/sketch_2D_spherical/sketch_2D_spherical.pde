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
  
  return 1;//sdCircle(sphVec.add(p, pos1), .3);
}

void rayTrace(sphVec p){
  stroke(0,0,0);
  strokeWeight(1);
  int nrays = 100;
  float frac = TAU/nrays;
  for (int i = 0; i<nrays;i++){
    float theta = frac*i;
    sphVec pinit = new sphVec(theta, pos.phi);
    //p2.add(new PVector(250,250));
    float cumul_dist = 0;
    for (int j = 0; j < 10; j++){
      float dist = sdAll(pinit);
      cumul_dist += dist;
      pinit.add(new sphVec(0, dist));
      if (dist < 0 || cumul_dist > PI){
        break;
      }
    }
    sphVec p3 = p.copy();
    p3.add(new sphVec(0, cumul_dist));
    //println(cumul_dist, p3.phi);
    //PVector pini = new PVector( r*sin(pos.phi)*cos(pos.theta), r*sin(pos.phi)*sin(pos.theta), r*cos(pos.phi));
    
    int n_segments = 10;
    float frac_phi = p3.phi/n_segments;
    for (int k = 1; k<n_segments+1;k++){
      float c_phi_prev = frac_phi*(k-1);
      float c_phi = frac_phi*k;
      PVector pini = new PVector( r*sin(c_phi_prev)*cos(theta), r*sin(c_phi_prev)*sin(theta), r*cos(c_phi_prev));
      PVector pfinal = new PVector( r*sin(c_phi)*cos(theta), r*sin(c_phi)*sin(theta), r*cos(c_phi));
      //println(c_phi_prev,c_phi, pini.x);
      line(pini.x,pini.y,pini.z,pfinal.x, pfinal.y, pfinal.z);
    }
    
  }
  pos1.mult(-1);
  PVector circ = sphVec.sph2cart(pos1);
  PVector posvec = sphVec.sph2cart(pos);
  strokeWeight(30);
  stroke(255, 0,0);
  point(circ.x, circ.y, circ.z);
  stroke(0, 255,0);
  point(posvec.x, posvec.y, posvec.z);
  
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
