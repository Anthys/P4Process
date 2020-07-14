void setup(){
  size(500,500);
  noLoop();
}


void draw(){
  strokeWeight(4);
  noFill();
  //translate(width/2, height/2);
  int step = 10;
  for (int i=0;i<width; i+=step){
  beginShape();
  for (int j=0;j<height;j+=step){
     float x = map(i, 0,width, -1,1);
     float y = map(j, 0,height, -1,1);
     PVector p = new PVector(x,y);
     //p = new PVector(sin(p.x), sin(p.y));
     //p = waves(p,.1,.1,.1,.1);
     p = exponential(p);
     x = map(p.x, -1,1,0,width);
     y = map(p.y, -1,1,0,height);
     vertex(x,y);
  }
  endShape();
  }
}
