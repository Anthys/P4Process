// Template based on GenerateMe's one
class NoiseDance {
 
 class Agent {
  PVector pos; // position of the agent
  float angle; // current angle of the agent
  color col;
  int self_i;
  int type_mod = 0;
 
  void update() {
    // modify position using current angle
    float amp = 1;
    pos.x += cos(angle)*amp;
    pos.y += sin(angle)*amp;
 
    PVector scale_pos = new PVector(1,1);
     
    // get point coordinates
    float xx = scale_pos.x* map(pos.x, 0, width, -1, 1);
    float yy = scale_pos.y* map(pos.y, 0, height, -1, 1);
 
    PVector pp = new PVector(xx, yy);
    
    PVector v = new PVector(xx, yy);
    
    // VARIATION HERE
    
    v.mult(4);
    v.add(new PVector(0,-0));
    float b = noise(v.x, v.y)*2-1;
    b = atan2(v.x, v.y);
    PVector a = variation1t2.cardiod(b);
        
    //v .add( a);
        
    
    // MODIFICATIONS HERE
    
    // modify an angle using noise information
    float scale_angle = 3;
    float m = map( noise(v.x, v.y), 0, 1, -1, 1);
    m = v.mag()/atan2(v.x, v.y);
    m = pow(m, 4);
    //m=cos(m);
    //m = noise(m);
    angle += scale_angle* m;
  }
  
  void draw(){
    stroke(col, 20);
    point(pos.x, pos.y);
  }

  } 
   
  // global configuration
  float time = 0; // time passes by
  color cback = #47135A;

  float square_l = 3;
  float npoints;
  int type_mod = 0; // lerp or add
   
  void setup() {
    smooth(8);
    // noiseSeed(1111);
    init();
    
  }
  
  void init(){
    strokeWeight(0.66);
    noFill();
    background(cback);
    points.clear();

    float ninc = .04;
    npoints = pow(square_l*2/ninc, 2);
    
    for (float x=-square_l; x<=square_l; x+=ninc) {
      for (float y=-square_l; y<=square_l; y+=ninc) {
        PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
        points.add(v);
      }
    }
  }
   
  void draw() {
    int point_idx = 0;
    float edge_l = 2;
    float map_l = square_l + edge_l;
    for (PVector p : points) {
        float xx = map(p.x, -map_l, map_l, 0, width);
        float yy = map(p.y, -map_l, map_l, 0, height);

        stroke(#F2DA22, 20);
        point(xx, yy); //draw
    
        // v is vector from the field
        // placeholder for vector field calculations
        
        float n = noise(p.x, p.y);

        PVector v = new PVector(0,0);

        // placeholder for vector field calculations

        float stren = .2;
        float vector_scale = 0.01; 

        switch (type_mod){
        case 0:
            p.x = lerp(p.x, v.x, stren);
            p.y = lerp(p.y, v.y, stren);
        case 1:
            p.x += vector_scale * v.x;
            p.y += vector_scale * v.y;
        }
        point_idx++;
        }
        time += 0.001;
  }
  
void keyPressed(){
  if (key=='p' || key=='s'){
    saveFrame("out-####.png");
  }
  if (keyCode == 32){
    init();
  }
}
}