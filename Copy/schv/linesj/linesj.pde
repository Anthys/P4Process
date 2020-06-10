void setup(){
  size(500,500, P2D);
  draw_();
}

void draw(){
}

void draw_(){
  background(200);
  
  float rotat = (random(0,2)<1)?0:PI/4;
  
  float n1 = 100;
  float n2 = 200;
  float n3 = 300;
  float rm = pow(width/2, 2)+pow(height/2, 2);
  
  int n = 2000;
  translate(width/2, height/2);
  for (int i=0;i<n;i++){
    float theta = random(0,TWO_PI);
    
    float r1 = n1/(abs(cos(theta))+abs(sin(theta)));
    float r2 = n2/(abs(cos(theta))+abs(sin(theta)));   
    float r3 = n3/(abs(cos(theta))+abs(sin(theta)));    
    
    float x1 = r1*cos(theta);
    float y1 = r1*sin(theta);
    float x2 = r2*cos(theta);
    float y2 = r2*sin(theta);
    float x3 = r3*cos(theta);
    float y3 = r3*sin(theta);
    float x4 = (r2+50)*cos(theta);
    float y4 = (r2+50)*sin(theta);
    
    float xf = rm*cos(theta);
    float yf = rm*sin(theta);
    
    
    color col1 = find_color(theta);
    color col2 = find_color(theta+PI/2);
    color col3 = find_color(theta+PI/4);
    
    stroke(col1, 200);
    line(0,0, xf, yf);
    pushMatrix();
    rotate(rotat);
    stroke(col2, 200);
    line(x1,y1, x2, y2);
    stroke(col3, 200);
    line(x4,y4, x3, y3);
    popMatrix();
  }
}

color find_color(float theta){
  theta = theta%PI;
  color c1 = color(#485E83);
  color c2 = color(#8B253E);
  color c3 = color(#FAE43D);
  color c4 = color(#F22264);
  color c5 = color(#485E83);
  color[] cols  = {c1, c2, c3, c4, c5};
  float my_x = theta/PI*(cols.length-1);
  int i1 = floor(my_x);
  return lerpColor(cols[i1], cols[i1+1], my_x%1);
}

void keyPressed(){
  if (keyCode == 32){
    draw_();
  }

}
