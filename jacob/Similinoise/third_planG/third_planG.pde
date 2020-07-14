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
    if (pos.x<0 || pos.x > width || pos.y <0 || pos.y > height ||p.dead  ){
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
  saveFrame("out/out-####.png");
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
  //cvs.circle(width/2, height/2, 500);
  hud.clear();
  cvs.endDraw();
  hud.endDraw();
  particles.clear();
  init_part();
  
  int n = 5;
  
  
  for (int i = 0; i<n; i++){
    //float x = width/2;
    //float y = height/2;
    float x = random(width);
    float y = random(height);
    particles.add(new Particle(x, y, 0,0));
    Particle p = particles.get(i);
    p.c = color(random(255), 50);
    p.c = color(i*25%255, 0,0);
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
  boolean dead;
  float mvel = 3;
  
  Particle(float x, float y, float vx, float vy){
    pos = new PVector(x, y);
    lpos = pos.copy();
    vel = new PVector(vx, vy);
    acc = new PVector(0, 0);
    vel = new PVector(random(-1,1), random(-1,1));
    c = color(random(255), 0,0);
    a = random(2*TWO_PI);
    sn = 0;
    timer = 0;
    res = 4;
    dead = false;
  }
  
  void draw2(){
    cvs.strokeWeight(3);
    cvs.stroke(c);
    cvs.point(pos.x, pos.y);
  }
  
  void draw(){
    cvs.strokeWeight(3);
    cvs.stroke(c, 255);
    cvs.point(pos.x, pos.y);
    return;
    /*PVector normal = vel.copy().rotate(PI/2);
    int npoints = 1;
    float dis = 60;//+nnoise(pos.x, pos.y)*30;
    
    
    
    for (int j=0;j<npoints;j++){
     float cdis= dis/npoints*j-dis/2 + cos(t*10+j)*10;
     PVector slpos = PVector.add(lpos, PVector.mult(normal, cdis));
     PVector spos = PVector.add(pos, PVector.mult(normal, cdis));
     //cvs.point(spos.x, spos.y);
     cvs.line(slpos.x, slpos.y, spos.x, spos.y);
    }
     lpos = pos.copy();*/
  }
  
  void update(){
    acc = new PVector(0,0);
    float r = 5;
    float res = 1.5;
    float x = pos.x;
    float y = pos.y;
    float aa = mnoise(x/width*res, y/height*res+float(sn%5)/10, t)*2*TWO_PI;
    
    float angmax = PI/4;
    int ndir = 6;
      int npoints = 50;
    PVector normal = new PVector(-vel.y, vel.x);
    int countcol = 0;
    for (int i = 0;i<ndir;i++){
      float ca = angmax*2/ndir*i-angmax;
      PVector cdir = vel.copy().rotate(ca);
      cdir.normalize();
      float da = collision(cdir, npoints);
      countcol = (da==1)?countcol+1:countcol;
      da = (da==npoints)?0:5/da;
      //da = (npoints - da);
      //if (ca<=0){
      //acc.add(PVector.mult( vel.copy().rotate(-ca), da));
      //else{acc.add(PVector.mult( vel.copy().rotate(-ca), da));};
      //acc.sub(new PVector(normal.x*cdir.x*da, cdir.y*normal.y*da));
      acc.sub(PVector.mult(new PVector(cdir.x, cdir.y), da));
    }
    if (countcol >0){
      dead=true;
    }
    
      //float da = collision(vel.copy(), npoints);
      //da = (npoints - da)*.001;
      //acc.add(PVector.mult( vel.copy().rotate(PI/2), da));
    if (acc.x==0){
      acc = new PVector(cos(aa)*r, sin(aa)*r);
      acc.mult(.1);
    }
    acc.limit(1);
    acc.mult(.1);
    hud.stroke(0,0,255);
    float mmm = 20;
    hud.line(pos.x, pos.y, pos.x+acc.x*mmm, pos.y+mmm*acc.y);
    hud.stroke(0,255,255);
    vel.add(acc);
    vel.normalize();
    //vel.x = lerp(vel.x, cos(a), .1);
    hud.line(pos.x, pos.y, pos.x+vel.x*mmm, pos.y+mmm*vel.y);
    pos.add(vel);
  }
  
  float collision(PVector dir, int npoints){
    float dist = 150;
    float delta = npoints;
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
