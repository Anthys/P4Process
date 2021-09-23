class Particle2 extends Particle{
  
  Particle2(float x, float y ,float a){
    super(x, y, a);
  }

  float get_pixel(int x, int y, PImage img){
    return blue(img.get(x, y));
  }
  void deposit(PImage img){
    int[] p = this.getIndex(this.pos, img.width, img.height);
    float a = get_pixel(p[0], p[1], img);
    a = min(MAX_VAL, a+INC_VAL);
    img.set(p[0], p[1], color(a,0,a));
    
  }
}
