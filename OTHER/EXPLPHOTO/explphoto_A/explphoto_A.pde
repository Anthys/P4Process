
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
    if (random(1)<.01){
      ops.add(new operator(i, j, int(random(1))*2-1));
    }
    
    color c = img.get(int(i), int(j));
    Particle p = new Particle(i, j, c);
    p.psize = decal;
    parts.particles.add(p);
  }
}

void draw(){
  parts.run();
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
