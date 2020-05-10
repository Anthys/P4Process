function setup() {
  createCanvas(500,500);
  frameRate(fps);
}

var fps = 60;
var capturer = new CCapture({format: 'png',framerate: fps});

var t = 0;
const video = true;

const r = 200;
const r2 = 30;

function draw() {
  if (t===0 && video){
    capturer.start();
    t = 1;
  }
  
  background(200);
  strokeWeight(10);
  point(r*cos(t/100)+width/2, r*sin(t/100)+height/2);
  const x1 = r*cos((t+100)/50)+width/2;
  const y1 = r*sin((t+30)/50)+height/2;
  point(x1,y1);
  point(r2*cos(t/20)+x1, r2*sin(t/20)+y1);
  
  t += 1;
  
  if (video){
    capturer.capture(document.getElementById("defaultCanvas0"));
  }

}

function keyPressed() {
  if (keyCode === 32 && video) {
    noLoop();
    console.log("finished_recording");
    capturer.stop();
    capturer.save();
    return;
  }
}
