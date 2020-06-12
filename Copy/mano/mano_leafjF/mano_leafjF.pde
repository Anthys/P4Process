void setup(){
  size(1000,1000,P2D);
  palette = new color[]{color(#33671F), color(#6FA75A), color(#86C692), color(#527C5A)};
  particles = new ArrayList<myLeaf>();
  res = 4;
  draw_();
}

void draw(){
  background(0);
  println(particles.get(0).x);
  println(particles.get(0).r);
  for (myLeaf m:particles){
    m.update();
    m.border();
    m.draw();
  }
}

color[] palette;


color rColor(){
  return palette[int(random(0,palette.length))];

}

void draw_leaf(float xx, float yy, float s, float r, color c){
  pushMatrix();
  translate(xx, yy);
  rotate(r);
  scale(s);
  float x = -5;
  float y = -5;
  fill(c);
  beginShape();
  vertex(x,y);
  bezierVertex(x+10,y-15,x+30,y-5,x+40,y+5);
  bezierVertex(x+30,y+10,x+10,y+20,x,y);
  //bezierVertex(60,55,30,65,20,45);
  endShape();
  popMatrix();
  
}

void my_sphere(float x, float y, float s, color c){
  fill(c);
  noStroke();
  circle(x,y,s);
  fill(c, 2);
  for (int i=0;i<50;i++){
    circle(x,y,s+i*1);
  }
}


// FROM https://www.openprocessing.org/sketch/7743/#
void stolen(){
float pointShift = random(-20,20); // here is a variable between -20 and 20 
  beginShape(); // start to draw a shape
  vertex(20, 45); // begin at this point x, y
  // bezierVertex(30,30,60,40,70 + random(-20,20),50); // moving only the pointy point meant that sometimes the leaf shape would turn into a heart shape, because the control points were not also moving. So I created a variable called pointShift
    bezierVertex(30,30, 60 + pointShift,40 + pointShift/2, 70 + pointShift,50); // make the pointy end of the leaf vary on the x axis (so the leaf gets longer or shorter) AND vary the y axis of the control points by the same amount. It should be possible to have 'normal' leaves, very short fat ones and very long thin ones.
    bezierVertex(60 + pointShift,55, 30,65, 20,45); // draw the other half of the shape
  endShape();
}

class myLeaf {
  float x;
  float y;
  float s;
  float r;
  color c;
  float rands;
    
  myLeaf(float x_, float y_, float s_, float r_, color c_){
    x = x_;
    y = y_;
    s = s_;
    r = r_;
    c = c_;
    rands = random(0,3);
  }
  
  void draw(){
    draw_leaf(x, y, s, r, c);
  }
  
  void update(){
    float d = 3;
    x = x+d*cos(r);
    y = y+d*sin(r);
    r = lerp(r, noise(x/width*res, res*y/height, rands+float(frameCount)/400)*TWO_PI,.01);
  
  };
  
  void border(){
  if (x<-20){
    x = width+20;
    y = random(0,height);
  }
  if (y<-20){
    y = height+20;
    x = random(0,width);
  }
  }

}

ArrayList<myLeaf> particles;
float res;

void init(){
  particles.clear();
  int n = 1000;
  for (int i = 0; i < n; i++){
    float x = random(0,width);
    float y = random(0,height);
    float s = noise(x/width*res, res*y/height)*1.1+.5;
    float r = noise(x/width*res, res*y/height)*TWO_PI;
    color c= rColor();
    particles.add(new myLeaf(x, y, s, r, c));
  }
}

void draw_(){
  //background(0);
  init();
}

void draw_2(){
  background(0);
  //stolen();$
  strokeWeight(3);
  int n = 100;
  for (int i=0;i<n;i++){
    float x = random(0,width);
    float y = random(0,height);
    //x = 100;
    //y = 100;
    float s = random(.5, 1.6);
    float r = random(0,TWO_PI);
    float res = 4;
    color c= rColor();
    s = noise(x/width*res, res*y/height)*1.1+.5;
    r = noise(x/width*res, res*y/height)*TWO_PI;
    draw_leaf(x,y,s,r, c);
  }
  
  my_sphere(width/2, height/2, 50, color(255, 0,0));

}

void keyPressed(){
  if (keyCode == 32){
    noiseSeed(int(random(0,100)));
    draw_();
  }

}
