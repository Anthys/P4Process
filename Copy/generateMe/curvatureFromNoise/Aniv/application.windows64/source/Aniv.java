import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.function.Consumer; 
import java.util.Random; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Aniv extends PApplet {

//drawing agent
class Agent {
  PVector pos; // position of the agent
  float angle; // current angle of the agent
  int col;
 
  public void update() {
    // modify position using current angle
    pos.x += cos(angle)*1/(1+time*5);
    pos.y += sin(angle)*1/(1+time*5);
     
    //float a = 1+1*time;
    float a = 1;
 
    PVector scale_pos = new PVector(a,a);
     
    // get point coordinates
    float xx = scale_pos.x* map(pos.x, 0, width, -1, 1);
    float yy = scale_pos.y* map(pos.y, 0, height, -1, 1);
 
    PVector pp = new PVector(xx, yy);
    
    PVector v = new PVector(xx, yy);
    for (int i =0; i<n_iter;i++){
      v = variations.transforms[index_transforms[i]].apply(v);
    }
    //v = variations.sinusoidal(pp);
    //v = variations.spherical(pp);
    
    v.mult(1);//noise(245)*5);
    //v.x*=1/v.mag();
    v.add(new PVector(5,-3));
    //v.mult(.5);
    //v.y=1/v.x;
    //v.y=pow(v.y, 5);
 
    // modify an angle using noise information
    float scale_angle = 3;
    float m = map( noise(v.x, v.y), 0, 1, -1, 1);
    if (noise(1571.2f)*2<1){m = v.mag();};
    if (noise(126.57f)*2<1){m += map(noise(v.x, v.y), 0, 1, -1, 1)*10;};
    angle += scale_angle* m;
  }
  
  public void draw(){
    stroke(col, 20);
    point(pos.x, pos.y);
  }

}

public void keyPressed(){
  if (key=='p' || key=='s'){
    saveFrame("out-####.png");
  }
  if (keyCode == 32){
    init();
  }
}

public PVector kampyle(float n) {
  float sec = 1/sin(n);
 
  float xt = sec;
  float yt = tan(n)*sec;
 
  return new PVector(xt, yt);
}
 
// all agents in the list
ArrayList<Agent> agents = new ArrayList<Agent>();
int n_iter = 1;
int[] index_transforms;
 
public void setup() {
  
  
  init();
}

public void init(){
  noiseSeed((int)random(1000));
  int back = 0;
  if (noise(512)>=.5f){back=240;}
  background(back);
  //background(0);
  stroke(20, 10);
  strokeWeight(0.7f);
  
  
  int n_iter = (int) (noise(12)*3+1);
  println(n_iter);
  index_transforms = new int[n_iter];
  for (int i = 0;i<n_iter;i++){
    index_transforms[i] = (int) random(0, variations.transforms.length);
  }
 
  // initialize in random positions
  int val = 1;
  int numPoints = 5000*2;
  int rcolor = (int)random(7);
  agents.clear();
  if (val == 0){
    for (int i=0; i<numPoints; i++) {
      Agent a = new Agent();
      float posx = random(200, 600);
      float posy = random(200, 600);
      a.pos = new PVector(posx, posy);
      a.angle = random(TWO_PI);
      agents.add(a);
    }
  }else if (val==1){
    float radius = 300;
    float fract = (1+sqrt(5))/2;
    for (int i=0; i<numPoints; i++) {
      Agent a = new Agent();
      float dst = radius*pow(i/(numPoints-1.f), .5f);
      float angle = 2*PI*fract*i;
      float posx = dst*cos(angle)+width/2+randomGaussian()*8;
      float posy = dst*sin(angle)+height/2+randomGaussian()*8;
      a.pos = new PVector(posx, posy);
      a.angle = random(TWO_PI);
      
      float fx = map(posx, 0,width, 0,1);
      float fy = map(posy, 0,height, 0,1);
      int col = rgradient(rcolor, fx, fy);
      a.col = col;
      agents.add(a);
    }
  }
}

public int rgradient(int thing, float fx, float fy){
  int col = color(0);
  if (thing == 0){
    col = color(noise(fx, fy)*(200),0,200);
  }
  if (thing == 1){
    col = color(noise(fx, fy)*(200),200,200);
  }
  if (thing == 2){
    col = color(noise(fx, fy)*(100)+50,200,250);
  }
  if (thing == 3){
    col = color(noise(fx, fy)*(100)+50,200,noise(fy, fx)*100+100);
  }
  if (thing >= 4 && thing <=6){
    col = color(noise(1)*(255),noise(fx, fy)*noise(2)*255,noise(fy, fx)*noise(3)*255);
    col = lerpColor(col, color(255),.5f);
  }
  return col;
}
 
float time = 0;
public void draw() {
  for (Agent a : agents) {
    a.draw();
    a.update();
  }
  time += 0.001f;
}


static class variations{
  

// FROM
// The Fractal Flame Algorithm
// Scott Draves
// Spotworks, NYC, USA
// Erik Reckase
// Berthoud, CO, USA
// September 2003, Last revised November 2008

public static PVector linear(PVector p, float rotation, float size){
    PVector p2 = new PVector(size*p.x, size*p.y);
    p2.rotate(rotation);
    return p2;
}


public static PVector sinusoidal(PVector p) {
  return new PVector(sin(p.x), sin(p.y));
}

    interface Transform {
        public PVector apply(PVector p);
    }

    static private Transform[] transforms = new Transform[] {
        new Transform() { public PVector apply(PVector p) {return sinusoidal(p); } },
        new Transform() { public PVector apply(PVector p) {return spherical(p); }  },
        new Transform() { public PVector apply(PVector p) {return swirl(p); } },
        new Transform() { public PVector apply(PVector p) {return horseshoe(p); } },
        new Transform() { public PVector apply(PVector p) {return polar(p); } },
        new Transform() { public PVector apply(PVector p) {return handkerchief(p); } },
        new Transform() { public PVector apply(PVector p) {return heart(p); } },
        new Transform() { public PVector apply(PVector p) {return disc(p); } },
        new Transform() { public PVector apply(PVector p) {return spiral(p); } },
        new Transform() { public PVector apply(PVector p) {return hyperbolic(p); } },
        new Transform() { public PVector apply(PVector p) {return diamond(p); } },
        new Transform() { public PVector apply(PVector p) {return ex(p); } },
        new Transform() { public PVector apply(PVector p) {return julia(p); } },
        new Transform() { public PVector apply(PVector p) {return bent(p); } },
        new Transform() { public PVector apply(PVector p) {return waves(p); } },
        new Transform() { public PVector apply(PVector p) {return fisheye(p); } },
        new Transform() { public PVector apply(PVector p) {return exponential(p); } },
        new Transform() { public PVector apply(PVector p) {return power(p); } },
        new Transform() { public PVector apply(PVector p) {return cosine(p); } },
    };

public static PVector lerandom(PVector p){
  int n = transforms.length;
  int a = (int) utils.random(0,n);
  println(a);
  return transforms[a].apply(p);
}

public static PVector spherical(PVector p){
    float r = p.mag();
    return new PVector(p.x, p.y).mult(1/(r*r));
}

public static PVector swirl(PVector p){
    float r = p.mag();
    return new PVector(p.x*sin(r*r)-p.y*cos(r*r), p.x*cos(r*r)+p.y*sin(r*r));
}

public static PVector horseshoe(PVector p){
    float r = p.mag();
    return new PVector((p.x-p.y)*(p.x+p.y), 2*p.x*p.y).mult(1/r);
}

public static PVector polar(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(theta/PI, r-1);
}

public static PVector handkerchief(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta+r), cos(theta-r)).mult(r);
}

