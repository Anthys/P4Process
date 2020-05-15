import peasy.*;

import java.nio.IntBuffer;
PShader shader;
PShape sphere;
PeasyCam cam;
PShape cube;

void setup() {
  size(500,500,P3D);
  noStroke();

  shader = loadShader("fshade.glsl", "vshade.glsl");
  openCubeMap("px.png", "nx.png", "py.png", "ny.png", "pz.png", "nz.png");
  shader.set("cubemap", 1);

  sphere = createShape(SPHERE, 120);
  sphere.setFill(color(-1, 50));
  cam = new PeasyCam(this, 400);
}

void draw() {
  background(0);
  fill(color(255,0,0, 50));
  box(40);

  directionalLight(102, 102, 102, 0, 0, -1);
  lightSpecular(204, 204, 204);
  directionalLight(102, 102, 102, 0, 1, -1);
  specular(100, 150, 150);

  //translate(width / 2, height / 2);
  shader(shader);
  shape(sphere);
  resetShader();
}  

void openCubeMap(String posX, String negX, String posY, String negY, String posZ, String negZ) {

  PGL pgl = beginPGL();
  // create the OpenGL-based cubeMap
  IntBuffer envMapTextureID = IntBuffer.allocate(1);
  pgl.genTextures(1, envMapTextureID);
  pgl.activeTexture(PGL.TEXTURE1);
  pgl.enable(PGL.TEXTURE_CUBE_MAP);  
  pgl.bindTexture(PGL.TEXTURE_CUBE_MAP, envMapTextureID.get(0));
  pgl.texParameteri(PGL.TEXTURE_CUBE_MAP, PGL.TEXTURE_WRAP_S, PGL.CLAMP_TO_EDGE);
  pgl.texParameteri(PGL.TEXTURE_CUBE_MAP, PGL.TEXTURE_WRAP_T, PGL.CLAMP_TO_EDGE);
  pgl.texParameteri(PGL.TEXTURE_CUBE_MAP, PGL.TEXTURE_WRAP_R, PGL.CLAMP_TO_EDGE);
  pgl.texParameteri(PGL.TEXTURE_CUBE_MAP, PGL.TEXTURE_MIN_FILTER, PGL.LINEAR);
  pgl.texParameteri(PGL.TEXTURE_CUBE_MAP, PGL.TEXTURE_MAG_FILTER, PGL.LINEAR);

  //Load in textures
  String[] textureNames = { posX, negX, posY, negY, posZ, negZ };
  for (int i=0; i<textureNames.length; i++) {    
    PImage texture = loadImage(textureNames[i]);
    int w = texture.width;
    int h = texture.height;
    texture.loadPixels();
    pgl.texImage2D(PGL.TEXTURE_CUBE_MAP_POSITIVE_X + i, 0, PGL.RGBA, w, h, 0, PGL.RGBA, PGL.UNSIGNED_BYTE, IntBuffer.wrap(texture.pixels));
  }

  endPGL();
}
