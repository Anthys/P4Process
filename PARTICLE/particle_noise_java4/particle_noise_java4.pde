float t;
ArrayList<Particle> particles;
PGraphics img;

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
  float radius = 200;
  img = createGraphics(width, height);
  for (int i=0;i<n;i++){
    float r = random(0, radius*2)/2;
    float a = random(0, TWO_PI*2);
    float x = width/2+cos(a)*r;
    float y = height/2+sin(a)*r;
    ArrayList<PVector> P = make_cool_curve(x,y,150.,2,"r");
    plot_cool_curve(img,P, false);
  }
  image(img, 0, 0);
  strokeWeight(10);
  stroke(100);
  //point(width/2, height/2);
}

void draw(){
}

void keyPressed(){
  if (key == 'p'){
    saveFrame("out-####.png");
  }
    
  if (keyCode==32){
    init();
  }
}
