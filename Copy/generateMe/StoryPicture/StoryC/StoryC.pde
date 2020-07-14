void setup() {
  size(800,800);
  smooth(8);
  noFill();
  makeme();
}
 
void makeOptions() {
  shape_closed = random(1)<0.5 ? true : false;
  shiftxy = (int)random(3);
  do_absx = random(1)<0.5 ? true : false;
  do_absy = random(1)<0.5 ? true : false;
  do_blocky = random(1)<0.75 ? true : false;
}
 
// background grid
void makeBackground() {
  background(37,49,63);
  strokeWeight(1);
  pushMatrix();
  translate(400,400);
  rotate(HALF_PI/2.0);
  for(float x=-600;x<600;x+=random(5)) {
    stroke(90,104,115,random(5,15));
    line(-600,x,600,x);
    line(x,-600,x,600);
  }
  popMatrix();
}
 
boolean do_absx=false;
boolean do_absy=false;
boolean do_blocky=true;
int shiftxy = 0;
boolean shape_closed = true;
 
float yoff = random(1.0);
void makeme() {
  makeBackground();
  pushMatrix();
  if(do_blocky) translate(360,360); else translate(400,400);
  makeOptions(); // calculate some random parameters
 
  for(int iter=0;iter<3000;iter++) {
 
    // gold line
    boolean gold_line = false;
    if(random(1)>0.01) {
      stroke(lerpColor(color(255,241,170),color(255,255,250),random(1)), random(5.0,20.0));
      strokeWeight(random(1.0));
    } else {
      gold_line = true;
      stroke(253,155,87,random(20,60));
      strokeWeight(random(1.0,1.5));
    }
 
    float xoff = random(1.0);
    beginShape();
    for (float ang=random(0.2); ang<random(0.8,0.9)*TWO_PI; ang+=random(TWO_PI/200.0)) {
 
      float ll,rr;
      if(gold_line) { ll=120; rr=320; } else { ll=20; rr=400; }
 
      float r = map(noise(xoff, yoff*5.0), 0, 1, ll, rr);
      float x = r * cos(ang);
      float y = r * sin(ang);
 
      // shift
      if( (shiftxy == 1 && x>0.0) || (shiftxy == 2 && y>0.0)) {
        x += 20.0;
        y += 20.0;
      } else if(shiftxy > 0.0) {
        x -= 20.0;
        y -= 20.0;
      }
 
      // rectangles
      if(do_blocky) {
        float sx = (do_absx?abs(x):x) % 40.0;
        float sy = (do_absy?abs(y):y) % 40.0;
        int xx = (int)(x/40.0);
        int yy = (int)(y/40.0);
        x = xx*40.0 + (40-sx);
        y = yy*40.0 + (40-sy);
      }
 
      vertex(x, y);
      xoff += random(0.01,0.05);
    }
    yoff += random(0.01,0.05);
    if(shape_closed) endShape(CLOSE); else endShape();
  }
  popMatrix();
}
 
void draw() {}
void keyPressed() { saveFrame("f####.jpg"); }
void mousePressed() { makeme(); }