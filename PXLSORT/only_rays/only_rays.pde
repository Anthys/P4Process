import java.util.Collections;

void setup(){
  size(1000, 1000);
  cvs = createImage(width, height, RGB);
    cvs_orig = loadImage("picB.jpg");
  //colorMode(RGB, mx_color);
  strokeWeight(20);
}
int i=0;
float mx_color = 1.;
PImage cvs_orig;
PImage cvs;
ArrayList<Integer> line_colors;
int mode = 0;

void draw(){
  theloop();
  theloop();
  theloop();
  theloop();
}
void theloop(){
  int x,y;
  i+=1;
  //for (int i=0; i<width*2+height*2; i++){
    x = i<width?i:i<width+height?width-1:i<width*2+height?width-(i-height-width):0;
    y = i<width?0:i<width+height?i-width:i<width*2+height?height-1:height-(i-2*width-height);
    point(x,y);
    float aa = float(i)/(2*width+height*2)*mx_color;
    color a = color(aa, 100, 100);
    //cvs.set(x, y, a);
    //bresenham_line_copy(cvs, a, int(width/2), int(height/2), x, y);
    line_colors = get_line(cvs_orig, int(width/2), int(height/2), x, y);
    //Collections.reverse(line_colors);
    Collections.sort(line_colors);
    //sortRow(line_colors);
    draw_line(cvs,line_colors,  int(width/2), int(height/2), x, y);
    
  if (i>width*2+height*2){cvs.filter(BLUR, 2); noLoop();}
    image(cvs, 0,0);
    //stroke(a);
    //point(x, y);
    
}

void sortRow(ArrayList<Integer> lc) {
  
  // where to start sorting
  int i = 0;
  
  // where to stop sorting
  int iend = 0;
  
  while(iend < lc.size()-1) {
    switch(mode) {
      case 0:
        i = getFirstNotBlack(lc, i);
        if(i < 0) break;
        iend = getNextBlack(lc, i);
        break;
      case 1:
        i = getFirstBright(lc, i);
        if(i < 0) break;
        iend = getNextDark(lc, i);
        break;
      case 2:
        //i = getFirstNotWhite(lc, i);
        //iend = getNextWhite(lc, i);
        break;
      default:
        break;
    }
    
    if(i < 0) break;
    
    int sortLength = iend-i;
    
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i2=0; i2<sortLength; i2++) {
      unsorted[i2] = lc.get(i+i2);
    }
    
    sorted = sort(unsorted);
    
    for(int i2=0; i2<sortLength; i2++) {
      lc.set(i+i2, sorted[i2]);      
    }
    
    i = iend+1;
  }
}


int blackValue = -16000000;
int brightnessValue = 60;
int whiteValue = -13000000;

int getFirstNotBlack(ArrayList<Integer> lc, int i) {
  while(lc.get(i) < blackValue) {
    i++;
    if(i >= lc.size()) 
      return -1;
  }
  
  return i;
}

int getNextBlack(ArrayList<Integer> lc, int i) {
  
  while(lc.get(i) > blackValue) {
    i++;
    if(i >= lc.size()) 
      return lc.size()-1;
  }
  
  return i-1;
}


// brightness x
int getFirstBright(ArrayList<Integer> lc, int i) {
  
  while(brightness(lc.get(i)) < brightnessValue) {
    i++;
    if(i >= lc.size())
      return -1;
  }
  
  return i;
}

int getNextDark(ArrayList<Integer> lc, int i) {
  int i2 = i+1;
  
  while(brightness(lc.get(i2)) > brightnessValue) {
    i2++;
    if(i2 >= lc.size()) return lc.size()-1;
  }
  return i2-1;
}

void bresenham_line(PImage cvs, color c, int x0,int y0, int x1,int y1){
  int dx = x1-x0;
  int dy = y1-y0;
  int D = 2*dy-dx;
  int y = y0;
  for (int x=x0; x<x1;x0++){
    cvs.set(x, y, c);
    if (D>0){
      y++;
      D-=2*dx;
    }
    D = D+2*dy;
  }
}

