static class variations2t2{
  

// FROM
// The Fractal Flame Algorithm
// Scott Draves
// Spotworks, NYC, USA
// Erik Reckase
// Berthoud, CO, USA
// September 2003, Last revised November 2008

static PVector linear(PVector p, float rotation, float size){
    PVector p2 = new PVector(size*p.x, size*p.y);
    p2.rotate(rotation);
    return p2;
}

static PVector sinusoidal(PVector p) {
  return new PVector(sin(p.x), sin(p.y));
}

static PVector spherical(PVector p){
    float r = p.mag();
    return new PVector(p.x, p.y).mult(1/(r*r));
}

static PVector polar(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(theta/PI, r-1);
}
  
}
