CurvNoise el1;
PosNoise el2;
void setup(){
  el1 = new CurvNoise();
  el2 = new PosNoise();
  el2.setup();
}

void settings(){
  size(1000*4, 4*1000);

  smooth(8);
}

void draw(){
  el2.draw();
}

void keyPressed(){
  el2.keyPressed();
}
