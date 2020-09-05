// Template based on GenerateMe's one
class PosNoiseB {
 
    ArrayList<Agent> agents = new ArrayList<Agent>();
    
    // global configuration
    float time = 0;
    color cback = 0;
    int seed;
    PGraphics cvs;
    PImage img = loadImage("h.png");

    float square_l = 6;
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

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);
            
            v = new PVector(cos(TAU*sin(TAU*noise(p.x, p.y))),sin(TAU*cos(TAU*noise(p.y, p.x))));

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
        
        void draw(PGraphics cvs){
            float xx = map(pt.x, -map_l, map_l, 0, width);
            float yy = map(pt.y, -map_l, map_l, 0, height);
            
            cvs.stroke(col);
            cvs.point(xx, yy); //draw
        }

    }

    void init(){
        seed = (int)random(1000);
        init(seed);
    }

    void init(int seed){

        noiseSeed(seed);
        cvs = createGraphics(width, height);
        cvs.smooth(8);
        //init();
        
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
            Agent a = new Agent();
            a.pt = v;
            a.vel = new PVector(0,0);
            a.mi = i;
            float xx = map(a.pt.x, -map_l, map_l, 0, width);
            float yy = map(a.pt.y, -map_l, map_l, 0, height);
            a.col = img.get((int)xx, (int)yy);
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
    }
}
