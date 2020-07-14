ArrayList<Particle> particles;
Particle part;

PGraphics cvs;
PGraphics hud;

color cback;

float t;

void setup(){
  size(1000,1000);
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
  for (int i = particles.size()-1; i>=0;i--){
    Particle p = particles.get(i);
    p.update();
    p.draw();
    PVector pos = p.pos;
    if (pos.x<0 || pos.x > width || pos.y <0 || pos.y > height){
      particles.remove(i);
    }
  }

}

void draw(){
  cvs.beginDraw();
  hud.beginDraw();
  hud.clear();
  t = float(frameCount)/100;
  draw__();
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
  //cvs.clear();
  //cvs.background(cback);
  hud.clear();
  cvs.endDraw();
  hud.endDraw();
  particles.clear();
  init_part();
  
  int n = 1;
  
  for (int i = 0; i<n; i++){
    float x = width/2;
    float y = height/2;
    particles.add(new Particle(x, y, 0,0));
    Particle p = particles.get(i);
    p.c = color(random(255), 50);
    p.c = color(0);
    p.sn = i;
  }

}

class Particle{
  PVector pos;
  PVector lpos;
  PVector vel;
  PVector acc;
  color c;
  float a;
  float timer;
  float res;
  int sn;
  
  Particle(float x, float y, float vx, float vy){
    pos = new PVector(x, y);
    lpos = pos.copy();
    vel = new PVector(vx, vy);
    acc = new PVector(0, 0);
    vel = new PVector(1, 0);
    c = color(random(255), 0,0);
    a = random(2*TWO_PI);
    sn = 0;
    timer = 0;
    res = 4;
  }
  
  void draw2(){
    cvs.strokeWeight(3);
    cvs.stroke(c);
    cvs.point(pos.x, pos.y);
  }
  
  void draw(){
    cvs.strokeWeight(3);
    cvs.stroke(c, 255);
    PVector normal = new PVector(-sin(a), cos(a));
    int npoints = 1;
    float dis = 60;//+nnoise(pos.x, pos.y)*30;
    
    
    
    for (int j=0;j<npoints;j++){
     float cdis= dis/npoints*j-dis/2 +cos(t+j)*10;
     PVector spos = PVector.add(pos, PVector.mult(normal, cdis));
     cvs.point(spos.x, spos.y);
    }
  }
  
  void update(){
    acc = new PVector(0,0);
    float r = 5;
    float res = 2;
    float x = pos.x;
    float y = pos.y;
    float aa = mnoise(x/width*res, y/height*res+float(sn%5)/10, t*0)*2*TWO_PI;
    a = aa;
    pos.add(r*cos(a), r*sin(a));
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


float mnoise(float x, float y, float t){
  return noise(x, y, t)*2-1;

}

void keyPressed(){
  if (key=='d'){
    noiseSeed((int)random(100));
    init();
  }
  if (keyCode==32){
    noiseSeed((int)random(100));
    cvs.beginDraw();
    cvs.clear();
    cvs.background(cback);
    cvs.endDraw();
    init();
  }
  if (key=='s'){
    saveFrame("out-####.png");
  }

}
