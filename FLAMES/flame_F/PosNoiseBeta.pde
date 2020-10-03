// Template based on GenerateMe's one


float mnoise(float a){
  return noise(a)*2-1;
}

PVector pnoise(PVector a){
 return new PVector(mnoise(a.x/a.y), mnoise((a.y*5))); 
}

class Cam{
  PVector pos;
  float angle;
  float zoom;
  
  Cam(PVector pos_, float ang_, float zoom_){
    pos = pos_;
    angle = ang_;
    zoom = zoom_;
  }
}

class Variation{
   PVector pos;
   float angle;
   float scale;
   float weight;
   int col;
   
   Variation(PVector pos_){
     this(pos_, 0,1,1,0);
   }
   
   Variation(PVector pos_, float angle_, float scale_){
     this(pos_, angle_,scale_,1,0);
   }
   
   Variation(PVector pos_, float angle_, float scale_, float weight_){
     this(pos_, angle_,scale_,weight_,0);
   }
   
   Variation(PVector pos_, float angle_, float scale_, float weight_, int col_){
     pos = pos_;
     angle = angle_;
     scale = scale_;
     weight = weight_;
     col = col_;
   }
   
   
  
  
}

class PosNoiseB {
 
    ArrayList<Agent> agents = new ArrayList<Agent>();
    
    // global configuration
    float time = 0;
    color cback = 0;
    int seed;
    PGraphics cvs;
    
    Cam cam;

    float square_l = 3;
    float edge_l = 0;
    float map_l = square_l + edge_l;
    int npoints;

    int type_mod = 1; // lerp or add
    
    ArrayList<int[][]> buffers;
    ArrayList<Variation> varias;
    
    float sum_proba;
    
    int state = 0;
    PGraphics final_cvs;
    
    class Agent {

        PVector pt; // position of the agent
        PVector vel;
        float angle; // current angle of the agent
        color col;
        int mi;
        
        void update() {
            float scale_v = square_l;

            float xx = scale_v*map(pt.x, -square_l, square_l, -1, 1);
            float yy = scale_v*map(pt.y, -square_l, square_l, -1, 1);
            // v is vector from the field
            // placeholder for vector field calculations
            
            PVector p = new PVector(xx,yy);
            
            float ran = random(sum_proba+.4);
            
            float csum = 0;
            for (int i=0;i<varias.size()-1;i++){
              Variation v = varias.get(i);
              csum += v.weight;
              if (ran<csum){
                if (i==0){
                 //pt.add(pnoise(pt).mult(1));
                 pt.mult(v.scale);
                 this.store_dt(i);
                }
                else{
                  pt.add(v.pos);
                  pt.mult(v.scale);
                  pt.rotate(v.angle);
                 this.store_dt(i);
                }
                break;
              }
              
            }
            
              

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);

            // placeholder for vector field calculations

            float stren = .2;
            float vector_scale = 0.01; 
            
        }
        
        void draw(PGraphics cvs){
          int symms = 3;
          for (int i =0; i<symms;i++){
            PVector newpt = pt.copy().rotate(TAU/symms*i);
            float xx = map(newpt.x*cam.zoom-cam.pos.x, -map_l, map_l, -1, 1);
            float yy = map(newpt.y*cam.zoom-cam.pos.y, -map_l, map_l, -1, 1);
            float tx = cos(cam.angle)*xx+sin(cam.angle)*yy;
            yy = -sin(cam.angle)*xx+cos(cam.angle)*yy;
            xx= tx;
            xx = map(xx, -1, 1, 0, width);
            yy = map(yy, -1, 1, 0, height);
            
            cvs.stroke(#DE0909, 50);
            cvs.point(xx, yy); //draw
        }
      }
      void store_dt(int vari){
          int symms = 3;
          for (int i =0; i<symms;i++){
            PVector newpt = pt.copy().rotate(TAU/symms*i);
            float xx = map(newpt.x*cam.zoom-cam.pos.x, -map_l, map_l, -1, 1);
            float yy = map(newpt.y*cam.zoom-cam.pos.y, -map_l, map_l, -1, 1);
            float tx = cos(cam.angle)*xx+sin(cam.angle)*yy;
            yy = -sin(cam.angle)*xx+cos(cam.angle)*yy;
            xx= tx;
            xx = map(xx, -1, 1, 0, width);
            yy = map(yy, -1, 1, 0, height);
            if (is_inside(xx, yy)){
              int x = int(xx);
              int y = int(yy);
              buffers.get(vari)[x][y] += 1;
            }
        }
      }

    }

    void init(){
        seed = (int)random(1000);
        init(seed);
    }
    
    boolean is_inside(float x, float y){
      return (x>=0 && x<width && y>=0 && y<height);
    }

