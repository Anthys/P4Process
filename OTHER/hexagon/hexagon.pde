void setup(){
size(500,500,P2D);
t= 0.;
draw_();
}
float t;

float[] perlinize(float x, float y){
  float scale = .01;
  float strength = 50;
  float angle = noise(x*scale, y*scale, t)*2-1;
  float[] out = {x+cos(angle)*strength, y+sin(angle)*strength};
  return out;
}
  
color getShading(float x, float y){
  float scale = .01;
  float value = (noise(x*scale, y*scale, t));
  float shade = 255-value*255;
  return color(shade);
}


void draw(){
  draw_();
}

// from https://www.bit-101.com/blog/2019/01/perlinized-hexagons/

void hexagone(float x, float y, float r){
  float theta = 0;
  for (int i = 0; i<6; i++){
    float[] p = perlinize(x+cos(theta)*r, y+sin(theta)*r);
    vertex(p[0], p[1]);
    theta += PI/3;
  }
}
 
void draw_(){
  t += .01;
  background(200);
  float radius = 10;
  float ydelta = sin(PI/3)*radius;
  boolean even = true;
  
  for (float y =0; y<900; y+= ydelta){
    float offset = 0;
    float yy = y;
    offset = (even)?radius*1.5:offset;
    for (float x= 0; x<900; x += radius*3.){
      noFill();
      fill(getShading(x+offset, y));
      beginShape();
      hexagone(x+offset, y, radius);
      endShape();
   }
   even = !even;
  
  }
}

void keyPressed(){
  if (keyCode == 32){
    noiseSeed(int(random(0,100)));
    draw_();
  }
}
