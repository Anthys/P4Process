## GOAL https://www.shvembldr.com/gallery/motion-generative/nox


## DIMINUEr la taille du tracé plus on avance dans le trait
def setup():
    size(500,500,P2D)
    global t,sh
    t = 0.
    init()
    sh = loadShader("sph.glsl")
    draw_()
    
def init():
    noiseSeed(int(random(0,1000)))


def get_x_y2(i, radius, n, poww=.5, fract=(1+sqrt(5))/2):
    #dst = var1*i/(numPoints-1)#pow(,poww)
    #dst = pow(i/(numPoints-1), 1)
    dst = radius*pow(i/(n-1.), poww)
    angle = 2*PI*fract*i
    x = dst*cos(angle)
    y = dst*sin(angle)
    return x, y


def get_x_y(i, radius):
    r = radius*random(0,1)
    a = random(0,1)*TWO_PI
    rx = r*cos(a)
    ry = r*sin(a)
    return rx, ry

def draw_():
    global sh
    img = createGraphics(width, height)
    background(200)
    n = 1000
    translate(width/2, height/2)
    radius = 200
    for i in range(n):
        #rx,ry = get_x_y2(i, radius, n)
        rx,ry = get_x_y(i,radius)
        pos = PVector(rx,ry)
        uv = PVector(pos.x/height, pos.y/width)+PVector(1,1)
        col = colpoint(pos.x, pos.y)
        img.fill(0,0)
        make_curve(img, rx,ry, l=90,n=5, col = col)
    sh.set("u_resolution", float(width), float(height))
    sh.set("u_time", float(t))
    sh.set("texture", img)
    #shader(sh)
    image(img, -width/2,-height/2)

def mnoise(a,b,c=0):
    return noise(a,b,c)*2-1

def colpoint(x,y):
    uv = PVector(x/width, y/height)+PVector(1,1)
    varc = 10
    col = color(noise(uv.x*varc, varc*uv.y, 25)*255, 30,noise(uv.x*varc, varc*uv.y, 75)*255,200)
    return col 

def make_curve(img, x,y, l=90,n=2, col=color(0,0,0,0)):
    pos = PVector(x,y)
    uv = PVector(x/width, y/height) 
    
    partial_l = float(l)/n
    
    s = 5*noise(3*uv.x,3*uv.y)
    
    img.beginDraw()
    img.translate(width/2, height/2)
    img.strokeWeight(s)
    img.stroke(col)
    img.beginShape()
    img.curveVertex(pos.x, pos.y)
    img.curveVertex(pos.x, pos.y)
    
    fract_s = s/n 
    
    for i in range(n):
        img.strokeWeight(i)
        varx = 2*pos.x/width+1
        vary = 2*pos.y/height+1
        base_noise_x = 100+1*i*.5
        base_noise_y = 150+1*i*.5
        n_pos = pos + partial_l*PVector(mnoise(varx,vary, base_noise_x),mnoise(varx,vary, base_noise_y))
        img.curveVertex(n_pos.x, n_pos.y)
        pos = n_pos
    img.curveVertex(n_pos.x, n_pos.y)
    img.endShape()
    img.strokeWeight(s+2)
    var1 = 20
    col2 = colpoint(n_pos.x+var1, n_pos.y+var1)
    img.stroke(col2)
    img.point(n_pos.x, n_pos.y)
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
