import java.util.Random;

static PApplet pa;

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


static PVector waves(PVector p){
    float waves_b = utils.random(.1);
    float waves_e = utils.random(.3);
    float waves_c = utils.random(-.2);
    float waves_f = utils.random(.1);
    return waves(p, waves_b, waves_e, waves_c, waves_f);
}

static PVector waves(PVector p, float b, float e, float c, float f){
  float x = p.x + b * sin(p.y * (1.0 / (c * c) ));
  float y = p.y + e * sin(p.x * (1.0 / (f*f) ));
  return new PVector(x, y);
}

static PVector fisheye(PVector p){
    float r = p.mag();
    return new PVector(p.y, p.x).mult(2/(r+1));
}

static PVector popcorn(PVector p, float c, float f){
    return new PVector(p.x + c*sin(tan(3*p.y)), p.y+f*sin(tan(3*p.x)));
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

static PVector rings(PVector p, float c){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta), sin(theta)).mult((r+c*c)%(2*c*c)-c*c+r*(1-c*c));  
}

static PVector fan(PVector p,float c, float f){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float t = PI*c*c;
    PVector out;
    if ((theta+f)%t>t/2){
      out = new PVector(cos(theta-t/2), sin(theta-t/2)).mult(r);
    }
    else {
      out = new PVector(cos(theta+t/2), sin(theta+t/2)).mult(r);
    }
    return out;
}

static PVector blob(PVector p, float p1,float p2,float p3){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
  return new PVector(cos(theta),sin(theta)).mult(p2+(p1-p2)/2*(sin(p3*theta)+1)).mult(r);
}

static PVector pdj(PVector p, float p1, float p2, float p3, float p4){
  return new PVector(sin(p1*p.y)-cos(p2*p.x), sin(p3*p.x)-cos(p4*p.y));
}

static PVector fan2(PVector p, float fx, float fy){
  float r = p.mag();
  float theta = atan2(p.x,p.y);
  float p1 = PI*(fx*fx);
  float p2 = fy;
  float t = theta+p2-p1*round(2*theta*p2/p1);
  PVector out;
  if (t>p1/2){
    out = new PVector(sin(theta-p1/2),cos(theta-p1/2)).mult(r);
  }
  else{
    out = new PVector(sin(theta+p1/2),cos(theta+p1/2)).mult(r);
  }
  return out;
}

static PVector rings2(PVector p, float v){
  float r = p.mag();
  float theta = atan2(p.x,p.y);
  float p1 = v*v;
  float t = r-2*p1*round((r+p1)/(2*p1))+r*(1-p1);
  return new PVector(sin(theta), cos(theta)).mult(t);
}

static PVector eyefish(PVector p){
  float r = p.mag();
  return new PVector(p.x, p.y).mult(2/(r+1));
}

static PVector bubble(PVector p){
  float r = p.mag();
  return new PVector(p.x, p.y).mult(4/(r*r+4));
}

static PVector cylinder(PVector p){
  return new PVector(sin(p.x), p.y);
}

static PVector perspective(PVector p, float p1, float p2){
  return new PVector(p.x, p.y*cos(p1)).mult(p2/(p2-p.y*sin(p1)));
}

static PVector noise(PVector p){
  float psi1 = utils.random(1);
  float psi2 = utils.random(1);
  return new PVector(p.x*cos(TAU*psi2), p.y*sin(TAU*psi2)).mult(psi1);
}

static PVector julian(PVector p, float p1, float p2){
  float r = p.mag();
  float phi = atan2(p.y,p.x);
  float p3 = round(abs(p1)*utils.random(1));
  float t = (phi+TAU*p3)/p1;
  return new PVector(cos(t), sin(t)).mult(pow(r, p2/p1));
}

static PVector juliascope(PVector p, float p1, float p2){
  float r = p.mag();
  float phi = atan2(p.y,p.x);
  float p3 = round(abs(p1)*utils.random(1));
  float A = ((int)utils.random(0,2))*2-1;
  float t = (A*phi+TAU*p3)/p1;
  return new PVector(cos(t), sin(t)).mult(pow(r, p2/p1));
}

