class Particle{
  float seek_dist = 20;
  float seek_angle = PI/3;
  float move_dist = .4;
  float move_angle = PI/12;
  float angle = 0;
  PVector pos;
  
  //int THRESHOLD_LOW = 50;
  //int THRESHOLD_HIGH = 100;
  int MAX_VAL = 255;
  int INC_VAL = 50;
  
  Particle(){
    this.pos = new PVector(0, 0);
    this.angle = 0;
  }
    
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
    float aLeft = get_pixel(pLeft[0], pLeft[1], img);
    float aMiddle = get_pixel(pMiddle[0], pMiddle[1], img);
    float aRight =get_pixel(pRight[0], pRight[1], img);
    
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
    float a = get_pixel(p[0], p[1], img);
    a = min(MAX_VAL, a+INC_VAL);
    img.set(p[0], p[1], color(a));
    
  }
  
  float get_pixel(int x, int y, PImage img){
    return brightness(img.get(x, y));
  }
  
  void clip(int w, int h){
    this.pos.x = my_mod(this.pos.x, w);
    this.pos.y = my_mod(this.pos.y, h);
  }
  
  int[] getIndex(PVector pos, int sx, int sy){
    int xx = int(pos.x/width*sx);
    int yy = int(pos.y/height*sy);
    return new int[]{xx, yy};
  }
  
  float my_mod(float b, float c){
    if (b<0){
      return b+c;
    }
    else if (b>c){
      return b-c;
    }
    return b;
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
