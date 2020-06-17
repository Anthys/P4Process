import com.hamoid.*;

// LEFT CLICK HOLD: MOVE CONSTANTS A AND B
// RIGHT CLICK HOLD: MOVE CONSTANTS C AND D
// MIDDLE CLICK : PRINT COORDINATES


color bcolor;

float x1,x2,y1,y2;
float p1,p2,p3,p4;
float a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17;
float t;
int cstep;

VideoExport vid;
boolean video;

ArrayList<PVector> particles;
int[][] back;

void setup(){
  bcolor = color(0);
  size(1000,1000, P2D);
  cstep = 0;
  vid = new VideoExport(this);
  video = false;
  t = 0;
  ini_ar();
  float sq = 10;
  x1 = -2;
  x2 = 2;
  y1 = -2;
  y2 = 2;
  
  
  if (sq != 0){
    x1 = y1= -sq;
    x2 = y2 = sq;
  }
  
  
  
  p1=x1+2+-1;
  p2=x2-2-0;
  p3=y1+2+-1;
  p4=y2-2-0;
  particles = new ArrayList<PVector>();
  init();
  if (video){
    vid.startMovie();  
  }
}

void draw_1(){
  //smooth(2);
  fill(200,50);
  //rect(0,0,width,height);
  //background(200,200,200,1);
  strokeWeight(1);
  //A = 1.4 *0.1;
  //B = -2.3*sin(t/50+PI/2);
  ///C = 2.4*cos(t/50);
  //B = -2.3+cos(t/50+PI/2)*2;
  //C = 2.4+sin(t/50)*2;
  float e = .01;
  
  for (int j=0;j<1;j++){
   //init_part();
  for (int i=0;i<1;i++)
  for (PVector p:particles){
    stroke(255, 100);
    //a = c = sin(p.x);
    //b = d = 1.;
    float x = p.x;
    float y = p.y;
    float xx = a1+a2*x+a3*y+a4*pow(abs(x), a5)+a6*pow(abs(y), a7);
    float yy = a8+a9*x+a10*y+a11*pow(abs(x), a12)+a13*pow(abs(y), a14);
    x = lerp(x,xx,e) ;
    y = lerp(y,yy, e);
    p.x = x;
    p.y = y;
    if (i>-1){
      /*p1=x1;
      p2=x2;
      p3=y1;
      p4=y2;*/
      
      
      /*p1=2;
      p2=3;
      p3=4;
      p4=5;
      */
    xx = map(x, p1, p2, 0, width);
    yy = map(y, p3, p4, 0, height);
    point(xx,yy);
    if (inside(xx,yy)){
    back[int(xx)][int(yy)] += 1;
    }
    }
    
  }}
  //saveFrame("out-####.png");
  //ini_ar();
  //background(200);
}

boolean inside(float x, float y){
  return (x>=0 && x<width && y>0 && y<height);

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
  ArrayList<Integer> michel = new ArrayList<Integer>();
  for (int i=0;i<width;i++)
  for (int j=0;j<height;j++){
    if (back[i][j] > mxx){
      mxx = back[i][j];
    }
    if (back[i][j] < mnn){
      mnn = back[i][j];
    }
    if (back[i][j] !=0) michel.add(back[i][j]);
  }
  java.util.Collections.sort(michel);
  Integer q3 = michel.get(int(float(michel.size())*.99999));
  println(q3);
  println(mxx);
  
  
  loadPixels();
  for (int i=0;i<width;i++)
  for (int j=0;j<height;j++){
    float val = map(min(float(back[i][j]), q3), mnn,q3,0,1);
    val = 1-val;
    val = pow(val,20.);
    val = 1-val;
    pixels[i+j*width] = color(255*val);
  }
  updatePixels();
}

void draw(){
  
  
  //segundo();
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
  tertio();
}

void actu_part(){
  for (int i=0;i<500;i++){
    particles.remove(0);
    particles.add(new PVector(random(x1,x2) ,random(y1,y2)));  
  }
}

void init(){
  cstep= 0;
  
  background(bcolor);
  //A = .918;
  /*A = 1.641;
  B = 1.902;
  C = 0.316;
  D = 1.525;
  
  A = 1.4;
  B = -2.3;
  C = 2.4;
  D = -2.1;*/
  
  a1 = -0.8;
  a2 = 0.4;
  a3 = -1.1;
  a4 = 0.5;
  a5 = -0.6;
  a6 = -0.1;
  a7 = -0.5;
  a8 = 0.8;
  a9 = 1.0;
  a10 = -0.3;
  a11 = -0.6;
  a12 = -0.3;
  a13 = -1.2;
  a14 = -0.3;
  
  init_part();
  ini_ar();
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

void tertio(){
  if (mousePressed){
  if (mouseButton == CENTER){ 
  println("---");
  println(a1);
  println(a2);
  println(a3);
  println(a4);
  float amp = 5;
  p1=x1+2+map(mouseX, 0, width, -amp, amp);
  p2=x2-2+map(mouseX, 0, width, -amp, amp);
  p3=y1+2+-1+map(mouseY, 0, height, -amp, amp);
  p4=y2-2-0+map(mouseY, 0, height, -amp, amp);
  }
  if (mouseButton == LEFT){
    a1=map(mouseX, 0, width, -3, 3);
    a2=map(mouseY, 0, height, -3, 3);
  }
  if (mouseButton == RIGHT) {
    a3 = map(mouseX, 0, width, -3, 3);
    a4 = map(mouseY, 0, height, -3, 3);
  }
  }

}

void crox(float x, float y, float s){
  strokeWeight(5);
  stroke(0);
 line(x-s, y, x+s, y);
 line(x, y-s, x, y+s);
}


void keyPressed(){
  if (keyCode == 32){
  init();
}
if (key=='c'){
  
    background(bcolor);
  cstep= 0;
    ini_ar();
    init_part();
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
