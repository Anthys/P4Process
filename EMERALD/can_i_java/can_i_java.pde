import peasy.*;

PeasyCam cam;
PShape cube;
float t;

public void setup(){
  size(500,500,P3D);
  cam = new PeasyCam(this,400);
  t = millis();
  cube = loadShape("monkey.obj");
  println(millis()-t);
}

void alternate_shape(PShape s){
  fill(255);
  stroke(0);
  strokeWeight(0.1);
  for (int i = 0; i< s.getChildCount(); i++){
    PShape f = s.getChild(i);
    beginShape();
    for (int j=0; j < f.getVertexCount();j++){
      PVector v = f.getVertex(j);
      vertex(v.x, v.y, v.z);
    }
    endShape(CLOSE);
  }
}

void draw_things(){
  scale(50);
  PVector a = cube.getChild(0).getVertex(0);
  a.x += 0.001;
  cube.getChild(0).setVertex(0,a);
  alternate_shape(cube);
}

public void draw(){
  background(100);
  draw_things();
  if (frameCount%30 == 0){
  println(millis()-t);}
  t = millis();
  
}
