void setup(){
  size(500,500);
  draw_();
}

float mnoise(float x, float y){
  float res = 4;
  float stre = 1;
  x = x/width*res;
  y = y/height*res;
  float noi = noise(x, y)*stre;
  return noi;
}


boolean isnear(float a, float b){
  float c = .1;
  return isnear(a, b, c);
}

boolean isnear(float a, float b, float c){
  return (a>b-c && a<b+c);
}

void draw_(){
  color cback = color(0);
  background(cback);
  
  for (int i = 0; i<width;i+=1){
  for (int j =0; j<height;j+=1){
    float x = i + randomGaussian();
    float y = j + randomGaussian();
    float noi = mnoise(x, y);
    float m0 = 15; //numb of colors to seq
    float m05 = noi*m0;
    float m1 = int(m05);
    float m2 = abs((m05%1.-.5)*2);
    color col;
    //col = isnear(noi,.5, .01)?color(0):color(200);
    //col = color(255/m1);
    col = color(255/m0*m1, 100, 200);
    float lborder = .5;
    //if (m2 <1-lborder){col = color(200);}
    //if (m2 >1-lborder){col = color(cback);}
    if (m2 >1-lborder){continue;}
    stroke(col);
    strokeWeight(3);
    point(x, y);
    //fill(col);
    //circle(x, y, 2);
  }
  }
}

void draw(){
}

void keyPressed(){
  if (keyCode == 32){
    noiseSeed((int)random(100));
    draw_();
  }
  if (key == 's'){
    saveFrame("out-####.png");
  }
}
