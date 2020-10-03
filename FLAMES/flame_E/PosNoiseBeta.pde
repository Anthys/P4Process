// Template based on GenerateMe's one

PImage[] imgs;
float mnoise(float a){
  return noise(a)*2-1;
}

PVector pnoise(PVector a){
 return new PVector(mnoise(a.x+a.y), mnoise((a.x*a.y))); 
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
            
            float ran = random(1.5);
            PImage img = imgs[0];
            if (ran<.1){
              img = imgs[0];
            }else if (ran<.9){
              img = imgs[1];
             pt.rotate(PI/3);
            }else if (ran<1.1){
              img = imgs[2];
            }
             
            int ix = (int)map(xx, -1,1, 0, img.width);
            int iy = (int)map(yy, -1,1, 0, img.height);
            color col = img.get(ix, iy);
            float supra = red(col)/255;
            supra = supra*2-1;
            
            if (ran<10){
              //float ar = .25;
              //float nx = random(-ar,ar);
              //float ny = random(-ar,ar);
              //pt = new PVector(nx, ny);
               pt.add(pnoise(pt).mult(1));
               pt = PVector.mult(pt, supra);
            }else if (ran<.9){
             pt = PVector.add(pt, new PVector(0.3,supra));
             pt = PVector.mult(pt, .9);
             pt.rotate(PI/3);
            }else if (ran<1.1){
             pt = PVector.add(pt, new PVector(.3,0.5));
             pt = PVector.mult(pt, .2);
             pt.rotate(supra*PI);
            }
            
              

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);

            // placeholder for vector field calculations

            float stren = .2;
            float vector_scale = 0.01; 
            
        }
        
        void draw(PGraphics cvs){
          int symms = 1;
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

    }

    void init(){
        seed = (int)random(1000);
        init(seed);
    }

    void init(int seed){
        PImage img1 = loadImage("a.jpg");
        PImage img2 = loadImage("b.jpg");
        PImage img3 = loadImage("c.jpg");
        imgs = new PImage[]{img1, img2, img3};
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
        for (Agent a : agents) {
          a.update();
        }
    }
   
    void draw() {
        cvs.beginDraw();
        for (Agent a : agents) {
          a.draw(cvs);
        }
        cvs.endDraw();
        image(cvs, 0,0);
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