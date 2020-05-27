float t;
ArrayList<Particle> particles;
PGraphics img;
PImage img2;

void setup(){
  size(500, 500);
  init();

}

void init(){
  background(200);
  noiseSeed(int(random(0,100)));
  t = 0.;
  int n = 100;
  float res= 1.5;
  particles = new ArrayList<Particle>();
  for (int i=0;i<n;i++){
    particles.add(new Particle(width*i/n,20+ height, 0, 0, res));
    particles.add(new Particle(20+width,20+ height*i/n, 0, 0, res));
  }
  img = createGraphics(width, height);
  img2 = createImage(width, height, RGB);
  for (int i = 0; i<width; i++)
  for (int j = 0; j < height; j++){
    PVector uv = new PVector(float(i)/img.width+1, float(j)/img.height+1).mult(res);
    img2.pixels[i+img2.width*j] = color(noise(uv.x, uv.y)*255);
  }
  /*
  float radius = 200;
  for (int i=0;i<n;i++){
    float r = random(0, radius*2)/2;
    float a = random(0, TWO_PI*2);
    float x = width/2+cos(a)*r;
    float y = height/2+sin(a)*r;
    ArrayList<PVector> P = make_cool_curve(x,y,150.,2,"r");
    plot_cool_curve(img,P, false);
  }
  */
  image(img, 0, 0);
  strokeWeight(10);
  stroke(100);
  //point(width/2, height/2);
}

void draw(){
  image(img, 0, 0);
  img = createGraphics(width, height);
  for (Particle p:particles){
    p.draw();
    if (frameCount%2==0){
      ArrayList<PVector> P = make_cool_curve(p.p.x,p.p.y,150.,3,"r");
      plot_cool_curve(img,P, false);
    }
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
