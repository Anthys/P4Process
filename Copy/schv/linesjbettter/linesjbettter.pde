void setup(){
  size(500,500, P2D);
  draw_();
}

void draw(){
}

void draw_(){
  background(200);
  
  float rotat = (random(0,2)<1)?0:PI/4;
  
  int n_rhombus = int(random(1,7));
  float rm = pow(width/2, 2)+pow(height/2, 2);
  
  float[][] rhombus = new float[n_rhombus][4]; 
  
  for (int i=0;i<n_rhombus;i++){
    rhombus[i][0] = random(0, min(width/2, height/2)); 
    rhombus[i][1] = random(rhombus[i][0], min(width/2, height/2));
    rhombus[i][2] = random(0, PI);
    rhombus[i][3] = random(0, 2);
  }
  
  int n_lines = 2000;
  translate(width/2, height/2);
  for (int i=0;i<n_lines;i++){
    float theta = random(0,TWO_PI);
    
    float xf = rm*cos(theta);
    float yf = rm*sin(theta);
    
    
    color col = find_color(theta);
    
    stroke(col, 200);
    line(0,0, xf, yf);
    
    //rotate(rotat);
    for (int j=0;j<n_rhombus;j++){
      pushMatrix();
      float r1 = rhombus[j][0]/(abs(cos(theta))+abs(sin(theta)));
      float r2 = rhombus[j][1]/(abs(cos(theta))+abs(sin(theta)));
      color col1 = find_color(theta+rhombus[j][2]);
      float x1 = r1*cos(theta);
      float y1 = r1*sin(theta);
      float x2 = r2*cos(theta);
      float y2 = r2*sin(theta);
      rotate((rhombus[j][3]<1)?0:PI/4);
      stroke(col1, 200);
      line(x1,y1, x2, y2);
      popMatrix();
    }
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
  if (key=='p'){
    saveFrame("out-####.png");
  }

}
