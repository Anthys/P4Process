import controlP5.*;

/*

 ASDF Pixel Sort
 Kim Asendorf | 2010 | kimasendorf.com
 
 sorting modes
 
 0 = black
 1 = white
 2 = bright
 3 = dark
 4 = near to color
 5 = far from color
 
*/

ControlP5 cp5;
RadioButton r1;
boolean gui_shown = true;

PImage img;
PGraphics cvs;
String imgFileName = "b.jpg";

int mode = 0;

float tim=0;


// threshold values
int blackValue = -11000000;
int brightnessValue = 100;
int whiteValue = -11000000;
int colortarget = color(0,200,0);
int colordistValue = 250;

float angle_rays = PI/5;
color background_rot = color(0);

float noiseIntensity = 100;
float noiseScale = 100;

boolean do_columns = true;
boolean do_rows = false;
boolean reverse_rows = false;
boolean reverse_columns = true;
boolean noise_on_rows = false;
boolean noise_on_columns = false;
float rand_chance_columns = .9;
float rand_chance_rows = .9;

//size of the original picture, before rotation
int[] wh;
float ratio = 1.;

boolean micheldebug = true;

void setup() {
  noiseSeed(240);
  wh = make_rotate();
  cvs = createGraphics(wh[0], wh[1]);
  
  // use only numbers (not variables) for the size() command, Processing 3
  size(1, 1);
  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(1000, 1000);
  
  cp5 = new ControlP5(this);
  cp5.addSlider("sliderNoiseIntensity", 0, 200, 100, 100, 260, 100*2, 14*3).setId(1);
  cp5.addSlider("sliderNoiseSeed", 0, 200, 100, 100, 260+100, 100*2, 14*3).setId(2);
  cp5.addSlider("sliderNoiseScale", 0, 200, 100, 100, 260+100*2, 100*2, 14*3).setId(3);
  cp5.addSlider("sliderBlackValue", 0,16000000, 11000000, 100, 260+100*3, 100*2, 14*3).setId(4);
  cp5.addSlider("sliderWhiteValue", 0,16000000, 11000000, 100, 260+100*4, 100*2, 14*3).setId(5);
  cp5.addSlider("sliderBrightnessValue", 0,255, 60, 100, 260+100*5, 100*2, 14*3).setId(6);
  cp5.addSlider("sliderRandChanceCol", 0,1, .9, 100, 260+100*6, 100*2, 14*3).setId(7);
  cp5.addSlider("sliderAngleRays", 0,TAU, PI/4, 100, 260+100*6+50, 100*2, 14*3).setId(8);
  cp5.addSlider("sliderdistcolorValue", 0,600, 300, 100+200+50, 260+100*6+50, 100*2, 14*3).setId(9);
  
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
         .addItem("3",3)
         .addItem("4",4)
         .addItem("5",5)
         .activate(mode);
     
  for(Toggle t:r1.getItems()) {
    t.getCaptionLabel().setColorBackground(color(255,80));
    t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
    t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
    t.getCaptionLabel().getStyle().backgroundWidth = 45;
    t.getCaptionLabel().getStyle().backgroundHeight = 13;
  }
}

void draw() {
  if (tim==0)
    pixel_sort(img);
  tim += 1.;
    image(cvs, 0,0, ratio*wh[0], ratio*wh[1]);
}



void keyPressed(){
  if (key == 'r'){
        re_rotate();
        re_draw();
  }
  if (key == 's'){
    save_img("mine"+str(int(tim)));
  }
  if (key=='h'){
    if (gui_shown)
      cp5.hide();
    else
      cp5.show();
    gui_shown=!gui_shown;
  }
  if (key=='p'){
    color c = get(mouseX, mouseY);
    colortarget = c;
  }
}

// CP5

void textBlackValue(String val){
  blackValue = - int(val);
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
      case(8):
        angle_rays = theEvent.getController().getValue();
        //re_rotate();
        break;
      case(9):
        colordistValue = (int)theEvent.getController().getValue();
        //re_rotate();
        break;
    }
  }
  //re_draw();
}

// RETRIEVING PIXELS

color get_col(PImage img, int i, int j){
  return get_col(img, i, j, false);
}

/** get a certain pixel color, with a potential alteration
*/
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

//IMAGE TRANSFORMATION

/** create the temporary rotated picture on which is done the pixel sorting
* return the sizes of the original picture
*/
int[] make_rotate(){
  background_rot = (mode==0)?color(0):color(255);
  float th = angle_rays;
  PImage img_bfr = loadImage(imgFileName);
  int w = img_bfr.width;
  int h = img_bfr.height;
  float c = abs(cos(th));
  float s = abs(sin(th));
  int newWidth = (int) floor(w * c + h * s);
  int newHeight = (int) floor(h * c + w * s);
  PGraphics cvs_t = createGraphics(newWidth, newHeight);
  img = img_bfr;
  cvs_t.beginDraw();
  cvs_t.background(background_rot);
  cvs_t.imageMode(CENTER);
  cvs_t.translate(newWidth/2, newHeight/2);
  cvs_t.rotate(angle_rays);
  cvs_t.image(img_bfr, 0,0);
  cvs_t.save("tmp_r.png");
  cvs_t.endDraw();
  img = loadImage("tmp_r.png");
  return new int[]{w, h};
}

