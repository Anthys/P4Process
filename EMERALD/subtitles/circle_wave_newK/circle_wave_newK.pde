CurvNoise el1;
PosNoiseB el2;

void settings(){
  
  el1 = new CurvNoise();
  el1.settings();
}
void setup(){
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
