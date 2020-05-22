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
    
    
    """rs = random(0,40)
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
            elts = elts[:i]+elts[i+1:]"""
    n = 30
    palette = ["#fafa6e","#86d780","#23aa8f","#007882","#2a4858"]
    palette = palette[:-1]+ palette[::-1]
    for i in range(n):
        mx = max(width, height)+230
        part = mx/n
        s = mx - part*i+(t)%part -part
        #c = int(len(palette)*(i+t/part)/n)%len(palette)
        #c = hex_to_rgb(palette[c].upper())
        #c = color(c[0], c[1], c[2])
        c = int(255*(i+int(t/part))/n)%255
        c = color(c)
        fill(c)
        circle(width/2, height/2, s)
    
    speed = 1./50
    paperplane(width/2, height/2+100*sin(t*speed),30, rot=.5*cos(t*speed))
    t+=1.
    
    
    
    if video:
        vid.saveFrame()

def hex_to_rgb(value):
    value = value.lstrip('#')
    lv = len(value)
    return tuple(int(value[i:i + lv // 3], 16) for i in range(0, lv, lv // 3))

def keyPressed():
    if key == "q" and video:
        vid.endMovie()
        exit()