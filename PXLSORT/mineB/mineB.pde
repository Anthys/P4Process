
/*

 ASDF Pixel Sort
 Kim Asendorf | 2010 | kimasendorf.com
 
 sorting modes
 
 0 = black
 1 = brightness
 2 = white
 
 */

int mode = 1;

// image path is relative to sketch directory
PImage img;
String imgFileName = "ab";
String fileType = "jpg";

int loops = 1;

// threshold values to determine sorting start and end pixels
int blackValue = -11000000;
int brightnessValue = 100;
int whiteValue = -11000000;

int row = 0;
int column = 0;

boolean saved = false;

void add_noise(PImage img){
  for (int i=0; i<img.width; i++)
  for (int j=0; j<img.height;j++){
    color a = img.get(i,j);
    float x,y,f;
    f = 100;
    x = f*float(i)/img.width;
    y = f*float(j)/img.height;
    int n = int(50*noise(x,y));
    color an = color(n);
    color am = lerpColor(a,an,.3);
    img.set(i, j, a);
  }
}

color get_col(PImage img, int i, int j){
  color a = img.get(i,j);
  float x,y,f;
  f = 100;
  x = f*float(i)/img.width;
  y = f*float(j)/img.height;
  int n = int(100*noise(x,y, tim/10));
  color an = color(n);
  color am = lerpColor(a,an,.3);
  return am;
}


void setup() {
  noiseSeed(240);
  img = loadImage(imgFileName+"."+fileType);
  
  // use only numbers (not variables) for the size() command, Processing 3
  size(1, 1);
  
  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  
  // load image onto surface - scale to the available width,height for display
  image(img, 0, 0, width, height);
}

float tim=0;

void draw() {
  tim += 1.;
  add_noise(img);
  if (true){
  row = 0;
  column = 0;
  img = loadImage(imgFileName+"."+fileType);
  
  // loop through columns
  while(column < img.width-1) {
    println("Sorting Column " + column);
    img.loadPixels(); 
    sortColumn();
    column++;
    img.updatePixels();
  }
  
  // loop through rows
  while(row < img.height-1) {
    println("Sorting Row " + column);
    img.loadPixels(); 
    //sortRow();
    row++;
    img.updatePixels();
  }
  }
  
  // load updated image onto surface and scale to fit the display width,height
  image(img, 0, 0, width, height);
  
  if(!saved && frameCount >= loops) {
    
  // save img
    img.save(imgFileName+"_"+mode+".png");
  
    saved = true;
    println("Saved "+frameCount+" Frame(s)");
    
    // exiting here can interrupt file save, wait for user to trigger exit
    println("Click or press any key to exit...");
  }
  noLoop();
}

void keyPressed() {
  if(saved)
  {
    System.exit(0);
  }
}

void mouseClicked() {
  if(saved)
  {
    System.exit(0);
  }
}

void sortRow() {
  // current row
  int y = row;
  
  // where to start sorting
  int x = 0;
  
  // where to stop sorting
  int xend = 0;
  
  while(xend < img.width-1) {
    switch(mode) {
      case 0:
        x = getFirstNotBlackX(x, y);
        xend = getNextBlackX(x, y);
        break;
      case 1:
        x = getFirstBrightX(x, y);
        xend = getNextDarkX(x, y);
        break;
      case 2:
        x = getFirstNotWhiteX(x, y);
        xend = getNextWhiteX(x, y);
        break;
      default:
        break;
    }
    
    if(x < 0) break;
    
    int sortLength = xend-x;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = get_col(img, x+i, y);
    }
    
    sorted = sort(unsorted);
    
    for(int i=0; i<sortLength; i++) {
      img.pixels[x + i + y * img.width] = sorted[i];      
    }
    
    x = xend+1;
  }
}


void sortColumn() {
  // current column
  int x = column;
  
  // where to start sorting
  int y = 0;
  
  // where to stop sorting
  int yend = 0;
  
  while(yend < img.height-1) {
    switch(mode) {
      case 0:
        y = getFirstNotBlackY(x, y);
        yend = getNextBlackY(x, y);
        break;
      case 1:
        y = getFirstBrightY(x, y);
        yend = getNextDarkY(x, y);
        break;
      case 2:
        y = getFirstNotWhiteY(x, y);
        yend = getNextWhiteY(x, y);
        break;
      default:
        break;
    }
    
    if(y < 0) break;
    
    int sortLength = yend-y;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = get_col(img, x, y+i);
    }
    
    sorted = sort(unsorted);
    sorted = reverse(sorted);
    
    for(int i=0; i<sortLength; i++) {
      img.pixels[x + (y+i) * img.width] = sorted[i];
    }
    
    y = yend+1;
  }
}


// black x
int getFirstNotBlackX(int x, int y) {
  
  while(get_col(img, x, y) < blackValue) {
    x++;
    if(x >= img.width) 
      return -1;
  }
  
  return x;
}

int getNextBlackX(int x, int y) {
  x++;
  
  while(get_col(img, x, y) > blackValue) {
    x++;
    if(x >= img.width) 
      return img.width-1;
  }
  
  return x-1;
}

// brightness x
int getFirstBrightX(int x, int y) {
  
  while(brightness(get_col(img, x, y)) < brightnessValue) {
    x++;
    if(x >= img.width)
      return -1;
  }
  
  return x;
}

int getNextDarkX(int _x, int _y) {
  int x = _x+1;
  int y = _y;
  
  while(brightness(get_col(img, x, y)) > brightnessValue) {
    x++;
    if(x >= img.width) return img.width-1;
  }
  return x-1;
}

// white x
int getFirstNotWhiteX(int x, int y) {

  while(get_col(img, x, y) > whiteValue) {
    x++;
    if(x >= img.width) 
      return -1;
  }
  return x;
}

int getNextWhiteX(int x, int y) {
  x++;

  while(get_col(img, x, y) < whiteValue) {
    x++;
    if(x >= img.width) 
      return img.width-1;
  }
  return x-1;
}


// black y
int getFirstNotBlackY(int x, int y) {

  if(y < img.height) {
    while(get_col(img, x, y) < blackValue) {
      y++;
      if(y >= img.height)
        return -1;
    }
  }
  
  return y;
}

int getNextBlackY(int x, int y) {
  y++;

  if(y < img.height) {
    while(get_col(img, x, y) > blackValue) {
      y++;
      if(y >= img.height)
        return img.height-1;
    }
  }
  
  return y-1;
}

// brightness y
int getFirstBrightY(int x, int y) {

  if(y < img.height) {
    while(brightness(get_col(img, x, y)) < brightnessValue) {
      y++;
      if(y >= img.height)
        return -1;
    }
  }
  
  return y;
}

int getNextDarkY(int x, int y) {
  y++;

  if(y < img.height) {
    while(brightness(get_col(img, x, y)) > brightnessValue) {
      y++;
      if(y >= img.height)
        return img.height-1;
    }
  }
  return y-1;
}

// white y
int getFirstNotWhiteY(int x, int y) {

  if(y < img.height) {
    while(get_col(img, x, y) > whiteValue) {
      y++;
      if(y >= img.height)
        return -1;
    }
  }
  
  return y;
}

int getNextWhiteY(int x, int y) {
  y++;
  
  if(y < img.height) {
    while(get_col(img, x, y) < whiteValue) {
      y++;
      if(y >= img.height) 
        return img.height-1;
    }
  }
  
  return y-1;
}
