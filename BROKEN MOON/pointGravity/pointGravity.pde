void setup(){
  size(1000, 1000);
  arrayPoints = new ArrayList<Point>();
  stroke(0);
  strokeWeight(10);
  iniPoints();
}

float G = 100;

void iniPoints(){
  for (int i =0;i<5;i++){
    Point p = new Point();
    arrayPoints.add(p);
  }
}

class Point{
  PVector pos;
  PVector vel = new PVector(0,0);
  float m = 1;
  Point(){
    pos = new PVector(random(1)*width, random(1)*height);
    //vel = new PVector(random(1), random(1));
  }
  
  void update(){
    pos = PVector.add(pos, vel);
    
    pos.x = max(0,pos.x);
    pos.x = min(width, pos.x);
    pos.y = max(0,pos.y);
    pos.y = min(height, pos.y);
    
    for (Point p : arrayPoints){
      if (p!=this){
        PVector d = PVector.add(p.pos, PVector.mult(pos, -1));
        float f = G*m*p.m/(d.mag()*d.mag());
        d.normalize();
        PVector out = PVector.mult(d, f);
        vel = PVector.add(vel, out);
      }
    }
  }
  
  void draw(){
    point(pos.x, pos.y);
  }
}

ArrayList<Point> arrayPoints;

void draw(){
  background(200);
  
  for (Point p:arrayPoints){
    p.update();
    p.draw();
  }
}
