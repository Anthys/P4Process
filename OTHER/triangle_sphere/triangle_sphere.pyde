def setup():
    size(1000,1000,P2D)
    global msk,sh
    #msk = create_triangle_mask()
    sh = loadShader("frag.glsl")
    msk = create_triangle_center(c = PVector(width/2, height/2),s=400, rot=-PI/2)
    #msk_inv = invert_color(msk)
    circl = circles_everywhere(n=500, rs0=20,rs1=100)
    circl.mask(msk)
    
    
    image(circl,0,0)
    saveFrame("out.png")

def invert_color(img):
    out = createImage(img.width, img.height,RGB)
    for i in range(len(img.pixels)):
        c = img.pixels[i]
        r = red(c)
        g = green(c)
        b = blue(c)
        out.pixels[i] = color(255-r, 255-g, 255-b)
    return out

def is_inside_triangle(p, t1,t2,t3):
    a = area_triangle(t1,t2,t3)
    b = area_triangle(t1,t2,p)
    c = area_triangle(t3,t2,p)
    d = area_triangle(t1,t3,p)
    return a == b+c+d
    
def area_triangle(p1,p2,p3):
    a = abs( (p2.x-p1.x)*(p3.y-p1.y) - (p3.x-p1.x)*(p2.y-p1.y))
    return a

def create_triangle_center(c=None, s=None,rot=0):
    if c is None:
        c = PVector(width/2, height/2)
    if s is None:
        s = 20
    angles = [0,-2*PI/3,2*PI/3]
    points = []
    for i in range(3):
        a = c + PVector(cos(angles[i]+rot), sin(angles[i]+rot))*s
        points.append(a)
    print(points)
    return create_triangle_mask(points[0],points[1],points[2])

def create_triangle_mask(p1=None,p2=None,p3=None):
    if p1 is None:
        p1 = PVector(width/2, 0)
    if p2 is None:
        p2 = PVector(0, height)
    if p3 is None:
        p3 = PVector(width, height)
        
    out = createGraphics(width, height)
    out.beginDraw()
    out.fill(255);
    out.rect(-1,-1,width+1,1+ height)
    out.fill(0)
    out.triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y)
    out.endDraw()
    return out


import random as rnd

def circles_everywhere(n=100,x0=0,y0=0,x1=None,y1=None,rs0=0,rs1=40):
    palette = ["#2A4AE5","#DB2AE5","#EA8CF0","#E7E1E8", "#464A89"]
    if x1 == None:
        x1 = width
    if y1 == None:
        y1 = height
    out = createGraphics(width, height)
    out.beginDraw()
    out.fill(255);
    for i in range(n):
        randx = random(x0,x1)
        randy = random(y0,y1)
        p = PVector(randx, randy)
        strokeWeight(0)
        fill(palette[rnd.randint(0,len(palette)-1)])
        circle(p.x,p.y, random(rs0,rs1))
    out.endDraw()
    return out
        

def rand_circle_in_triangle():
    s = 150.
    a1 = 0.
    a2 = -PI*2./3
    a3 = PI*2./3
    middle = PVector(width/2, height/2)
    t1 = middle + PVector(cos(a1-PI/2),sin(a1-PI/2))*s
    t2 = middle + PVector(cos(a2-PI/2),sin(a2-PI/2))*s
    t3 = middle + PVector(cos(a3-PI/2),sin(a3-PI/2))*s
    while True:
        randx = random(0,width)
        randy = random(0,height)
        p = PVector(randx, randy)
        if is_inside_triangle(p, t1,t2,t3):
            break
    circle(p.x,p.y, random(0,40))

def draw():
    pass
    
