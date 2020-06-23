void setup(){
  size(1000,1000);
  draw_();
}

float mnoise(float x, float y){
  return noise(x, y)*2-1;

}

color colnoise(float x, float y){
  float noi = noise(x+100, y+100);
  float noi2 = noise(x+300, y+200);
  color c = color(noi*255, noi2*255, 0);
  c = lerpColor(c, color(255), .2);
  return c;
}

color colnoise2(float x, float y){
  float noi = noise(x+100, y+100);
  float noi2 = noise(x+300, y+200);
  color c = color(noi*255, noi*noi2*255, noi2*255);
  c = lerpColor(c, color(255), .2);
  return c;
}

void draw_(){
  background(0);
  int n = 100000;
  float res = 5;
  float res2 = 2;
  float sy = 30;
  float sx = 2;
  
  for (int i = 0; i < n; i++){
    float x = random(width);
    float y = random(height);
    float noi = mnoise(x/width*res, y/height*res);
    float nnoi = (noi+1)/2;
    float anoi = abs(noi);
    float g = random(-1,1);
    if (g<=noi){
      res2 = 3;
      color c = colnoise(x/width*res2, y/height*res2);
      stroke(c, pow(random(1), 10)*255);
      float s = pow(random(1), 10)*6;
      s = random(1)*anoi*10;
      //s = (anoi<.3)?0:s;
      strokeWeight(s);
      //strokeWeight(0);
      point(x, y);
    }else{
      if (noi>-1){
      color c = colnoise(x/width*res2+100,200+ y/height*res2);
      stroke(c, 70);
      float x1 = x+randomGaussian()*sx;
      float x2 = x+randomGaussian()*sx;
      float syy = anoi*sy;
      float y1 = y+syy/2;
      float y2 = y-syy/2;
      strokeWeight(2);
      line(x1,y1,x2,y2);
      }
    }
  }

}

void draw(){
}

void keyPressed(){
  if (keyCode == 32){
    noiseSeed((int)random(100));
    draw_();
  }
  if (key=='s'){
    saveFrame("out-####.png");
  }
}
