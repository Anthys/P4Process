void setup() {
  size(600, 600);
  background(250);
  smooth(8);
  noFill();
  stroke(60, 15);
  strokeWeight(0.9);
 
  x1=y1=-3;
  x2=y2=3;
  y=y1;
  step=sqrt(n)*(x2-x1)/(2.321*width);
}
 
float x1, y1, x2, y2; // function domain
float step; // step within domain
float y;
 
boolean go = true;
void draw() {
  if (go) {
    for (int i=0; (i<20)&go; i++) { // draw 20 lines at once
      for (float x=x1; x<=x2; x+=step) {
        drawVariation(x, y);
      }
      y+=step;
      if (y>y2) {
        go = false;
        println("done");
      }
    }
  }
}
 
int n=64;
void drawVariation(float x, float y) {
  PVector v = new PVector(x, y);
 
  for (int i=0; i<n; i++) {
    v = julia(sech(v, 1), 1);
    v = sinusoidal(v, (x2-x1)/2);
    float xx = map(v.x+0.003*randomGaussian(), x1, x2, 20, width-20);
    float yy = map(v.y+0.003*randomGaussian(), y1, y2, 20, height-20);
    point(xx, yy);
  }
}

PVector addF(PVector v1, PVector v2) { return new PVector(v1.x+v2.x, v1.y+v2.y); }
PVector subF(PVector v1, PVector v2) { return new PVector(v1.x-v2.x, v1.y-v2.y); }
PVector mulF(PVector v1, PVector v2) { return new PVector(v1.x*v2.x, v1.y*v2.y); }
PVector divF(PVector v1, PVector v2) { return new PVector(v2.x==0?0:v1.x/v2.x, v2.y==0?0:v1.y/v2.y); }

PVector d_pdj(PVector v, float amount) {
  float h = 0.1; // step
  float sqrth = sqrt(h);
  PVector v1 = pdj(v, amount);
  PVector v2 = pdj(new PVector(v.x+h, v.y+h), amount);
  return new PVector( (v2.x-v1.x)/sqrth, (v2.y-v1.y)/sqrth );
}

PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}

PVector hyperbolic(PVector v, float amount) {
  float r = v.mag() + 1.0e-10;
  float theta = atan2(v.x, v.y);
  float x = amount * sin(theta) / r;
  float y = amount * cos(theta) * r;
  return new PVector(x, y);
}

float pdj_a = 0.1;
float pdj_b = 1.9;
float pdj_c = -0.8;
float pdj_d = -1.2;
PVector pdj(PVector v, float amount) {
  return new PVector( amount * (sin(pdj_a * v.y) - cos(pdj_b * v.x)),
                      amount * (sin(pdj_c * v.x) - cos(pdj_d * v.y)));
}

PVector julia(PVector v, float amount) {
  float r = amount * sqrt(v.mag());
  float theta = 0.5 * atan2(v.x, v.y) + (int)(2.0 * random(0, 1)) * PI;
  float x = r * cos(theta);
  float y = r * sin(theta);
  return new PVector(x, y);
}

float cosh(float x) { return 0.5 * (exp(x) + exp(-x));}
float sinh(float x) { return 0.5 * (exp(x) - exp(-x));}
 
PVector sech(PVector p, float weight) {
  float d = cos(2.0*p.y) + cosh(2.0*p.x);
  if (d != 0)
    d = weight * 2.0 / d;
  return new PVector(d * cos(p.y) * cosh(p.x), -d * sin(p.y) * sinh(p.x));
}
