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
  translate(width/2, height/2); // Center the scene
  u_time += 1;
  pos.add(vos); // Add the shift of the sphere
  vos.mult(.9); // Decrease the shifting, makes the smooth effect
  background(204);
  rayTrace(pos);
}

float sphdist(PVector a, PVector b){
  return acos(a.dot(b));
}

float sdAllSph(sphVec p){
  
  //sphVec posAA = new sphVec(PI/2,PI/2);
  sphVec posAA = new sphVec(0,0);
  sphVec pos = p.copy();
  
  float radius = .5;
  return pos.distTo(posAA)-radius;
}

float sdAll(PVector p){
  
  sphVec posA1 = new sphVec(PI/2,PI/2);
  sphVec posA2 = new sphVec(0,0);
  
  PVector pos1 = sphVec.sph2cart(posA1);
  PVector pos2 = sphVec.sph2cart(posA2);
  pos1.mult(1/pos1.mag());
  pos2.mult(1/pos2.mag());
  
  PVector pos = p.copy();
  pos.mult(1/pos.mag());
  
  float radius = .5;
  //return TAU;
  float d1 = sphdist(pos, pos1)-radius;
  float d2 = sphdist(pos, pos2)-radius;
  //return TAU;
  return min(d1, d2);
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
    cumul_dist /= TAU;
    float rmax  = r*cumul_dist;
    line(0, 0, cos(theta)*rmax, sin(theta)*rmax);
    stroke(0);
    
    
    strokeWeight(cumul_dist/TAU*5);
    
    
  }
  strokeWeight(30);
  stroke(255, 0,0);
  point(0,0);
  stroke(0, 255,0);
  float distTo0 = pos.mag()/PI*r;
  //point(dir1.x*distTo0, dir1.y*distTo0);
  
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
