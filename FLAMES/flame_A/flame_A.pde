
PosNoiseB partA = new PosNoiseB();

void setup(){
  size(1000,1000);
  partA.init(1337);
}

void draw(){
  partA.update();
  partA.draw();
}
