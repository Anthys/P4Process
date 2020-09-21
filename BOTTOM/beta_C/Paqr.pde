class ParticleGroup{
  ArrayList<Particle> particles;
  
  ParticleGroup(int n){
    particles = new ArrayList<Particle>();
    for (int i=0; i<n;i++){
      particles.add(new Particle());
    }
  }
  
  ParticleGroup(){
    particles = new ArrayList<Particle>();
  }
  
  void run(){
    for (int i = 0; i<particles.size();i++){
      Particle p = particles.get(i);
      p.update();
    }
    for (int i = 0; i<particles.size();i++){
      Particle p = particles.get(i);
      p.draw();
    }
  }

}

class Particle{
  PVector pos;
  PVector vel;
  PVector acc;
  float theta = 0;
  float r = 1;
  float r2;
  int selfi;
  color col;
  
  float psize = 2;
  float vel_lim = 0;
  
  Particle(PVector p_, PVector v_, PVector a_, color c_){
    pos = p_;
    vel = v_;
    acc = a_;
    col = c_;
  }
  
  Particle(PVector p_, PVector v_, PVector a_){
    this(p_, v_, a_, color(0));
  }
  
  Particle(float x, float y){
    this(x, y, 0,0, 0, 0, color(0));
  }
  
  Particle(float x, float y, float vx, float vy, float ax, float ay){
    this(x, y, vx, vy, ax, ay, color(0));
  }

  Particle(float x, float y, float vx, float vy, float ax, float ay, color c_){
    this(new PVector(x, y), new PVector(vx, vy), new PVector(ax, ay), c_);
  }
  
  Particle(){
    this(random(width),random(height),random(-1,1),random(-1,1),0,0);
  }
  
  void update(){
    pos = new PVector(r*cos(theta), r*sin(theta));
    
    PVector v = new PVector(float(selfi)/1000, theta);
    v = variations2t2.sinusoidal(v);
    
    float m = noise(v.x, v.y)*2-1;
    r2 = r+ m*300;
    theta += .001;
  
  }
  
  void draw(){
    stroke(col, 20);
    strokeWeight(psize);
    point(r2*cos(theta), r2*sin(theta));
  }

}