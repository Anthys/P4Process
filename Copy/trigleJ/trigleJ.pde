void setup(){
  size(500, 500);
  draw_();
}

void draw(){
}

void draw_(){
  
  int n_iter = int(random(5,15));
  float lWidth = int(random(10,25));
  float rad = lWidth;
  
  int n_seg = int(random(3,9));
  
  translate(width*.5, height*.5);
  
  for (int iter=0;iter < n_iter; iter ++){
    float px0 = 0;
    float py0 = 0;
    float px1 = 0;
    float py1 = 0;
    
    float n_shad = 3;
    
    for (int shad = 0; shad < n_shad; shad ++){
      float deltaS = float(shad)/n_shad;
      float a = map(deltaS, 0,1,10,0);
      float size = map(deltaS, 0, 1, 1, 1.07);
      boolean shadow = true;
      if (shad == n_shad -1){
        shadow = false;
      }
      
      pushMatrix();
      scale(size, size);
      
      beginShape(QUAD);
      for (int s = 0; s< n_seg+1; s++)
      {
        float deltas = float(s)/n_seg;
        float angle = deltas*TWO_PI;
        float x = cos(iter+angle)*rad;
        float y = sin(iter+angle)*rad;
        float a0 = angle;
        float a1 = angle+PI;
        float x0 = x + cos(a0)*lWidth;
        float y0 = y + sin(a0)*lWidth;
        float x1 = x + cos(a1)*lWidth;
        float y1 = y + sin(a1)*lWidth;
        
        if (s>0){
          color c = color(0);
          color c2 = color(c);
          
          if (!shadow){
            noStroke();
            fill(c);
            vertex(px0, py0);
            vertex(x0, y0);
            vertex(x1,y1);
            vertex(px1,py1);
          }else{
            color co = color(0);
            noStroke();
            fill(co);
            vertex(px0, py0);
            vertex(x0,y0);
            vertex(x1, y1);
            vertex(px1, py1);
          }
          
        } px0 = x0;
          py0 = y0;
          px1 = x1;
          py1 = y1;
        
      }
      endShape();
      popMatrix();
    
    
    
    }
    
    rad += lWidth*2.0;
  
  
  }


}

void keyPressed(){
  if (keyCode == 32){
    background(200);
    draw_();
  }
  if (key == 's'){
    saveFrame("out-####.png");
  }

}
