ArrayList<Particle> particles;

PGraphics cvs;
PGraphics hud;

void setup(){
  size(500,500);
  particles = new ArrayList<Particle>();
  cvs = createGraphics(width, height);
  hud = createGraphics(width, height);
}

void init(){
  cvs.clear();
  hud.clear();
  particles.clear();
  
  int n = 5;
  
  for (int i = 0; i<n; i++){
    float x = random(width);
    float y = random(height);
    particles.add(new Particle(x, y, 0,0));
    Particle p = particles.get(i);
    p.c = color(random(255));
  }

}

class Particle{
  PVector pos;
  PVector vel;
  color c;
  float a;
  
  Particle(float x, float y, float vx, float vy){
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    c = color(random(255), 0,0);
    a = random(2*TWO_PI);
  }
  
  void draw(){
    strokeWeight(3);
  }

}
