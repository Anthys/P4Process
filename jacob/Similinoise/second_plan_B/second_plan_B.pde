ArrayList<Particle> particles;
Particle part;

PGraphics cvs;
PGraphics hud;

color cback;

float t;

void setup(){
  size(500,500);
  particles = new ArrayList<Particle>();
  cvs = createGraphics(width, height);
  hud = createGraphics(width, height);
  cback = color(255);
  init();
}

void draw_(){
  part.update();
  part.draw();

}
void draw__(){
  for (int i = 0; i<particles.size();i++){
    Particle p = particles.get(i);
    p.update();
    p.draw();
  }

}

void draw(){
  cvs.beginDraw();
  hud.beginDraw();
  hud.clear();
  t = float(frameCount)/10;
  draw_();
  cvs.endDraw();
  hud.endDraw();
  image(cvs, 0,0);
  image(hud, 0,0);
}

void init_part(){
  float x = random(100)+width/2;
  float y = random(100)+height/2;
  part  =(new Particle(x, y, 0,0));
  part.c = color(random(255));
}

void init(){
  t=0;
  cvs.beginDraw();
  hud.beginDraw();
  cvs.clear();
  cvs.background(cback);
  hud.clear();
  cvs.endDraw();
  hud.endDraw();
  particles.clear();
  init_part();
  
  int n = 5;
  
  for (int i = 0; i<n; i++){
    float x = random(width);
    float y = random(height);
    particles.add(new Particle(x, y, 0,0));
    Particle p = particles.get(i);
    p.c = color(random(255), 50);
  }

}

class Particle{
  PVector pos;
  PVector vel;
  PVector acc;
  color c;
  float a;
  float timer;
  float res;
  
  Particle(float x, float y, float vx, float vy){
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    acc = new PVector(0, 0);
    vel = new PVector(1, 0);
    c = color(random(255), 0,0);
    a = random(2*TWO_PI);
    timer = 0;
    res = 4;
  }
  
  void draw(){
    cvs.strokeWeight(3);
    cvs.stroke(c);
    cvs.point(pos.x, pos.y);
  }
  
  void update(){
    acc = new PVector(0,0);
    float res = 5;
    float intensity = 1;
    float x = pos.x/width*res;
    float y = pos.y/height*res;
    float noi = mnoise(x, y)*intensity;
    int npoints = 10;
    float dangle = PI/12;
    float col1 = this.collision(vel.copy().rotate(dangle), npoints);
    float col2 = this.collision(vel.copy().rotate(-dangle), npoints);
    float delta = 0;
    if (col1+col2!=0){
      delta = max(col1,col2);
      delta = PI/10 * (npoints-delta)/npoints;
      if (col1>=col2){delta = -delta;}
    }else{
    //delta = noi*TWO_PI*2;
    //delta *= .005;
    }
    PVector cacc = new PVector(-vel.y, vel.x);
    cacc.normalize();
    cacc.mult(delta);
    acc = cacc;
    //PVector vel2 = vel.copy().rotate(delta);
    float m0 = .3;
    //vel = new PVector(lerp(vel.x, vel2.x, m0), lerp(vel.y, vel2.y, m0));
    //vel = vel2;
    vel.add(acc);
    PVector vel2 = vel.copy().normalize();
    
    vel = new PVector(lerp(vel.x, vel2.x, m0), lerp(vel.y, vel2.y, m0));
    //vel.normalize();
    pos.add(vel);
  }
  
  float collision(PVector dir, int npoints){
    float dist = 150;
    float delta = 0;
    for (int i =1;i<npoints;i++){
      float cdist = dist/npoints*i;
      PVector cpos = PVector.add(pos, PVector.mult(dir, cdist));
      hud.stroke(0,255,0);
      hud.strokeWeight(3);
      //cvs.point(cpos.x, cpos.y);
      if (cvs.get(int(cpos.x), int(cpos.y)) != color(cback)){
        hud.stroke(255,0,0);
        hud.strokeWeight(10);
        hud.point(cpos.x, cpos.y);
        delta = i;
        break;
      }
      hud.point(cpos.x, cpos.y);
    }
    return delta;
  }

}

float mnoise(float x, float y){
  return noise(x, y)*2-1;

}

void keyPressed(){
  if (keyCode==32){
    init();
  }

}
