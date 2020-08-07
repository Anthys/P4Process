static class ColorGradients{

    static PApplet p;
    
    static class oneD {
        static int test(){
              return 1;
        }
    }

    static class twoD{
        static int beta(){
            return oneD.test();
        }
    }
    
      static final int randomNum() {
    return (int) p.random(1, 2);
  }
}
