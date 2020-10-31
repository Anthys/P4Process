
PosNoiseB partA = new PosNoiseB();

void setup(){
  size(1000,1000);
  partA.init(133);
}

void draw(){
  partA.update();
  partA.draw();
}

void keyPressed(){
  partA.keyPressed();
}
