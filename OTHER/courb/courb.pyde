def setup():
    size(500,500,P2D)
    
    fill(0,0.)
    strokeWeight(10)
    #rounder3(width/2, height/2, 200, 100)
    #rounder3(50, height/2, 200, 100)
    mul()
    
    
def randcol():
    return color(random(0,255),random(0,255),random(0,255))

def mul(n=10):
    for i in range(n):
        contour(width/2+500, height/2+300, 1000, 400, cs= 15, rot=PI/6+random(-1,1), c2 = randcol())

def rounder4(x0,y0,sx,sy):
    p1 = x0-sx/4
    p2 = x0+sx/4
    
    p3 = y0-sy/2
    p4 = y0+sy/2

def contour(x0=0.,y0=0.,sx=50., sy=50., rot=PI/6,c1=color(0), c2=color(255), cs = 5):
    pushMatrix()
    translate(x0,y0)
    pushMatrix()
    rotate(rot)
    strokeWeight(0)
    fill(c1)
    rounder(0, 0, sx, sy)
    fill(c2)
    rounder(0, 0, sx-cs, sy-cs)
    popMatrix()
    popMatrix()
    

def rounder3(x0=0.,y0=0.,sx=50., sy=50., rot=PI/6):
    pushMatrix()
    translate(x0,y0)
    pushMatrix()
    rotate(rot)
    rounder(0, 0, sx, sy)
    popMatrix()
    popMatrix()

def rounder(x0=0.,y0=0., sx= 50, sy = 50):
    
    p1 = x0-sx/4
    p2 = x0+sx/4
    
    p3 = y0-sy/2
    p4 = y0+sy/2

    
    ellipse(p1,y0,sx/2,sy)
    beginShape()
    vertex(p1,p3)
    vertex(p1+sx/2,p3)
    vertex(p1+sx/2,p3+sy)
    vertex(p1,p3+sy)
    endShape(CLOSE)
    #rect(p1,p3,sx/2,sy)
    ellipse(p2,y0,sx/2, sy)

def rounder2(x0=0.,y0=0.,x1=None,y1=None):
    if x1 is None:
        x1 = width
    if y1 is None:
        y1 = height
    
    p1 = x0+ (x1-x0)/3
    p2 = x0 + 2.*(x1-x0)/3
    
    p3 = y0+(y1-y0)/2
    
    fill(0)
    strokeWeight(1)
    
    ellipse(p1,p3,(x1-x0)/3*2,(y1-y0))
    rect(p1,y0,(x1-x0)/3,(y1-y0))
    ellipse(p2,p3,(x1-x0)/3*2,(y1-y0))
    
def draw():
    pass
