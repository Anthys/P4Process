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
    float theta = random(0,TWO_PI);
    color c = img.get(int(x), int(y));
    stroke(c);
    line(x, y, x+cos(theta)*s, y+s*sin(theta));
    
  }
}

void keyPressed(){
  if (key=='p'){
    saveFrame("out_####.png");
  }

}
