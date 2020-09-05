/**
 * SteaMew.
 * apply vector field effect on photo image.
 * 
 * reference : https://generateme.wordpress.com/2016/04/24/drawing-vector-field/
 * run : processing-java --force --sketch=/path/to/SteaMew/ --run "image path"
 *
 * @author @deconbatch
 * @version 0.1
 * Processing 3.2.1
 * 2019.02.24
 */

/**
 * main
 */
void setup() {

  size(1080, 1080);
  colorMode(HSB, 360.0, 100.0, 100.0, 100.0);
  smooth();
  noLoop();
  noStroke();

}

void draw() {

  int caseWidth  = 50;
  int baseCanvas = width - caseWidth * 2;

  // I brought vector field parameters in class.
  VectorParams bp = new BackgroundParams();
  VectorParams ep = new EdgeParams();
  VectorParams rp = new RoughEdgeParams();
  VectorParams dp = new DetailEdgeParams();

  ImageLoader imgLoader = new ImageLoader(baseCanvas);
  PImage img = imgLoader.load();
    
  int edgeAry[][] = detectEdge(img);
    
  translate((width - img.width) / 2, (height - img.height) / 2);
  for (int imgCnt = 0; imgCnt < 3; ++imgCnt) {

    // draw vector field pattern with nice parameters.
    // I did not bring these common parameters in class. Am I doing right thing?
    float plotMult = 0.3 + 0.4 * imgCnt;
    float noiseDiv = 0.007;
    
    background(0.0, 0.0, 90.0, 100.0);
    drawVector(bp, plotMult, noiseDiv, img, edgeAry);
    drawVector(ep, plotMult, noiseDiv, img, edgeAry);
    drawVector(rp, plotMult, noiseDiv, img, edgeAry);
    drawVector(dp, plotMult, noiseDiv, img, edgeAry);

    saveFrame("frames/" + String.format("%04d", imgCnt + 1) + ".png");

  }

  exit();

}

/**
 * drawVector : draw vector field.
 * @param  _vp       : vector field parameters class.
 * @param  _plotMult : vector field shape parameter. field shape flow < curl
 * @param  _noiseDiv : vector field shape parameter. point location little effect < big effect
 * @param  _img      : origimal photo image.
 * @param  _edge     : detented edge information.
 */
private void drawVector(VectorParams _vp, float _plotMult, float _noiseDiv, PImage _img, int[][] _edge) {

  float plotMult   = _plotMult;
  float noiseDiv   = _noiseDiv;

  int   plotCntMax = _vp.plotCntMax();
  int   initDiv    = _vp.initDiv();
  float plotDiv    = _vp.plotDiv();
  float baseSiz    = _vp.baseSiz();

  // draw vector field
  for (int xInit = 0; xInit < _img.width; xInit += initDiv) {
    for (int yInit = 0; yInit < _img.height; yInit += initDiv) {
      if (_vp.isTarget(_edge, xInit, yInit)) {

        color original = _img.pixels[yInit * _img.width + xInit];

        float xPoint = xInit * 1.0;
        float yPoint = yInit * 1.0;
        for (int plotCnt = 0; plotCnt < plotCntMax; ++plotCnt) {

          float plotRatio = map(plotCnt, 0, plotCntMax, 0.0, 1.0);
          float eHue      = _vp.hueVal(_img, xInit, yInit, floor(xPoint), floor(yPoint));
          float eSat      = saturation(original);
          float eBri      = brightness(original);
          float eAlp      = 100.0 * (1.0 - plotRatio);
          float eSiz      = pow(baseSiz * sin(PI * plotRatio), 2);

          float xPrev = xPoint;
          float yPrev = yPoint;
          xPoint += plotDiv * cos(TWO_PI * sin(TWO_PI * noise(xPrev * noiseDiv, yPrev * noiseDiv)) * plotMult);
          yPoint += plotDiv * sin(TWO_PI * cos(TWO_PI * noise(yPrev * noiseDiv, xPrev * noiseDiv)) * plotMult);

          fill(eHue % 360.0, eSat, eBri, eAlp);
          ellipse(xPoint, yPoint, eSiz, eSiz);

        }
      }
    }
  }
}

/**
 * detectEdge : detect edge of photo image.
 * @param  _img      : detect edge of thid image.
 * @return int[x][y] : 2 dimmension array. it holds 0 or 1, 1 = edge
 */
