import com.hamoid.*;

// LEFT CLICK HOLD: MOVE CONSTANTS A AND B
// RIGHT CLICK HOLD: MOVE CONSTANTS C AND D
// MIDDLE CLICK : PRINT COORDINATES




float x1, x2, y1, y2;
float A, B, C, D;
float t;
int cstep;
int max_int=1;

float my = 2.4;

VideoExport vid;
boolean video;

ArrayList<PVector> particles;
int[][] back;
PImage bcc;

void setup() {
  noiseSeed(0);
  size(1000, 1000, P2D);
  cstep = 0;
  vid = new VideoExport(this);
  bcc = new PImage(width, height, RGB);
  video = false;
  t = 0;
  ini_ar();
  float sq = 0;
  x1 = 0;
  x2 = 1;
  y1 = 2.4;
  y2 = 4.0;

  if (sq != 0) {
    x1 = y1= -sq;
    x2 = y2 = sq;
  }
  particles = new ArrayList<PVector>();
  init();
  if (video) {
    vid.startMovie();
  }
}

void draw_1() {
  //smooth(2);
  fill(200, 50);
  //rect(0,0,width,height);
  //background(200,200,200,1);
  strokeWeight(2);
  //A = 1.4 *0.1;
  //B = -2.3*sin(t/50+PI/2);
  ///C = 2.4*cos(t/50);
  //B = -2.3+cos(t/50+PI/2)*2;
  //C = 2.4+sin(t/50)*2;
  float a = -.3;//A;
  float b = -2.3;//B;
  float c = 1.5;//C;
  float d = 1.4;//D;
  float e = .01;

  for (int j=0; j<1; j++) {
    init_part();
    for (int i=0; i<10; i++)
      for (PVector p : particles) {
        stroke(0, 100);
        //a = c = sin(p.x);
        //b = d = 1.;
        float x = p.x;//+(noise(noise(p.x, p.y)*2-1, .5)*2-1)*.5;
        float y = p.y;
        float r = 3.8;
        float xx = my*x*(1-x);
        float yy = my;
        x = xx;//lerp(x,xx,e) ;
        y = yy;//lerp(y,yy, e);
        float nn = .5;
        //x = (noise(xx, yy)*2-1)*nn;
        //y += (noise(xx+20,yy+20)*2-1)*nn;
        p.x = x;
        p.y = y;
        float sqtt = 0;
        if (i>5) {
          xx = map(x, x1+sqtt, x2-sqtt, 0, width);
          yy = map(y, y1+sqtt, y2-sqtt, 0, height);
          if (xx > 0 && xx < width-1 && yy > 0 && yy < height-1) { 
            back[int(xx)][int(yy)] += 1;
            max_int = max(back[int(xx)][int(yy)], max_int);
          }
          //x1 = -.5;
          //x2 = .5;
          //y1 = .9;
          //y2 = 1.1;
          //bcc.set(int(xx), int(yy), bcc.get(int(xx), int(yy))+1);
        }
      }
  }
  //draw_2();
  //saveFrame("out-####.png");
  //ini_ar();
  //background(200);
}

void ini_ar() {

  back = new int[width][height];
  for (int i=0; i<width; i++)
    for (int j=0; j<height; j++) {
      back[i][j] = 0;
    }
}

void draw_2() {
  loadPixels();
  for (int i=0; i<width; i++)
    for (int j=0; j<height; j++) {
      float val = map(float(back[i][j]), 0, max_int, 0, 1);
      val = 1-val;
      val = pow(val, 40);
      //val = exp(val*100.);
      val = 1-val;
      //val = val>.001?1:val;
      pixels[i+j*width] = color(255*val);
    }
  updatePixels();
  //image(bcc, 0,0);
}

void draw() {
  t += 1;
  my += .001;
  if (my >4){
    my = 2.5;
  }
  if (t%20 == 0){
    draw_2();
  }
  //segundo();
  t = float(frameCount)/10;
  if (cstep == 0) {
    draw_1();
  }
  if (cstep == 1) {
    draw_2();
  }
  if (video) {
    vid.saveFrame();
  }
  tertio();
}

void actu_part() {
  for (int i=0; i<500; i++) {
    particles.remove(0);
    particles.add(new PVector(random(x1, x2), random(y1, y2)));
  }
}

void init() {
  cstep= 0;

  background(255);
  A = random(-3, 3);
  B = random(-3, 3);
  C = random(-3, 3);
  D = random(-3, 3);
  /*A = 1.641;
   B = 1.902;
   C = 0.316;
   D = 1.525;
   
   A = 1.4;
   B = -2.3;
   C = 2.4;
   D = -2.1;*/

  init_part();
  ini_ar();
  particles.set(0, new PVector(0, 0));
}

void init_part() {
  particles.clear();
  float n = 1000;
  //background(200);
  for (int i = 0; i < n; i++) {
    particles.add(new PVector(random(x1, x2), random(y1, y2)));
  }
}

void tertio() {
  if (mousePressed) {
    if (mouseButton == CENTER) { 
      println("---");
      println(A);
      println(B);
      println(C);
      println(D);
    }
    if (mouseButton == LEFT) {
      C=map(mouseX, 0, width, -3, 3);
      D=map(mouseY, 0, height, -3, 3);
    }
    if (mouseButton == RIGHT) {
      A = map(mouseX, 0, width, -3, 3);
      B = map(mouseY, 0, height, -3, 3);
    }
  }
}

void segundo() {
  if (mousePressed) {
    if (mouseButton == CENTER) { 
      println("---");
      println(A);
      println(B);
      println(C);
      println(D);
    }
    if (mouseButton == LEFT) {
      textSize(32);
      fill(0);
      text("(C,D)", 100, 100);
      C=map(mouseX, 0, width, -3, 3);
      D=map(mouseY, 0, height, -3, 3);
    }
    if (mouseButton == RIGHT) {
      textSize(32);
      fill(0);
      A = map(mouseX, 0, width, -3, 3);
      B = map(mouseY, 0, height, -3, 3);
      text("(A,B)", 100, 100);
    }
  }
  crox(map(A, -3, 3, 0, width), map(B, -3, 3, 0, height), 10);
  crox(map(C, -3, 3, 0, width), map(D, -3, 3, 0, height), 10);
}

void crox(float x, float y, float s) {
  strokeWeight(5);
  stroke(0);
  line(x-s, y, x+s, y);
  line(x, y-s, x, y+s);
}


void keyPressed() {
  if (keyCode == 32) {
    init();
  }
  if (key=='c') {

    background(255);
    ini_ar();
  }

  if (key == 'q' && video) {
    vid.endMovie();
    exit();
  }
  if (key == 'n') {
    cstep = 1;
  }
  if (key == 's') {
    saveFrame("out-####.png");
  }
}