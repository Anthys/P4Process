ArrayList<PVector> particles;
ArrayList<Float> angles;
ArrayList<Integer> cols;

void setup(){
  size(1000,1000);
  particles = new ArrayList<PVector>();
  angles = new ArrayList<Float>();
  cols = new ArrayList<Integer>();
  init();
  
}

void update(int i){
  PVector p = particles.get(i);
  float a = angles.get(i);
  float x = p.x;
  float y = p.y;
  float res = 4;
  float r = 2;
  float stre1=3;
  x = x/width*res;
  y = y/height*res;
  a += (noise(x, y)*2-1)*stre1;
  angles.set(i, a);
  p.add(new PVector(r*cos(a), r*sin(a)));
}

void draw_(){
  //background(200);
  for (int i = 0; i<particles.size();i++){
    PVector p = particles.get(i);
    float a = angles.get(i);
    color c = cols.get(i);
    update(i);
    stroke(0,50);
    stroke(c, 50);
    fill(c, 50);
    circle(p.x, p.y, 5);
  
  }
  
}

void draw(){
  draw_();

}

void init(){
  background(200);
  particles.clear();  
  angles.clear();
  cols.clear();
  int n = 5000;
  for (int i= 0; i<n; i ++){
    float x = random(width);
    float y = random(height);
    particles.add(new PVector(x, y));
    float a = random(0,2*TWO_PI);
    angles.add(a);
    int c = ncol(x, y);
    cols.add(c);
  }
}

color ncol(float x, float y){
  color c1 = color(random(255), 100, 200);
  c1 = color(random(255), 50, 50);
  color c2 = color(0);
  color c3 = lerpColor(c1, c2, .1);
  return c3;
}

void keyPressed(){
  if (keyCode == 32){
    noiseSeed((int)random(100));
    init();
  }
  if (key=='s'){
    saveFrame("out-####.png");
  }

}
