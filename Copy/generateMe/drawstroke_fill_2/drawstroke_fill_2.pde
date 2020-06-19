
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
  to_process = new ArrayList<ArrayList<int[]>>();
  colores = new ArrayList<Integer>();
  back = createGraphics(width, height);
  back.beginDraw();
  back.strokeWeight(stroke_width);
  back.background(200);
  back.endDraw();
  //new_flaq();
}

void new_flaq(){
  int x = (int)random(width);
  int y = (int)random(height);
  color c = img.get(x, y);
  colores.add(c);
  to_process.add(new ArrayList<int[]>());
  to_process.get(to_process.size()-1).add(new int[]{x,y});

}

void new_flaq(int x, int y){
  color c = img.get(x, y);
  colores.add(c);
  to_process.add(new ArrayList<int[]>());
  to_process.get(to_process.size()-1).add(new int[]{x,y});

}

float getStat(color c1, color c2){
  int stat_type = 5;
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

void draw__(){
  //cx = (int)random(img.width);
  //cy = (int)random(img.height);
  draw_();
  image(back, 0, 0);
  fill(0);
  text(frameCount, 30, 30);
}

void draw(){
  if (frameCount%10==0){
    find_flaq();
  }
  if (keyPressed && keyCode==RIGHT || true){
    //println(1);
    draw__();
  }
  //saveFrame("ttt/out-####.png");
}

ArrayList<Integer> colores;
ArrayList<ArrayList<int[]>> to_process;

void process_pixel(int x, int y, color c, int j){
  if (x<0 || x>width || y<0 || y>height){return;}
  else{
  color c1 = back.get(x, y);
  color c2 = img.get(x, y);
  int s = 6;
  PImage imag_crop = img.get(x-s/2, y-s/2, s, s);
  PImage prev_back_crop = back.get(x-s/2, y-s/2, s, s);
  back.stroke(c);
  back.point(x, y);
  PImage new_back_crop = back.get(x-s/2, y-s/2, s, s);
  
  int local_err = calcError(imag_crop,prev_back_crop);
  int new_err = calcError(imag_crop,new_back_crop);
  if (local_err > new_err){
    to_process.get(j).add(new int[]{x+1,y});
    to_process.get(j).add(new int[]{x-1,y});
    to_process.get(j).add(new int[]{x,y+1});
    to_process.get(j).add(new int[]{x,y-1});
  } else {
    back.image(prev_back_crop, x-s/2, y-s/2);
  }
  }
}
void process_pixel_print(int x, int y, color c, int j){
  if (x<0 || x>width || y<0 || y>height){return;}
  else{
  color c1 = back.get(x, y);
  color c2 = img.get(x, y);
  int local_err = (int)getStat(c1,c2);
  int new_err = (int)getStat(c, c2);
  println(local_err, " | ", new_err);
  if (local_err > new_err){
    back.stroke(c);
    back.point(x, y);
    to_process.get(j).add(new int[]{x+1,y});
    to_process.get(j).add(new int[]{x-1,y});
    to_process.get(j).add(new int[]{x,y+1});
    to_process.get(j).add(new int[]{x,y-1});
  }
  }
}

void draw_(){
  //println("---");
  //int a = (to_process.get(to_process.size()-1).size());
  //println(a);
  back.beginDraw();
  
  
  for (int i=0; i<to_process.size();i++){
    ArrayList<int[]> flaq = to_process.get(i);
    color c = color(colores.get(i));
    int mxj = flaq.size();
    for (int j=0; j< mxj; j++){
      int[] p = flaq.get(0);
      process_pixel(p[0], p[1], c, i);
      flaq.remove(0);
    }
  }
  //a = (to_process.get(to_process.size()-1).size());
  //println(a);
  back.endDraw();
  
  //image(back,0,0,width,height);

}

void find_flaq(){
  int fx, fy, fc;
  fc = fx = fy =0;
  
  for (int i=0; i<10; i++){
    int x = (int)random(width);
    int y = (int)random(height);
    color c = back.get(x, y);
    color c2 = img.get(x, y);
    int cf = (int)getStat(c, c2);
    println(cf);
    if (cf > fc){
      fc = cf;
      fx = x;
      fy = y;
    }
  
  }
  new_flaq(fx, fy);

}

void mousePressed(){
  if (mouseButton == LEFT){
    find_flaq();
    //print(mouseX, mouseY);
    //new_flaq(int(mouseX), int(mouseY));
  }

  if (mouseButton == RIGHT){
    println(back.get(int(mouseX), int(mouseY)));
  }
}


void keyPressed(){
  if (keyCode==32){
    new_flaq();
  }
}
