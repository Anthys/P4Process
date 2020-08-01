class PosNoise {
 
  ArrayList<PVector> points = new ArrayList<PVector>();
 
  // colors used for points
  color[] pal = {
    color(0, 91, 197),
    color(0, 180, 252),
    color(23, 249, 255),
    color(223, 147, 0),
    color(248, 190, 0)
  };
   
  // global configuration
  float vector_scale = 0.01; // vector scaling factor, we want small steps
  float time = 0; // time passes by
   
  void setup() {
    //size(800, 800);
    strokeWeight(0.66);
    noFill();
    smooth(8);
   
    // noiseSeed(1111); // sometimes we select one noise field
     init();
    
  }
  
  void init(){
    background(0, 5, 25);
    background(#300469);
    points.clear();
    // create points from [-3,3] range
    float ninc = .04;
    for (float x=-3; x<=3; x+=ninc) {
      for (float y=-3; y<=3; y+=ninc) {
        // create point slightly distorted
        PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
        points.add(v);
      }
    }
  }
   
  void draw() {
    int point_idx = 0; // point index
    float a = 3;
    for (PVector p : points) {
      // map floating point coordinates to screen coordinates
      float xx = map(p.x, -a, a, 0, width);
      float yy = map(p.y, -a, a, 0, height);
   
      // select color from palette (index based on noise)
      //int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
      //stroke(pal[cn], 15);
      stroke(noise(point_idx)*255, 0,100, 20);
      stroke(#F2DA22, 20);
      point(xx, yy); //draw
   
      // placeholder for vector field calculations
   
      // v is vector from the field
      // placeholder for vector field calculations
      float n = noise(p.x, p.y);
       
      PVector v = new PVector(0,0);
      n = float(point_idx)/100;
      n = noise(p.x, p.y);
      //n = atan2(p.x, p.y);
      n = p.mag()/n;
      n *= 10;
      n = point_idx+noise(n)*20;
      v = variation1t2.cardiod(n);
   
     float stren = .5;
       p.x = lerp(p.x, v.x, stren);
       p.y = lerp(p.y, v.y, stren);
      //p.x += vector_scale * v.x;
      //p.y += vector_scale * v.y;
     
      // go to the next point
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
