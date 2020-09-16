ParticleGroup gp;

float midr = 700;
float drr = 100;

void setup(){
  size(1000, 1000);
  gp = new ParticleGroup();
  int n = 1000;
  for (int i =0;i<n;i++){
    float rr = midr-drr+drr*2/n*i;
    Particle pp = new Particle(rr, 0);
    pp.r = rr;
    pp.selfi = i;
    pp.theta = 0;
    gp.particles.add(pp);
  }
}

void draw(){
  gp.run();
}

void keyPressed(){
  if (key == 's'){
    saveFrame("out-####.png");
  }
}
