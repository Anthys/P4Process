## GOAL https://www.shvembldr.com/gallery/motion-generative/nox

def setup():
    size(500,500)
    init()
    
def init():
    noiseSeed(int(random(0,1000)))
    background(200)
    n = 1000
    translate(width/2, height/2)
    radius = 200
    for i in range(n):
        r = random(0,radius)
        a = random(0,TWO_PI)
        rx = r*cos(a)
        ry = r*sin(a)
        pos = PVector(rx,ry)
        uv = PVector(pos.x/height, pos.y/width)
        stroke(noise(uv.x*3, 3*uv.y, 25)*255, 30,noise(uv.x*3, 3*uv.y, 75)*255,200)
        fill(0,0)
        make_curve(rx,ry, l=90,n=3)


def make_curve(x,y, l=90,n=2):
    pos = PVector(x,y)
    uv = PVector(x/width, y/height) 
    
    partial_l = float(l)/n
    strokeWeight(5*noise(3*uv.x,3*uv.y))
    
    beginShape()
    curveVertex(pos.x, pos.y)
    curveVertex(pos.x, pos.y)
    for i in range(n):
        varx = 2*pos.x/width
        vary = 2*pos.y/height
        base_noise_x = 100+100*i
        base_noise_y = 150+100*i
        n_pos = pos + partial_l*PVector(noise(varx,vary, base_noise_x),noise(varx,vary, base_noise_y))
        curveVertex(n_pos.x, n_pos.y)
        pos = n_pos
    curveVertex(n_pos.x, n_pos.y)
    endShape()
       


def draw():
    pass
    
def keyPressed():
    if key == "p":
        saveFrame("out-####.png")
    elif keyCode == 32:
        init()
