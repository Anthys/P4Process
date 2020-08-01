CurvNoise el1;
PosNoise el2;
void setup(){
  el1 = new CurvNoise();
  el2 = new PosNoise();
  el1.setup();
}

void settings(){
  size(1000, 1000);

  smooth(8);
}

void draw(){
  el1.draw();
}

void keyPressed(){
  el1.keyPressed();
}
