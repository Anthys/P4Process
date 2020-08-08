var myFont;
var ci = 0;
var ctime = 0;
var cback;
var d_x = 0;
var s_font = 100;
var racing = false;

function preload() {
  myFont = loadFont('NotoSansJP-Regular.otf');
}

function setup() {
  cback = color(200);
  pixelDensity(3);
  createCanvas(windowWidth,windowHeight);
  textFont(myFont);
  init();
}

function init(){
  for (let i = 0; i<25; i++){
    let letter = alphabet[i];
    dic_widths[letter] = (real_width(letter));
  }
}

var dic_widths = {};

var alphabet = "abcdefghijklmnopqrstuvwxyz,.ABCDEFGHIJKLMNOPQRSTUVWXYZ";

var txt = "abcdefghijklmnopqrstuvwxyz";

function draw_text(txt, dx = 0){
  var letter_length = 60;
  for (let i = 0; i<txt.length; i++){
    if (i<ci){
      fill(150);
    }else{
      fill(0);
    }
    let letter = txt[i];
    letter_length = dic_widths[letter];
    text(txt[i], dx, height/2);
    dx += letter_length;
  }
}

function real_width(txt, s = 0){
  if (s ==0){
    s = s_font;
  }
  textFont(myFont);
  textSize(s);
  return textWidth(txt);
}

function millis_to_timea(a){
  return "a";
}

function millis_to_time(mls){
  let seconds = int(mls/60);
  let millis = mls%60;
  seconds = str(seconds);
  millis = str(millis);
  if (millis.length <2){
    millis = "0"+millis;
  }
  let timetxt = seconds+":"+millis;
  return timetxt;
  
}

function print_time(x, y){
  var timetxt = millis_to_time(ctime);
  text(str(timetxt), x,y);
}

function draw() {
  background(cback);
  print_time(0,300);
  //text(txt, 0, height/2);
  var sx = width/4;
  line(sx, 0, sx, height);
  textSize(s_font);
  draw_text(txt, sx + d_x);
  if (ci>= txt.length){
    racing = false;
    var ggmsg = "gg le sang";
    var rw = real_width(ggmsg, 30)/2;
    textSize(30);
    text(ggmsg, width/2-rw, height/2);
  }
  if (racing){
    ctime += 1;
  }
}

function print_leaderboard(lead_name = "leaderboard"){
  var lead = getItem(lead_name);
   if (lead == null){
     lead = new Array(15).fill(0);
     storeItem(lead_name, lead);
   }
   for (let i = 0; i<lead.length; i++){
     let txt = millis_to_time(lead[i]);
     print(txt, width/2-realWidth(txt), i*80+40);
   }
}

function actualize_leaderboard(new_t, lead_name = "leaderboard"){
   var lead = getItem(lead_name);
   if (lead == null){
     lead = new Array(15).fill(0);
     lead[1] = new_t;
     storeItem(lead_name, lead);
   }
   else{
     for (let i = lead.length-1;i>=0;i--){
       if (new_t <= lead[i] || lead[i] == 0){
         // Found a better place
         if (i< lead.length-1){
           // if not at the end
           for (let j = i+1; j< lead.length;j++){
             // Move all the other records
             lead[j] = lead[j-1];
           }
         }
         lead[i] = new_t;
         break;
       }
     }
   }
}

function reset(){
  ci = 0;
  ctime = 0;
  racing = false;
  d_x = 0;
}

function keyPressed(){
  if (key == txt[ci]){
    racing = true;
    d_x -= textWidth(txt[ci]);
    ci++;
  }
  if (keyCode == ESCAPE){
    racing = false;
    reset();
  }
  
  if (keyCode == ENTER && !racing){
    reset();
  }
}
