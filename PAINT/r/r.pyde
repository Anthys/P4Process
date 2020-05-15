def setup():
    global sh,img
    size(481,680,P2D)
    sh = loadShader("frag.glsl")
    img = loadImage("alpha.jpg")

def draw():
    sh.set("u_resolution", float(width), float(height));
    sh.set("u_mouse", float(mouseX), float(mouseY));
    sh.set("u_time", millis() / 1000.0);
    shader(sh)
    image(img,0,0)
    #fill(255,0,0)
    #rect(0,0,width,height);
    #saveFrame("out/out-####.png")