void bresenham_line_copy(PImage cvs, int c, int x,int y,int x2, int y2) {
    int w = x2 - x ;
    int h = y2 - y ;
    int dx1 = 0, dy1 = 0, dx2 = 0, dy2 = 0 ;
    if (w<0) dx1 = -1 ; else if (w>0) dx1 = 1 ;
    if (h<0) dy1 = -1 ; else if (h>0) dy1 = 1 ;
    if (w<0) dx2 = -1 ; else if (w>0) dx2 = 1 ;
    int longest = Math.abs(w) ;
    int shortest = Math.abs(h) ;
    if (!(longest>shortest)) {
        longest = Math.abs(h) ;
        shortest = Math.abs(w) ;
        if (h<0) dy2 = -1 ; else if (h>0) dy2 = 1 ;
        dx2 = 0 ;            
    }
    int numerator = longest >> 1 ;
    for (int i=0;i<=longest;i++) {
        cvs.set(x,y,c) ;
        numerator += shortest ;
        if (!(numerator<longest)) {
            numerator -= longest ;
            x += dx1 ;
            y += dy1 ;
        } else {
            x += dx2 ;
            y += dy2 ;
        }
    }
}

void draw_line(PImage cvs, ArrayList<Integer> colors, int x,int y,int x2, int y2) {
    int w = x2 - x ;
    int h = y2 - y ;
    int dx1 = 0, dy1 = 0, dx2 = 0, dy2 = 0 ;
    if (w<0) dx1 = -1 ; else if (w>0) dx1 = 1 ;
    if (h<0) dy1 = -1 ; else if (h>0) dy1 = 1 ;
    if (w<0) dx2 = -1 ; else if (w>0) dx2 = 1 ;
    int longest = Math.abs(w) ;
    int shortest = Math.abs(h) ;
    if (!(longest>shortest)) {
        longest = Math.abs(h) ;
        shortest = Math.abs(w) ;
        if (h<0) dy2 = -1 ; else if (h>0) dy2 = 1 ;
        dx2 = 0 ;            
    }
    int numerator = longest >> 1 ;
    for (int i=0;i<=longest;i++) {
        cvs.set(x,y, colors.get(i)) ;
        numerator += shortest ;
        if (!(numerator<longest)) {
            numerator -= longest ;
            x += dx1 ;
            y += dy1 ;
        } else {
            x += dx2 ;
            y += dy2 ;
        }
    }
}

ArrayList<Integer> get_line(PImage cvs, int x,int y,int x2, int y2){
  int w = x2 - x ;
  int h = y2 - y ;
  int dx1 = 0, dy1 = 0, dx2 = 0, dy2 = 0 ;
  if (w<0) dx1 = -1 ; else if (w>0) dx1 = 1 ;
  if (h<0) dy1 = -1 ; else if (h>0) dy1 = 1 ;
  if (w<0) dx2 = -1 ; else if (w>0) dx2 = 1 ;
  int longest = Math.abs(w) ;
  int shortest = Math.abs(h) ;
  if (!(longest>shortest)) {
      longest = Math.abs(h) ;
      shortest = Math.abs(w) ;
      if (h<0) dy2 = -1 ; else if (h>0) dy2 = 1 ;
      dx2 = 0 ;            
  }
  
  ArrayList<Integer> l_colors = new ArrayList<Integer>();  
  
  int numerator = longest >> 1 ;
  for (int i=0;i<=longest;i++) {
      color a = cvs.get(x,y);
      l_colors.add(a);
      numerator += shortest ;
      if (!(numerator<longest)) {
          numerator -= longest ;
          x += dx1 ;
          y += dy1 ;
      } else {
          x += dx2 ;
          y += dy2 ;
      }
  }
  return l_colors;
}
