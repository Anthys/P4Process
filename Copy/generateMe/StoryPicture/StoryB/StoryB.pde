void setup() {
  size(800,800);
  smooth(8);
  noFill();
  makeme();
}
 
void makeOptions() {
  shape_closed = random(1)<0.5 ? true : false;
}
 
boolean shape_closed = true;
float yoff = random(1.0);
void makeme() {
  background(20);
  translate(400,400);
  makeOptions(); // calculate some random parameters
  for(int iter=0;iter<3000;iter++) {
    stroke(240, random(5.0,20.0));
    strokeWeight(random(1.0));
    float xoff = random(1.0);
    beginShape();
    for (float ang=random(0.2); ang<random(0.8,0.9)*TWO_PI; ang+=random(TWO_PI/200.0)) {
      float r = map(noise(xoff, yoff*5.0), 0, 1, 20, 400);
      float x = r * cos(ang);
      float y = r * sin(ang);
      vertex(x, y);
      xoff += random(0.01,0.05);
    }
    yoff += random(0.01,0.05);
    if(shape_closed) endShape(CLOSE); else endShape();
  }
}
 
void draw() {}
void keyPressed() { saveFrame("f####.jpg"); }
void mousePressed() { makeme(); }
