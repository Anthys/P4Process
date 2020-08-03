// Template based on GenerateMe's one
class PosNoise {
 
    ArrayList<Agent> agents = new ArrayList<Agent>();
    
    // global configuration
    float time = 0; // time passes by
    color cback = 0;

    float square_l = 6;
    float edge_l = 0;
    float map_l = square_l + edge_l;
    float npoints;
    int type_mod = 1; // lerp or add
    
    PImage img;
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
            float ximg = map(pt.x, -map_l, map_l, 0, img.width);
            float yimg = map(pt.y, -map_l, map_l, 0, img.height);
            color cimg = img.get(int(ximg), int(yimg));
            //color cimg = cvs.get(int(ximg), int(yimg));
            
            PVector p = new PVector(xx,yy);

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);
            
            
            n = noise(p.x, p.y)*100;
            n=p.x*p.y;///atan2(p.x, p.y);
            boolean d = (p.x*p.x+p.y*p.y)<=6;
            d = p.mag()+sin(p.x)<3;
            n = pow(red(cimg)*abs(cos(green(cimg))), .1);
            n = abs(n*sin(blue(cimg)));//*noise(p.x,p.y);
            float a1=n*5*cos(p.x);
            float a2 = n;
            float val = (p.mag())/6;
            val = pow(val, .5);
            float a3 = constrain(val, 0,1);
            n = lerp(a1,a2,a3);
            n = self_i;
            v = variation1t2.cardiod(n);
            
            
            float c = 1./30000*n;
            //c = p.mag();
            //v.x += c;
            //v.mult(int(c)+1);
            //v.x+=(red(cimg)*.01);
            v.normalize();
            //v.mult(3);
            float a = 0;
            a = red(cimg)/255*TAU*2;

            // placeholder for vector field calculations

            float stren = .2;
            float vector_scale = 0.01; 
            
            float amp = .01;
            
            type_mod = 2;
             
             switch (type_mod){
                case 0:
                    pt.x = lerp(p.x, v.x, stren);
                    pt.y = lerp(p.y, v.y, stren);
                    break;
                case 1:
                    pt.x += vector_scale * v.x;
                    pt.y += vector_scale * v.y;
                    break;
                case 2:
                    pt.x += cos(a)*amp;
                    pt.y += sin(a)*amp;
            }
            vel = v;
            
        }
        
        void draw(){
            float xx = map(pt.x, -map_l, map_l, 0, width);
            float yy = map(pt.y, -map_l, map_l, 0, height);
            
            float ximg = map(pt.x, -map_l, map_l, 0, img.width);
            float yimg = map(pt.y, -map_l, map_l, 0, img.height);
            //float ximg = map(noise(pt.x), 0, 1, 0, img.width);
            //float yimg = map(noise(pt.y), 0, 1, 0, img.height);
            color cimg = img.get(int(ximg), int(yimg));
            color cimg2 = img.get(int(noise(cimg)*img.width), int((noise(100+cimg))*img.height));
            cimg2 = lerpColor(cimg, cimg2, 0);
            //cvs.stroke(#DE0909, 50);
            //cvs.stroke(cimg, 30);
            cvs.stroke(cimg2,250);
            
            cvs.point(xx, yy); //draw
        }

    }
    
    void setup() {
        cvs = createGraphics(width, height);
        cvs.smooth(8);
        img = loadImage("a.jpg");
        img.resize(width, height);
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
            float ximg = map(v.x, -map_l, map_l, 0, img.width);
            float yimg = map(v.y, -map_l, map_l, 0, img.height);
            ximg = noise(v.x, v.y)*img.width;
            yimg = noise(v.y, v.x)*img.height;
            color cimg = img.get(int(ximg), int(yimg));
            a.col = cimg;
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
        if (key == 'd'){
          image(img, 0,0);
        }
    }
}
