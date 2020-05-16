def setup():
    global sh,im
    size(481,680,P2D)
    sh = loadShader("frag.glsl")
    im = loadImage("alpha.jpg")

def draw():
    sh.set("u_resolution", float(width), float(height));
    sh.set("u_mouse", float(mouseX), float(mouseY));
    sh.set("u_time", millis() / 1000.0);
    shader(sh)
    image(im,0,0);
