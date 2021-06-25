import controlP5.*;


/*

 ASDF Pixel Sort
 Kim Asendorf | 2010 | kimasendorf.com
 
 sorting modes
 
 0 = black
 1 = brightness
 2 = white
 
 */

int mode = 0;

// image path is relative to sketch directory
PImage img;
String imgFileName = "alexb";
String fileType = "jpg";

int loops = 1;

// threshold values to determine sorting start and end pixels
int blackValue = -11000000;
int brightnessValue = 100;
int whiteValue = -11000000;

int row = 0;
int column = 0;

float angle_rays = PI/4;

boolean saved = false;

ControlP5 cp5;

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

float noiseIntensity = 100;
float noiseScale = 100;
boolean do_columns = true;
boolean do_rows = false;

color get_col(PImage img, int i, int j){
  return get_col(img, i, j, false);
}

color get_col(PImage img, int i, int j, boolean use_noise){
  if (!use_noise){
    return img.get(i,j);
  }
  color a = img.get(i,j);
  float x,y,f;
  f = noiseScale;
  x = f*float(i)/img.width;
  y = f*float(j)/img.height;
  int n = int(noiseIntensity*noise(x,y));
  color an = color(n);
  color am = lerpColor(a,an,.3);
  return am;
}

RadioButton r1;

void make_rotate(){
  float th = angle_rays;
  PImage img_bfr = loadImage(imgFileName+"."+fileType);
  int w = img_bfr.width;
  int h = img_bfr.height;
  int newWidth = (int) Math.floor(w * cos(th) + h * sin(th));
  int newHeight = (int) Math.floor(h * cos(th) + w * sin(th));
  PGraphics cvs_t = createGraphics(newWidth, newHeight);
  img = img_bfr;
  cvs_t.beginDraw();
  cvs_t.translate(sin(th)*h, 0);
  cvs_t.rotate(angle_rays);
  cvs_t.image(img_bfr, 0,0);
  cvs_t.save("tmp_r.png");
  cvs_t.endDraw();
  img = loadImage("tmp_r.png");
}

void setup() {
  noiseSeed(240);
  make_rotate();
  
  // use only numbers (not variables) for the size() command, Processing 3
  size(1, 1);
  
  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  
  // load image onto surface - scale to the available width,height for display
  image(img, 0, 0, width, height);
  cp5 = new ControlP5(this);
  cp5.addSlider("sliderNoiseIntensity", 0, 200, 100, 100, 260, 100*2, 14*3).setId(1);
  cp5.addSlider("sliderNoiseSeed", 0, 200, 100, 100, 260+100, 100*2, 14*3).setId(2);
  cp5.addSlider("sliderNoiseScale", 0, 200, 100, 100, 260+100*2, 100*2, 14*3).setId(3);
  cp5.addSlider("sliderBlackValue", 0,16000000, 11000000, 100, 260+100*3, 100*2, 14*3).setId(4);
  cp5.addSlider("sliderWhiteValue", 0,16000000, 11000000, 100, 260+100*4, 100*2, 14*3).setId(5);
  cp5.addSlider("sliderBrightnessValue", 0,255, 60, 100, 260+100*5, 100*2, 14*3).setId(6);
  cp5.addSlider("sliderRandChanceCol", 0,1, .9, 100, 260+100*6, 100*2, 14*3).setId(7);
  //cp5.addTextfield("textBlackValue", 100, 700, 100, 20).setInputFilter(ControlP5.INTEGER);
  
  cp5.addToggle("do_rows")
     .setPosition(100,100)
     .setSize(100,100)
     ;
  cp5.addToggle("do_columns")
     .setPosition(100+150,100)
     .setSize(100,100)
     ;
  cp5.addToggle("micheldebug")
     .setPosition(100+150*2,100)
     .setSize(50,50)
     ;
  cp5.addToggle("noise_on_rows")
     .setPosition(100,200)
     .setSize(50,50)
     ;
  cp5.addToggle("noise_on_columns")
     .setPosition(100+150,200)
     .setSize(50,50)
     ;
  cp5.addToggle("reverse_rows")
     .setPosition(100+75,200)
     .setSize(50,50)
     ;
  cp5.addToggle("reverse_columns")
     .setPosition(100+150+75,200)
     .setSize(50,50)
     ;
  r1 = cp5.addRadioButton("mode_choose")
         .setPosition(20,20)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(3)
         .setSpacingColumn(50)
         .addItem("0",0)
         .addItem("1",1)
         .addItem("2",2)
         .activate(mode);
         //.addItem("200",4)
         //.addItem("250",5)
         ;
     
     for(Toggle t:r1.getItems()) {
       t.getCaptionLabel().setColorBackground(color(255,80));
       t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
       t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
       t.getCaptionLabel().getStyle().backgroundWidth = 45;
       t.getCaptionLabel().getStyle().backgroundHeight = 13;
     }
  
  //pixel_sort(img);
}

void textBlackValue(String val){
  blackValue = - int(val);
}

void buttonRows(){
  do_rows = !do_rows;
}
void buttonColumns(){
  do_columns = !do_columns;
}

void keyPressed(){
  if (key == 'r'){
    re_draw();
  }
  if (key == 's'){
    save_img("mine"+str(int(tim)));
  }
}

