Particle[] particles;
PImage img;

void setup(){
  size(500, 500);
  
  int si = 1000;
  particles = new Particle[si];
  for (int i=0;i<si;i++){
    int x = (int)random(0, width);
    int y = (int)random(0, height);
    float a = random(0, TAU);
    particles[i] = new Particle(x, y,a);
  }
  img = new PImage(500, 500);
}

int t = 0;

void draw(){
  t++;
  for(int i =0;i<particles.length;i++){
    Particle part = particles[i];
    if (i==particles.length/2){
      //print(part.pos);
    }
    part.rotate(img);
    part.move();
    part.clip(img.width, img.height);
  }
  for(int i =0;i<particles.length;i++){
    Particle part = particles[i];
    part.deposit(img);
  }
  image(img,0,0);
  if (t%8==0)img.filter(BLUR, 1);
  
}
