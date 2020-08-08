var myFont;
var ci = 0;
var ctime = 0;
var cback;
var d_x = 0;
var s_font = 100;
var racing = false;
var shown_superdiv = false;

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
  for (let i = 0; i<alphabet.length; i++){
    let letter = alphabet[i];
    dic_widths[letter] = (real_width(letter));
  }
}


function bclick(i){
  if (i==0){
    txt = "abcdefghijklmnopqrstuvwxyz";
  }
  if (i==1){
    var tx = "abcdefghijklmnopqrstuvwxyz";
    for (let j = 0; j<tx.length;j++){
      var k = int(random(0,tx.length));
      var tmp = tx[j];
      tx = replaceAt(tx, j, tx[k]);
      tx = replaceAt(tx, k, tmp);
    }
    print(tx);
    txt = tx;
  }
  if (i==2){
    txt = dic_text["olivier_full"].replace(/  +/g, ' ');
  }
  reset();

}

var dic_widths = {};

var alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,.é!'-0123456789? ";

var txt = "abcdefghijklmnopqrstuvwxyz";

var dic_text = {
  "olivier_small": "Bonjour, je suis Olivier de Carglass.",
  "olivier_full":
  "Bonjour, je suis Olivier de Carglass.\
  Vous pensez que cet impact est trop petit et que cela ne vaut pas le coup\
  de s'en occuper? Quand il fait chaud comme aujourd'hui, on met la clim! \
  Et voila l'impact n'a pas supporte le changement brutal de temperature..\
  Bien sur, si demain ça vous arrive, chez Carglass, on remplacera \
  votre pare brise mais vous risquez de payer une franchise!! Alors \
   que si vous appelez Carglass des que vous avez un impact, on vient \
   chez vous et on repare votre pare brise sans le remplacer, on injecte\
   notre resine speciale en 30 minutes le resultat est presque invisible,\
   et le pare brise retrouve sa solidite.En plus avec votre assurance bris-de-glace \
   le plus souvent chez Carglass la reparation, ça ne vous coute rien! Oui \
   vraiment, ça ne vous coute rien! Alors n'attendez plus, appelez nous\
   maintenant au 0 800 77 24 24 ou reservez sur Carglass.fr!"
}
   
//txt = "abc";

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
  if (frameCount == 1){
    //clear_leaderboard();
  }
  background(cback);
  print_time(0,300);
  //text(txt, 0, height/2);
  var sx = width/4;
  line(sx, 0, sx, height);
  textSize(s_font);
  draw_text(txt, sx + d_x);
  if (ci>= txt.length){
    if (racing){
      actualize_leaderboard(ctime);
      racing = false;
    }
    print_leaderboard();
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
   }else{
   }
   for (let i = 0; i<lead.length; i++){
     let tx = millis_to_time(lead[i]);
     if (lead[i] == 0){
       tx = "XXX";
     }
     tx = str(i+1)+" - " + tx;
     textSize(50);
     text(tx, 3*width/4-real_width(tx, 20), i*40+80);
   }
}
//
function clear_leaderboard(lead_name = "leaderboard"){
     var lead = new Array(15).fill(0);
     storeItem(lead_name, lead);  
}

function actualize_leaderboard(new_t, lead_name = "leaderboard"){
   var lead = getItem(lead_name);
   if (lead == null){
     lead = new Array(15).fill(1);
     lead[0] = new_t;
     storeItem(lead_name, lead);
   }
   else{
     for (let i = 0;i<lead.length;i++){
       if (new_t <= lead[i] || lead[i] == 0){
         // Found a better place
         if (i< lead.length-1){
           // if not at the end
           for (let j =lead.length-1; j>= i+1;j--){
             // Move all the other records
             lead[j] = lead[j-1];
           }
         }
         lead[i] = new_t;
         break;
       }
     }
     storeItem(lead_name, lead);
   }
}

function reset(){
  ci = 0;
  ctime = 0;
  racing = false;
  d_x = 0;
}

function replaceAt(tx, index, replacement) {
    return tx.substr(0, index) + replacement + tx.substr(index + replacement.length);
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
  
  if ( (keyCode == ENTER || keyCode == 32) && !racing){
    reset();
  }
  
  if (keyCode == 17){
    let superdiv = select("#superdiv");
    shown_superdiv = !shown_superdiv;
    if (shown_superdiv){
      superdiv.style('display', 'block');
    }else{
      superdiv.style('display', 'none');
    }
  }
}
