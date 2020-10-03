// Template based on GenerateMe's one
class PosNoiseB {
 
    ArrayList<Agent> agents = new ArrayList<Agent>();
    
    // global configuration
    float time = 0;
    color cback = 0;
    int seed;
    PGraphics cvs;

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
            
            float ran = random(1);
            if (ran<.25){
              //float ar = .25;
              //float nx = random(-ar,ar);
              //float ny = random(-ar,ar);
              //pt = new PVector(nx, ny);
               pt = PVector.mult(pt, .25);
             pt.add(new PVector(noise(p.x, p.y), noise(p.x, p.y)));
            }else if (ran<1){
             pt = PVector.add(pt, new PVector(0.5,0.5));
             pt = PVector.mult(pt, .9);
             pt.rotate(PI/4);
            }else if (ran<1.5){
            }
            
              

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);

            // placeholder for vector field calculations

            float stren = .2;
            float vector_scale = 0.01; 
            
        }
        
        void draw(PGraphics cvs){
            float xx = map(pt.x, -map_l, map_l, 0, width);
            float yy = map(pt.y, -map_l, map_l, 0, height);
            
            cvs.stroke(#DE0909, 50);
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
