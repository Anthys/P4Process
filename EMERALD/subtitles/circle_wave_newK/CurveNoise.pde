// Template based on GenerateMe's one
class CurvNoise {

    color cback = 0;
    float time = 0;
    int seed;
    PGraphics cvs;
    PImage img = loadImage("aa.jpg");
    
    void settings(){
      size(1000, 1000);
    }
  
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
            //scale_pos = new PVector(1,1);
            
            // get point coordinates
            float xx = scale_pos.x* map(pos.x, 0, width, -1, 1);
            float yy = scale_pos.y* map(pos.y, 0, height, -1, 1);
        
            PVector pp = new PVector(xx, yy);
            
            PVector v = new PVector(xx, yy);
            
            // VARIATION HERE

            v.mult(3);
            //v.add(new PVector(5,-3));
            
            float b = atan2(v.x, v.y);
            
            // MODIFICATIONS HERE
            
            // modify an angle using noise information
            float scale_angle = 3;
            float m = map( noise(v.x, v.y), 0, 1, -1, 1);
            m = atan2(v.x, v.y)*10;
            m = lerp(m/cos(m),((angle)%TAU-PI),.7);
            m = m/cos(m);
            m = m/(cos(v.mag()))*.1;
            angle += scale_angle* m;
        }
        
        void draw(PGraphics cvs){
            cvs.stroke(col, 10);
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
        cvs.strokeWeight(2);
        cvs.endDraw();
        
        // initialize in random positions
        int val = 0;
        int numPoints = 5000;
        int rcolor = (int)random(7);
        agents.clear();
        switch (val){
            case 0:
              int i = 0;
              while (i<numPoints){
                    Agent a = new Agent();
                    float posx = random(0, width);
                    float posy = random(0,height);
                    float px2 = map(posx, 0,width, 0, img.width);
                    float py2 = map(posy, 0,height, 0, img.height);
                    color cc = (img.get((int)px2, (int)py2));
                    if (brightness(cc)<100){
                      a.pos = new PVector(posx, posy);
                      a.angle = random(TWO_PI);
                      float fx = map(posx, 0,width, 0,1);
                      float fy = map(posy, 0,height, 0,1);
                      color col = rgradient(rcolor, fx, fy);
                      col = (img.get((int)px2, (int)py2));
                      col = lerpColor(col, color(255), .5);
                      a.col = col;
                      a.mi = i;
                      agents.add(a);
                      i += 1;
                    }
                }
              break;
            case 1:
                float radius = 300;
                float fract = (1+sqrt(5))/2;
                for (i=0; i<numPoints; i++) {
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
