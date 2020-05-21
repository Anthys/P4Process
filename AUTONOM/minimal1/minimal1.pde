import com.hamoid.*;

VideoExport videoExport;
PVector[] particles;
PImage img;
boolean video;

void setup(){
  size(500,500,P2D);
  img = loadImage("epsi.png");
  int n = 100;
  particles = new PVector[n];
  video = false;
  
  for (int i=0;i<particles.length; i++){
    PVector pp = new PVector();
    pp.x = random(0,width);
    pp.y = random(0,20);
    particles[i] = pp;
  }
  if (video){
    videoExport = new VideoExport(this);
    videoExport.startMovie();
  }
  
}


void draw(){
  float radius = 200;
  for (PVector p:particles){
    stroke(0.,20.);
    strokeWeight(4.);
    point(p.x, p.y);
    
    
    
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
        dist.normalize().mult((1.0/mg)*val*(dist2));
        speed.add(dist);
      }
    }
    p.y += 2;
    p.add(speed);
    
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
