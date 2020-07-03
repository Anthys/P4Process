let palette = ["#FFD35C", "#FD4A8E", "#08A9E5", "#202020", "#ededed"];

function setup() {
  createCanvas(800, 800);
  noLoop();
}

function draw() {
  background(random(palette));
  let num = 30;
  for (let i = 0; i < num; i++) {
    let x = random(width);
    let y = random(height);
    let cc = int(random(2, 10));
    shuffle(palette, true);
    fill(palette[0]);
    noStroke();
    circle(x, y, 10);
    for (let j = 0; j < cc; j++) {
      form(x, y);
    }
  }
}

function form(x, y) {
  let num = 250;
  let step = 2;
  let a = random(TAU);
  let aStep = random() * 0.1 * (random() < 0.5 ? -1 : 1);
  let aAcc = random(1, 10) * 0.0006 * (random() < 0.5 ? -1 : 1);
  let rnd = random();
  let col1 = color(palette[0]);
  let col2 = color(palette[1]);

  noStroke();
  for (let i = 0; i < num; i++) {
    let s = map(sin(i * rnd * 0.01), -1, 1, 1, 5);
    fill(lerpColor(col1, col2, i / num));
    circle(x, y, s);
    x += step * sin(a);
    y += step * cos(a);
    a += aStep;
    aStep += aAcc;
  }
}
