add_library("videoExport")

import elements as elem

def setup():
    size(500,500,P2D)
    global video, vid, t, elts, sh, post, n, counter, mx
    counter = 0
    sh = loadShader("loss.glsl")
    video = False
    post = PVector(width/2, height/2)
    t=0.
    elts = []
    n = 30
    for i in range(n):
        mx = max(width, height)+400
        part = mx/n
        elts += [elem.Circle(width/2, height/2, i*part)]
    
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

def lerp(a,b,t):
    return (1-t)*a + (t*b)

def pos_paper(t):
    return PVector(float(width/2), height-float(height/2+100*sin(t)))

def draw():
    global t, elts, sh
    
    speed = 1./50
    
    sh.set("u_resolution", float(width), float(height));
    sh.set("u_mouse", float(mouseX), float(mouseY));
    sh.set("u_time", millis() / 1000.0);
    posp = pos_paper(t*speed)
    sh.set("central", posp.x, posp.y)
    background(200)

    n = 30
    palette = ["#fafa6e","#86d780","#23aa8f","#007882","#2a4858"]
    palette = palette[1:-1]+ palette[::-1]
    
    pg = createGraphics(width, height)
    pg.beginDraw()
    pg.background(200);
    for i in range(len(elts)-1, -1,-1):
        v = elts[i]
        v.s += 1
        if v.s >= mx:
            elts = elts[:i]+elts[i+1:]
        pg.fill(v.c)
        posty = height-float(height/2+100*sin(t*speed-float(v.s)/100.))
        pg.circle(v.x, posty, v.s)
    if len(elts) <= n-1:
        c = palette[int(counter/3)%len(palette)]
        c1 = hex_to_rgb(c)
        c = color(c1[0],c1[1],c1[2])
        a = elem.Circle(width/2, height/2, 0, c)
        global counter
        elts = [a] + elts
        counter += 1
    pg.endDraw()
    sh.set("texture", pg)
    shader(sh)
    image(pg, 0,0)
    resetShader()
    paperplane(posp.x, height-posp.y,30, rot=.5*cos(t*speed))
    t+=1.
    
    
    
    if video and t > 300:
        vid.saveFrame()

def hex_to_rgb(value):
    value = value.lstrip('#')
    lv = len(value)
    return tuple(int(value[i:i + lv // 3], 16) for i in range(0, lv, lv // 3))

def keyPressed():
    if key == "q" and video:
        vid.endMovie()
        exit()
