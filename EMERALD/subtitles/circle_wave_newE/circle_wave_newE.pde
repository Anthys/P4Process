CurvNoise el1;
PosNoiseB el2;
void setup(){
  size(1000, 1000);
  el1 = new CurvNoise();
  el2 = new PosNoiseB();
  el1.init();
      background(0);
}

void draw(){
  el1.update();
  el1.draw();
}

void keyPressed(){
  el1.keyPressed();
}