static PVector blur(PVector p){
  float psi1 = utils.random(1);
  float psi2 = utils.random(1);
  return new PVector(cos(TAU*psi2), sin(TAU*psi2)).mult(psi1);
}

static PVector gaussian(PVector p){
  // Summing 4 random numbers and subtracting 2 is an attempt at approximating
  // a Gaussian distribution
  float coeff = 0;
  for (int i=0;i<4;i++){
    float psi = utils.random();
    coeff += psi;
  }
  coeff -= 2;
  float psi5 = utils.random();
  return new PVector(cos(TAU*psi5), sin(TAU*psi5)).mult(coeff);
}

static PVector radialBlur(PVector p, float angle, float val){
  float r = p.mag();
  float phi = atan2(p.y,p.x);
  
  float p1 = angle*PI/2;
  float t1 = 0;
  for (int i=0;i<4;i++){
    float psi = utils.random();
    t1 += psi;
  }
  t1 -= 2;
  t1*=val;
  
  float t2 = phi+t1*sin(p1);
  float t3 = t1*cos(p1)-1;
  return new PVector(r*cos(t2)+t3*p.x, r*sin(t2)+t3*p.y).mult(1/val);
}

static PVector pie(PVector p, float slices, float rotation, float thickness){
  float t1 = round( utils.random()*slices+.5);
  float t2 = rotation + TAU/slices*(t1+utils.random()*thickness);
  
  return new PVector(cos(t2), sin(t2)).mult(utils.random());
}

static PVector ngon(PVector p, float power, float sides, float corners, float circle){
  float r = p.mag();
  float phi = atan2(p.y,p.x);
  
  float p2 = TAU/sides;
  float t3  = phi - p2 * floor(phi/p2);
  float t4;
  if (t3 > p2/2){
    t4 = t3;
  }
  else {
    t4 = t3-p2;
  }
  
  float k = (corners*(1/cos(t4)-1)+circle)/pow(r, power);
  return new PVector(p.x, p.y).mult(k);
}

static PVector curl(PVector p, float p1, float p2){
  float t1 = 1 + p1*p.x + p2*(p.x*p.x -p.y*p.y);
  float t2 = p1*p.y+ 2*p2*p.x*p.y;
  return new PVector(p.x*t1+p.y*t2,p.y*t1-p.x*t2).mult(1/(t1*t1+t2*t2));
}

static PVector rectangles(PVector p, float p1, float p2){
  return new PVector( (2*floor(p.x/p1)+1)*p1-p.x, (2*floor(p.y/p2)+1)*p2-p.y);
}

static PVector arch(PVector p, float val){
  float psi = utils.random();
  return new PVector(sin(psi*PI*val), pow(sin(psi*PI*val), 2)/cos(psi*PI*val));
}

static PVector tangeant(PVector p){
  return new PVector(sin(p.x)/cos(p.y), tan(p.y));
}

static PVector square(PVector p){
  return new PVector(utils.random()-.5, utils.random()-.5);
}

static PVector rays(PVector p, float val){
  float r = p.mag();
  return new PVector(cos(p.x), sin(p.y)).mult(val*tan(utils.random()*PI*val)/(r*r));
}

static PVector blade(PVector p, float v){
  float psi = utils.random();
  float r = p.mag();
  return new PVector(cos(psi*r*v)+sin(psi*r*v), cos(psi*r*v)- sin(psi*r*v)).mult(p.x);
}

static PVector secant(PVector p, float v){
  float r = p.mag();
  return new PVector(p.x, 1/(v*cos(v*r)));
}

static PVector twintrian(PVector p, float v){
  float psi = utils.random();
  float r = p.mag();
  float t = utils.log10( pow(sin(psi*r*v), 2))+cos(psi*r*v);
  return new PVector(t, t-PI*sin(psi*r*v)).mult(p.x);
}

static PVector cross(PVector p){
  return new PVector(p.x, p.y).mult(sqrt(1/pow((p.x*p.x-p.y*p.y), 2)));
}

}

