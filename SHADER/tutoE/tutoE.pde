
import peasy.PeasyCam;

PeasyCam cam;
PShape back;
PShape glass;
PImage i;
void setup(){
  size(500,500,P3D);
  i = loadImage("pic2.jpg");
  //textureMode(NORMAL);
  back = createBack(0,0,-100.,100.,100.,i);
  cam = new PeasyCam(this, 400);
}

PShape createBack(float x, float y, float z, float sx, float sy, PImage s){
  textureMode(NORMAL);
  PShape sh = createShape();
  noStroke();
  sh.beginShape();
  sh.texture(s);//textureWrap(CLAMP);
  sh.vertex(x-sx/2, y-sy/2, z,0,0);
  sh.vertex(x+sx/2, y-sy/2, z,1,0);
  sh.vertex(x+sx/2, y+sy/2, z,1,1);
  sh.vertex(x-sx/2, y+sy/2, z,0,1);
  sh.endShape(CLOSE);
  return sh;
}

void draw(){
  background(200);
  shape(back);
}
