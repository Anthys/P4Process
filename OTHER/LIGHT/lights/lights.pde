class Point{
  float x;
  float y;
  float px;
  float py;
  
  Point(float xx, float yy, float pxx, float pyy){
    x = xx;
    y = yy;
    px = pxx;
    py = pyy;
  }
}

ArrayList<Point> points = new ArrayList<Point>();
PGraphics cvs;
void setup(){
  size(1000,1000);
  cvs = createGraphics(width, height);
  int n = 1000;
  for (int i = 0;i<n;i++){
    points.add(new Point(i-100, 1, i-100, 0));
  }
  background(0);
  
}

void draw(){
  background(0);
  for (int j=0;j<10;j++){
    cvs.beginDraw();
    cvs.stroke(255,  6);
    for (int i=0;i<points.size();i++){
      Point p = points.get(i);
      cvs.line(p.px, p.py, p.x, p.y);
    }
    cvs.endDraw();
    if (points.get(0).y>cvs.height){
    noLoop();
    }
    for (int i=0;i<points.size();i++){
      Point p = points.get(i);
      p.px = p.x;
      p.py = p.y;
      p.x += noise(float(i)/250, p.y/250)*2-1;
      p.y+=1;
    }
  }
    
  image(cvs, 0,0);
}
