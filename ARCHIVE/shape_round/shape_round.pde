Point[] points;
void setup() {
  size(500,500);

  points = new Point[3];
  points[0] = new Point(0,0);
  points[1] = new Point(0,100);
  points[2] = new Point(100,0);
};

void draw() {
  translate(width/2, height/2);
  background(200);
  for (int i = 0; i<3; i++){
    points[i].draw();
  };
  
  fill(255,0,0);
  beginShape();
  for (int i = 0; i<3; i++){
    curveVertex(points[i].x, points[i].y);
  };
  endShape();
  
}
/**
def draw():
    background(200)
    translate(width/2, height/2)
    points = [Point(0,0),Point(50,0), Point(0,50)]
    
    for p in points:
        p.draw()
    
    fill(255,0,0)
    beginShape()
    for p in points:
        curveVertex(p.x, p.y)
    endShape()
        */
