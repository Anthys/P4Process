

PImage img;
int ch = 0;
ArrayList<PVector> ppos;
ArrayList<Integer> pcols;

void settings(){
  img = loadImage("img.jpg");
  size(img.width,img.height);
}

void setup(){
  
  background(200);
  ppos = new ArrayList<PVector>();
  init();
}

void init(){
  int mode = 1;
  int np = 1000;
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
        if (random(0,1)<pow(1-val, 10)){ppos.add(new PVector(random(width), random(height)));}
        
      }
      break;
  }
}

void draw_(){
  for (PVector p: ppos){
    color c = img.get(int(p.x),int(p.y));
    stroke(c, 50);
    point(p.x,p.y);
    update_pos(p, c);    
  }
  if (frameCount>30){
    frameCount=0;
    init();
  }
}

void update_pos(PVector p, color c){
  int mode = 3;
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
    background(200);
    init();
    ch = int(random(0,6));
    noiseSeed(int(random(100)));
  }

}
