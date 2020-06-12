import com.hamoid.*;

VideoExport cama;
boolean video;
float rotat;
void setup(){
size(500,500,P2D);
t= 0.;
rotat = 0;
video = true;
cama = new VideoExport(this);
if (video){
  cama.startMovie();
}
//draw_();

}

float t;

PVector perlinize(float x, float y){
  float scale = .01;
  float strength = 20;
  float angle = (noise(x*scale+t, y*scale+t/2)*2-1)*PI;
  PVector modif = new PVector(cos(angle)*strength, sin(angle)*strength);
  modif.rotate(t);
  PVector out = new PVector(x, y).add(modif);
  return out;
}
  
color getShading(float x, float y){
  float scale = .01;
  float value1 = (noise(x*scale+t, y*scale+t/2));
  float value2 = (noise(x*scale+t+500, 200+y*scale+t/2));
  float shade = 255-value1*255;
  return color(shade, 30,value2*255);
}


void draw(){
  pushMatrix();
  translate(width/2, height/2);
  draw_();
  if (video){
    cama.saveFrame();
  }
  popMatrix();
}

// from https://www.bit-101.com/blog/2019/01/perlinized-hexagons/

void hexagone(float x, float y, float r){
  float theta = 0;
  for (int i = 0; i<6; i++){
    PVector p = perlinize(x+cos(theta)*r, y+sin(theta)*r);
    vertex(p.x, p.y);
    theta += PI/3;
  }
}
 
void draw_(){
  t += .02;
  background(200);
  float radius = 10;
  float ydelta = sin(PI/3)*radius;
  boolean even = true;
  
  for (float y =-width/2-50; y<width/2+50; y+= ydelta){
    float offset = 0;
    float yy = y;
    offset = (even)?radius*1.5:offset;
    for (float x=-height/2 -50; x<height/2+50; x += radius*3.){
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
  if (key == 'q' && video){
    cama.endMovie();
    exit();
  }
}
