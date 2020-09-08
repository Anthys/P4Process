CurvNoise el1;
PosNoise el2;
void setup(){
  el1 = new CurvNoise();
  el2 = new PosNoise();
  el1.setup();
}
float aaa = 3;
void settings(){
  size(int(1000*aaa), int(aaa*1000));

  smooth(8);
}

void draw(){
  el1.draw();
}

void keyPressed(){
  el1.keyPressed();
}
