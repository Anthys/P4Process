
ArrayList<PVector> ppos;
ArrayList<PVector> pvel;
ArrayList<Integer> pcols;
PGraphics img;

void setup(){
  size(500,500, P2D);
  ppos = new ArrayList<PVector>();
  pvel = new ArrayList<PVector>();
  pcols = new ArrayList<Integer>();
  img = my_img();
  init();
}

PGraphics my_img(){
  PGraphics out = createGraphics(width, height);
  out.beginDraw();
  out.background(255);
  out.fill(0);
  out.circle(width/2, height/2, 100);
  out.endDraw();
  print(red(out.get(width/2, height/2)));
  return out;

}

void init(){
  int n = 100;
  for (int i = 0; i < n; i++){
    float x = i*width/n;
    float y = 0;
    ppos.add(new PVector(x, y));
    pvel.add(new PVector(0, 0));
    pcols.add(color(i*255/n, 100, 200));
  }
  
}

void draw(){
  draw_();
}

void updatepos(PVector pos, PVector vel){
  color c = img.get(int(pos.x), int(pos.y));
  if (red(c)!=0){
    vel.x = 0;
    vel.y = 1;
  }else{
    vel.rotate(.01);
  }
  pos.add(vel);
}

void draw_(){
  for (int i=0; i<ppos.size();i++){
    PVector p = ppos.get(i);
    PVector v = pvel.get(i);
    color c = color(pcols.get(i));
    stroke(c);
    point(p.x, p.y);
    updatepos(p, v);
  }
}
