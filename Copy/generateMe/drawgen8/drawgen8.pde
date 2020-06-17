PImage img;


void settings(){
  img = loadImage("img.jpg");
  size(img.width,img.height);
}

void setup(){
  
  background(200);
}

void draw(){
  int n = 100;
  for (int i = 0; i<n;i++){
    float x = random(width);
    float y = random(height);
    color c = img.get(int(x), int(y));
    float s = random(0,10);
    float res = 3;
    float val = map(brightness(c), 0,255,0,1);
    float t = map(noise(x/width*res, y/height*res), 0,1,1,4);
    s = val*map(noise(x/width*res, y/height*res), 0,1,0,20);
    float theta = random(0,TWO_PI);
    //theta = map(noise(x/width*res, y/height*res), 0,1,0,TWO_PI);
    stroke(c, 50);
    strokeWeight(t);
    fill(c, 50);
    //line(x, y, x+cos(theta)*s, y+s*sin(theta));
    //circle(x, y, s);
    spray(x, y, s);
  }
}

void spray(float x, float y, float s){
  strokeWeight(1);
  for (int i = 0; i<30;i++){
    float r = random(s);
    float theta = random(TWO_PI);
    point(x+r*cos(theta), y+r*sin(theta));
  }
}
