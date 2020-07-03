//progfay

final int MAX_LEVEL = 7;
int R;
final float PERSENT = 1;

static ArrayList<Triangle> triangles = new ArrayList<Triangle>();
static ArrayList<Stroke> edges = new ArrayList<Stroke>();

void setup() {
  fullScreen();
  background(0);
  
  R = int(min(width, height) * 0.5);

  trianglate(
    new Triangle(
    new Point(R*cos(radians( 30)), R*sin(radians( 30))), 
    new Point(R*cos(radians(150)), R*sin(radians(150))), 
    new Point(R*cos(radians(270)), R*sin(radians(270)))
    )
    );

  translate(width*0.5, height*0.6);
  stroke(0);
  fill(-1);
  new Triangle(
    new Point(R*cos(radians( 30)), R*sin(radians( 30))), 
    new Point(R*cos(radians(150)), R*sin(radians(150))), 
    new Point(R*cos(radians(270)), R*sin(radians(270)))
    ).draw();
  // noStroke();
  
  for (Triangle triangle : triangles) {
   if (random(1) < PERSENT) {
     triangle.draw();
   }
 }
}
