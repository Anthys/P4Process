class Point{
  int x;
  int y;
  int s;
  
  Point(int xx, int yy){
    x = xx;
    y = yy;
    s = 5;
  };
    
  void draw(){
    strokeWeight(s);
    point(x, y);
  };
};
