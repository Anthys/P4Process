
PImage img;
PGraphics back;
int stroke_len = 3;
int angles_no = 30;
int segments = 500;
float stroke_width = 1;

int cx, cy;
int sqwidth;
int[] sintab, costab;

void settings(){
  img = loadImage("img.jpg");
  size(img.width, img.height);
}

void setup(){
  frameRate(120);
  back = createGraphics(width, height);
  back.beginDraw();
  back.strokeWeight(stroke_width);
  back.background(200);
  back.endDraw();
  cx = cy = 0;
  sqwidth = stroke_len * 2 + 4;
  
  sintab = new int[angles_no];
  costab = new int[angles_no];
 
  for(int i=0;i<angles_no;i++) {
    sintab[i] = (int)(stroke_len * sin(TWO_PI*i/(float)angles_no));
    costab[i] = (int)(stroke_len * cos(TWO_PI*i/(float)angles_no));
  } 
  
}

float getStat(color c1, color c2){
  int stat_type = 4;
  float v = 0;
  switch(stat_type) {
    case 0: 
      v = abs(hue(c1)-hue(c2));
      break;
    case 1:
      v = abs(brightness(c1)-brightness(c2));
    case 2: 
      v = abs(saturation(c1)-saturation(c2));
      break;
    case 3:
      v = abs(red(c1)-red(c2))+abs(green(c1)-green(c2))+abs(blue(c1)-blue(c2));
      break;
    case 4: 
      v = abs( (red(c1)+blue(c1)+green(c1)) - (red(c2)+blue(c2)+green(c2)) );
      break;
    case 5: 
      v = sq(red(c1)-red(c2)) + sq(green(c1)-green(c2)) + sq(blue(c1)-blue(c2)); 
      break;
  }
  return v;
}

int calcError(PImage img1, PImage img2){
  int err = 0;
  img1.loadPixels();
  img2.loadPixels();
  for(int i=0;i<img1.pixels.length;i++)
    err += getStat(img1.pixels[i],img2.pixels[i]);
  return err;
}

void draw(){
  cx = (int)random(img.width);
  cy = (int)random(img.height);
  draw_();
  image(back, 0, 0);
}

void draw_(){
  back.beginDraw();
  color c = img.get(cx, cy);
  back.stroke(c, 100);
  
  
  for (int i = 0; i < segments; i ++){
    int corx = int(cx)-stroke_len-2;
    int cory = int(cy)-stroke_len-2; 
    
    PImage imgpart = img.get(corx,cory,sqwidth,sqwidth);
    PImage mypart = back.get(corx,cory,sqwidth,sqwidth);
    
    
    int j = (int)random(angles_no);
    PImage destpart = null;
    int _nx=cx,_ny=cy;
    float localerr = calcError(imgpart,mypart);
    int iterangles = angles_no;
    
    while(iterangles-- > 0) {
      // take end points
      int nx = cx + costab[j];
      int ny = cy + sintab[j];
     
      // if not out of the screen
      if(nx>=0 && nx<img.width-1 && ny>=0 && ny<img.height-1) {
        // clean region and draw line
        back.image(mypart,corx,cory);
        back.line(cx,cy,nx,ny);
      
        // take region with line and calc diff
        PImage curr = back.get(corx,cory,sqwidth,sqwidth);
        int currerr = calcError(imgpart,curr);
        
        // if better, remember this region and line endpoint
        if(currerr < localerr) {
          destpart = curr;
          _nx = nx;
          _ny = ny;
          localerr = currerr;
        }
      }
      
      // next angle
      j = (j+1)%angles_no;
    }
    
    if(destpart != null) {
      back.image(destpart,corx,cory);
      cx = _nx;
      cy = _ny;
    } else {
      break; // skip
    }
    
  }
  back.endDraw();
  image(back,0,0,width,height);

}
