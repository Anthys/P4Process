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
    strokeWeight(0.66);
    noFill();
    smooth(8);
   
    // noiseSeed(1111); // sometimes we select one noise field
     init();
    
  }
  
  void init(){
    background(0, 5, 25);
    background(#47135A);
    points.clear();
    // create points from [-3,3] range
    float ninc = .04;
    float a = 3;
    for (float x=-a; x<=a; x+=ninc) {
      for (float y=-a; y<=a; y+=ninc) {
        // create point slightly distorted
        PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
        points.add(v);
      }
    }
  }
   
  void draw() {
    int point_idx = 0; // point index
    float a = 6;
    float g = 2;
    for (PVector p : points) {
      // map floating point coordinates to screen coordinates
      float xx = map(p.x, -a, a, 0, width);
      float yy = map(p.y, -a-g, 4, 0, height);
   
      // select color from palette (index based on noise)
      //int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
      //stroke(pal[cn], 15);
      //stroke(noise(point_idx)*255, 0,100, 20);
      stroke(#F2DA22, 20);
      point(xx, yy); //draw
   
      // placeholder for vector field calculations
   
      // v is vector from the field
      // placeholder for vector field calculations
      float n = noise(p.x, p.y);
       
      PVector v = new PVector(0,0);
      //n = float(point_idx)/100;
      //n = noise(p.x, p.y);
      //n = atan2(p.x, p.y);
      //n = p.mag()/n;
      //n *= 10;
      //n = (float)point_idx*5;//+noise(n)*20;
      //n = point_idx;
      //n -= p.mag()*30;
      //n = noise(p.x, p.y)*100;
      //n = n/p.mag();
      //n= random(1)+float(frameCount)/10;
      n = (float)point_idx;
      n = noise(p.x, p.y)*100;
      n= n/p.mag()/atan2(p.x, p.y);
      v = variation1t2.cardiod(n);
      //v = variation1t2.astroid(n);
      float c = 1./30000*n;
      c = atan2(p.x, p.y)*p.mag();
      //c=10;
      v.mult(c);
      //v = variation1t2.astroid(n);
      /*for (int j=0;j<3;j++){
      v.x = v.x%.5+(v.x/.5)*.2;
      v.y = v.y%.5+(v.y/.8)*.2;
      }*/
     //p.x = lerp(p.x, 0, p.mag()/10);
     float stren = .2;
       //p.x = lerp(p.x, v.x, stren);
       //p.y = lerp(p.y, v.y, stren);
      //v.x += noise(p.x);
      p.x += vector_scale * v.x;
      p.y += vector_scale * v.y;
     
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