private int[][] detectEdge(PImage _img) {

  int edgeAry[][] = new int[_img.width][_img.height];
  for (int idxW = 0; idxW < _img.width; ++idxW) {  
    for (int idxH = 0; idxH < _img.height; ++idxH) {
      edgeAry[idxW][idxH] = 0;
    }
  }
    
  _img.loadPixels();
  for (int idxW = 1; idxW < _img.width - 1; ++idxW) {  
    for (int idxH = 1; idxH < _img.height - 1; ++idxH) {

      int pixIndex = idxH * _img.width + idxW;

      // saturation difference
      float satCenter = saturation(_img.pixels[pixIndex]);
      float satNorth  = saturation(_img.pixels[pixIndex - _img.width]);
      float satWest   = saturation(_img.pixels[pixIndex - 1]);
      float satEast   = saturation(_img.pixels[pixIndex + 1]);
      float satSouth  = saturation(_img.pixels[pixIndex + _img.width]);
      float lapSat = pow(
                         - satCenter * 4.0
                         + satNorth
                         + satWest
                         + satSouth
                         + satEast
                         , 2);

      // brightness difference
      float briCenter = brightness(_img.pixels[pixIndex]);
      float briNorth  = brightness(_img.pixels[pixIndex - _img.width]);
      float briWest   = brightness(_img.pixels[pixIndex - 1]);
      float briEast   = brightness(_img.pixels[pixIndex + 1]);
      float briSouth  = brightness(_img.pixels[pixIndex + _img.width]);
      float lapBri = pow(
                         - briCenter * 4.0
                         + briNorth
                         + briWest
                         + briSouth
                         + briEast
                         , 2);

      // hue difference
      float hueCenter = hue(_img.pixels[pixIndex]);
      float hueNorth  = hue(_img.pixels[pixIndex - _img.width]);
      float hueWest   = hue(_img.pixels[pixIndex - 1]);
      float hueEast   = hue(_img.pixels[pixIndex + 1]);
      float hueSouth  = hue(_img.pixels[pixIndex + _img.width]);
      float lapHue = pow(
                         - hueCenter * 4.0
                         + hueNorth
                         + hueWest
                         + hueSouth
                         + hueEast
                         , 2);

      // bright and saturation difference
      if (
          brightness(_img.pixels[pixIndex]) > 30.0
          && lapSat > 20.0
          ) edgeAry[idxW][idxH] = 1;

      // bright and some saturation and hue difference
      if (
          brightness(_img.pixels[pixIndex]) > 30.0
          && saturation(_img.pixels[pixIndex]) > 10.0
          && lapHue > 100.0
          ) edgeAry[idxW][idxH] = 1;

      // just brightness difference
      if (lapBri > 100.0) edgeAry[idxW][idxH] = 1;

    }
  }

  return edgeAry;
}

/**
 * ImageLoader : load and resize image
 */
public class ImageLoader {

  PImage imgInit;
  String imgPass;

  ImageLoader(int baseCanvas) {

    if (args == null) {
      // you can use your photo in ./data/your_image.jpg
      imgPass = "h.png";
    } else {
      // args[0] must be image path
      imgPass = args[0];
    }    
    imgInit = loadImage(imgPass);
      
    float rateSize = baseCanvas * 1.0 / max(imgInit.width, imgInit.height);
    imgInit.resize(floor(imgInit.width * rateSize), floor(imgInit.height * rateSize));

    println(int(imgInit.width)); // Image width
    println(int(imgInit.height)); // Image height

  }

  /**
   * load : return loaded image
   */
  public PImage load() {
    return imgInit;
  }

}

/**
 * VectorParams : holding vector field parameters.
 */
interface VectorParams {

  /**
   * isTarget : is this point(x, y) drawing target?
   * @return true : draw target
   */
  Boolean isTarget(int _points[][], int _x, int _y);

  /**
   * hueVal : returns which color, Init point or Pass point?
   * I think this is not a smart way.
   * @return img point hue value
   */
  float hueVal(PImage _img, int _xInit, int _yInit, int _xPass, int _yPass);

  /**
   * just returns parameter value
   */
  int   plotCntMax();
  int   initDiv();
  float plotDiv();
  float baseSiz();

}

public class BackgroundParams implements VectorParams {
  
  public Boolean isTarget(int _points[][], int _x, int _y) {
    // every point
    return true;
  }
  
  public float hueVal(PImage _img, int _xInit, int _yInit, int _xPass, int _yPass) {
    // returns Pass point hue value = original image hue
    // it makes strange color effect, because draw with NOT original saturation and brightness.
    int xCol = floor(constrain(_xPass, 0, _img.width - 1));
    int yCol = floor(constrain(_yPass, 0, _img.height - 1));
    return hue(_img.pixels[yCol * _img.width + xCol]);
  }
  
  public int plotCntMax() {
    return 300;
  }
  
  public int initDiv() {
    return 5;
  }
  
  public float plotDiv() {
    return 1.0;
  }
  
  public float baseSiz() {
    return 2.0;
  }

}

public class EdgeParams implements VectorParams {

  public Boolean isTarget(int _points[][], int _x, int _y) {
    // only edge is target
    if (_points[_x][_y] == 1) {
      return true;
    }
    return false;
  }
  
  public float hueVal(PImage _img, int _xInit, int _yInit, int _xPass, int _yPass) {
    // returns Init point hue value = hue of vector field drawing start point
    // it makes same color in each vector field line.
    int xCol = floor(constrain(_xInit, 0, _img.width - 1));
    int yCol = floor(constrain(_yInit, 0, _img.height - 1));
    return hue(_img.pixels[yCol * _img.width + xCol]);
  }

  public int plotCntMax() {
    return 100;
  }
  
  public int initDiv() {
    return 2;
  }
  
  public float plotDiv() {
    return 1.0;
  }
  
  public float baseSiz() {
    return 1.5;
  }
  
}

public class RoughEdgeParams extends EdgeParams {

  public int plotCntMax() {
    return 40;
  }
  
  public int initDiv() {
    return 1;
  }
  
  public float baseSiz() {
    return 1.0;
  }
  
}

public class DetailEdgeParams extends EdgeParams {

  public int plotCntMax() {
    return 20;
  }
  
  public int initDiv() {
    return 1;
  }
  
  public float baseSiz() {
    return 1.2;
  }
  
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