float tim=0;

boolean reverse_rows = false;
boolean reverse_columns = true;

void pixel_sort(PImage img){
  //add_noise(img);
  row = 0;
  column = 0;
  //img = loadImage(imgFileName+"."+fileType);
  
  // loop through columns
  if (do_columns){
    while(column < img.width-1) {
      //println("Sorting Column " + column);
      img.loadPixels(); 
      sortColumn();
      column++;
      img.updatePixels();
    }
  }
  
  // loop through rows
  if (do_rows){
    while(row < img.height-1) {
      //println("Sorting Row " + column);
      img.loadPixels(); 
      sortRow();
      row++;
      img.updatePixels();
    }
  }
}

void re_draw(){
  img = loadImage("tmp_r.png");
  pixel_sort(img);
}

void save_img(String name){
    img.save(name+".png");
}


void save_img(){
    img.save(imgFileName+"_"+mode+".png");
}


void draw() {
  tim += 1.;
  
  
  // load updated image onto surface and scale to fit the display width,height
  image(img, 0, 0, width, height);
  
  //noLoop();
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
      unsorted[i] = get_col(img, x+i, y, false);
    }
    
    sorted = sort(unsorted);
    if (reverse_rows)
      sorted = reverse(sorted);
      
    
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
      unsorted[i] = get_col(img, x, y+i, false);
    }
    
    sorted = sort(unsorted);
    if (reverse_columns)
      sorted = reverse(sorted);
    
    for(int i=0; i<sortLength; i++) {
      img.pixels[x + (y+i) * img.width] = sorted[i];
    }
    
    y = yend+1;
  }
}

boolean micheldebug = true;

// black x
int getFirstNotBlackX(int x, int y) {
  
  while(get_col(img, x, y,noise_on_rows) < blackValue) {
    x++;
    if(x >= img.width) 
      return -1;
  }
  
  return x;
}

int getNextBlackX(int x, int y) {
  x++;
  
  while(get_col(img, x, y,noise_on_rows) > blackValue ) {
    x++;
    if(x >= img.width) 
      return img.width-1;
  }
  
  return x-1;
}

boolean noise_on_rows = false;
boolean noise_on_columns = true;

// brightness x
int getFirstBrightX(int x, int y) {
  
  while(brightness(get_col(img, x, y,noise_on_rows)) < brightnessValue) {
    x++;
    if(x >= img.width)
      return -1;
  }
  
  return x;
}

int getNextDarkX(int _x, int _y) {
  int x = _x+1;
  int y = _y;
  
  while(brightness(get_col(img, x, y,noise_on_rows)) > brightnessValue) {
    x++;
    if(x >= img.width) return img.width-1;
  }
  return x-1;
}

// white x
int getFirstNotWhiteX(int x, int y) {

  while(get_col(img, x, y,noise_on_rows) > whiteValue) {
    x++;
    if(x >= img.width) 
      return -1;
  }
  return x;
}

int getNextWhiteX(int x, int y) {
  x++;

  while(get_col(img, x, y,noise_on_rows) < whiteValue) {
    x++;
    if(x >= img.width) 
      return img.width-1;
  }
  return x-1;
}

// black y
int getFirstNotBlackY(int x, int y) {

  if(y < img.height) {
    while(get_col(img, x, y,noise_on_columns) < blackValue && (random(1)<rand_chance_columns)) {
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
    while(get_col(img, x, y,noise_on_columns) > blackValue || (random(1)<rand_chance_columns)) {
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
    while(brightness(get_col(img, x, y,noise_on_columns)) < brightnessValue) {
      y++;
      if(y >= img.height)
        return -1;
    }
  }
  
  return y;
}

float rand_chance_columns = .9;

int getNextDarkY(int x, int y) {
  y++;

  if(y < img.height) {
    while(brightness(get_col(img, x, y,noise_on_columns)) > brightnessValue|| (random(1)<rand_chance_columns)) {
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
    while(get_col(img, x, y,noise_on_columns) > whiteValue&& (random(1)<rand_chance_columns)) {
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
    while(get_col(img, x, y,noise_on_columns) < whiteValue|| (random(1)<rand_chance_columns)) {
      y++;
      if(y >= img.height) 
        return img.height-1;
    }
  }
  
  return y-1;
}


public void controlEvent(ControlEvent theEvent) {
  println("got a control event from controller with id "+theEvent.getId());
  if(theEvent.isFrom(r1)) {
    mode = int(theEvent.getGroup().getValue());
  }
  else {
    switch(theEvent.getId()) {
      case(1): // numberboxA is registered with id 1
        noiseIntensity = (theEvent.getController().getValue());
        break;
      case(2):
        noiseSeed((int)theEvent.getController().getValue());
        break;
      case(3):
        noiseScale = theEvent.getController().getValue();
        break;
      case(4):
        blackValue = -(int)theEvent.getController().getValue();
        break;
      case(5):
        whiteValue = -(int)theEvent.getController().getValue();
        break;
      case(6):
        brightnessValue = (int)theEvent.getController().getValue();
        break;
      case(7):
        rand_chance_columns = theEvent.getController().getValue();
        break;
    }
  }
  println(1);
  re_draw();
}
