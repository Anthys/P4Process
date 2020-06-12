void setup(){
  size(500,500,P2D);
  draw_();
  curves = new ArrayList<cool_curve>();
}

ArrayList<cool_curve> curves;

class cool_curve{
  float a1, a2, res, med_r, max_s;
  color c1, c2, c3;
  
  cool_curve(float a1_, float a2_, color c1_, color c2_, color c3_, float res_, float med_r_, float max_s_){
    a1 = a1_;
    a2 = a2_;
    res = res_;
    med_r = med_r_;
    max_s = max_s_;
    c1 = c1_;
    c2 = c2_;
    c3 = c3_;
  }

}

void draw(){
}

void my_curve(float a1, float a2, color c1, color c2, color c3, float res, float med_r, float max_s){
  
  
  res = int((a2-a1)*res);
  for (int i=0;i<res;i++){
    float part = float(i)/res;
    float theta = a1 + (a2-a1)*part;
    float r1 = med_r - max_s*part;
    float r2 = med_r + max_s*part;
    float r3 = (r1+r2)/2;
    float ecart = .08;
    r3 += random(-(r2-r1)*ecart,(r2-r1)*ecart);
    float x1 = r1*cos(theta);
    float x2 = r2*cos(theta);
    float y1 = r1*sin(theta);
    float y2 = r2*sin(theta);
    float x3 = r3*cos(theta);
    float y3 = r3*sin(theta);
    //stroke( lerpColor(c1, c2, part));
    //line(x1,y1,x2,y2);
    color c4 = lerpColor(c1,c3,part);
    line_gradient2(x1, y1, x3, y3, c4, c2, 10);
    line_gradient2(x2, y2, x3, y3, c4, c2, 10);
  }
}

void init(){


}

void draw_(){
  background(#D7EDF0);
  translate(width/2, height/2);
  
  int n = 50;
  
  color[] palette = {color(#BC4848), color(#9A309B), color(#BD9AD1), color(#C46385)};
  
  color c3 = color(#FFFFFF, 200);
  
  for (int i = 0; i<n;i++){
    float a1 = random(0,TWO_PI);
    float a2 = random(a1,a1+TWO_PI);
    int res = int(random(250,400)); 
    float med_r = random(0, 300);
    float max_s = random(0,1)*max(med_r*.3, 10);
    color c1 = color(palette[int(random(0,palette.length))], 150);
    color c2 = color(palette[int(random(0,palette.length))], 150);
    my_curve(a1, a2, c1, c3, c2, res, med_r, max_s);
  }
  
}

void line_gradient(float x1,float y1, float x2, float y2, color c1, color c2, int steps){
  PVector dir = new PVector(x2-x1, y2-y1);
  float fract_l = dir.mag()/steps;
  dir = dir.normalize();
  for (int i = 0;i<steps;i++){
    stroke(lerpColor(c1, c2, float(i)/steps));
    line(x1+i*fract_l*dir.x, y1+i*fract_l*dir.y, x1+(i+1)*fract_l*dir.x, y1+(i+1)*fract_l*dir.y);
  }
}

void line_gradient2(float x1,float y1, float x2, float y2, color c1, color c2, int steps){
  PVector dir = new PVector(x2-x1, y2-y1);
  float fract_l = dir.mag()/steps;
  dir = dir.normalize();
  for (int i = 0;i<steps;i++){
    stroke(lerpColor2(c1, c2, float(i)/steps));
    line(x1+i*fract_l*dir.x, y1+i*fract_l*dir.y, x1+(i+1)*fract_l*dir.x, y1+(i+1)*fract_l*dir.y);
  }
}

color lerpColor2(color c1, color c2, float t){
  t = pow(t, 2);
  return lerpColor(c1, c2, t);
}

void keyPressed(){
  if (keyCode == 32){
    draw_();
  }
  if (key == 'p'){
    saveFrame("out-####.png");
  }
}
