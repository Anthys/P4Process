void setup() {
  size(800,800);
  smooth(8);
  noFill();
  
  cback = color(23, 67, 88);
  cfront = color(233, 131, 45);
  
  makeme();
  
  
}

color cback = #9133B9;
color cfront = #FF2441;

 
float yoff = 0.0;
void makeme() {
  background(cback);
  for(int iter=0;iter<2000;iter++) {
    stroke(cfront, random(5,20));
    strokeWeight(2*noise(20,200));
    beginShape();
    float xoff2 = random(1.0);
    for (float x = 0; x <= width; x += 5) {
      float y = map(noise(xoff2, yoff*20.0), 0, 1, 20, 800);
      vertex(x, y);
    }
    yoff += .01;
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  }
}
 
void draw() {}
void keyPressed() {saveFrame("f####.png"); }
void mousePressed() { makeme(); }
