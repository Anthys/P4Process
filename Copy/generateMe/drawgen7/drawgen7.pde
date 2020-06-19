PImage img;


void settings(){
  img = loadImage("picA.jpg");
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
    float s = random(0,10);
    float res = 3;
    float t = map(noise(x/width*res, y/height*res), 0,1,1,4);
    s = map(noise(x/width*res, y/height*res), 0,1,0,40);
    float theta = random(0,TWO_PI);
    //theta = map(noise(x/width*res, y/height*res), 0,1,0,TWO_PI);
    color c = img.get(int(x), int(y));
    stroke(c, 50);
    strokeWeight(t);
    fill(c, 50);
    //line(x, y, x+cos(theta)*s, y+s*sin(theta));
    circle(x, y, s);
  }
}

void keyPressed(){
  if (key=='p'){
    saveFrame("out_####.png");
  }

}