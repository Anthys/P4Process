static float sph_dist(float theta1, float phi1, float theta2, float phi2){
  // theta 0 2PI
  // phi 0 PI
  return acos(sin(phi1-PI/2)*sin(phi2-PI/2)+cos(phi1-PI/2)*cos(phi2-PI/2)*cos(theta2-theta1));
}

static class sphVec{
  float theta = 0; // 0 2PI
  float phi = 0; // 0 PI
  float vtheta = 0.;
  float vphi = 0.;
  
  sphVec(float _theta, float _phi){
   theta = _theta;
   phi = _phi;
  }
  
  float mag(){
    return sph_dist(0,0,theta, phi);
  }
  
  float dist_between(sphVec v2){
    return sph_dist(theta, phi, v2.theta, v2.phi);
  }
  
  void add(sphVec v2){
    theta += v2.theta;
    phi += v2.phi;
  }
  void mult(float a){
    theta *= a;
    phi *= a;
  }
  
  static float dist_between(sphVec v1, sphVec v2){
    return sph_dist(v1.theta, v1.phi, v2.theta, v2.phi);
  }
  
  static sphVec add(sphVec v1, sphVec v2){
    return new sphVec(v1.theta+v2.theta, v1.phi+v1.theta);
  }
  
  sphVec copy(){
    return new sphVec(theta, phi);
  }
  
  static PVector sph2cart(sphVec v){
    float r = 300;
      PVector pini = new PVector( r*sin(v.phi)*cos(v.theta), r*sin(v.phi)*sin(v.theta), r*cos(v.phi));
      return pini;
  }
  
  PVector sph2cart(){
    float r = 300;
      PVector pini = new PVector( r*sin(phi)*cos(theta), r*sin(phi)*sin(theta), r*cos(phi));
      return pini;
  }
}
