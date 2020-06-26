ArrayList<PVector> particles;
ArrayList<Float> isov;

void setup(){
  size(500,500);
  particles = new ArrayList<PVector>();
  isov = new ArrayList<Float>();
  init();
}

void draw(){
  draw_();
}

float mnoise(float x, float y){
  float res = 4;
  x = x/width*res;
  y = y/height*res;
  return noise(x, y);
}

void update(int i){
  PVector p = particles.get(i);
  float x = p.x;
  float y = p.y;
  float res = 4;
  float r = 2;
  float stre1=3;
  float ds = 10;
  PVector[] next = new PVector[]{new PVector(0,ds), new PVector(0,-ds), new PVector(ds,0), new PVector(-ds,0)};
  float cn = mnoise(x, y);
  
  PVector bp = PVector.add(next[0], p);
  float min_dn = abs(cn-mnoise(bp.x, bp.y));
  
  for (int j = 1; j<next.length;j++){
    PVector p2 = next[j];
    PVector pot = PVector.add(p, p2);
    float cdn = abs(cn-mnoise(pot.x, pot.y));
    if (cdn < min_dn){
      min_dn = cdn;
      bp = pot;
    }
  }
  particles.set(i, bp);
}

void draw_(){
  background(200);
  for (int i = 0; i<particles.size();i++){
    PVector p = particles.get(i);
    update(i);
    point(p.x,p.y);
  
  }
}

void init(){
  background(200);
  particles.clear();
  int n = 5000;
  for (int i= 0; i<n; i ++){
    float x = random(width);
    float y = random(height);
    particles.add(new PVector(x, y));
    particles.add(new PVector(x, y));
  }
}
