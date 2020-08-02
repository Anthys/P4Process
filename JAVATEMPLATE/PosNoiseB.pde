// Template based on GenerateMe's one
class PosNoiseB {
 
    ArrayList<Agent> agents = new ArrayList<Agent>();
    
    // global configuration
    float time = 0; // time passes by
    color cback = 0;

    float square_l = 6;
    float edge_l = 0;
    float map_l = square_l + edge_l;
    float npoints;
    int type_mod = 1; // lerp or add
    
    PGraphics cvs;
    
    class Agent {

        PVector pt; // position of the agent
        PVector vel;
        float angle; // current angle of the agent
        color col;
        int self_i;
        
        void update() {
            float scale_v = square_l;

            float xx = scale_v*map(pt.x, -square_l, square_l, -1, 1);
            float yy = scale_v*map(pt.y, -square_l, square_l, -1, 1);
            // v is vector from the field
            // placeholder for vector field calculations
            
            PVector p = new PVector(xx,yy);

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);

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
            vel = v;
            
        }
        
        void draw(){
            float xx = map(pt.x, -map_l, map_l, 0, width);
            float yy = map(pt.y, -map_l, map_l, 0, height);
            
            cvs.stroke(#DE0909, 50);
            cvs.point(xx, yy); //draw
        }

    }
    
    void setup() {
        cvs = createGraphics(width, height);
        cvs.smooth(8);
        // noiseSeed(1111);
        init();
    }
    
    void init(){cvs.beginDraw();
        cvs.strokeWeight(0.66);
        cvs.noFill();
        cvs.background(cback);
        cvs.endDraw();
        agents.clear();

        float ninc = .07;
        npoints = pow(square_l*2/ninc, 2);
        int i = 0;
        for (float x=-square_l; x<=square_l; x+=ninc) {
        for (float y=-square_l; y<=square_l; y+=ninc) {
            PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
            Agent a = new Agent();
            a.pt = v;
            a.vel = new PVector(0,0);
            a.self_i = i;
            agents.add(a);
            i++;
        }
        }
    }
   
    void draw() {
        int point_idx = 0;
        cvs.beginDraw();
        for (Agent a : agents) {
          a.draw();
          a.update();
        }
        cvs.endDraw();
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
    }
}
