class Stroke {
  Point [] endpoints = new Point [2];

  Stroke(Point p1, Point p2) {
    this.endpoints[0] = p1;
    this.endpoints[1] = p2;
  }

  boolean equals(Stroke target) {
    return (this.endpoints[0].equals(target.endpoints[0])
      && this.endpoints[1].equals(target.endpoints[1]))
      || (this.endpoints[0].equals(target.endpoints[1])
      && this.endpoints[1].equals(target.endpoints[0]));
  }

  boolean equals(Point p1, Point p2) {
    if (this.endpoints[0] == null) return false;
    if (this.endpoints[1] == null) return false;
    // println(this.endpoints[0], this.endpoints[1]);
    return (this.endpoints[0].equals(p1)
      && this.endpoints[1].equals(p2))
      || (this.endpoints[0].equals(p2)
      && this.endpoints[1].equals(p1));
  }

  void draw() {
    line(this.endpoints[0].x, this.endpoints[0].y, 
      this.endpoints[1].x, this.endpoints[1].y);
  }

  boolean contain(Point target) {
    return this.endpoints[0].equals(target) || this.endpoints[1].equals(target);
  }
  
  String toString() {
    return "[ " + this.endpoints[0] + " , " + this.endpoints[1] + " }";
  }
}
