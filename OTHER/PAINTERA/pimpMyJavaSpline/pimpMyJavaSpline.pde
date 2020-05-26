ArrayList<PVector> vectors = new ArrayList<PVector>();
PGraphics pg;

CoolSpline a;


void setup(){
  size(500,500);
  pg = createGraphics(100,100);
  vectors.add(new PVector(10, 10));
  vectors.add(new PVector(90, 20)); 
  vectors.add(new PVector(50,20));
  vectors.add(new PVector(50,100));
  vectors.add(new PVector(300,100));
  a = new CoolSpline(pg, 3, 3, vectors);
  b = new CoolSpline(pg, 3, 3, vectors);
}

void draw(){
  a.draw();
  image(pg,0,0);
}
