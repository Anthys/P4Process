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
    strokeWeight(3);
    float x = random(width);
    float y = random(height);
    float s = random(0,10);
    float theta = random(0,TWO_PI);
    float res = 3;
    theta = map(noise(x/width*res, y/height*res), 0,1,0,TWO_PI);
    color c = img.get(int(x), int(y));
    stroke(c);
    line(x, y, x+cos(theta)*s, y+s*sin(theta));
    
  }
}
