void setup(){
  size(1000,1000);
  draw_();
}

float mnoise(float x, float y, float t){
  return noise(x, y, t)*2-1;

}

color colnoise(float x, float y){
  float noi = noise(x+100, y+100);
  float noi2 = noise(x+300, y+200);
  color c = color(noi*255, noi2*255, 0);
  c = color(noi*100+100, noi2*255, noi2*255);
  c = color(noi*100+100, noi*255, noi2*100+150);
  c = color(noi*255, 100, noi2*100);
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
  
  PGraphics c1 = createGraphics(width, height);
  PGraphics c2 = createGraphics(width, height);
  c1.beginDraw();
  c2.beginDraw();
  
  for (int i = 0; i < n; i++){
    float x = random(width);
    float y = random(height);
    float noi = mnoise(x/width*res, y/height*res, 0);
    float nnoi = (noi+1)/2;
    float anoi = abs(noi);
    float g = random(-1,1);
    if (g<=noi){
      res2 = 3;
      color c = colnoise(x/width*res2, y/height*res2);
      c1.stroke(c, pow(random(1), 10)*255);
      float s = pow(random(1), 10)*6;
      s = random(1)*nnoi*10;
      //s = (anoi<.3)?0:s;
      c1.strokeWeight(s);
      //strokeWeight(0);
      c1.point(x, y);
    }else{
      color c = colnoise(x/width*res2+100,200+ y/height*res2);
      c2.stroke(c, 70);
      float x1 = x+randomGaussian()*sx;
      float x2 = x+randomGaussian()*sx;
      float syy = anoi*sy;
      float y1 = y+syy/2;
      float y2 = y-syy/2;
      float s = (1-nnoi)*2;
      s = 3;
      c2.strokeWeight(s);
      c2.line(x1,y1,x2,y2);
      
    }
  }
  c1.endDraw();
  c2.endDraw();
  c2.filter(BLUR,7);
  
  image(c2,0,0);
  image(c1, 0,0);
}

void draw(){
  //draw_();
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
