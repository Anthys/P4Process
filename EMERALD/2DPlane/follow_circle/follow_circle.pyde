add_library("videoExport")

import elements as elem

def setup():
    size(500,500,P2D)
    global video, vid, t, elts, sh, post
    sh = loadShader("loss.glsl")
    video = False
    post = PVector(width/2, height/2)
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
    for i in range(n):
        mx = max(width, height)+230
        part = mx/n
        s = mx - part*i+(t)%part -part
        #c = int(len(palette)*(i+t/part)/n)%len(palette)
        #c = hex_to_rgb(palette[c].upper())
        #c = color(c[0], c[1], c[2])
        c = int(255*(i+int(t/part))/n)%255
        c = int((len(palette)-1)*(i+int(t/part))/n)%(len(palette))
        c = hex_to_rgb(palette[c])
        c = color(c[0],c[1],c[2])
        #c = color(c)
        pg.fill(c)
        postx = posp.x #+ cos(t*speed-.2-s/80.)*100
        #posty = height-float(height/2+100*sin((t+10*(i+int(t/part)))*speed))
        posty = height-float(height/2+100*sin(t*speed-.2-s/80.) )
        pg.circle(postx, posty, s)
    pg.endDraw()
    sh.set("texture", pg)
    shader(sh)
    image(pg, 0,0)
    resetShader()
    paperplane(posp.x, height-posp.y,30, rot=.5*cos(t*speed))
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
