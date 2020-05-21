import com.hamoid.*;

// Deux choses possibles pour la vitesse: La calculer en fonction du déplacement, 
// pour faire de belles explosions lorsque ça tend vers +infini, 
// ou alors dire que si elle est proche de zéro on supprime la particule

VideoExport videoExport;
PVector[] particles;
PImage img;
boolean video;
int divide;
HashMap<Integer, ArrayList<PVector>> hashmap;
PVector gravity;
boolean repul;


void store(HashMap hash, int k, PVector v){
  if (hash.get(k) == null) {
      hash.put(k, new ArrayList<PVector>());
  }
  hashmap.get(k).add(v);
}

void fill_hashmap(HashMap hash, PVector p){
  int ww = int(float(width)/divide);
  int x = int(p.x/divide);
  int y = int(p.y/divide);
  int k = x+y*ww;
  store(hash, k, p);
}

PVector repulsions(HashMap<Integer, ArrayList<PVector>> hash, PVector p, float radius){
  PVector out = new PVector(0,0);
  int n_radius = int(radius/divide);
  int x = int(p.x/divide);
  int y = int(p.y/divide);
  int ww = int(float(width)/divide);
  int hh = int(float(height)/divide);
  int minx = max(0, x-n_radius);
  int maxx = min(ww, x+n_radius);
  int miny = max(0, y-n_radius);
  int maxy = min(ww, y+n_radius);
  //println(x,y, ww, hh, n_radius, minx, maxx, miny, maxy);
  for (int xx=minx; xx<=maxx; xx++)
  for (int yy=miny; yy<=maxy; yy++){
    int ind = xx+ww*yy;
    if (hash.get(ind) == null){
    } else{
      ArrayList<PVector> particl = hash.get(ind);
      for (PVector p2:particl){
        PVector distt = new PVector(p.x-p2.x, p.y-p2.y);
        float dd = distt.mag();
        if (dd != 0.){
        distt.normalize().mult(1.0/dd);
        out.add(distt);}
      }
    }
  }
  //out = new PVector(0,0);
  out.normalize().mult(0.5);
  return out;
}

float radius;

void setup(){
  size(600,900,P2D);
  img = loadImage("mona3.jpeg");
  int n = 100;
  radius = 200.;
  divide = 50;
  repul = false;
  gravity = new PVector(0,0);
  
  hashmap = new HashMap<Integer, ArrayList<PVector>>();
  particles = new PVector[n];
  video = false;
  
  for (int i=0;i<particles.length; i++){
    PVector pp = new PVector();
    pp.x = random(0,img.width);
    pp.y = random(0,img.height);
    particles[i] = pp;
  }
  if (video){
    videoExport = new VideoExport(this);
    videoExport.startMovie();
  }
  
}


void draw(){
  hashmap.clear();
  for (PVector p:particles){
    stroke(0.,20.);
    strokeWeight(1.);
    point(p.x, p.y);
    
    if (repul){
      fill_hashmap(hashmap, p);
    }
    
    
    
    int xmin = max(0, int(p.x-radius));
    int xmax = min(img.width-1, int(p.x+radius));
    int ymin = max(0, int(p.y-radius));
    int ymax = min(img.height-1, int(p.y+radius));
    PVector speed = new PVector(0,0);
    for (int x=xmin;x<=xmax;x+=5)
    for (int y=ymin;y<=ymax;y+=5){
      PVector dist = new PVector(x-p.x, y-p.y);
      float mg = dist.mag();
      if (mg<=radius){
        float val = brightness(img.pixels[x+y*img.width]);
        val = (255.-val)/255.;
        float dist2 = (height-p.y)/height;
        //val = val/255;
        dist.normalize().mult((1.0/mg)*val);//*(dist2));
        speed.add(dist);
      }
    }
    p.add(gravity);
    p.add(speed);
    
  }
  //println(hashmap.keySet());
  if (repul){
    for (PVector p:particles){
      p.add(repulsions(hashmap, p, radius));
    }
  }
  if (video){
    videoExport.saveFrame();
  }
}

void keyPressed() {
  if (key == 'q' && video) {
    videoExport.endMovie();
    exit();
  }
}
