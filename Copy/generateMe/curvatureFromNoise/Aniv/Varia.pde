import java.util.function.Consumer;

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

    interface Transform {
        PVector apply(PVector p);
    }

    static private Transform[] transforms = new Transform[] {
        new Transform() { public PVector apply(PVector p) {return sinusoidal(p); } },
        new Transform() { public PVector apply(PVector p) {return spherical(p); }  },
        new Transform() { public PVector apply(PVector p) {return swirl(p); } },
        new Transform() { public PVector apply(PVector p) {return horseshoe(p); } },
        new Transform() { public PVector apply(PVector p) {return polar(p); } },
        new Transform() { public PVector apply(PVector p) {return handkerchief(p); } },
        new Transform() { public PVector apply(PVector p) {return heart(p); } },
        new Transform() { public PVector apply(PVector p) {return disc(p); } },
        new Transform() { public PVector apply(PVector p) {return spiral(p); } },
        new Transform() { public PVector apply(PVector p) {return hyperbolic(p); } },
        new Transform() { public PVector apply(PVector p) {return diamond(p); } },
        new Transform() { public PVector apply(PVector p) {return ex(p); } },
        new Transform() { public PVector apply(PVector p) {return julia(p); } },
        new Transform() { public PVector apply(PVector p) {return bent(p); } },
        new Transform() { public PVector apply(PVector p) {return waves(p); } },
        new Transform() { public PVector apply(PVector p) {return fisheye(p); } },
        new Transform() { public PVector apply(PVector p) {return exponential(p); } },
        new Transform() { public PVector apply(PVector p) {return power(p); } },
        new Transform() { public PVector apply(PVector p) {return cosine(p); } },
    };

static PVector lerandom(PVector p){
  int n = transforms.length;
  int a = (int) utils.random(0,n);
  println(a);
  return transforms[a].apply(p);
}

static PVector spherical(PVector p){
    float r = p.mag();
    return new PVector(p.x, p.y).mult(1/(r*r));
}

static PVector swirl(PVector p){
    float r = p.mag();
    return new PVector(p.x*sin(r*r)-p.y*cos(r*r), p.x*cos(r*r)+p.y*sin(r*r));
}

static PVector horseshoe(PVector p){
    float r = p.mag();
    return new PVector((p.x-p.y)*(p.x+p.y), 2*p.x*p.y).mult(1/r);
}

static PVector polar(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(theta/PI, r-1);
}

static PVector handkerchief(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta+r), cos(theta-r)).mult(r);
}

static PVector heart(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta*r), -cos(theta*r)).mult(r);
}

static PVector disc(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(PI*r), cos(PI*r)).mult(theta/PI);
}

static PVector spiral(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta)+sin(r), sin(theta)-cos(r)).mult(1/r);
}

static PVector hyperbolic(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta)/r, r*cos(theta));

}


static PVector diamond(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta)*cos(r), cos(theta)*sin(r));
}

static PVector ex(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float p0 = sin(theta+r);
    float p1 = cos(theta-r);
    return new PVector(pow(p0, 3)+pow(p1,3),pow(p0,3)-pow(p1,3)).mult(r);
}

static PVector julia(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float omega = ((int)utils.random(2))*PI;
    return new PVector(cos(theta/2+omega), sin(theta/2+omega)).mult(sqrt(r));
}

static PVector bent(PVector p){
    PVector out;
    if (p.x>=0 && p.y>=0){
        out = new PVector(p.x,p.y);
    } else if (p.x < 0 && p.y >= 0){
        out = new PVector(2*p.x, p.y);
    } else if (p.x >=0 && p.y <0){
        out = new PVector(p.x, p.y/2);
    }
    else{
        out = new PVector(2*p.x, p.y/2);
    }
    return out;
}

static PVector waves(PVector p, float b, float e, float c, float f){
  float x = p.x + b * sin(p.y * (1.0 / (c * c) ));
  float y = p.y + e * sin(p.x * (1.0 / (f*f) ));
  return new PVector(x, y);
}

static PVector waves(PVector p){
    float waves_b = utils.random(.1);
    float waves_e = utils.random(.3);
    float waves_c = utils.random(-.2);
    float waves_f = utils.random(.1);
    return waves(p, waves_b, waves_e, waves_c, waves_f);
}

static PVector fisheye(PVector p){
    float r = p.mag();
    return new PVector(p.y, p.x).mult(2/(r+1));
}
static PVector exponential(PVector p){
    return new PVector(cos(PI*p.y), sin(PI*p.y)).mult(exp(p.x-1));
}

static PVector power(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta), sin(theta)).mult(pow(r, sin(theta)));
}

static PVector cosine(PVector p){
    return new PVector(cos(PI*p.x)*utils.cosh(p.y), -sin(PI*p.x)*utils.sinh(p.y));
}


// UTILS

import java.util.Random;

static class utils{

static Random rand = new Random();

static float log10 (float x) {
  return (log(x) / log(10));
}

static float random(){
  return random(0,1);
}
 
static float random(float max){
  return random(0,max);
}
 
static float random(float min, float max){
  return rand.nextFloat()*(max-min)+min;
}

static final float cosh(float x) { return 0.5 * (exp(x) + exp(-x));}
static final float sinh(float x) { return 0.5 * (exp(x) - exp(-x));}
static final float tanh(float x) { return sinh(x)/cosh(x);}
static float sec(float x) { return 1./cos(x);}
}
}
