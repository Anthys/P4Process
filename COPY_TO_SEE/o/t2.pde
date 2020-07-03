class Point {
  float x, y;

  Point(float _x, float _y) {
    this.x = _x;
    this.y = _y;
  }

  boolean equals(Point target) {
    if (target == null) return false;
    return this.x == target.x && this.y == target.y;
  }

  String toString() {
    return "( " + this.x + " , " + this.y + " )";
  }
}

float dist(Point p1, Point p2){
  return dist(p1.x, p1.y, p2.x, p2.y);
}
