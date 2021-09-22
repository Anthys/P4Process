int cols = 100;
int rows = cols;
int [][] grid = new int[rows][cols];
PGraphics cvs = createGraphics(rows,cols);

class Agent{
    
  PVector pos;
  PVector vel;
  float angle;
  float dist_sense = 2;
  float angle_sense = PI/6;
  float delta_angle_turn = PI/6;
  float dist_move = 1;
  
  Agent(float x, float y, float a){
    pos = new PVector(x,y);
    angle = a;
  }
  
  void update(){
    // SENSE & ROTATE
    
    int sign_delta_angle = 0;
    int xsenseA = int(pos.x + dist_sense*cos(angle+angle_sense));
    int ysenseA = int(pos.y+ dist_sense*sin(angle+angle_sense));
    int xsenseB = int(pos.x + dist_sense*cos(angle));
    int ysenseB = int(pos.y+ dist_sense*sin(angle));
    int xsenseC = int(pos.x + dist_sense*cos(angle-angle_sense));
    int ysenseC = int(pos.y+ dist_sense*sin(angle-angle_sense));
    int senseA = grid[ysenseA][xsenseA];
    int senseB = grid[ysenseB][xsenseB];
    int senseC = grid[ysenseC][xsenseC];
    if (senseB > senseA && senseB > senseC){    
    }else if (senseB < senseA && senseB < senseC){
      sign_delta_angle = int(random(2))==0?-1:1;
    }else if (senseB > senseA && senseB < senseC){
      sign_delta_angle = -1;
    }else if (senseB < senseA && senseB > senseC){
      sign_delta_angle = 1;
    }
    angle += sign_delta_angle*delta_angle_turn;
    
    // MOVE
    
    pos.add(new PVector(dist_move*cos(angle), dist_move*sin(angle)));
    
    // DEPOSIT
    
    
}
  
  
  
}

ArrayList<Agent> agents;


void setup(){
  size(1000,1000);
}
void draw(){
}
