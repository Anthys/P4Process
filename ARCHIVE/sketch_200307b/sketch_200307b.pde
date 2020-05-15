/**
 * Brain Damage.
 * 
 * @author @deconbatch
 * @version 0.1
 * Processing 3.2.1
 * created 2019.08.18
 * an animation of Vector Field with perlin noise in angle.
 */

void setup() {

  size(720, 720);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  smooth();
  noStroke();
  noLoop();

}

void draw() {

  int   imgMax  = 3;
  int   plotMax = 1500;
  float plotDiv = 0.002;
  float initDiv = 0.03;
  float baseBri = 5.0;
  float baseSiz = 0.7;
  float initHue = random(360.0);

  translate(width * 0.5, height * 0.5);
  for (int imgCnt = 0; imgCnt < imgMax; imgCnt++) {
    
    float imgRatio = map(imgCnt, 0, imgMax, 0.0, 1.0);
    float baseHue  = initHue + imgRatio * 240.0;
    float noiseDiv = random(5.0, 8.0);
    
    background(baseHue, 5.0, 90.0, 100);
    blendMode(DIFFERENCE);

    // draw vector field
    for (float xInit = -0.5; xInit <= 0.5; xInit += initDiv) {
      for (float yInit = -0.5; yInit <= 0.5; yInit += initDiv) {
        float xPoint = xInit;
        float yPoint = yInit;
        for (int plotCnt = 0; plotCnt < plotMax; plotCnt++) {

          float plotRatio = map(plotCnt, 0, plotMax, 0.0, 1.0);
          float eHue      = baseHue + plotRatio * 60.0 + floor(((xInit * yInit) * 10000.0) % 4.0) * 10.0;
          float eSat      = map(sin(PI * plotRatio), 0.0, 1.0, 40.0, 80.0);
          float eBri      = baseBri * (1.0 + sin(PI * plotRatio));
          float eSiz      = baseSiz * (1.0 + sin(PI * plotRatio));

          float xPrev = xPoint;
          float yPrev = yPoint;
          // radius:xPrev,yPrev radian:xInit,yInit
          float radius = dist(0.0, 0.0, xPrev, yPrev);
          float pNoise = noise(
                               imgRatio * width + radius * cos(atan2(yInit, xInit)) * noiseDiv,
                               imgRatio * width + radius * sin(atan2(yInit, xInit)) * noiseDiv
                               ) * noiseDiv;
          xPoint += plotDiv * cos(TWO_PI * pNoise);
          yPoint += plotDiv * sin(TWO_PI * pNoise);

          fill(eHue % 360.0, eSat, eBri, 100.0);
          ellipse(xPoint * width * 0.5, yPoint * height * 0.5, eSiz, eSiz);

        }
      }
    }
      
    casing();
    // for slideshow animation
    for (int i = 0; i < 20; i++) {
      saveFrame( String.format("%02d", imgCnt) + String.format("%02d", i) + ".png");
    }

  }
  exit();
}

/**
 * casing : draw fancy casing
 */
private void casing() {

  blendMode(BLEND);
  fill(0.0, 0.0, 0.0, 0.0);
  strokeWeight(42.0);
  stroke(0.0, 0.0, 0.0, 100.0);
  rect(0.0, 0.0, width, height);
  strokeWeight(40.0);
  stroke(0.0, 0.0, 100.0, 100.0);
  rect(0.0, 0.0, width, height);
  noStroke();
  noFill();

}

/*
Copyright (C) 2019- deconbatch

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see 
*/
