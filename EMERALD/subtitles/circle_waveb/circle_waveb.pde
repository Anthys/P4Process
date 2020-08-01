CurvNoise el1;
PosNoise el2;
void setup(){
  size(1000, 1000);
  el1 = new CurvNoise();
  el2 = new PosNoise();
  el1.setup();
}

void draw(){
  el1.draw();
}

void keyPressed(){
  el1.keyPressed();
}
