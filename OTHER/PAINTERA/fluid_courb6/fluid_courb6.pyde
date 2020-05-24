## GOAL https://www.shvembldr.com/gallery/motion-generative/nox

def setup():
    size(500,500,P2D)
    global t,sh
    t = 0.
    init()
    sh = loadShader("sph.glsl")
    draw_()
    
def init():
    noiseSeed(int(random(0,1000)))


def draw_():
    global sh
    img = createGraphics(width, height)
    background(200)
    n = 3000
    translate(width/2, height/2)
    radius = 200
    for i in range(n):
        r = radius*random(0,1)
        a = random(0,1)*TWO_PI
        rx = r*cos(a)
        ry = r*sin(a)
        pos = PVector(rx,ry)
        uv = PVector(pos.x/height, pos.y/width)+PVector(1,1)
        varc = 10
        img.stroke(noise(uv.x*varc, varc*uv.y, 25)*255, 30,noise(uv.x*varc, varc*uv.y, 75)*255,200)
        img.fill(0,0)
        make_curve(img, rx,ry, l=90,n=5)
    sh.set("u_resolution", float(width), float(height))
    sh.set("u_time", float(t))
    sh.set("texture", img)
    shader(sh)
    image(img, -width/2,-height/2)

def mnoise(a,b,c=0):
    return noise(a,b,c)*2-1

def make_curve(img, x,y, l=90,n=2):
    pos = PVector(x,y)
    uv = PVector(x/width, y/height) 
    
    partial_l = float(l)/n
    img.beginDraw()
    img.translate(width/2, height/2)
    img.strokeWeight(5*noise(3*uv.x,3*uv.y))
    img.beginShape()
    img.curveVertex(pos.x, pos.y)
    img.curveVertex(pos.x, pos.y)
    for i in range(n):
        varx = 2*pos.x/width+1
        vary = 2*pos.y/height+1
        base_noise_x = 100+100*i
        base_noise_y = 150+100*i
        n_pos = pos + partial_l*PVector(mnoise(varx,vary, base_noise_x),mnoise(varx,vary, base_noise_y))
        img.curveVertex(n_pos.x, n_pos.y)
        pos = n_pos
    img.curveVertex(n_pos.x, n_pos.y)
    img.endShape()
    img.endDraw()


def draw():
    global t
    t += 1.
    #draw_()
    
def keyPressed():
    if key == "p":
        saveFrame("out-####.png")
    elif keyCode == 32:
        init()
        draw_()
