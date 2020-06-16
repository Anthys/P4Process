void setup(){
  size(500,500,P2D);
  particles = new ArrayList<MyParticle>();
  draw_();
}

ArrayList<MyParticle> particles;

void draw(){
  //background(200);
  for (MyParticle m: particles){
    m.new_vel();
    m.update();
    m.draw();
  }

}

class MyParticle{
  PVector pos;
  PVector vel;
  color col;
  float s;
  float rands;
  float inix;
  
  MyParticle(float x_, float y_, float vx_, float vy_, float s_, color c_){
    pos = new PVector(x_, y_);
    vel = new PVector(vx_,vy_);
    s = s_;
    col = c_;
    rands = random(0,100);
    inix = x_;
  }
  
  void draw(){
    noStroke();
    fill(col);
    circle(pos.x, pos.y, s);
  }
  
  void new_vel(){
    float size = 4;
    float res = 1./30;
    float dy = 1;
    float dx = (noise(float(frameCount)*res+rands)*2-1)*size;
    //dx = lerp(vel.x, dx, .1);
    vel = new PVector(dx, dy);
  }
  
  void update(){
    pos.y += vel.y;
    pos.x = lerp(pos.x+vel.x, inix, .1);
  }
}

void draw_(){
  background(200);
  init();
}

void init(){
  particles.clear();
  int n = 200;
  float radius = 200;
  for (int i = 0; i<n; i++){
    float r = random(100,radius);
    float theta = random(0,2*TWO_PI);
    float x = r*cos(theta)+width/2;
    float y = r*sin(theta)+height/2;
    float vx = 0;
    float vy = 0;
    float s = 3;
    color c = color(random(150, 220), random(0,100),random(50,150),200);
    particles.add(new MyParticle(x,y,vx,vy,s,c));
  }
}

void keyPressed(){
  if (key == 'p'){
    particles.clear();
  }
  if (keyCode == 32){
    draw_();
  }

}
