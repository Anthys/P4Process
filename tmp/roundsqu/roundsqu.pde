
float sq_size = 100;
PGraphics cvs;
void setup(){size(500,500);cvs = createGraphics(width, height);
}
void draw_one(){
    cvs.beginShape();
    cvs.vertex(0,0);
    cvs.endShape();
}
void draw_one2(){
    cvs.beginShape();
    cvs.vertex(0,0);
    cvs.quadraticVertex(0, sq_size/2, sq_size/2, sq_size/2);
    cvs.vertex(sq_size/2, sq_size/2);
    cvs.vertex(0, sq_size/2);
    cvs.vertex(0,0);
    cvs.endShape();
    cvs.beginShape();
    cvs.vertex(0, sq_size/2);
    cvs.vertex(sq_size/2, sq_size/2);
    cvs.quadraticVertex(sq_size/2, sq_size, 0, sq_size);
    cvs.vertex(0, sq_size);
    cvs.vertex(0, sq_size/2);
    cvs.endShape();
}
void draw(){
cvs.beginDraw();
cvs.translate(width/2, height/2);
    cvs.fill(100);
    cvs.beginShape();
    cvs.endShape(CLOSE);
    
    cvs.fill(0);
    cvs.beginShape();
    cvs.endShape();
    
    
    cvs.fill(250);
    cvs.push();
    cvs.rotate(PI/2);
    cvs.translate(-sq_size*0, -sq_size);
    draw_one();
    cvs.pop();
    
    cvs.fill(150);
    draw_one();
    
    cvs.endDraw();
    image(cvs,0,0);
}
