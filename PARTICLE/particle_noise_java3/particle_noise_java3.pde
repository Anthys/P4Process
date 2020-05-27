float t;
ArrayList<Particle> particles;
PImage img;

void setup(){
  size(500, 500);
  init();

}

void init(){
  background(200);
  noiseSeed(int(random(0,100)));
  t = 0.;
  int n = 500;
  float res= 1.5;
  particles = new ArrayList<Particle>();
  for (int i=0;i<n;i++){
    particles.add(new Particle(width*i/n,20+ height, 0, 0, res));
    particles.add(new Particle(20+width,20+ height*i/n, 0, 0, res));
  }
  
  img = createImage(width, height, RGB);
  for (int i = 0; i<width; i++)
  for (int j = 0; j < height; j++){
    PVector uv = new PVector(float(i)/img.width+1, float(j)/img.height+1).mult(res);
    img.pixels[i+img.width*j] = color(noise(uv.x, uv.y)*255);
  }
}

void draw(){
  //image(img, 0, 0);
  for (Particle p:particles){
    p.draw();
  }
}

void keyPressed(){
  if (key == 'p'){
    saveFrame("out-####.png");
  }
    
  if (keyCode==32){
    init();
  }
}