    void init(int seed){
        varias = new ArrayList<Variation>();
        Variation v1 = new Variation(new PVector(0, 0), 0, .45, .1, color(205, 0, 200));
        Variation v2 = new Variation(new PVector(0.3,-.5), PI/3, .9, .8,color(100, 255, 150));
        Variation v3 = new Variation(new PVector(.3,0.5), -PI/3, .2, .2,color(200, 0, 255));
        varias.add(v1);
        varias.add(v2);
        varias.add(v3);
        final_cvs = createGraphics(width, height);
        
        buffers = new ArrayList<int[][]>();
        for (int i=0;i<varias.size(); i++){
          int[][] a = new int[width][height];
          buffers.add(a);
          
          sum_proba += varias.get(i).weight;
          
        }
      
      
      
        cam = new Cam(new PVector(0,0), 0, 1);
        cam = new Cam(new PVector(.14, 0), 2.3, 2.5);
        noiseSeed(seed);
        cvs = createGraphics(width, height);
        cvs.smooth(8);
        
        cvs.beginDraw();
        cvs.strokeWeight(0.66);
        cvs.noFill();
        cvs.background(cback);
        cvs.endDraw();

        agents.clear();

        float ninc = .07;
        npoints = (int)pow(square_l*2/ninc, 2);
        int i = 0;

        for (float x=-square_l; x<=square_l; x+=ninc) {
        for (float y=-square_l; y<=square_l; y+=ninc) {
            PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
            v = new PVector(0,0);
            Agent a = new Agent();
            a.pt = v;
            a.vel = new PVector(0,0);
            a.mi = i;
            agents.add(a);
            i++;
        }
        }
    }

    void update(){
      if (state == 0){
        for (Agent a : agents) {
          a.update();
        }
      }
    }
   
    void draw() {
      if (state == 0){
        cvs.beginDraw();
        for (Agent a : agents) {
          a.draw(cvs);
        }
        cvs.endDraw();
        image(cvs, 0,0);
      }else{
        image(final_cvs, 0,0);
      }
        time += 0.001;
    }
    void rredraw(){
      cvs.beginDraw();
        cvs.strokeWeight(0.66);
        cvs.noFill();
        cvs.background(cback);
        cvs.endDraw();

        agents.clear();

        float ninc = .07;
        npoints = (int)pow(square_l*2/ninc, 2);
        int i = 0;
        for (float x=-square_l; x<=square_l; x+=ninc) {
        for (float y=-square_l; y<=square_l; y+=ninc) {
            PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
            v = new PVector(0,0);
            Agent a = new Agent();
            a.pt = v;
            a.vel = new PVector(0,0);
            a.mi = i;
            agents.add(a);
            i++;
        }
        }
    }
    
    void render(){
      int[][] totalhits = new int[width][height];
      int m_hits=0;
      
      for (int i = 0;i<width;i++)
      for (int j = 0; j< height; j++){
        for (int k = 0; k < varias.size();k++){
          totalhits[i][j] += buffers.get(k)[i][j];
        }
        m_hits = max(m_hits, totalhits[i][j]);
      }
      final_cvs.beginDraw();
      for (int i = 0;i<width;i++)
      for (int j = 0; j< height; j++){
        float r = 0;
        float g = 0;
        float b = 0;
        if (totalhits[i][j] == 0){
          continue;
        }
        for (int k = 0; k < varias.size();k++){
          float weight = buffers.get(k)[i][j]/totalhits[i][j];
          r += red(varias.get(k).col)*weight;
          g += blue(varias.get(k).col)*weight;
          b += green(varias.get(k).col)*weight;
        }
        final_cvs.set(i,j, color(r,g,b));
      }
      final_cvs.endDraw();
      
    }
  
    void keyPressed(){
        if (key=='p' || key=='s'){
            saveFrame("out-####.png");
        }
        if (keyCode == 32){
            init();
        }
        if (key == 'n'){
            println(seed);
            init(seed);
        }
        if (key == 'x'){
          render();
          background(0);
          print("done");
            state = 1;
        }
        int[] cool_keys = new int[]{LEFT, RIGHT, UP, DOWN};
        for (int v:cool_keys){
          if (keyCode == v){
            PVector upvec = new PVector(cos(cam.angle), sin(cam.angle));
            PVector rightvec = new PVector(cos(cam.angle + PI/2), sin(cam.angle+PI/2));
            if (keyCode == LEFT){
              cam.pos.add(upvec.mult(.1));;
            }
            if (keyCode == RIGHT){
              cam.pos.add(upvec.mult(-.1));;
            }
            if (keyCode == UP){
              cam.pos.add(rightvec.mult(.1));;
            }
            if (keyCode == DOWN){
              cam.pos.add(rightvec.mult(-.1));;
            }
            rredraw();
          }
        }
       char[] best_keys = new char[]{'a', 'z', 'e', 'r'};
       for (char v:best_keys){
          if (key == v){
            if (key == 'a'){
              cam.zoom += .1;
            }
            if (key == 'z'){
              cam.zoom -= .1;
            }
            if (key == 'e'){
              cam.angle += .1;
            }
            if (key == 'r'){
              cam.angle -= .1;
            }
          rredraw();
            }
          }
         if (key == 'w'){
           print(cam.pos, cam.angle, cam.zoom);
         }
        }
    }
