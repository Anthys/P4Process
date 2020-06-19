
PImage img;


void settings(){
   img = loadImage("img.jpg");
   size(img.width, img.height);

}

void setup(){
  
  ArrayList<PVector> poly;

  background(255);
  noStroke();
  fill(255, 0, 0, 10);

  ArrayList<PVector> base_poly, variation;
  float r = 5;

  base_poly = create_base_poly(width/2, height/2, width/3, 10);
  variation = deform(base_poly, 5, random(r/10, r/4), 4);
  
  poly = variation;
  ArrayList<ArrayList<PVector>> spoly;
  spoly = polystack(width/2, height/2, width/3, 10);
  draw_stack(spoly);
}

void draw_poly(ArrayList<PVector> poly){
  beginShape();
  for (int i = 0; i < poly.size(); i++)
    vertex(poly.get(i).x, poly.get(i).y);
  endShape(CLOSE);
}

void draw_stack(ArrayList<ArrayList<PVector>> stack) {
  for (int i = 0; i < stack.size(); i++) {
    ArrayList<PVector> poly = stack.get(i);
    draw_poly(poly);
  }
}


ArrayList<ArrayList<PVector>>
polystack(float x, float y, float r, int nsides) {
  ArrayList<ArrayList<PVector>> stack;
  ArrayList<PVector> base_poly, poly;
  stack = new ArrayList<ArrayList<PVector>>();

  /* Generate a base polygon with depth 5 and variance 15 */
  base_poly = rpoly(x, y, r, nsides);
  base_poly = deform(base_poly, 5, r/10, 2);

  /* Generate a variation of the base polygon with a random variance */
  for (int k = 0; k < 100; k++) {
    poly = deform(base_poly, 5, random(r/15, r/5), 4);
    stack.add(poly);
  }

  return stack;
}


ArrayList<PVector> deform(ArrayList<PVector> points, int depth,
                            float variance, float vdiv) {

  float sx1, sy1, sx2 = 0, sy2 = 0;
  ArrayList<PVector> new_points = new ArrayList<PVector>();

  if (points.size() == 0)
    return new_points;

  /* Iterate over existing edges in a pairwise fashion. */
  for (int i = 0; i < points.size(); i++) {
    sx1 = points.get(i).x;
    sy1 = points.get(i).y;
    sx2 = points.get((i + 1) % points.size()).x;
    sy2 = points.get((i + 1) % points.size()).y;

    new_points.add(new PVector(sx1, sy1));
    subdivide(new_points, sx1, sy1, sx2, sy2,
                depth, variance, vdiv);
  }

  return new_points;
}

/*
 * Recursively subdivide a line from (x1, y1) to (x2, y2) to a
 * given depth using a specified variance.
 */
void subdivide(ArrayList<PVector> new_points,
                 float x1, float y1, float x2, float y2,
                 int depth, float variance, float vdiv) {
  float midx, midy;
  float nx, ny;

  if (depth >= 0) {
    /* Find the midpoint of the two points comprising the edge */
    midx = (x1 + x2) / 2;
    midy = (y1 + y2) / 2;

    /* Move the midpoint by a Gaussian variance */
    nx = midx + randomGaussian() * variance;
    ny = midy + randomGaussian() * variance;

    /* Add two new edges which are recursively subdivided */
    subdivide(new_points, x1, y1, nx, ny,
                depth - 1, variance/vdiv, vdiv);
    new_points.add(new PVector(nx, ny));
    subdivide(new_points, nx, ny, x2, y2,
                depth - 1, variance/vdiv, vdiv);
  }
}

ArrayList<PVector> create_base_poly(float x, float y,
                                      float r, int nsides) {
  ArrayList<PVector> bp;
  bp = rpoly(x, y, r, nsides);
  bp = deform(bp, 5, r/10, 2);
  return bp;
}




ArrayList<PVector> rpoly(float x, float y, float r, int nsides){
  ArrayList<PVector> points = new ArrayList<PVector>();
  float sx, sy;
  float angle = TWO_PI/nsides;
  
  for (float a=0; a <TWO_PI; a+=angle){
    sx = x + cos(a)*r;
    sy = y +sin(a)*r;
    points.add(new PVector(sx, sy));
  }
  return points;
}

void draw_(){
}

void draw(){
  draw_();
}
