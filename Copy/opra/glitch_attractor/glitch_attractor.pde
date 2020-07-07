float t, x, y, a, accacc, value;
float tx, ty;
float scale=1;
int n_particles_i;
int n_particles;
int var_acc;
boolean debug = true;
void setup(){
  size(1000,1000);
  init();
  draw_();
}

void init(){
  t = 1 ;
  tx = 0;
  ty = 0;
  scale = 1;
  var_acc = 1;
  value = 0.1;
  n_particles = 10000;
  n_particles_i = 4;
  accacc = .001;
  x = random(-100,100);
  y = random(-100,100);
  a = random(TAU);
}

void draw_(){
  push();
  translate(tx+width/2, ty+height/2);
  scale(scale);
  background(200);
  
  float aa = a;
  int n = n_particles ;
  float r = 3;
  float xx = x;
  float yy = y;
  float aspeed = 0.01;
  for (int i = 0; i < n; i++){
    xx += sin(aa)*r;
    yy += cos(aa)*r;
    aa += aspeed;
    aspeed += .0001+accacc;
    point(xx,yy);
  }
  pop();
}


void draw(){
  t += .1;
  draw_();
  if (keyPressed){
  if (key == 'q'){
    accacc -= value;
  }
  if (key == 'd'){
    accacc += value;
  }
  }
  if (debug){
  text(str(value), 100,100);
  text(str(n_particles), 100,200);
  }
}

void mousePressed(){
  tx = -(mouseX-width/2-tx);
  ty = -(mouseY-height/2-ty);
  if (mouseButton == RIGHT){
    tx = 0;
    ty = 0;
    scale = 1;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  float scale2 = scale + ((scale>1)?-1*e*(1/scale):-1*e*scale*.05);
  scale2 = max(0.01,scale2);
  scale = scale2;
}


void keyPressed(){
  if (keyCode == LEFT){
    tx += 5;
  }
  if (key == 'p'){
  }
  if (keyCode==32){
    init();
    draw_();
  }
  if (key == 'e'){
    accacc += value;
  }
  if (key == 'a'){
    accacc -= value;
  }
  if (key == 'f'){
    saveFrame("out/out-####.png");
  }
  if (key == 'z'){
    var_acc = (var_acc)%6+1;
    value = 1./(pow(10, var_acc));
  }
  if (key == 's'){
    var_acc = (var_acc-2)%6+1;
    var_acc = (var_acc==0)?6:var_acc;
    value = 1./(pow(10, var_acc));
  }
  if (key == 'c'){
    n_particles_i = (n_particles_i)%8+1;
    n_particles = (int)pow(10, n_particles_i);
  }
  if (key == 'w'){
    n_particles_i = (n_particles_i-2)%8+1;
    n_particles_i = (n_particles_i==0)?1:n_particles_i;
    n_particles = (int)pow(10, n_particles_i);
  }
  if (key == 'i'){
    debug = !debug;
  }
}
