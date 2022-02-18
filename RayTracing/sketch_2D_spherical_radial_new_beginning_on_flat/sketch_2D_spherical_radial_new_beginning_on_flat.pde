import peasy.*;

PeasyCam cam;


void setup(){
  size(1000,1000);
}


float r = 300;
sphVec pos = new sphVec(PI/2,PI/2);
sphVec vos = new sphVec(0,0); // Shift of the sphere
int u_time = 0;

void draw(){
  translate(width/2, height/2);
  u_time += 1;
  pos.add(vos);
  vos.mult(.9);
  background(204);
  rayTrace(pos);
}

float sphdist(PVector a, PVector b){
  return acos(a.dot(b));
}

float sdAll(PVector p){
  
  sphVec posAA = new sphVec(PI/2,PI/2);
  //PVector posA = new PVector(0,0,300);
  PVector posA = sphVec.sph2cart(posAA);
  posA.mult(1/posA.mag());
  
  PVector pos = p.copy();
  pos.mult(1/pos.mag());
  
  float radius = .5;
  //return TAU;
  return sphdist(pos, posA)-radius;
}

void rayTrace(sphVec p){
  stroke(0,0,0);
  strokeWeight(1);
  int nrays = 100;
  float frac = TAU/nrays;
  
  PVector pos_cart = pos.sph2cart();
  PVector dir1 = new PVector(cos(pos.phi)*cos(pos.theta), cos(pos.phi)*sin(pos.theta), -sin(pos.phi)); //Basis for the normal space to the sphere at point pos_cart
  PVector dir2 = new PVector(-sin(pos.phi)*sin(pos.theta), sin(pos.phi)*cos(pos.theta), 0);
  dir2 = dir1.cross(pos_cart);
  dir1 = dir1.mult(1.0/dir1.mag());
  dir2 = dir2.mult(1.0/dir2.mag());
    
  float f = 60;
  stroke(200,200,0);
  strokeWeight(10);
  //line(pos_cart.x,pos_cart.y,pos_cart.z,pos_cart.x+dir1.x*f, pos_cart.y+dir1.y*f, pos_cart.z+dir1.z*f);
  //line(pos_cart.x,pos_cart.y,pos_cart.z,pos_cart.x+dir2.x*f, pos_cart.y+dir2.y*f, pos_cart.z+dir2.z*f);
  strokeWeight(1);
  
  for (int i = 0; i<nrays;i++){
    float theta = frac*i;
    PVector dir = PVector.add( PVector.mult(dir1, cos(theta)), PVector.mult(dir2, sin(theta)));
    dir.mult(r/dir.mag());
    
    PVector probe = pos_cart.copy();
    
    float cumul_dist = 0;
    for (int j = 0; j < 10; j++){
      float dist = sdAll(probe);
      cumul_dist += dist;
      probe = (PVector.add(PVector.mult(pos_cart, cos(cumul_dist)), PVector.mult(dir, sin(cumul_dist))));
      strokeWeight(10);
      stroke(255-j*25, 0,0);
      //point(probe.x, probe.y, probe.z);
      strokeWeight(1);
      if (dist < 0 || cumul_dist > TAU){
        break;
      }
    }
    if (cumul_dist <=0){
      continue;
    }
    sphVec p3 = p.copy();
    p3.add(new sphVec(0, cumul_dist));
    
    stroke(0,0,255);
    cumul_dist = min(cumul_dist, TAU);
    float rmax  = 50*cumul_dist;
    line(0, 0, cos(theta)*rmax, sin(theta)*rmax);
    //line(pos_cart.x,pos_cart.y,pos_cart.z,pos_cart.x+dir.x*f, pos_cart.y+dir.y*f, pos_cart.z+dir.z*f);
    stroke(0);
    
    strokeWeight(cumul_dist/TAU*5);
    
    int n_segments = 10;
    float frac_dist = cumul_dist/n_segments;
    for (int k = 1; k<n_segments+1;k++){
      float c_dist_prev = frac_dist*(k-1);
      float c_dist = frac_dist*k;
      PVector pini = PVector.add(PVector.mult(pos_cart, cos(c_dist_prev)), PVector.mult(dir, sin(c_dist_prev)));
      PVector pfinal = PVector.add(PVector.mult(pos_cart, cos(c_dist)), PVector.mult(dir, sin(c_dist)));
      //println(pos_cart, dir, pini, pfinal);
      //println(c_phi_prev,c_phi, pini.x);
      //line(pini.x,pini.y,pini.z,pfinal.x, pfinal.y, pfinal.z);
      //point(pfinal.x, pfinal.y, pfinal.z);
    }
    
  }
  PVector posvec = sphVec.sph2cart(pos);
  strokeWeight(30);
  stroke(255, 0,0);
  point(0,0);
  stroke(0, 255,0);
  //point(posvec.x, posvec.y, posvec.z);
  
}


float factor_key_pressed = .01;
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
  if (key == 'p'){
    println(pos.theta, pos.phi);
  }
}
