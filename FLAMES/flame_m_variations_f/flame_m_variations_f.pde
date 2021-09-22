
PosNoiseB partA = new PosNoiseB();

void setup(){
  //size(1000,1000);
  float factor = 4;
  width = 1000*int(factor);
  height = 1000*int(factor);
  partA.init(133);
}

int ii = 0;

void draw(){
  ii += 1;
  if (ii<= -100){
     saveFrame("out-####.png");
  exit();  
}
  partA.update();
  //partA.draw();
}

void keyPressed(){
  partA.keyPressed();
}
