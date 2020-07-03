void fripping(Stroke frip) {
  int index1 = -1;
  int index2 = -1;
  for (int i = 0; i < triangles.size(); i++) {
    if (triangles.get(i).hasEdge(frip)) {
      if (index1 == -1) {
        index1 = i;
        continue;
      } else {
        index2 = i;
        break;
      }
    }
  }

  if (index1 == -1 || index2 == -1) {
    fripping(edges.get((int)random(edges.size())));
    return;
  }

  Stroke fripped = otherDiagonal(triangles.get(index1), triangles.get(index2), frip);
  if (fripped.endpoints[0].equals(fripped.endpoints[1])) {
    fripping(edges.get((int)random(edges.size())));
    return;
  }

  Triangle ft1 = new Triangle(fripped.endpoints[0], fripped.endpoints[1], frip.endpoints[0]);
  Triangle ft2 = new Triangle(fripped.endpoints[0], fripped.endpoints[1], frip.endpoints[1]);
  triangles.remove(index1);
  triangles.remove(index2-1);
  triangles.add(ft1);
  triangles.add(ft2);
  edges.remove(frip);
  edges.add(fripped);
  //println(ft1);
  //println(ft2);
  //println();
}

Stroke otherDiagonal(Triangle t1, Triangle t2, Stroke diagonal) {
  Point p1 = t1.vertex[0];
  Point p2 = t2.vertex[0];
  if (diagonal.contain(p1)) {
    p1 = t1.vertex[1];
    if (diagonal.contain(p1)) {
      p1 = t1.vertex[2];
    }
  }
  if (diagonal.contain(p2)) {
    p2 = t2.vertex[1];
    if (diagonal.contain(p2)) {
      p2 = t2.vertex[2];
    }
  }
  //if (p1.equals(p2)) {
  //  println(t1);
  //  println(t2);
  //  println(diagonal);
  //  println(p1, p2);
  //  println();
  //}
  return new Stroke(p1, p2);
}
