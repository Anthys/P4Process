def setup():
    size(1000,1000);
    draw_();

def draw():
    draw_()
    pass

def mnoise(x, y, t=0):
    return noise(x, y, t)*2-1

def rColor(i=0,j=0, t=0):
    c1 = color(random(255), 100, 200)
    c1 = color(random(255), 0, 100)
    c1 = color(noise(i+100,j+100+t)*255, 0, 100)
    c2 = color(255)
    c3 = lerpColor(c1, c2, noise(i*100+100, j*100+100))
    return c3

def draw_():
    
    cvs = createGraphics(width, height)
    cvs.beginDraw();
    
    t = float(frameCount)/10
    #t = 0
    cvs.background(0);
    nx = 15#int(random(7,20))
    ny = nx
    res = 5;
    intensity = 50*2;
    partx = float(width)/nx
    party = float(height)/ny
    cvs.noStroke();
    for i in range(0,nx):
        for j in range(0,ny):
            cvs.fill(noise(i*10, j*10)*255);
            cvs.fill(rColor(i,j, t))
            p1 = PVector(i*partx, j*party)
            p2 = PVector(i*partx, (j+1)*party)
            p3 = PVector((i+1)*partx, (j+1)*party)
            p4 = PVector((i+1)*partx, (j)*party)
            ps = [p1,p2,p3,p4]
            for k,p in enumerate(ps):
                x = p.x/width*res
                y = p.y/height*res
                ps[k].x += mnoise(x, y, t*0)*intensity
                ps[k].y += mnoise(x+100, y+100, t*0)*intensity
                
            p1,p2,p3,p4 = ps
            
            if i==0:
                p1.x = 0
                p2.x = 0
            if j==0:
                p1.y = 0
                p4.y = 0
            if i==nx-1:
                p3.x = width
                p4.x = width
            if j==ny-1:
                p2.y = height
                p3.y = height
            
            cvs.beginShape()
            cvs.vertex(p1.x, p1.y)
            cvs.vertex(p2.x, p2.y)
            cvs.vertex(p3.x, p3.y)
            cvs.endShape(CLOSE);
            
            #fill(noise(i*10+10, 10+j*10)*255);
            
            cvs.fill(rColor(i+.5, j+.5, t))
            
            cvs.beginShape()
            cvs.vertex(p1.x, p1.y)
            cvs.vertex(p4.x, p4.y)
            cvs.vertex(p3.x, p3.y)
            cvs.endShape(CLOSE);
    
    cvs.endDraw()
    cvs2 = cvs.copy()
    
    msk = createGraphics(width, height)
    msk.beginDraw()
    msk.background(0)
    msk.fill(255)
    msk.circle(width/2, height/2, 600)
    msk.endDraw()
    cvs2.mask(msk)
    
    cvs.filter(BLUR, 5)
    
    image(cvs, 0,0)
    image(cvs2, 0,0)
    #filter(BLUR, 3)

def keyPressed():
    if keyCode == 32:
        noiseSeed(int(random(100)))
        draw_()
    if key=='s':
        saveFrame("out-####.png")
