class Triangle {
  Point[] vertex = new Point [3];
  color fill_color;

  Triangle() {
  }

  Triangle(Point p1, Point p2, Point p3) {
    this.vertex[0] = p1;
    this.vertex[1] = p2;
    this.vertex[2] = p3;
    //this.fill_color = color(-1);
    //this.fill_color = color(random(255));
    this.fill_color = color(random(255), random(255), random(255));
    //this.fill_color = color(256.0 - 372.0*dist(new Point(0, 0), this.center())/R);
    //this.fill_color = color(degrees(atan2(this.center().x, this.center().y))+180.0, 100, 100.0 - 133.0*dist(new Point(0, 0), this.center())/R);
  }

  void draw() {
    fill(this.fill_color);
    //stroke(this.fill_color);
    //noStroke();
    triangle(
      this.vertex[0].x, this.vertex[0].y, 
      this.vertex[1].x, this.vertex[1].y, 
      this.vertex[2].x, this.vertex[2].y
      );
  }

  Point center() {
    return new Point(
      (this.vertex[0].x+this.vertex[1].x+this.vertex[2].x) / 3.0, 
      (this.vertex[0].y+this.vertex[1].y+this.vertex[2].y) / 3.0
      );
  }

  boolean hasEdge(Stroke target) {
    if (this.vertex[0] == null) return false;
    if (target.endpoints[0] == null) return false;
    return target.equals(this.vertex[0], this.vertex[1])
      || target.equals(this.vertex[1], this.vertex[2])
      || target.equals(this.vertex[2], this.vertex[0]);
  }

  String toString() {
    return "[ " + this.vertex[0] + " , " + this.vertex[1] + " , " + this.vertex[2] + " ]";
  }
}
