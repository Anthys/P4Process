// Template based on GenerateMe's one
class PosNoise {
 
    ArrayList<PVector> points = new ArrayList<PVector>();
    
    // global configuration
    float time = 0; // time passes by
    color cback = 0;

    float square_l = 4;
    float npoints;
    int type_mod = 1; // lerp or add
    
    void setup() {
        smooth(8);
        // noiseSeed(1111);
        init();
        
    }
    
    void init(){
        noiseSeed((int)random(100));
        strokeWeight(0.66);
        noFill();
        background(cback);
        points.clear();

        float ninc = .07;
        npoints = pow(square_l*2/ninc, 2);
        
        for (float x=-square_l; x<=square_l; x+=ninc) {
        for (float y=-square_l; y<=square_l; y+=ninc) {
            PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
            points.add(v);
        }
        }
    }
   
    void draw() {
        int point_idx = 0;
        float edge_l = 0;
        float map_l = square_l + edge_l;

        for (PVector p : points) {
            float xx = map(p.x, -map_l, map_l, 0, width);
            float yy = map(p.y, -map_l, map_l, 0, height);

            stroke(#F2DA22, 50);
            point(xx, yy); //draw
            point_idx++;
        }


        point_idx = 0;
        for (PVector pt : points) {
            
            float scale_v = square_l;

            float xx = scale_v*map(pt.x, -square_l, square_l, -1, 1);
            float yy = scale_v*map(pt.y, -square_l, square_l, -1, 1);
            // v is vector from the field
            // placeholder for vector field calculations
            
            PVector p = new PVector(xx,yy);

            float n = noise(p.x, p.y);

            PVector v = new PVector(0,0);
            
            
            float noi = noise(p.x, p.y);
            //n=p.x*p.y;///atan2(p.x, p.y);
            n = point_idx+noi*10;
            
            v = variation1t2.cardiod(n);
            float rn = n/npoints;
            v.mult(cos(noi));
            
            
            float c = 1./30000*n;
            //c = p.mag();
            //v.x += c;
            //v.mult(int(c)+1);
            //v.normalize();
            //v.mult(3);

            // placeholder for vector field calculations

            float stren = .5;
            float vector_scale = 0.01; 
            type_mod = 0;

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
          
        }
    }
}
