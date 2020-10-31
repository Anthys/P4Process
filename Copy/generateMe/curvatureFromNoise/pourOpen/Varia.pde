
static class variations{
  

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



// UTILS


static float log10 (float x) {
  return (log(x) / log(10));
}
static final float cosh(float x) { return 0.5 * (exp(x) + exp(-x));}
static final float sinh(float x) { return 0.5 * (exp(x) - exp(-x));}

}
