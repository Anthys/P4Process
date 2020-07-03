void trianglate(Triangle parent) {
  // parent.draw();
  triangles = new ArrayList<Triangle>();
  triangles.add(parent);
  dividate(parent, 0);
}

void dividate(Triangle parent, int level) {
  if (level >= MAX_LEVEL) return;
  Point center = parent.center();
  edges.add(new Stroke(parent.vertex[0], center));
  edges.add(new Stroke(parent.vertex[1], center));
  edges.add(new Stroke(parent.vertex[2], center));
  Triangle t1 = new Triangle(parent.vertex[0], parent.vertex[1], center);
  Triangle t2 = new Triangle(parent.vertex[1], parent.vertex[2], center);
  Triangle t3 = new Triangle(parent.vertex[2], parent.vertex[0], center);
  triangles.add(t1);
  triangles.add(t2);
  triangles.add(t3);
  triangles.remove(parent);
  dividate(t1, level+1);
  dividate(t2, level+1);
  dividate(t3, level+1);
}
