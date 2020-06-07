void setup(){
  size(500,500);
  draw_();
}

void mypoint(float x, float y){
  strokeWeight(10);
  point(x,y);
}

float transfo1(int alpha, float nois){
  
  float out = 0;
  
  out = cos(nois*alpha);
  out = sin(alpha)*out;
  
  return out;
  
}

float transfo2(int alpha, float nois){
  
  float out = 0;
  
  out = cos(alpha);
  out = sin(alpha*2*nois)*cos(out*nois);
  
  return out;
  
}

void draw_(){
  background(200);
  translate(width/2, height/2);
  int mxi = 360;
  float r = 200;
  for (int alpha = 0; alpha<mxi; alpha++){
    float x = transfo1(alpha+100, float(frameCount)/10000)*r;
    float y = transfo2(alpha-100, float(frameCount)/10000)*r;
    mypoint(x,y);
  }
}

void draw4_(){
  background(200);
  translate(width/2, height/2);
  int mxi = 360;
  float r = 200;
  for (int alpha = 0; alpha<mxi; alpha++){
    float x = transfo1(alpha, float(frameCount)/10000)*r;
    float y = transfo2(alpha, float(frameCount)/10000)*r;
    mypoint(x,y);
  }
}

void draw3_(){
  background(200);
  translate(width/2, height/2);
  int mxi = 360;
  float r = 200;
  for (int alpha = 0; alpha<mxi; alpha++){
    float x = transfo1(alpha, float(frameCount)/10000)*r;
    float y = transfo1(alpha*2, float(frameCount)/10000)*r;
    mypoint(x,y);
  }
}


void draw2_(){
  background(200);
  translate(width/2, height/2);
  int mxi = 360;
  float r = 200;
  for (int alpha = 0; alpha<mxi; alpha++){
    float x = transfo1(alpha, float(frameCount)/10000)*r;
    float y = transfo1(mxi-alpha, float(frameCount)/10000)*r;
    mypoint(x,y);
  }
}

void draw1_(){
  background(200);
  translate(width/2, height/2);
  int mxi = 360;
  float r = 200;
  for (int alpha = 0; alpha<mxi; alpha++){
    float x = transfo1(alpha, float(frameCount)/10000)*r;
    float y = sin(alpha)*r;
    mypoint(x,y);
  }
}

void draw(){
  draw_();
}
