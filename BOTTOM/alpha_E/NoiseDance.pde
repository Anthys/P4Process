class NoiseDance{
// Template based on GenerateMe's one
class PosNoiseB {
 
    ArrayList<Agent> agents = new ArrayList<Agent>();
    
    // global configuration
    float time = 0;
    color cback = 0;
    int seed;
    PGraphics cvs;

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
        init();
        
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
class CurvNoise {

    color cback = 255;
    float time = 0;
    int seed;
    PGraphics cvs;
  
    class Agent {

        PVector pos; // position of the agent
        float angle; // current angle of the agent
        color col;
        int mi;
        
        void update() {
            // modify position using current angle
            pos.x += cos(angle);
            pos.y += sin(angle);
        
            PVector scale_pos = new PVector(3,3);
            
            // get point coordinates
            float xx = scale_pos.x* map(pos.x, 0, width, -1, 1);
            float yy = scale_pos.y* map(pos.y, 0, height, -1, 1);
        
            PVector pp = new PVector(xx, yy);
            PVector pp2 = new PVector(xx/scale_pos.x, yy/scale_pos.y);
            
            
            PVector v = variations2t2.spherical(pp);
            //PVector v = new PVector(xx, yy);
            //v.mult(5);
            v.add(new PVector(5,-3));
            
            v.mult(5);
            
            // modify an angle using noise information
            float scale_angle = 10;
            float m = map( noise(v.x, v.y), 0, 1, -1, 1);
            float rrr = .5;
            m = pp2.mag()>rrr-.2?lerp(m, .5, constrain((-.3+pp2.mag())*2, 0., 1.)):m;
            //m = pp2.mag()>rrr?2:m;
            //m = v.mag();
            angle += scale_angle* m;
            pos.add(pp.mult(m));
        }
        
        void draw(PGraphics cvs){
            cvs.stroke(col, 50);
            cvs.point(pos.x, pos.y);
        }

    }
    
    ArrayList<Agent> agents = new ArrayList<Agent>();

    void init(){
        seed = (int)random(1000);
        init(seed);
    }

    void init(int seed){
        noiseSeed(seed);

        cvs = createGraphics(width, height);
        cvs.smooth(8);

        cvs.beginDraw();
        cvs.background(cback);
        cvs.stroke(20, 10);
        cvs.strokeWeight(0.7);
        cvs.endDraw();
        
        // initialize in random positions
        int val = 1;
        int numPoints = 5000;
        int rcolor = (int)random(7);
        agents.clear();
        switch (val){
            case 0:
                for (int i=0; i<numPoints; i++) {
                    Agent a = new Agent();
                    float posx = random(200, 600);
                    float posy = random(200, 600);
                    a.pos = new PVector(posx, posy);
                    a.angle = random(TWO_PI);
                    float fx = map(posx, 0,width, 0,1);
                    float fy = map(posy, 0,height, 0,1);
                    color col = rgradient(rcolor, fx, fy);
                    a.col = col;
                    a.mi = i;
                    agents.add(a);
                }
                break;
            case 1:
                float radius = 300;
                float fract = (1+sqrt(5))/2;
                for (int i=0; i<numPoints; i++) {
                    Agent a = new Agent();
                    float dst = radius*pow(i/(numPoints-1.), .5);
                    float angle = 2*PI*fract*i;
                    float posx = dst*cos(angle)+width/2+randomGaussian()*8;
                    float posy = dst*sin(angle)+height/2+randomGaussian()*8;
                    a.pos = new PVector(posx, posy);
                    a.angle = random(TWO_PI);
                    
                    float fx = map(posx, 0,width, 0,1);
                    float fy = map(posy, 0,height, 0,1);
                    color col = rgradient(rcolor, fx, fy);
                    a.col = col;
                    a.mi = i;
                    agents.add(a);
                }
                break;
        }
    }

    color rgradient(int thing, float fx, float fy){
        color col = color(0);
        thing = 1;
        switch (thing){
            case 0:
                col = color(noise(fx, fy)*(200),0,200);
                break;
            case 1:
                col = color(noise(fx, fy)*(200),200,200);
                break;
            case 2:
                col = color(noise(fx, fy)*(100)+50,200,250);
                break;
            case 3:
                col = color(noise(fx, fy)*(100)+50,200,noise(fy, fx)*100+100);
                break;
        }
        if (thing >= 4 && thing <=6){
            col = color(noise(1)*(255),noise(fx, fy)*noise(2)*255,noise(fy, fx)*noise(3)*255);
            col = lerpColor(col, color(255),.5);
        }
        return col;
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
        cvs.noFill();
        //cvs.circle(width/2,height/2,width/2);
        //cvs.circle(width/2,height/2,width/2+width*3/10);
        cvs.endDraw();
        image(cvs, 0, 0);
        time += 0.001;
    }


    void keyPressed(){
        if (key=='p' || key=='s'){
            saveFrame("out-####.png");
        }
        if (key == 'n'){
            println(seed);
            init(seed);
        }
        if (keyCode == 32){
            init();
        }
    }
}
}
