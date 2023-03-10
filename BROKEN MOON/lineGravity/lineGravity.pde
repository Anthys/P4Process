void setup(){
  size(1000, 1000);
  arrayStructs = new ArrayList<PointStruct>();
  stroke(0);
  strokeWeight(10);
  iniStructs();
}

float G = 1000;

void iniStructs(){
  for (int i =0;i<5;i++){
    PointStruct s = new PointStruct();
    arrayStructs.add(s);
  }
}

PVector getGravitation(PVector p1, PVector p2, float m12, float thresholdDistance){
    PVector d = PVector.add(p2, PVector.mult(p1, -1));
    float mag = d.mag();
    if (mag<thresholdDistance){
      return new PVector(0,0);
    }
    float f = G*m12/(mag*mag);
    d.normalize();
    return PVector.mult(d, f);
}

PVector getGravitation(PVector p1, PVector p2, float m12){
    return getGravitation(p1, p2, m12, 0);
}

float REPULSION_MAX_DIST = 300;
float R = G*1.3;
PVector getRepulsion(PVector p1, PVector p2, float m12){
    PVector d = PVector.add(p2, PVector.mult(p1, -1));
    if (d.mag()>REPULSION_MAX_DIST){
      return new PVector(0,0);
    }
    
    float f = -R/(d.mag()*d.mag());
    d.normalize();
    return PVector.mult(d, f);
    
}

class PointStruct{
  PVector centerOfMass;
  float rot = 0;
  float m = 1;
  PVector vel = new PVector(1,0);
  float rotVel = 0.0;
  
  ArrayList<Point> points = new ArrayList<Point>();
  
  PointStruct(){
    centerOfMass = new PVector(random(1)*width, random(1)*height);
    for (int i = 0;i<5;i++){
      points.add(new Point(150));
    }
  }
  
  void update(){
    centerOfMass = PVector.add(centerOfMass, vel);
    
    if (centerOfMass.x < 0){
      centerOfMass.x = 0;
      vel.x = 0;
    }else if (centerOfMass.x > width){
      centerOfMass.x = width;
      vel.x = 0;
    }
    if (centerOfMass.y < 0){
      centerOfMass.y = 0;
      vel.y = 0;
    }else if (centerOfMass.y > width){
      centerOfMass.y = width;
      vel.y = 0;
    }    
    rot += rotVel;
    
    // Only using center of mass to hold the full mass and moving along vel
    // Using all the other points to compute the rotvel
    for (PointStruct ps : arrayStructs){
      if (ps!=this){
          vel = PVector.add(vel, getGravitation(centerOfMass, ps.centerOfMass, ps.m*m));
          vel = PVector.add(vel, getRepulsion(centerOfMass, ps.centerOfMass, ps.m*m));
          for (Point p: points){
            PVector pGlobalPos = p.getGlobalPos(centerOfMass, rot);
            PVector dirToCenter = PVector.add(centerOfMass, PVector.mult(pGlobalPos, -1));
            PVector dirToCenterRot90 = new PVector(dirToCenter.y, -dirToCenter.x);
            PVector force = getGravitation(pGlobalPos, ps.centerOfMass, ps.m, 50);
            float rotForce = force.dot(dirToCenterRot90);
            rotVel += rotForce/1000.0;
            
          }
        }
    }
    rotVel = rotVel*.9;
    
    /*for (Point p : arrayPoints){
      if (p!=this){
        PVector d = PVector.add(p.pos, PVector.mult(pos, -1));
        float f = G*m*p.m/(d.mag()*d.mag());
        d.normalize();
        PVector out = PVector.mult(d, f);
        vel = PVector.add(vel, out);
      }
    }*/
  }
  
  void draw(){
    pushMatrix();
    translate(centerOfMass.x, centerOfMass.y);
    rotate(rot);
    for (Point p : points){
      p.draw(centerOfMass, rot);
    }
    stroke(200,0,0);
    point(0,0);
    stroke(0);
    popMatrix();
  }
}

class Point{
  PVector pos; // in local frame
  Point(){
    pos = new PVector(random(1)*width, random(1)*height);
  }
  Point(float s){
    pos = new PVector(random(s)-s/2, random(s)-s/2);
  }  
  Point(float x, float y){
    pos = new PVector(x, y);
  }  
  void draw(PVector center, float rot){
    point(pos.x,pos.y);
  }
  
  PVector getGlobalPos(PVector center, float rot){
    return new PVector(center.x + cos(rot)*pos.x - sin(rot)*pos.y, center.y + sin(rot)*pos.x + cos(rot)*pos.y); 
  }
}

ArrayList<PointStruct> arrayStructs;

void draw(){
  background(200);
  
  for (PointStruct p:arrayStructs){
    p.update();
    p.draw();
  }
}
