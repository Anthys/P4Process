import com.hamoid.*;

ArrayList<PVector> particles;
ArrayList<Float> angles;
ArrayList<Integer> cols;
float t;
color cback;

PGraphics cvs;
PGraphics hud;

boolean video;

VideoExport cam;

void setup(){
  size(1000,1000);
  particles = new ArrayList<PVector>();
  angles = new ArrayList<Float>();
  cols = new ArrayList<Integer>();
  init();
  t = 0;
  cback = color(255);
  
  video = false;
  if (video){
     cam = new VideoExport(this);
     cam.startMovie();
  }
  
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
  float acol = collisions(p, a);
  if (acol!=a){
    a = acol;
    angles.set(i, a);
  }else{
    float a2 = a + .005*mnoise(x, y)*TWO_PI*2;
    a = lerp(a, a2, 1);
    //a = mnoise(x, y+i*5)*TWO_PI*2;
    angles.set(i, a);
  }
  float newx = p.x + r*cos(a);
  float newy = p.y + r*sin(a);
  float m0 = .7;
  PVector newp = new PVector(lerp(p.x, newx, m0), lerp(p.y, newy, m0));
  particles.set(i, newp);
  return a;
}

float update2(int i, float di){
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
  PVector normal = new PVector(-sin(a), cos(a));
  float npoints = 10;
  float acol1 = collisions(PVector.add(p, PVector.mult(normal, -di/2)), a);
  float acol2 = collisions(PVector.add(p, PVector.mult(normal, di/2)), a);
  if (acol1+acol2!=0){
    float da = max(acol1,acol2);
    da = PI/10 * (npoints-da)/npoints;
    if (acol1>=acol2){
    a += da;}else{a-=da;}
    angles.set(i, a);
  }else{
    float a2 = a + .005*mnoise(x, y)*TWO_PI*2;
    a = lerp(a, a2, 1);
    //a = mnoise(x, y+i*5)*TWO_PI*2;
    angles.set(i, a);
  }
  float newx = p.x + r*cos(a);
  float newy = p.y + r*sin(a);
  float m0 = .7;
  PVector newp = new PVector(lerp(p.x, newx, m0), lerp(p.y, newy, m0));
  particles.set(i, newp);
  return a;
}

float collisions(PVector pos, float a){
  PVector dir = new PVector(cos(a), sin(a));
  int npoints = 10;
  float dist = 150;
  float dda = 0;
  for (int i =1;i<npoints;i++){
    float cdist = dist/npoints*i;
    PVector cpos = PVector.add(pos, PVector.mult(dir, cdist));
    hud.stroke(0,255,0);
    hud.strokeWeight(3);
    //cvs.point(cpos.x, cpos.y);
    if (cvs.get(int(cpos.x), int(cpos.y)) != color(cback)){
      hud.stroke(255,0,0);
      hud.strokeWeight(10);
      hud.point(cpos.x, cpos.y);
      float da = i;
      dda = da;
      break;
    }
    hud.point(cpos.x, cpos.y);
  }
  return dda;
}

void draw_(){
  //background(200);
  cvs.beginDraw();
  hud.beginDraw();
  hud.clear();
  for (int i = 0; i<particles.size();i++){
    PVector p = particles.get(i);
    float a = angles.get(i);
    color c = cols.get(i);
    //stroke(0,50);
    cvs.stroke(c, 50);
    cvs.strokeWeight(5);
    //point(p.x, p.y);
    int npoints = 7;
    float dis = 60;
    
    
    a = update2(i, dis);
    PVector normal = new PVector(-sin(a), cos(a));
    
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
  hud.endDraw();
  image(cvs, 0,0);
  image(hud, 0,0);
  
}

void draw(){
  t = (float)frameCount/100;
  draw_();
  
  if (video)cam.saveFrame();
  //saveFrame("out/out-####.png");
}


void init(){
  cvs = createGraphics(width, height);
  hud = createGraphics(width, height);
  cvs.beginDraw();
  cvs.background(255);
  cvs.endDraw();
  particles.clear();  
  angles.clear();
  cols.clear();
  int n = 5;
  for (int i= 0; i<n; i ++){
    float nn = 200;
    float x = width/2+random(-nn,nn);
    float y = height/2+random(-nn,nn);
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
  if (key=='x' && video){
    cam.endMovie();
    exit();
  }

}
