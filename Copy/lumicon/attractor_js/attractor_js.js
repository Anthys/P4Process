var BCOLOR;
var x1,x2,y1,y2;
var p1,p2,p3,p4;
var all_vars;
var t;
var cstep;
var formula;
var start_i;
var zoomz;

var hidden;

var cvs;

var show_hud;

var particles;
var back;


function setup() {
  pixelDensity(1);
  bcolor = color(0);
  cvs = createCanvas(windowWidth,windowHeight);
  cstep = 0;
  t = 0;
  formula = 0;
  var sq = 10;
  show_HUD = false;
  hidden = false;
  x1 = -2;
  x2 = 2;
  y1 = -2;
  y2 = 2;
  zoomz = .2;
  start_i = -1;

  if (sq != 0){
    x1 = y1= -sq;
    x2 = y2 = sq;
  }
  p1=-2;
  p2=2;
  p3=-2;
  p4=2;
  particles = [];
  init();
}

function init(){
  cstep = 0;
  all_vars = [];
  background(bcolor);
  for (let i=0;i<15;i++){
    all_vars.push(random(-1,1));
  }
  
  all_vars[0] = -1.25;
  all_vars[1] = -1.25;
  all_vars[2] = -1.82;
  all_vars[3] = -1.91;
  ini_part();
  ini_ar();
  particles[0] = createVector(0,0);
  modePoints = 1;
}

function ini_part(){
  particles = [];
  var n = 1000;
  //background(200);
  for (let i = 0; i < n; i++){
    particles.push(createVector(random(x1,x2) ,random(y1,y2)));
  }
}

function ini_ar(){
  
  back = [];
  for (let i=0;i<width; i++){
    back[i] = [];
    for (let j=0;j<height;j++){
      back[i][j] = 0;
    }
  }

}

function draw() {
  t = float(frameCount)/10;
  if (show_hud){
    HUD();
  }else{
    if (cstep == 0){
      draw_1();
    }
    if (cstep == 1){
      draw_2();
    }
    tertio();
  }
}

function draw_2(){
  var mxx = 0.0;
  var mnn = 0.0;
  for (let i=0;i<width;i++){
    for (let j=0;j<height;j++){
      if (back[i][j] > mxx){
        mxx = back[i][j];
      }
      if (back[i][j] < mnn){
        mnn = back[i][j];
      }
    }
  }
  print(mxx, mnn);
  loadPixels();
  for (let i=0;i<width;i++){
    for (let j=0;j<height;j++){
      var val = float(map(float(back[i][j]), mnn,mxx,0,1));
      val = 1.0-val;
      val = pow(val,2.0);
      val = 1.0-val;
      var index = (i+j*width)*4;
      pixels[index+0] = val*255.0;
      pixels[index+1] = val*255.0;
      pixels[index+2] = val*255.0;
      pixels[index+3] = val*255.0;
    }
  }
  updatePixels();
}

function draw_1(){
  if (clear3 && frameCount%1==0){
    fill(bcolor, 1);
    rect(0,0,width, height);
  }
  
  fill(200,50);
  strokeWeight(1);
  var e = .01;
  
  var mj;
  var mi;
  switch (mode_points){
    case 0:
      mj = 1;
      mi = 1;
      start_i = -1;
      break;
    case 1:
      mj = 1;
      mi = 10;
      start_i = 5;
      break;
    case 2:
      mj = 1;
      mi = 1;
      start_i = -1;
      break;
  }
  
  for (let j=0;j<mj;j++){
    (mode_points==1)?ini_part():{};
    for (let i=0;i<mi;i++){
      for (let k=0;k<particles.length;k++){
        var p = particles[k];
        stroke(255, 100);
        var x = p.x;
        var y = p.y;
        var xx, yy;
        switch (formula){
          case 2:
            xx = x;
            yy = y;
            break;
          case 1:
            xx = all_vars[0]+all_vars[1]*x+all_vars[2]*y+all_vars[3]*pow(abs(x), all_vars[4])+all_vars[5]*pow(abs(y), all_vars[6]);
            yy = all_vars[7]+all_vars[8]*x+all_vars[9]*y+all_vars[10]*pow(abs(x), all_vars[11])+all_vars[12]*pow(abs(y), all_vars[13]);
            break;
          case 0:
            xx = sin(all_vars[0]*y)+all_vars[2]*cos(all_vars[0]*x);
            yy = sin(all_vars[1]*x)+all_vars[3]*cos(all_vars[1]*y);
            break;
          case 3:
            var tn = 0.4-float(6)/(1.0+x*x+y*y);
            xx = 1.0+all_vars[0]*(x*cos(tn)-y*sin(tn));
            yy = all_vars[0]*(x*sin(tn)+y*cos(tn));
            break;
           case 4:
            xx = sin(all_vars[0]*y)-cos(all_vars[1]*x);
            yy = sin(all_vars[2]*x)-cos(all_vars[3]*y);
        }
        if (mode_points==2){
        x = lerp(x,xx,e) ;
        y = lerp(y,yy, e);
        }else{
        x = xx;//lerp(x,xx,e) ;
        y = yy;//lerp(y,yy, e);
        }
        p.x = x;
        p.y = y;
        if (i>start_i){
          xx = map(x, (x1+p1)*zoomz, (x2+p2)*zoomz, 0, width);
          yy = map(y, (y1+p3)*zoomz, (y2+p4)*zoomz, 0, height);
          point(xx,yy);
          if (inside(xx,yy)){
            back[int(xx)][int(yy)] += 1;
          }
        }
      }
    }
  }
}

