Particle[] particles;
PImage img;



void setup(){
  size(500, 500);
  
  int si = 1000;
  particles = new Particle[si];
  float Rmax = 200;
  for (int i=0;i<si;i++){
    float r = random(0, Rmax);
    float theta = random(0, TAU*2);
    float x = r*cos(theta)+width/2;
    float y = r*sin(theta)+height/2;
    float a = theta+PI;
    particles[i] = new Particle(x, y,a);
  }
  img = new PImage(500, 500);
}

int t = 0;

void draw(){
  for(int j = 0;j<5;j++){
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
  if (t%8==0){
    img.filter(BLUR, 1);
  }
  }
    image(img,0,0);
}
