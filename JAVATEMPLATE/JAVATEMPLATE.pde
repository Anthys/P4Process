Particle part;
CurvNoise cn; 
PVector p;

void setup(){
  size(1000,1000);
  cn = new CurvNoise();
  part = new Particle();
  cn.init();
}


void draw(){
  cn.update();
  cn.draw();
  //translate(width/2, height/2);
  part.draw();
}
