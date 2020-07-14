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

final float cosh(float x) { return 0.5 * (exp(x) + exp(-x));}
final float sinh(float x) { return 0.5 * (exp(x) - exp(-x));}
