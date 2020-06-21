

PImage img;
int ch = 5;
ArrayList<PVector> ppos;
ArrayList<Integer> pcols;
float len;
String sessionid; 

void settings(){

  img = loadImage("img5.jpg");
  size(img.width,img.height);

}

void cool_background(){
  int n = 100;
  for (int i=0;i<n;i++){
    float xx = random(width);
    float yy = random(height);
    float s = random(500);
    color c = img.get(int(xx), int(yy));
    noStroke();
    fill(c, 10);
    circle(xx, yy, s);
  }

}

void setup(){
  background(255);
  sessionid = hex((int)random(0xffff),4);
  ppos = new ArrayList<PVector>();
  init();
  len = 100;
  //cool_background();
}

void init(){
  int mode = 1;
  int np = 10000;
  switch (mode){
    case 0:
      for (int i = 0; i<np; i++){
        ppos.add(new PVector(random(width), random(height)));
        
      }
      break;
    case 1:
      ppos.clear();
      for (int i = 0; i<np; i++){
        ppos.add(new PVector(random(width), random(height)));
        
      }
      break;
    case 2:
      ppos.clear();
      for (int i = 0; i<np; i++){
        float x = random(width);
        float y = random(height);
        color c = img.get(int(x), int(y));
        float val = brightness(c)/255;
        if (random(0,1)<val){ppos.add(new PVector(random(width), random(height)));}
        
      }
      break;
  }
}

void draw_(){
  len = 100;
  for (int j=0; j<1;j++){
  for (PVector p: ppos){
    color c = img.get(int(p.x),int(p.y));
    stroke(255-saturation(c), 100);
    point(p.x,p.y);
    update_pos(p, c);    
  }
  }
  //init();
  if (frameCount>len){
    frameCount=0;
    init();
  }
}

void update_pos(PVector p, color c){
  int mode = 0;
  float v, strength;
  float res = 10;
  switch (mode){
    case 0:
      strength = 1;
      v = (map(getChannel(c),0,255,0,TWO_PI));
      p.add(cos(v), sin(v)).mult(strength);
      break;
    case 1:
      strength = 1;
      v = noise(p.x/width*res, res*p.y/height); 
      p.add(cos(v), sin(v)).mult(strength);
      break;
    case 2:
      strength = 1;
      v = (map(getChannel(c),0,255,0,TWO_PI));
      v = v*noise(p.x/width*res, res*p.y/height); 
      p.add(cos(v), sin(v)).mult(strength);
      break;
    case 3:
      strength = 1;
      v = noise(p.x/width*res, res*p.y/height)*TWO_PI*2; 
      v = v*getChannel(c)/255;
      p.add(cos(v), sin(v)).mult(strength);
      break;
  }
}  

float getChannel(color c){
  
  float out = 0;
  switch (ch){
    case 0:
      out = red(c);
      break;
    case 1:
      out = blue(c);
      break;
    case 2:
      out = green(c);
      break;
    case 3:
      out = hue(c);
      break;
    case 4:
      out = saturation(c);
      break;
    case 5:
      out = brightness(c);
      break;
     
      
  }
  return out;

}

void draw(){
  draw_();
}

void keyPressed(){
  if (keyCode==32){
    background(255);
    init();
    ch = int(random(0,6));
    noiseSeed(int(random(100)));
  }
  if (key=='s'){
    saveFrame(sessionid + "_out_####.png");
  }

}
