//drawing agent
class Agent {
  PVector pos; // position of the agent
  float angle; // current angle of the agent
 
  void update() {
    // modify position using current angle
    pos.x += cos(angle);
    pos.y += sin(angle);
 
    // get point coordinates
    float xx = map(pos.x, 0, width, -1, 1);
    float yy = map(pos.y, 0, height, -1, 1);
 
    PVector v = new PVector(xx, yy);
 
    // modify an angle using noise information
    angle += map( noise(v.x, v.y), 0, 1, -1, 1);
  }
  
  void update2() {
  // modify position using current angle
  pos.x += cos(angle);
  pos.y += sin(angle);
 
  // get point coordinates
  float xx = 3 * map(pos.x, 0, width, -1, 1);
  float yy = 3 * map(pos.y, 0, height, -1, 1);
 
  float n1 = noise(xx+5,yy-3)-0.55;
 
PVector vc = kampyle(n1);
PVector v = sinusoidal(vc,1);
v.mult(5);
v.add(new PVector(5,-3));
 
  // modify an angle using noise information
  angle += 3 * map( noise(v.x, v.y), 0, 1, -1, 1);
}
}
 
// all agents in the list
ArrayList<Agent> agents = new ArrayList<Agent>();
 
void setup() {
  size(800, 800);
  background(240);
  stroke(20, 10);
  smooth(8);
  strokeWeight(0.7);
 
  // initialize in random positions
  for (int i=0; i<5000; i++) {
    Agent a = new Agent();
    float posx = random(200, 600);
    float posy = random(200, 600);
    a.pos = new PVector(posx, posy);
    a.angle = random(TWO_PI);
    agents.add(a);
  }
}
 
float time = 0;
void draw() {
  for (Agent a : agents) {
    pushMatrix();
    // position
    translate(a.pos.x, a.pos.y);
    // rotate
    rotate(a.angle);
    // paint
    point(0, 0);
    popMatrix();
    // update
    a.update2();
  }
  time += 0.001;
}

PVector kampyle(float n) {
  float sec = 1/sin(n);
 
  float xt = sec;
  float yt = tan(n)*sec;
 
  return new PVector(xt, yt);
}
PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}