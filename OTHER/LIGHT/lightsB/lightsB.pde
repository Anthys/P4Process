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
  background(0);
  init();
}

void init(){
  noiseSeed((int)random(100));
  cvs = createGraphics(width, height);
  points.clear();
  int n = width+500;
  for (int i = 0;i<n;i++){
    points.add(new Point(i-100, 1, i-100, 0));
  }
}

void draw(){
  background(0);
  for (int j=0;j<10;j++){
    cvs.beginDraw();
    cvs.stroke(255,  6);
    for (int i=points.size()-1;i>=0;i--){
      Point p = points.get(i);
      cvs.line(p.px, p.py, p.x, p.y);
      if (p.y>cvs.height){
        points.remove(i);
      }
    }
    cvs.endDraw();
    for (int i=0;i<points.size();i++){
      Point p = points.get(i);
      p.px = p.x;
      p.py = p.y;
      p.x += noise(p.x/250, p.y/250)*2-1;
      p.y+=noise(p.x/250, p.y/250+200);
    }
  }
    
  image(cvs, 0,0);
}


void keyPressed(){
  if (keyCode == 32){
    init();
  }
}
