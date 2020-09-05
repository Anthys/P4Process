
ParticleGroup parts;
float decal = 5;
PImage img;
void settings(){
  img = loadImage("h.png");
  size(img.width,img.height);
}

void setup(){
  ops = new ArrayList<operator>();
  parts = new ParticleGroup();
  for (float i = 0;i<width;i+=decal)
  for (float j = 0; j<height;j+=decal){
    color c = img.get(int(i), int(j));
    if (random(1) * (blue(c)/255)>.98 && false){
      ops.add(new operator(i, j, .1 * (int(random(1))*2-1)));
    }
    
    Particle p = new Particle(i, j, c);
    p.psize = decal;
    parts.particles.add(p);
  }
}

void draw(){
  parts.run();
}


void mouseClicked(){
  color c = img.get(int(mouseX), int(mouseY));
  for (int i = 0;i<5;i++){
    float dd = 50;
    float x = random(-dd,dd);
    float y = random(-dd,dd);
    ops.add(new operator(mouseX+x, mouseY+y, .1 * (int(random(1))*2-1)));
  }
}

void keyPressed(){
  if (key == 's'){
    saveFrame("out-####.png");
  }
}

ArrayList<operator> ops;

class operator{
  float strength; // negative expell
  PVector pos;
  
  operator(float x, float y, float str){
    pos = new PVector(x, y);
    strength = str;
  }

}
