void setup(){
  size(1000,1000);
}
PVector pos = new PVector(0,0);
PVector vos = new PVector(0,0);
void draw(){
  pos.add(vos);
  vos.mult(.99);
  translate(500,500);
  background(204);
  rayTrace(pos);
}

float sdAll(PVector p){
  PVector pos1 = new PVector(250, 250);
  PVector pos2 = new PVector(-250, 250);
  PVector pos3 = new PVector(-250, -250);
  PVector pos4 = new PVector(250, -250);
  PVector pos5 = new PVector(300, 0);
  
  return min(
          min( 
            min( 
             min(
               sdCircle(PVector.add(p, pos1), 50),
               sdCircle(PVector.add(p, pos2), 50)
               ),
             sdCircle(PVector.add(p, pos3), 50)
               ),
            sdCircle(PVector.add(p, pos4), 50)
              ),
           sdBox(PVector.add(p, pos5), new PVector(80, 40))
           );
}

void rayTrace(PVector p){
  int nrays = 300;
  float frac = TAU/nrays;
  for (int i = 0; i<nrays;i++){
    float theta = frac*i;
    PVector p2 = p.copy();
    //p2.add(new PVector(250,250));
    float cumul_dist = 0;
    for (int j = 0; j < 10; j++){
      float dist = sdAll(p2);
      cumul_dist += dist;
      p2.add(new PVector(cos(theta)*dist, dist*sin(theta)));
      if (dist < 0){
        break;
      }
    }
    PVector p3 = p.copy();
    p3.add(new PVector(cos(theta)*cumul_dist, cumul_dist*sin(theta)));
    line(p.x, p.y, p3.x, p3.y);
  }
  
}

void keyPressed(){
  if (keyCode == DOWN){
    vos.y += 1;
  }
  if (keyCode == UP){
    vos.y -= 1;
  }
  if (keyCode == RIGHT){
    vos.x += 1;
  }
  if (keyCode == LEFT){
    vos.x -= 1;
  }
}
