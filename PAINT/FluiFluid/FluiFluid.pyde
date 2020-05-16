def setup():
    global sh
    size(481,680,P2D)
    sh = loadShader("frag.glsl")#, "vert.glsl")

def draw():
    sh.set("u_resolution", float(width), float(height));
    sh.set("u_mouse", float(mouseX), float(mouseY));
    sh.set("u_time", millis() / 1000.0);
    shader(sh)
    rect(0,0,width,height);