void re_rotate(){
  wh = make_rotate();
}

//PIXEL SORTING A

void pixel_sort(PImage img){
  int row = 0;
  int column = 0;

  if (do_columns){
    while(column < img.width-1) {
      img.loadPixels(); 
      sortColumn(column);
      column++;
      img.updatePixels();
    }
  }
  
  if (do_rows){
    while(row < img.height-1) {
      img.loadPixels(); 
      sortRow(row);
      row++;
      img.updatePixels();
    }
  }
  cvs.beginDraw();
  cvs.imageMode(CENTER);
  cvs.translate(wh[0]/2, wh[1]/2);
  cvs.rotate(-angle_rays);
  cvs.image(img, 0, 0, img.width, img.height);
  cvs.endDraw();
  
  if (wh[0]>wh[1]){
    ratio = float(width)/wh[0];}
    else{ratio = float(height)/wh[1];};
  
  image(cvs, 0,0, ratio*wh[0], ratio*wh[1]);
  
  println("PIXELSORTING DONE");
}


void sortRow(int row) {
  int y = row;
  
  int x = 0;
  int xend = 0;
  
  while(xend < img.width-1) {
    x = getFirstPixelWithConditionX(mode, x, y);
    xend = getNextPixelWithConditionX(mode, x, y);
    
    if(x < 0) break;
    
    int sortLength = xend-x;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = get_col(img, x+i, y, false); 
      // use_noise to false because we don't want to alter the pixels during rendering
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


void sortColumn(int column) {
  int x = column;
  
  int y = 0;
  int yend = 0;
  
  while(yend < img.height-1) {
      y = getFirstPixelWithConditionY(mode, x, y);
      yend = getNextPixelWithConditionY(mode, x, y);
    
    
    if(y < 0) break;
    
    int sortLength = yend-y;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = get_col(img, x, y+i, false);
      // use_noise to false because we don't want to alter the pixels during rendering
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

//PIXEL SORTING B

boolean checkCond(int mode, color c){
  return checkCond(mode, c, false);
}

boolean checkCond(int mode, color c, boolean contrary){
  boolean condA = false;
  switch (mode){
    case 0:
      condA = c<blackValue;
      break;
    case 1:
      condA = c>blackValue;
      break;
    case 2:
      condA = brightness(c) < brightnessValue;
      break;
    case 3:
      condA = brightness(c) > brightnessValue;
      break;
    case 4:
      condA = colordist(c,colortarget)>colordistValue;
      break;
    case 5:
      condA = colordist(c,colortarget)<colordistValue;
      break;
  }
  return contrary?!condA:condA;
}

int getFirstPixelWithConditionX(int mode, int x, int y){
  color c = get_col(img, x, y,noise_on_rows);  
  
  while(checkCond(mode, c) && random(1)<rand_chance_rows) {
    x++;
    if(x >= img.width) 
      return -1;
    c = get_col(img, x, y,noise_on_rows);
  }
  return x;
}

int getNextPixelWithConditionX(int mode, int x, int y){
  color c = get_col(img, x, y,noise_on_rows);  
  
  while((!checkCond(mode, c)) || random(1)<rand_chance_rows) {
    x++;
    if(x >= img.width) 
        return img.width-1;
    c = get_col(img, x, y,noise_on_rows);
  }
  return x;
}

int getFirstPixelWithConditionY(int mode, int x, int y){
  color c = get_col(img, x, y,noise_on_rows);  
  
  while(checkCond(mode, c) && random(1)<rand_chance_columns){
    if(y >= img.height) 
      return -1;
    c = get_col(img, x, y,noise_on_rows);
  }
  return y;
}

int getNextPixelWithConditionY(int mode, int x, int y){
  color c = get_col(img, x, y,noise_on_rows);  
  
  while((!checkCond(mode, c)) || random(1)<rand_chance_columns) {
    y++;
    if(y >= img.height) 
        return img.height-1;
    c = get_col(img, x, y,noise_on_rows);
  }
  return y;
}

//UTILITIES

void save_img(String name){
    cvs.save(name+".png");
}
void save_img(){
    cvs.save(imgFileName+"_"+mode+".png");
}

void re_draw(){
  img = loadImage("tmp_r.png");
  pixel_sort(img);
}

float colordist(color c1, color c2){
  return abs(red(c1)-red(c2))+abs(green(c1)-green(c2))+abs(blue(c1)-blue(c2));  
}