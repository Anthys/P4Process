function setup() {
background(255);
createCanvas(windowWidth,windowHeight);  
}  

var PY, PX;
var x = [20];
var y = [20];
var segLength = 5;

for(var i=0; i<60; i++) {
    x[i]=1;
    y[i]=1;
}

function segment( x, y,  a) {
  strokeWeight(1);
  stroke(0, 0, 0,50);
  push();
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
  pop();
};

function dragSegment( i,  xin,  yin) {
  var dx = xin - x[i];
  var dy = yin - y[i];
  var angle = atan2(dy, dx);  
  x[i] = xin - cos(angle) * segLength;
  y[i] = yin - sin(angle) * segLength;
  segment(x[i], y[i], angle);
};

function draw() {
 PX=mouseX;
 PY=mouseY;
  dragSegment(0, PX, PY);
  for(var i=0; i<x.length-1; i++) {
    dragSegment(i+1, x[i], y[i]);
  }
};