public static PVector heart(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta*r), -cos(theta*r)).mult(r);
}

public static PVector disc(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(PI*r), cos(PI*r)).mult(theta/PI);
}

public static PVector spiral(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta)+sin(r), sin(theta)-cos(r)).mult(1/r);
}

public static PVector hyperbolic(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta)/r, r*cos(theta));

}


public static PVector diamond(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(sin(theta)*cos(r), cos(theta)*sin(r));
}

public static PVector ex(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float p0 = sin(theta+r);
    float p1 = cos(theta-r);
    return new PVector(pow(p0, 3)+pow(p1,3),pow(p0,3)-pow(p1,3)).mult(r);
}

public static PVector julia(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float omega = ((int)utils.random(2))*PI;
    return new PVector(cos(theta/2+omega), sin(theta/2+omega)).mult(sqrt(r));
}

public static PVector bent(PVector p){
    PVector out;
    if (p.x>=0 && p.y>=0){
        out = new PVector(p.x,p.y);
    } else if (p.x < 0 && p.y >= 0){
        out = new PVector(2*p.x, p.y);
    } else if (p.x >=0 && p.y <0){
        out = new PVector(p.x, p.y/2);
    }
    else{
        out = new PVector(2*p.x, p.y/2);
    }
    return out;
}

public static PVector waves(PVector p, float b, float e, float c, float f){
  float x = p.x + b * sin(p.y * (1.0f / (c * c) ));
  float y = p.y + e * sin(p.x * (1.0f / (f*f) ));
  return new PVector(x, y);
}

public static PVector waves(PVector p){
    float waves_b = utils.random(.1f);
    float waves_e = utils.random(.3f);
    float waves_c = utils.random(-.2f);
    float waves_f = utils.random(.1f);
    return waves(p, waves_b, waves_e, waves_c, waves_f);
}

public static PVector fisheye(PVector p){
    float r = p.mag();
    return new PVector(p.y, p.x).mult(2/(r+1));
}
public static PVector exponential(PVector p){
    return new PVector(cos(PI*p.y), sin(PI*p.y)).mult(exp(p.x-1));
}

public static PVector power(PVector p){
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    return new PVector(cos(theta), sin(theta)).mult(pow(r, sin(theta)));
}

public static PVector cosine(PVector p){
    return new PVector(cos(PI*p.x)*utils.cosh(p.y), -sin(PI*p.x)*utils.sinh(p.y));
}


// UTILS



static class utils{

static Random rand = new Random();

public static float log10 (float x) {
  return (log(x) / log(10));
}

public static float random(){
  return random(0,1);
}
 
public static float random(float max){
  return random(0,max);
}
 
public static float random(float min, float max){
  return rand.nextFloat()*(max-min)+min;
}

public static final float cosh(float x) { return 0.5f * (exp(x) + exp(-x));}
public static final float sinh(float x) { return 0.5f * (exp(x) - exp(-x));}
public static final float tanh(float x) { return sinh(x)/cosh(x);}
public static float sec(float x) { return 1.f/cos(x);}
}
}
  public void settings() {  size(1000, 1000);  smooth(8); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Aniv" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
