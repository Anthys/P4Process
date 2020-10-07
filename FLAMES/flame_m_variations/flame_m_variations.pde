
PosNoiseB partA = new PosNoiseB();

void setup(){
  size(4000,4000);
  partA.init(133);
}

void draw(){
  partA.update();
  partA.draw();
}

void keyPressed(){
  partA.keyPressed();
}
