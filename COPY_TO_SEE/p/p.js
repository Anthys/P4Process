var lines = [];
var temp = [];

function setup() {
  var edge = 150 * pow(2, 0.5);
  var ll = 30;
  createCanvas(400 + edge + 2 * ll, 400 + edge + 2 * ll);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke(0);
  background(200, 80, 50);

  lines[0] = new NormalLine(200 + ll, 50 + ll, 200 + edge + ll, 50 + ll, 0);
  lines[1] = new NormalLine(200 + edge + ll, 50 + ll, 350 + edge + ll, 200 + ll, 0);
  lines[2] = new NormalLine(350 + edge + ll, 200 + ll, 
                            350 + edge + ll, 200 + edge + ll, 0);
  lines[3] = new NormalLine(350 + edge + ll, 200 + edge + ll, 
                            200 + edge + ll, 350 + edge + ll, 0);
  lines[4] = new NormalLine(200 + edge + ll, 350 + edge + ll, 
                            200 + ll, 350 + edge + ll, 0);
  lines[5] = new NormalLine(200 + ll, 350 + edge + ll, 50 + ll, 200 + edge + ll, 0);
  lines[6] = new NormalLine(50 + ll, 200 + edge + ll, 50 + ll, 200 + ll, 0);
  lines[7] = new NormalLine(50 + ll, 200 + ll, 200 + ll, 50 + ll, 0);
}

function mousePressed() {
    for(var i = 0; i < lines.length; i++) {
      if(lines[i].l > 3) {
        fill(map(lines[i].generation, 0, 9, 200, 180), 
            map(lines[i].generation, 0, 9, 80, 0), 
            map(lines[i].generation, 0, 5, 60, 100), 90);
        lines[i].generate();
      }
    }
    lines = [];
    for(var i = 0; i < temp.length; i++) {
      lines[i] = temp[i];
    }
    temp = [];
}

function NormalLine(x1, y1, x2, y2, generation) {
  var angle = atan2(y2 - y1, x2 - x1);
  this.l = dist(x1, y1, x2, y2);
  this.generation = generation;

  this.generate = function() {
    var x11 = x1;
    var x22 = 2 / 3 * x1 + 1 / 3 * x2;
    var x44 = 1 / 3 * x1 + 2 / 3 * x2;
    var x55 = x2;
    var y11 = y1;
    var y22 = 2 / 3 * y1 + 1 / 3 * y2;
    var y44 = 1 / 3 * y1 + 2 / 3 * y2;
    var y55 = y2;
    var x33 = x22 + this.l / 2 * cos(angle + PI / 1.2);
    var y33 = y22 + this.l / 2 * sin(angle + PI / 1.2);
    temp.push(new NormalLine(x11, y11, x22, y22, this.generation + 1));
    temp.push(new NormalLine(x22, y22, x33, y33, this.generation + 1));
    temp.push(new NormalLine(x33, y33, x44, y44, this.generation + 1));
    temp.push(new NormalLine(x44, y44, x55, y55, this.generation + 1));
    triangle(x22, y22, x33, y33, x44, y44);
  }
}
