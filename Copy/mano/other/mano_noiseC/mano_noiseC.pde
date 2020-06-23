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
  int n = 100;
  float res = 5;
  float res2 = 2;
  float sy = 30;
  float sx = 2;
  
  for (int i = 0; i < n; i++){
    for (int j=0; j<n;j++){
    float x = float(width)/n*i;
    float y = float(height)/n*j;
    float noi = mnoise(x/width*res, y/height*res, 0);
    float nnoi = (noi+1)/2;
    float anoi = abs(noi);
    float g = mnoise(x/width*res+100,y/height*res+300, 0);
    if (g<=noi){
      res2 = 3;
      color c = colnoise(x/width*res2, y/height*res2);
      stroke(c, pow(noise(x/width*res+30), 10)*255);
      float s = pow(noise(x/width*res+40), 10)*6;
      s = random(1)*nnoi*10;
      //s = (anoi<.3)?0:s;
      strokeWeight(s);
      //strokeWeight(0);
      point(x, y);
    }else{
      color c = colnoise(x/width*res2+100,200+ y/height*res2);
      stroke(c, 70);
      float x1 = x+randomGaussian()*sx;
      float x2 = x+randomGaussian()*sx;
      float syy = anoi*sy;
      float y1 = y+syy/2;
      float y2 = y-syy/2;
      float s = (1-nnoi)*2;
      strokeWeight(s);
      line(x1,y1,x2,y2);
      
    }
  }
  }
}

void draw(){
  draw_();
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
