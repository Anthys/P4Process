class CoolSpline {
  PGraphics img;
  int x;
  int y;
  ArrayList<PVector> verts;
  
  CoolSpline(PGraphics img_, int x_, int y_,ArrayList<PVector> verts_){
    img = img_;
    x = x_;
    y = y_;
    verts = verts_;
  }
  
  void draw(){
    img.beginDraw();
    img.beginShape();
    img.curveVertex(verts.get(0).x, verts.get(0).y);
    for (PVector p:verts){
      img.curveVertex(p.x, p.y);
    }
    PVector tmp = verts.get(verts.size()-1);
    img.curveVertex(tmp.x, tmp.y);
    img.endShape();
    img.endDraw();
  }

}
