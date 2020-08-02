// Template based on GenerateMe's one
class PosNoise {
 
    ArrayList<Agent> agents = new ArrayList<Agent>();
    
    // global configuration
    float time = 0; // time passes by
    color cback = 0;

    float square_l = 6;
    float npoints;
    int type_mod = 1; // lerp or add
    
    PImage img;
    PGraphics cvs;
    
    class Agent {

        PVector pos; // position of the agent
        PVector v;
        float angle; // current angle of the agent
        color col;
        int self_i;
        
        void update() {
            
        }
        
        void draw(){
            stroke(col, 20);
            point(pos.x, pos.y);
        }

    }
    
    void setup() {
        cvs = createGraphics(width, height);
        cvs.smooth(8);
        // noiseSeed(1111);
        init();
        img = loadImage("a.jpg");
        img.resize(width, height);
    }
    
    void init(){cvs.beginDraw();
        cvs.strokeWeight(0.66);
        cvs.noFill();
        cvs.background(cback);
        cvs.endDraw();
        agents.clear();

        float ninc = .04;
        npoints = pow(square_l*2/ninc, 2);
        int i = 0;
        for (float x=-square_l; x<=square_l; x+=ninc) {
        for (float y=-square_l; y<=square_l; y+=ninc) {
            PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
            Agent a = new Agent();
            a.pos = v;
            a.v = new PVector(0,0);
            a.self_i = i;
            agents.add(a);
            i++;
        }
        }
    }
   
    void draw() {
        int point_idx = 0;
        float edge_l = 0;
        float map_l = square_l + edge_l;
        cvs.beginDraw();
        for (PVector p : points) {
            float xx = map(p.x, -map_l, map_l, 0, width);
            float yy = map(p.y, -map_l, map_l, 0, height);
            
            //float ximg = map(p.x, -map_l, map_l, 0, img.width);
            //float yimg = map(p.y, -map_l, map_l, 0, img.height);
            float ximg = map(noise(p.x), 0, 1, 0, img.width);
            float yimg = map(noise(p.y), 0, 1, 0, img.height);
            color cimg = img.get(int(ximg), int(yimg));
            //cvs.stroke(#DE0909, 20);
            cvs.stroke(cimg, 30);
            cvs.point(xx, yy); //draw
            point_idx++;
        }
        cvs.endDraw();


        point_idx = 0;
        for (PVector pt : points) {
            
            float scale_v = square_l;

            float xx = scale_v*map(pt.x, -square_l, square_l, -1, 1);
            float yy = scale_v*map(pt.y, -square_l, square_l, -1, 1);
            // v is vector from the field
            // placeholder for vector field calculations
            float ximg = map(pt.x, -map_l, map_l, 0, img.width);
            float yimg = map(pt.y, -map_l, map_l, 0, img.height);
            color cimg = img.get(int(ximg), int(yimg));
            
            PVector p = new PVector(xx,yy);

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);
            
            
            n = noise(p.x, p.y)*100;
            n=p.x*p.y;///atan2(p.x, p.y);
            n = pow(red(cimg)*abs(cos(green(cimg))), .1);
            v = variation1t2.cardiod(n);
            
            
            float c = 1./30000*n;
            //c = p.mag();
            //v.x += c;
            //v.mult(int(c)+1);
            v.normalize();
            //v.mult(3);

            // placeholder for vector field calculations

            float stren = .2;
            float vector_scale = 0.01; 
            

            switch (type_mod){
                case 0:
                    pt.x = lerp(p.x, v.x, stren);
                    pt.y = lerp(p.y, v.y, stren);
                    break;
                case 1:
                    pt.x += vector_scale * v.x;
                    pt.y += vector_scale * v.y;
                    break;
            }
            point_idx++;
        }
        image(cvs, 0,0);
        time += 0.001;
    }
  
    void keyPressed(){
        if (key=='p' || key=='s'){
            saveFrame("out-####.png");
        }
        if (keyCode == 32){
            init();
        }
        if (key == 'd'){
          image(img, 0,0);
        }
    }
}
