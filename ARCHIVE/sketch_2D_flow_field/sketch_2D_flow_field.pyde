inc = 0.1
scl = 10.
t=0.

particles = []
flowfield = []

from particle import *

def setup():
    global cols, rows, scl, particles,flowfield
    
    num_part = 1000
    res = 100
    
    
    size(900,500,P2D)
    #size(400,300, P2D)
    cols = floor(width / scl)
    rows = floor(height / scl)
    for i in range(num_part):
        particles.append(Particle())
    flowfield = [0]*(cols+1)*(rows+1)+[0]
    background(255)

true = True        

def draw():
    global t, particles,flowfield
    
    t+=1
    if True:
        yoff = 0
        for y in range(rows+1):
            xoff = 0
            for x in range(cols+1):
                index = x+y*cols
                #r = noise(xoff, yoff)*255
                angle = noise(xoff, yoff, t/100)*TWO_PI*4
                v = PVector.fromAngle(angle)
                v.setMag(1)
                flowfield[index] = v
                xoff += inc
                #fill(r)
                #rect(x*scl, y*scl, scl, scl)
                """
                stroke(0,50)
                strokeWeight(1)
                push()
                translate(x*scl,y*scl)
                rotate(v.heading())
                line(0,0,scl,0)
                pop()
                """
            yoff += inc
        global true
        true = False
    
    for p in particles:
        p.follow(flowfield,scl,cols)
        p.update()
        p.edges()
        p.show()
    if t%30 == 0:
        pass
        #saveFrame("framesD/out-####.png")
