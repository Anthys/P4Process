//drawing agent
class Agent {
  PVector pos; // position of the agent
  float angle; // current angle of the agent
  color col;
 
  void update() {
    // modify position using current angle
    pos.x += cos(angle);
    pos.y += sin(angle);
 
    PVector scale_pos = new PVector(3,3);
     
    // get point coordinates
    float xx = scale_pos.x* map(pos.x, 0, width, -1, 1);
    float yy = scale_pos.y* map(pos.y, 0, height, -1, 1);
 
    PVector pp = new PVector(xx, yy);
    
    PVector v = new PVector(xx, yy);
    v = variations.spherical(pp);
    //v = variations.horseshoe(pp);
    
    v.mult(5);
    v.add(new PVector(5,-3));
    //v.mult(.5);
    //v.x=1/v.x;
    //v.y=1/v.x;
    //v.y=pow(v.y, 5);
 
    // modify an angle using noise information
    float scale_angle = 3;
    float m = map( noise(v.x, v.y), 0, 1, -1, 1);
    m = v.mag();
    m += map(noise(v.x, v.y), 0, 1, -1, 1)*3;
    angle += scale_angle* m;
  }
  
  void draw(){
    stroke(col, 20);
    point(pos.x, pos.y);
  }

}

void keyPressed(){
  if (key=='p' || key=='s'){
    saveFrame("out-####.png");
  }
  if (keyCode == 32){
    init();
  }
}

PVector kampyle(float n) {
  float sec = 1/sin(n);
 
  float xt = sec;
  float yt = tan(n)*sec;
 
  return new PVector(xt, yt);
}
 
// all agents in the list
ArrayList<Agent> agents = new ArrayList<Agent>();
 
void setup() {
  size(1000, 1000);
  smooth(8);
  init();
}

void init(){
  noiseSeed((int)random(1000));
  background(240);
  background(0);
  stroke(20, 10);
  strokeWeight(0.7);
 
  // initialize in random positions
  int val = 1;
  int numPoints = 5000;
  int rcolor = (int)random(7);
  agents.clear();
  if (val == 0){
    for (int i=0; i<numPoints; i++) {
      Agent a = new Agent();
      float posx = random(200, 600);
      float posy = random(200, 600);
      a.pos = new PVector(posx, posy);
      a.angle = random(TWO_PI);
      agents.add(a);
    }
  }else if (val==1){
    float radius = 300;
    float fract = (1+sqrt(5))/2;
    for (int i=0; i<numPoints; i++) {
      Agent a = new Agent();
      float dst = radius*pow(i/(numPoints-1.), .5);
      float angle = 2*PI*fract*i;
      float posx = dst*cos(angle)+width/2+randomGaussian()*8;
      float posy = dst*sin(angle)+height/2+randomGaussian()*8;
      a.pos = new PVector(posx, posy);
      a.angle = random(TWO_PI);
      
      float fx = map(posx, 0,width, 0,1);
      float fy = map(posy, 0,height, 0,1);
      color col = rgradient(rcolor, fx, fy);
      a.col = col;
      agents.add(a);
    }
  }
}

color rgradient(int thing, float fx, float fy){
  color col = color(0);
  if (thing == 0){
    col = color(noise(fx, fy)*(200),0,200);
  }
  if (thing == 1){
    col = color(noise(fx, fy)*(200),200,200);
  }
  if (thing == 2){
    col = color(noise(fx, fy)*(100)+50,200,250);
  }
  if (thing == 3){
    col = color(noise(fx, fy)*(100)+50,200,noise(fy, fx)*100+100);
  }
  if (thing >= 4 && thing <=6){
    col = color(noise(1)*(255),noise(fx, fy)*noise(2)*255,noise(fy, fx)*noise(3)*255);
    col = lerpColor(col, color(255),.5);
  }
  return col;
}
 
float time = 0;
void draw() {
  for (Agent a : agents) {
    a.draw();
    a.update();
  }
  time += 0.001;
}
