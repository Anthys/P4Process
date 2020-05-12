add_library("peasycam")

def setup():
    size(500,500,P3D)
    cam = PeasyCam(this, 400)

def draw_things():
    strokeWeight(10)
    point(0,0,0)
    point(100,100,100)
    point(0,100,0)
    point(0,100,100)
    beginShape()
    vertex(-100,-100,-100)
    vertex(-400,-100,-200)
    vertex(-400,-300,-300)
    vertex(-100,-300,-100)
    endShape(CLOSE)

def draw():
    background(200)
    draw_things()
    