static class variation1t2{

  static PVector astroid(float t){
    return new PVector(pow(cos(t), 3), pow(sin(t), 3));
  }
  
  static PVector cardiod(float t){
    return new PVector(2*cos(t)-cos(2*t),2*sin(t)-sin(2*t)); 
  }
  
  static PVector conchoid(float t, float a){
    return new PVector(a+cos(t), a*tan(t)+sin(t));
  }
  
  static PVector epicycloid(float t, float a, float b){
    float x = (a+b)*cos(t)-b*cos((a/b+1)*t);
    float y = (a+b)*sin(t)-b*sin((a/b+1)*t);
    return new PVector(x, y);
  }
  
  static PVector epitrochoid(float t, float a, float b, float c){
    float x = (a+b)*cos(t)-c*cos((a/b+t)*t);
    float y = (a+b)*sin(t)-c*sin((a/b+t)*t);
    return new PVector(x,y);  
  }
  
  static PVector folium(float t, float a){
    float x = (3*a*t)/(1+t*t);
    float y = (3*a*t*t)/(1+t*t*t);
    return new PVector(x, y);
  }
  
  static PVector hypocycloid(float t, float a, float b){
    float x = (a-b)*cos(t)+b*cos((a/b-1)*t);
    float y = (a-b)*sin(t)+b*sin((a/b-1)*t);
    return new PVector(x, y);
  }
  
  static PVector hypotrochoid(float t, float a, float b ,float c){
    float x = (a-b)*cos(t)+c*cos((a/b-1)*t);
    float y = (a-b)*sin(t)+c*sin((a/b-1)*t);
    return new PVector(x, y);
  }
  
  static PVector involute(float t){
    return new PVector(cos(t)+t*sin(t), sin(t)-t*cos(t));
  }
  
  static PVector cissoid(float t){
    return new PVector(2*sin(t)*sin(t), 2*sin(t)*sin(t)*tan(t));
  }
  
  static PVector kampyle(float t){
    return new PVector(utils.sec(t), tan(t)*utils.sec(t));
  }
  
  static PVector lissajous(float t, float a, float b, float n, float c){
    return new PVector(a*sin(n*t+c), b*sin(t));
  }
  
  static PVector nephroid(float t){
    return new PVector(3*cos(t)-cos(3*t), 3*sin(t)-sin(3*t));
  }
  
  static PVector plateau(float t, float m, float n){
    float x = (sin((m+n)*t))/(sin((m-n)*t));
    float y = (2*sin((m*t))*sin(n*t))/(sin((m-n)*t));
    return new PVector(x, y);
  }
  
  static PVector talbot(float t, float a, float f, float b){
    float x = (a*a+f*f*sin(t)*sin(t))*cos(t)/a;
    float y = (a*a-2*f*f+f*f*sin(t)*sin(t))*sin(t)/b;
    return new PVector(x, y);
  }
  
  static PVector tractrix(float t){
    float x = 1/utils.cosh(t);
    float y = t - utils.tanh(t);
    return new PVector(x, y);
  }
  
  static PVector tricuspoid(float t){
    return new PVector(2*cos(t)+cos(2*t), 2*sin(t)-sin(2*t));
  }
  
  static PVector witchOfAgnesi(float t){
    return new PVector(t, 1/(1+t*t));
  }
  
}


static class variation1t1{

  static float uwu(float in){
    int rand = (int)utils.random(13);
    return uwu(in, rand);
  }

  static float uwu(float in, int rand){
    float out = 0;

    switch (rand){
      case 0:
        out = cos(in);
      case 1:
        out = sin(in);
      case 2:
        out = sqrt(in);
      case 3:
        out = pow(in, 2);
      case 4:
        out = log(in);
      case 5:
        out = exp(in);
      case 6:
        out = abs(in);
      case 7:
        out = ceil(in);
      case 8:
        out = tan(in);
      case 9:
        out = acos(in);
      case 10:
        out = asin(in);
      case 11:
        out = atan(in);
      case 12:
        out = 1/(in);
    }
    return out;


  } 

}


// UTILS

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
