CurvNoise el1;
PosNoiseB el2;
void setup(){
  size(600, 600);
  el1 = new CurvNoise();
  el2 = new PosNoiseB();
  el1.init();
}

void draw(){
  el1.update();
  el1.draw();
}

void keyPressed(){
  el1.keyPressed();
}
