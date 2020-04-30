import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer groove;
AudioMetaData meta;
BeatDetect beat;
float yoff = 0.0;
float slowChange;
 
void setup()
{
 
size(640, 360, P3D);
 
minim = new Minim(this);
groove = minim.loadFile("Allie X - Devil I Know (lyrics).mp3", 2048);
groove.play();
beat = new BeatDetect();
ellipseMode(CENTER);
 
}
void draw() 
{
background(#9C69D3);
beat.detect(groove.mix);
stroke(255);
 
  for(int i = 0; i < groove.bufferSize() - 1; i++)
  {
   arc(320, 180 + (50 * groove.left.get(5)), 300, 200, 0, PI, CHORD);
 
  }
fill(#2FCB38);
ellipse(320, 180, 300, 300);
 
fill(#149CC4);
ellipse(270, 120, 60, 60);
 
fill(#DAFC03);
ellipse(370, 120, 90, 90);
 
if(keyPressed)
{
fill(#2FCB38);
stroke(0);
 
arc(320 + (50 * groove.right.get(0)), 320, 250, 200, 0, -PI, CHORD);
}
else {
  fill(#2FCB38);
stroke(0);
 
}
 
fill(#1F0BDB);
beginShape();
 float xoff = 0;
  for (float x = 0; x <= width; x += 10) {
    float y = map(noise(xoff, yoff), 10, 1, 0, 300);
    vertex(x, y); 
    xoff += 0.10;
  }
  yoff += 0.10;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}
