class variations{

PVector linear(PVector p, float rotation, float size){
    PVector p2 = new PVector(size*p.x, size*p.y);
    p2.rotate(rotation);
    return p2;
}

PVector sinusoidal(PVector p, float a) {
  return new PVector(a * sin(p.x), a * sin(p.y));
}

PVector spherical(PVector p){
    float r = p.mag();
    return new PVector(p.x, p.y).mult(1/(r*r));
}

PVector swirl(PVector p){
    float r = p.mag();
    return new PVector(p.x*sin(r*r)-p.y*cos(r*r), p.x*cos(r*r)+p.y*sin(r*r));
}

PVector horseshoe(PVector p){
    float r = p.mag();
    return new PVector((p.x-p.y)*(p.x+p.y), 2*p.x*p.y).mult(1/r);
}

PVector polar(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(theta/PI, r-1);
}

PVector handkerchief(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta+r), cos(theta-r)).mult(r);
}

PVector heart(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta*r), -cos(theta*r)).mult(r);
}

PVector disc(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(PI*r), cos(PI*r)).mult(theta/PI);
}

PVector spiral(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta)+sin(r), sin(theta)-cos(r)).mult(1/r);
}

PVector hyperbolic(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta)/r, r*cos(theta));

}


PVector diamond(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta)*cos(r), cos(theta)*sin(r));
}

PVector ex(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float p0 = sin(theta+r);
    float p1 = cos(theta-r);
    return new PVector(pow(p0, 3)+pow(p1,3),pow(p0,3)-pow(p1,3)).mult(r);
}

PVector julia(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float omega = ((int)random(2))*PI;
    return new PVector(cos(theta/2+omega), sin(theta/2+omega)).mult(sqrt(r));
}

PVector bent(PVector p){
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


PVector waves(PVector p){
    float waves_b = random(.1);
    float waves_e = random(.3);
    float waves_c = random(-.2);
    float waves_f = random(.1);
    return waves(p, waves_b, waves_e, waves_c, waves_f);
}

PVector waves(PVector p, float b, float e, float c, float f){
  float x = p.x + b * sin(p.y * (1.0 / (c * c) ));
  float y = p.y + e * sin(p.x * (1.0 / (f*f) ));
  return new PVector(x, y);
}

PVector fisheye(PVector p){
    float r = p.mag();
    return new PVector(p.y, p.x).mult(2/(r+1));
}

PVector popcorn(PVector p, float c, float f){
    return new PVector(p.x + c*sin(tan(3*p.y)), p.y+f*sin(tan(3*p.x)));
}

PVector exponential(PVector p){
    return new PVector(cos(PI*p.y), sin(PI*p.y)).mult(exp(p.x-1));
}

PVector power(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta), sin(theta)).mult(pow(r, sin(theta)));
}

PVector cosine(PVector p){
    return new PVector(cos(PI*p.x)*cosh(p.y), -sin(PI*p.x)*sinh(p.y));
}

PVector rings(PVector p, float c){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta), sin(theta)).mult((r+c*c)%(2*c*c)-c*c+r*(1-c*c));  
}

PVector fan(PVector p,float c, float f){
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

PVector blob(PVector p, float p1,float p2,float p3){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
  return new PVector(cos(theta),sin(theta)).mult(p2+(p1-p2)/2*(sin(p3*theta)+1)).mult(r);
}

PVector pdj(PVector p, float p1, float p2, float p3, float p4){
  return new PVector(sin(p1*p.y)-cos(p2*p.x), sin(p3*p.x)-cos(p4*p.y));
}

PVector fan2(PVector p, float fx, float fy){
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

PVector rings2(PVector p, float v){
  float r = p.mag();
  float theta = atan2(p.x,p.y);
  float p1 = v*v;
  float t = r-2*p1*round((r+p1)/(2*p1))+r*(1-p1);
  return new PVector(sin(theta), cos(theta)).mult(t);
}

PVector eyefish(PVector p){
  float r = p.mag();
  return new PVector(p.x, p.y).mult(2/(r+1));
}

PVector bubble(PVector p){
  float r = p.mag();
  return new PVector(p.x, p.y).mult(4/(r*r+4));
}

PVector cylinder(PVector p){
  return new PVector(sin(p.x), p.y);
}

PVector perspective(PVector p, float p1, float p2){
  return new PVector(p.x, p.y*cos(p1)).mult(p2/(p2-p.y*sin(p1)));
}

PVector noise(PVector p){
  float psi1 = random(1);
  float psi2 = random(1);
  return new PVector(p.x*cos(TAU*psi2), p.y*sin(TAU*psi2)).mult(psi1);
}

PVector julian(PVector p, float p1, float p2){
  float r = p.mag();
  float phi = atan2(p.y,p.x);
  float p3 = round(abs(p1)*random(1));
  float t = (phi+TAU*p3)/p1;
  return new PVector(cos(t), sin(t)).mult(pow(r, p2/p1));
}

PVector juliascope(PVector p, float p1, float p2){
  float r = p.mag();
  float phi = atan2(p.y,p.x);
  float p3 = round(abs(p1)*random(1));
  float A = ((int)random(0,2))*2-1;
  float t = (A*phi+TAU*p3)/p1;
  return new PVector(cos(t), sin(t)).mult(pow(r, p2/p1));
}


final float cosh(float x) { return 0.5 * (exp(x) + exp(-x));}
final float sinh(float x) { return 0.5 * (exp(x) - exp(-x));}

}
