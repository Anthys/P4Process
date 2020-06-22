var textTyped;
var text2Type;

function setup() {
  createCanvas(500,500);
  
  textTyped = "";
  text2Type = "";
  text2Type = "$ a + b = c$";
}


function draw() {
  background(200); 
  stroke(0);
  textSize(20);
  textAlign(CENTER);
  text(textTyped, width/2, height/2,  100, 100);
  
}

function keyTyped() {
  if (keyCode >= 32) {
    textTyped += key;
    loop();
  }
}
