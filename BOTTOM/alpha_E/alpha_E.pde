NoiseDance nd = new NoiseDance();
NoiseDance.CurvNoise cv;

void setup(){
  cv = nd.new CurvNoise();
  
  size(1000,1000);
  cv.init();

}


void draw(){
  cv.update();
  cv.draw();
}

void keyPressed(){
cv.keyPressed();
}
