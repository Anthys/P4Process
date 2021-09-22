class Particle{
  float seek_dist = .5;
  float seek_angle = PI/6;
  float move_dist = .5;
  float move_angle = PI/12/2;
  float angle = 0;
  PVector pos;
  
  //int THRESHOLD_LOW = 50;
  //int THRESHOLD_HIGH = 100;
  int MAX_VAL = 255;
  int INC_VAL = 50;
    
  Particle(float x, float y ,float a){
    this.pos = new PVector(x, y);
    this.angle = a;
  }
  
  void rotate(PImage img){
    float angleLeft = this.angle-this.seek_angle;
    float angleRight = this.angle+this.seek_angle;
    PVector tmP = new PVector(this.seek_dist*cos(angleLeft), this.seek_dist*sin(angleLeft));
    int[] pLeft = this.getIndex(PVector.add(this.pos,tmP), img.width, img.height);
    tmP = new PVector(this.seek_dist*cos(angleRight), this.seek_dist*sin(angleRight));
    int[] pRight = this.getIndex(PVector.add(this.pos, tmP), img.width, img.height);
    tmP = new PVector(this.seek_dist*cos(this.angle), this.seek_dist*sin(this.angle));
    int[] pMiddle = this.getIndex(PVector.add(this.pos, tmP), img.width, img.height);
    float aLeft = brightness(img.get(pLeft[0], pLeft[1]));
    float aMiddle = brightness(img.get(pMiddle[0], pMiddle[1]));
    float aRight = brightness(img.get(pRight[0], pRight[1]));
    
    if (aMiddle>aLeft && aMiddle>aRight){
    }
    else if (aLeft>aMiddle && aRight > aMiddle){
      int b = floor(random(2));
      if (b==0){
        this.angle += this.move_angle;
      }else{
        this.angle -= this.move_angle;
      }
    }
    else if(aLeft>aMiddle && aMiddle> aRight){
      this.angle -= this.move_angle;
    }
    else if (aLeft<aMiddle && aMiddle < aRight){
      this.angle += this.move_angle;
    }
  }
  
  void move(){
    PVector p = new PVector(this.move_dist*cos(this.angle), this.move_dist*sin(this.angle));
    this.pos.add(p);
  }
  
  void deposit(PImage img){
    int[] p = this.getIndex(this.pos, img.width, img.height);
    float a = brightness(img.get(p[0], p[1]));
    a = min(MAX_VAL, a+INC_VAL);
    img.set(p[0], p[1], color(a));
    
  }
  
  void clip(int w, int h){
    this.pos.x = this.pos.x%w;
    this.pos.y = this.pos.y%h;
  }
  
  int[] getIndex(PVector pos, int sx, int sy){
    int xx = int(pos.x/width*sx);
    int yy = int(pos.y/height*sy);
    return new int[]{xx, yy};
  }
  
  
  /*boolean isLow(int a){
    return a <THRESHOLD_LOW;
  }
  boolean isMiddle(int a){
    return THRESHOLD_LOW<a && a<THRESHOLD_HIGH;
  }
  boolean isHigh(int a){
    return THRESHOLD_HIGH<a;
  }*/
  
}