function inside( x, y){
  return (x>=0 && x<width && y>0 && y<height);

}

function HUD(){
  fill(100);
  rect(0,0,width, height);
  noStroke();
  textSize(25);
  fill(10);
  text("Formula:\n  Clifford :\n  Power attractor:\n  x=x,y=y:\n  Ikeda attractor:\n  Peter de Jong:\n", 10,40);
  text("\n  A\n  Z\n  E\n  R\n  T\n", 230,40);
  
  text("CLEAR BACKGROUND:\n\nCLEAR BACKGROUND+ARRAY:\n\nHELP:", 10,260);
  text("C\n\nX\n\nH", 400,260);
  
  stroke(0);
  line(470,0,470,height);
  noStroke();
  
  text("MODE POINTS:\n  - one iteration, no clear (for ikeda)\n  - 10 iterations, last 5 points, clear\n  - 1 iteration, no clear, lerp points", 500,40);
  text("\n\n m to iterate", 950,40);
  
  text("COMBINATION (mapped to mouseX and mouseY):\n\n  A_1 and A_2\n  A_3 and A_4\n  A_5 and A_6\n  A_7 and A_8\n  A_9 and A_10\n  A_11 and A_12\n  A_13 and A_14", 500,250);
  text("\n\n1\n2\n3\n4\n5\n6\n7", 750,250);
  textSize(10);
}

function tertio(){
  if (mouseIsPressed){
  if (mouseButton == CENTER){ 
  var amp = 5;
  p1=map(mouseX, 0, width, -amp, amp);
  p2=map(mouseX, 0, width, -amp, amp);
  p3=map(mouseY, 0, height, -amp, amp);
  p4=map(mouseY, 0, height, -amp, amp);
  }
  if (mouseButton == LEFT){
    all_vars[cur_set*2]=map(mouseX, 0, width, -3, 3);
    all_vars[cur_set*2+1]=map(mouseY, 0, height, -3, 3);
  }
  if (mouseButton == RIGHT) {
    a3 = map(mouseX, 0, width, -3, 3);
    a4 = map(mouseY, 0, height, -3, 3);
  }
  }
}

function hide_and_show(){
  var element = document.getElementById("cool");
  if (hidden){
    cvs.show();
    element.style.display = "none";
  }else{
    cvs.hide();
    element.style.display = "inline";
  }
  hidden = !hidden;
  
}

function keyPressed(){
  
  if (key == 'h'){
    show_hud = !show_hud;
    
    background(bcolor);
  cstep= 0;
    ini_ar();
    ini_part();
  }
  
  if (keyCode == 32){
  init();
  hide_and_show();
}

if (key=='c'){
  
    background(bcolor);
  cstep= 0;
}

if (key=='x'){
  
    background(bcolor);
  cstep= 0;
    ini_ar();
    ini_part();
}
  var comb = ["1","2", "3", "4", "5", "6", "7"];
  var forms = ["a","z", "e", "r", "t", "y", "u"];
  for (let i=0;i<comb.length;i++){
    if (key==comb[i]){
      cur_set = int(i);
      noStroke();
      fill(100);
      rect(28,28,32,32);
      fill(230);
      text(comb[i], 40, 48);
    }
  }
  
  for (let i=0;i<forms.length;i++){
    if (key==forms[i]){
      formula = int(i);
      noStroke();
      fill(100);
      rect(28+34,28,32,32);
      fill(230);
      text(formula, 40+34, 48);
    }
  }
  if (key == 'n'){
    cstep = 1;
  }
  
  if (key=="m"){
    mode_points = (mode_points+1)%3;
    noStroke();
    fill(100);
    rect(28+34*2,28,32,32);
    fill(230);
    text(mode_points, 40+34*2, 48);
  }
  
  if (key == "b"){
    clear3 = !clear3;
  }
  
}

var cur_set = 0;
var mode_points = 1;
var clear3 = false;

function mouseWheel(event) {
  var streng = 100;
  if (keyIsDown(SHIFT)){
    streng = 10;
  }
  zoomz *= 1+event.delta/streng;
    noStroke();
    fill(100);
    rect(28+34*3,28,32,32);
    fill(230);
    text(int(100*zoomz), 40+34*3, 48);
}
