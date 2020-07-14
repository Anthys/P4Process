ArrayList<PVector> particles;
ArrayList<Float> angles;
ArrayList<Integer> cols;
float t;

PGraphics cvs;

void setup(){
  size(1000,1000);
  particles = new ArrayList<PVector>();
  angles = new ArrayList<Float>();
  cols = new ArrayList<Integer>();
  init();
  t = 0;
  
}

float mnoise(float x, float y){
  return noise(x,y)*2-1;
}

float update(int i){
  PVector p = particles.get(i);
  float a = angles.get(i);
  float x = p.x;
  float y = p.y;
  float res = 4;
  float r = 2;
  float stre1=.1;
  x = x/width*res;
  y = y/height*res;
  //a += (noise(x, y)*2-1)*stre1;
  //angles.set(i, a);
  //a = noise(x, y, t+float(i%100)/1000)*TWO_PI*2;
  float a2 = a + .005*mnoise(x, y)*TWO_PI*2;
  a = lerp(a, a2, 1);
  angles.set(i, a);
  a = mnoise(x, y+i*5)*TWO_PI*2;
  float newx = p.x + r*cos(a);
  float newy = p.y + r*sin(a);
  float m0 = .7;
  PVector newp = new PVector(lerp(p.x, newx, m0), lerp(p.y, newy, m0));
  particles.set(i, newp);
  return a;
}

void draw_(){
  //background(200);
  cvs.beginDraw();
  for (int i = 0; i<particles.size();i++){
    PVector p = particles.get(i);
    float a = angles.get(i);
    color c = cols.get(i);
    a = update(i);
    //stroke(0,50);
    cvs.stroke(c, 50);
    cvs.strokeWeight(5);
    //point(p.x, p.y);
    PVector normal = new PVector(-sin(a), cos(a));
    int npoints = 7;
    float dis = 60;
    for (int j=0;j<npoints;j++){
     float cdis= dis/npoints*j-dis/2;
     PVector spos = PVector.add(p, PVector.mult(normal, cdis));
     if (saturation(cvs.get(int(spos.x), (int)spos.y))!=0){continue;}
     else{cvs.point(spos.x, spos.y);}
    }
    //fill(c, 50);
    //circle(p.x, p.y, 5);
  
  }
  cvs.endDraw();
  image(cvs, 0,0);
  
}

void draw(){
  t = (float)frameCount/100;
  draw_();

}

void init(){
  cvs = createGraphics(width, height);
  cvs.beginDraw();
  cvs.background(255);
  cvs.endDraw();
  particles.clear();  
  angles.clear();
  cols.clear();
  int n = 5;
  for (int i= 0; i<n; i ++){
    float x = width/2+random(-100,100);
    float y = height/2+random(-100,100);
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
