import com.hamoid.*;

float x1,x2,y1,y2;
float A,B,C,D;
float t;
int cstep;

VideoExport vid;
boolean video;

ArrayList<PVector> particles;
int[][] back;

void setup(){
  size(1920,1080, P2D);
  //size(1000,500, P2D);
  cstep = 0;
  vid = new VideoExport(this);
  video = false;
  t = 0;
  ini_ar();
  float sq = 5;
  x1 = -2;
  x2 = 2;
  y1 = -2;
  y2 = 2;
  
  if (sq != 0){
    x1 = y1= -sq;
    x2 = y2 = sq;
  }
  particles = new ArrayList<PVector>();
  init();
  if (video){
    vid.startMovie();  
  }
}

void draw_1(){
  //smooth(2);
  fill(200,2);
  //rect(0,0,width,height);
  //background(200,200,200,1);
  strokeWeight(2);
  //A = 1.4 *0.1;
  //B = -2.3*sin(t/50+PI/2);
  ///C = 2.4*cos(t/50);
  //B = -2.3+cos(t/50+PI/2)*2;
  //C = 2.4+sin(t/50)*2;
  float a = A;
  float b = B;
  float c = C;
  float d = D;
  float e = .01;
  
  for (int j=0;j<1000;j++){
   actu_part();
  for (int i=0;i<10;i++)
  for (PVector p:particles){
    stroke(0, 100);
    //a = c = sin(p.x);
    //b = d = 1.;
    float x = p.x;
    float y = p.y;
    float xx = sin(a*y)-cos(b*x);
    float yy = sin(c*x)-cos(d*y);
    x = xx;//lerp(x,xx,e) ;
    y = yy;//lerp(y,yy, e);
    p.x = x;
    p.y = y;
    xx = map(x, x1+2.5, x2-2.5, 0, width);
    yy = map(y, y1+2.5, .5, 0, height);
    point(xx,yy);
    if( yy < height && x< width){
      back[int(xx)+1][int(yy)] += 1;
      back[int(xx)][int(yy)] += 1;
    back[int(xx)][int(yy)+1] += 1;}
  }}
  draw_2();
  
  noLoop();
  saveFrame("out-####.png");
  //ini_ar();
  //background(200);
}

void ini_ar(){
  
  back = new int[width][height];
  for (int i=0;i<width; i++)
  for (int j=0;j<height;j++){
    back[i][j] = 0;
  }

}

void draw_2(){
  int mxx = 0;
  int mnn = 0;
  for (int i=0;i<width;i++)
  for (int j=0;j<height;j++){
    if (back[i][j] > mxx){
      mxx = back[i][j];
    }
    if (back[i][j] < mnn){
      mnn = back[i][j];
    }
  }
  loadPixels();
  for (int i=0;i<width;i++)
  for (int j=0;j<height;j++){
    float val = map(float(back[i][j]), mnn,mxx,0,1);
    val = 1-val;
    val = pow(val,100.);
    val = 1-val;
    pixels[i+j*width] = color(255*val);
  }
  updatePixels();
}

void draw(){
  t = float(frameCount)/10;
  if (cstep == 0){
    draw_1();
  }
  if (cstep == 1){
    draw_2();
  }
  if (video){
    vid.saveFrame();  
  }
}

void actu_part(){
  for (int i=0;i<500;i++){
    particles.remove(0);
    particles.add(new PVector(random(x1,x2) ,random(y1,y2)));  
  }
}

void init(){
  
  
  A = random(-3,3);
  B = random(-3,3);
  C = random(-3,3);
  D = random(-3,3);
  A = 1.641;
  B = 1.902;
  C = 0.316;
  D = 1.525;
  
  A=2.4299998;
  B=1.7339997;
  C=-1.5333359;
  D=-0.16122723
;
  
  init_part();
   particles.set(0, new PVector(0,0));
}

void init_part(){
  particles.clear();
  float n = 1000;
  //background(200);
  for (int i = 0; i < n; i++){
    particles.add(new PVector(random(x1,x2) ,random(y1,y2)));
  }
}


void keyPressed(){
  if (keyCode == 32){
  init();
}
  
  if (key == 'q' && video){
    vid.endMovie();
    exit();
  }
  if (key == 'n'){
    cstep = 1;
  }
  if (key == 's'){
    saveFrame("out-####.png");
  }
}
