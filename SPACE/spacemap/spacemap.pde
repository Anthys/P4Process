import peasy.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PeasyCam cam;
PostFX fx;

void setup(){
  size(500,500,P3D);
  cam = new PeasyCam(this, 300);
  fx = new PostFX(this); 
  
  points = new ArrayList<PVector>();
  colores = new ArrayList<Integer>();
  
  int n = 1000;
  float sqed = 300;
  for (int i = 0;i <n; i++){
    float x = random(-sqed,sqed);
    float y = random(-sqed, sqed);
    float z = random(-sqed, sqed);
    color c = rColor();
    colores.add(c);
    points.add(new PVector(x, y, z));
  }

}

color rColor(){
  color out = color(random(255), 100, 200);
  return out;
}

void draw_points(){
  for (int i=0; i<points.size(); i++){
    PVector p = points.get(i);
    color c = colores.get(i);
    strokeWeight(10);
    stroke(c);
    point(p.x+noise(p.x+float(frameCount)/50)*50, p.y, p.z);
  }
  //filter( BLUR, 3);
  //box(100);
  cam.beginHUD();
  //fx.render().bloom(.5, 20,40).compose();
  fx.render().blur(10,10.).compose();
  cam.endHUD();
  for (int i=0; i<points.size(); i++){
    PVector p = points.get(i);
    color c = colores.get(i);
    strokeWeight(7);
    stroke(c);
    point(p.x+noise(p.x+float(frameCount)/50)*50, p.y, p.z);
  }

}


ArrayList<PVector> points;
ArrayList<Integer> colores;

void draw(){
  background(25,25,50);
  draw_points();
}
