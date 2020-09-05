CurvNoise el1;
PosNoiseB el2;
void setup(){
  size(1000, 1000);
  el1 = new CurvNoise();
  el2 = new PosNoiseB();
  el2.init();
}

void draw(){
  el2.update();
  el2.draw();
}

void keyPressed(){
  el2.keyPressed();
}
