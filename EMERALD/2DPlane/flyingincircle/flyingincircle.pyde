add_library("videoExport")

import elements as elem

def setup():
    size(500,500)
    global video, vid, t, elts
    video = False
    t=0.
    elts = []
    
    if video:
        vid = VideoExport(this)
        vid.startMovie()

def paperplane(x0=0,y0=0,s=200,rot=0):
    pushMatrix()
    translate(x0,y0)
    pushMatrix()
    rotate(rot)
    beginShape()
    fill(255)
    a = s/10
    vertex(-s/2, a)
    vertex(-s/2, -a)
    vertex(s/2,a)
    endShape(CLOSE)
    popMatrix()
    popMatrix()
    
def randcol():
    return color(random(0,255),random(0,255),random(0,255))

def draw():
    global t, elts
    background(200)
    
    
    rs = random(0,40)
    #rs = random(0,100)
    ry = random(0,height+rs)
    nel = elem.Circle(width+rs, ry, rs, randcol())
    ri = int(random(0, len(elts)-1))
    elts= elts[:ri] + [nel] + elts[ri:]
    
    for i in range(len(elts)-1, -1, -1):
        v = elts[i]
        v.draw()
        v.move(-1,0)
        if v.x <0-100:
            elts = elts[:i]+elts[i+1:]
    
    speed = 1./50
    paperplane(width/2, height/2+100*sin(t*speed),30, rot=.5*cos(t*speed))
    t+=1.
    
    
    
    if video and t > width:
        vid.saveFrame()


def keyPressed():
    if key == "q" and video:
        vid.endMovie()
        exit()
