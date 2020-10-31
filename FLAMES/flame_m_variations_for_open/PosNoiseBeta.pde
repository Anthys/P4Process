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
   float col;
   
   Variation(PVector pos_){
     this(pos_, 0,1,1,0);
   }
   
   Variation(PVector pos_, float angle_, float scale_){
     this(pos_, angle_,scale_,1,0);
   }
   
   Variation(PVector pos_, float angle_, float scale_, float weight_){
     this(pos_, angle_,scale_,weight_,0);
   }
   
   Variation(PVector pos_, float angle_, float scale_, float weight_, float col_){
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
    
    int[][] buffer;
    Float[][][] cvs_colors;
    ArrayList<Variation> varias;
    
    float sum_proba;
    
    int state = 0;
    PGraphics final_cvs;
    PImage gradient;
    
    int n_iterations = 0;
    
    int symms = 3;
    
    
    color color_from_gradient(float indx){
      int ind = int(indx*gradient.width);
      int col = gradient.get(ind,0);
      return col;
    }
    
    class Agent {

        PVector pt; // position of the agent
        PVector vel;
        float angle; // current angle of the agent
        float col = random(1);
        int mi;
        
        void update() {
            float scale_v = square_l;

            float xx = scale_v*map(pt.x, -square_l, square_l, -1, 1);
            float yy = scale_v*map(pt.y, -square_l, square_l, -1, 1);
            // v is vector from the field
            // placeholder for vector field calculations
            
            PVector p = new PVector(xx,yy);
            
            float ran = random(sum_proba);
            
            float csum = 0;
            for (int i=0;i<varias.size();i++){
              Variation v = varias.get(i);
              csum += v.weight;
              if (ran<csum){
                
                  pt.add(v.pos);
                  pt.mult(v.scale);
                  pt.rotate(v.angle);
                  col = (varias.get(i).col+col)/2;
                  if (i==0){
                    pt.x += mnoise(pt.x)*.5;
                    pt.y += mnoise(pt.y)*.5;
                    //pt.x = sin(pt.x);
                    pt = variations2t2.spherical(pt);
                  }
                  if (i==1){
                    pt = variations2t2.polar(pt);
                  }
                  if (n_iterations>20){
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
          for (int i =0; i<symms;i++){
            PVector newpt = pt.copy();
            newpt.rotate(TAU/symms*i);
            float xx = map(newpt.x*cam.zoom-cam.pos.x, -map_l, map_l, -1, 1);
            float yy = map(newpt.y*cam.zoom-cam.pos.y, -map_l, map_l, -1, 1);
            float tx = cos(cam.angle)*xx+sin(cam.angle)*yy;
            yy = -sin(cam.angle)*xx+cos(cam.angle)*yy;
            xx= tx;
            xx = map(xx, -1, 1, 0, width);
            yy = map(yy, -1, 1, 0, height);
            
            //cvs.stroke(#DE0909, 50);
            //cvs.point(xx, yy); //draw
          }
      }
      void store_dt(int vari){
          int mycol = color_from_gradient(col);
          for (int i =0; i<symms;i++){
            //print(i);
            PVector newpt = new PVector(pt.x, pt.y);
            newpt.rotate(TAU/symms*i);
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
              buffer[x][y] += 1;
              cvs_colors[0][x][y] += red(mycol)/255;
              cvs_colors[1][x][y] += blue(mycol)/255;
              cvs_colors[2][x][y] += green(mycol)/255;
            }
      }}
      

    }

    void init(){
        seed = (int)random(1000);
        init(seed);
    }
    
    boolean is_inside(float x, float y){
      return (x>=0 && x<width && y>=0 && y<height);
    }

    void init(int seed){
        gradient = loadImage("michel.png");
        varias = new ArrayList<Variation>();
        Variation v1 = new Variation(new PVector(1, .1), 2*PI/3-PI/12, .8, 1, .5);
        Variation v2 = new Variation(new PVector(0.5,0.5), PI/4, .6, .3,1);
        Variation v3 = new Variation(new PVector(.3,0.5), 2*PI/3, .2, .2,0);
        varias.add(v1);
        varias.add(v2);
        varias.add(v3);
        
        for (int i=0;i<varias.size(); i++){
          
          sum_proba += varias.get(i).weight;
          
        }
        final_cvs = createGraphics(width, height);
        
        buffer = new int[width][height];
        cvs_colors = new Float[3][width][height];
        
        for (int i = 0; i <3;i++)
        for (int j = 0; j <width;j++)
        for (int k = 0; k <height;k++){
          cvs_colors[i][j][k] = 0.;
        }
        
      
      
      
        cam = new Cam(new PVector(0,0), 0, 1);
        cam = new Cam(new PVector(-1.9, 1.4), .9, 3.3);
        cam = new Cam(new PVector(0,0), .9, 1.5);
        //cam = new Cam(new PVector(-1.14, 1.05), .9, 12.3);
        noiseSeed(seed);
        cvs = createGraphics(width, height);
        cvs.smooth(8);
        
        cvs.beginDraw();
        cvs.strokeWeight(0.66);
        cvs.noFill();
        cvs.background(cback);
        cvs.endDraw();
        
        reset_agents();

        
    }
    
    void reset_agents(){
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
        n_iterations += 1;
        println(n_iterations);
        if (n_iterations % 50 == 0){
          render();
          image(final_cvs, 0,0);
      };
        if (n_iterations >= 500){
          render();
          image(final_cvs, 0,0);
          saveFrame("out_####.png");
          state = 1;
        }
      }
      if (mousePressed && false){
      if (mouseButton==LEFT){
        varias.get(0).pos.x = map(mouseX, 0, width, -2,2);
        varias.get(0).pos.y = map(mouseY, 0, height, -2,2);
      }
      if (mouseButton==RIGHT){
        varias.get(0).angle = map(mouseX, 0, width, -PI,PI);
      }
        rredraw();
      }
    }
   
    void draw() {
      if (state == 0){
        cvs.beginDraw();
        for (Agent a : agents) {
          a.draw(cvs);
        }
        cvs.endDraw();
        //image(cvs, 0,0);
        
        Variation cvar = varias.get(0);
        float xx = map(cvar.pos.x, -2, 2, 0, width);
        float yy = map(cvar.pos.y, -2, 2, 0, height);
        float x1 = map(cvar.pos.x+cos(cvar.angle)*.5, -2, 2, 0, width);
        float y1 = map(cvar.pos.y+sin(cvar.angle)*.5, -2, 2, 0, height);
        float x2 = map(cvar.pos.x+cos(cvar.angle+PI/2)*.5, -2, 2, 0, width);
        float y2 = map(cvar.pos.y+sin(cvar.angle+PI/2)*.5, -2, 2, 0, height);
        stroke(255);
        strokeWeight(2);
        line(xx, yy, x1, y1);
        line(xx, yy, x2, y2);
      }else{
        image(final_cvs, 0,0);
      }
        time += 0.001;
    }
    void rredraw(){
      n_iterations = 0;
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
        
        buffer = new int[width][height];
        cvs_colors = new Float[3][width][height];
        final_cvs = createGraphics(width, height);
        
        for (int ii = 0; ii <3;ii++)
        for (int j = 0; j <width;j++)
        for (int k = 0; k <height;k++){
          cvs_colors[ii][j][k] = 0.;
        }
        
    }
    
    
    void render(){
      println(n_iterations);
      int[][] totalhits = new int[width][height];
      int m_hits=0;
      
      for (int i = 0;i<width;i++)
      for (int j = 0; j< height; j++){
        m_hits = max(m_hits, buffer[i][j]);
      }
      final_cvs.smooth(8);
      final_cvs.beginDraw();
      final_cvs.strokeWeight(1);
      for (int i = 0;i<width;i++)
      for (int j = 0; j< height; j++){
        float r = 0;
        float g = 0;
        float b = 0;
        if (buffer[i][j] == 0){
          continue;
        }
        float weight = log(float(buffer[i][j]))/log(float(m_hits));
        float gamma = 1/2.2;
        gamma = .5;
        weight = pow(weight, gamma);
        float cgamma = 2;
        float cmix = .5;
        r = pow(cvs_colors[0][i][j]*weight, gamma);
        g = pow(cvs_colors[1][i][j]*weight, gamma);
        b = pow(cvs_colors[2][i][j]*weight, gamma);
        r = cvs_colors[0][i][j]/float(buffer[i][j]);
        g = cvs_colors[1][i][j]/float(buffer[i][j]);
        b = cvs_colors[2][i][j]/float(buffer[i][j]);
        r = lerp(r, pow(r, cgamma), cmix);
        g = lerp(g, pow(g, cgamma), cmix);
        b = lerp(b, pow(b, cgamma), cmix);
        //weight = pow(weight, 1/100);
        color c = color(r*255,g*255,b*255, weight*255);
        c = color(weight*255);
        c = color(r*255,g*255,b*255);
        c = lerpColor(cback, c, weight);
        //final_cvs.set(i,j, color(r*255,g*255,b*255, weight*255));
        //final_cvs.stroke(c);
        //final_cvs.point(i,j);
        final_cvs.set(i,j, c);
      }
      final_cvs.endDraw();
      
      background(0);
      print("done");
        //state = 1;
      
    }
  
    void keyPressed(){
        if (key=='p' || key=='s'){
            saveFrame("out-####.png");
        }
        if (keyCode == 32){
            state = 0;
            rredraw();
        }
        if (key == 'n'){
            println(seed);
            init(seed);
        }
        if (key == 'x'){
          render();
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
