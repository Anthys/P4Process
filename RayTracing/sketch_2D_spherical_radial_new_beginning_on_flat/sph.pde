static float sphericalDistance(float theta1, float phi1, float theta2, float phi2){
  // theta 0 2PI
  // phi 0 PI
  return acos(sin(phi1-PI/2)*sin(phi2-PI/2)+cos(phi1-PI/2)*cos(phi2-PI/2)*cos(theta2-theta1));
}


static class sphVec{
  float r = 300;
  float theta = 0; // 0 2PI
  float phi = 0; // 0 PI
  float vtheta = 0.;
  float vphi = 0.;
  float vr = 0.;

  sphVec(float _r, float _theta, float _phi){
    r = _r;
    theta = _theta;
    phi = _phi;
  }
  
  sphVec(float _theta, float _phi){
    theta = _theta;
    phi = _phi;
  }
  
  float mag(){
    return sphericalDistance(0,0,theta, phi);
  }
  
  float distTo(sphVec v2){
    return sphericalDistance(theta, phi, v2.theta, v2.phi);
  }
  
  void add(sphVec v2){
    theta += v2.theta;
    phi += v2.phi;
  }
  void mult(float a){
    theta *= a;
    phi *= a;
  }
  
  static float distBetween(sphVec v1, sphVec v2){
    return sphericalDistance(v1.theta, v1.phi, v2.theta, v2.phi);
  }
  
  static sphVec add(sphVec v1, sphVec v2){
    return new sphVec(v1.theta+v2.theta, v1.phi+v1.theta);
  }
  
  sphVec copy(){
    return new sphVec(r, theta, phi);
  }
  
  static PVector sph2cart(sphVec v){
      PVector pini = new PVector( v.r*sin(v.phi)*cos(v.theta), v.r*sin(v.phi)*sin(v.theta), v.r*cos(v.phi));
      return pini;
  }
  
  PVector sph2cart(){
      PVector pini = sph2cart(this);
      return pini;
  }
}
