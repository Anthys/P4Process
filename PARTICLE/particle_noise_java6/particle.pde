class Particle {
  PVector p;
  PVector v;
  color c;
  float res;
  float s;
  
  
  Particle(float x_, float y_, float vx_, float vy_, float res_){
    p = new PVector(x_, y_);
    v = new PVector(vx_, vy_);
    c = color(100, 0, 20, 200);
    res = res_;
    s = 10;
    
  }

  PVector find_gradient(float res){
    float dx = res*1/width;
    float dy = res*1/height;
    PVector uv = new PVector(p.x/width+1, p.y/height+1);
    uv.mult(res);
    
    PVector v = new PVector(0,0);
    
    int rr = 50;
    
    for (int i = -rr; i < rr; i+=5)
    for (int j = -rr; j < rr; j+=5){
      PVector cp = new PVector(uv.x+i*dx, uv.y+j*dy);
      float val = anoise(cp.x, cp.y);
      v.add( (cp.sub(uv)).normalize().mult(val) );    
    }
    
    v.normalize().mult(.1);
    return v;
  
  }
  
  void update(){
    v.mult(.99);
    v.add(find_gradient(res));
    p.add(v.mult(0.7));
  }
  
  void border(){
    if (p.x < 0){p.x = width;}
    else if(p.x > width){p.x = 0;}
    
    if (p.y < 0){p.y = height;}
    else if (p.y > height){p.y = 0;}
  
  }
  
  void draw(){
    update();
    strokeWeight(s);
    stroke(c);
    point(p.x, p.y);
    //spray(p.x, p.y, s);
  }
 
}

void spray(float x, float y, float s){
  strokeWeight(3);
  for (int i =0;i<s*2;i++){
    point(x+random(-s, s), y+random(-s,s));  
  }

}

float anoise(float x, float y){
  return 1-noise(x,y);
}

float clamp(float a, float b, float c){
  return min(max(b,a),c);
}
