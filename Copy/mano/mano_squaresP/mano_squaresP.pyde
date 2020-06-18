def setup():
    size(500,500)
    draw_()


def draw_():
    ni = 5
    nj = 5
    fracti = width/ni
    fractj = height/nj
    for i in range(ni):
        for j in range(nj):
            px = fracti*i
            py = fractj*j
            motif(px, py, px+fracti, py+fractj)
                
def make_square(x1,y1,x2,y2, depth = 0):
    mx = (x2-x1)/2
    my = (y2-y1)/2
    motif(x1, y1, x1+mx, y1+my, depth+1)
    motif(x1+mx, y1, x2, y1+my, depth+1)
    motif(x1, y1+my, x1+mx, y2, depth+1)
    motif(x1+mx, y1+my, x2,y2, depth+1)
    

def motif(x1,y1,x2,y2, depth = 0):
    mx_depth = 1
    if depth < mx_depth and random(1)<.5:
        make_square(x1,y1,x2,y2, depth)
    else:
        my_motif(x1,y1,x2,y2)

def rcolor():
    return color(random(255), 100,200)

def rcolorn2(x,y):
    res = 3
    val = noise(float(x)/width*res, float(y)/height*res)
    return color(255*val, 100,200)


def rcolorn(x,y):
    res = 3
    val = noise(float(x)/width*res, float(y)/height*res)
    val = random(1)
    c1 = color(100, 100, 200)
    c2 = color(255)
    c3 = color(230,100,230)
    if val<.5:
        return lerpColor(c1,c2,val*2)
    else:
        return lerpColor(c2,c3,(val-.5)*2)

def rcolorn3(x,y):
    res = 3
    val = noise(float(x)/width*res, float(y)/height*res)
    c1 = color(255, 100, 200)
    c2 = color(255)
    return lerpColor(c1,c2,val)

def half_circle(x,y,sx,sy,rot=0):
    pushMatrix()
    r = rot*HALF_PI
    translate(x, y)
    pushMatrix()
    rotate(r)
    fill(rcolorn(x, y))
    rect(-sx/2, -sy/2, sx, sy)
    fill(rcolorn(width-x, y))
    arc(-sx/2, -sy/2, sx*2, sx*2, 0, HALF_PI, PIE);
    popMatrix()
    popMatrix()

def my_motif(x1,y1,x2,y2):
    sx = x2-x1
    sy = y2-y1
    mx = (x1+x2)/2
    my = (y1+y2)/2
    noStroke()
    fill(rcolorn(x1,y1))
    half_circle(mx,my,sx, sy, int(random(0,5)))

def my_motif4(x1,y1,x2,y2):
    sx = x2-x1
    sy = y2-y1
    mx = (x1+x2)/2
    my = (y1+y2)/2
    noStroke()
    fill(rcolorn(x1,y1))
    circle(mx,my,sx)

def my_motif3(x1,y1,x2,y2):
    sx = x2-x1
    sy = y2-y1
    mx = (x1+x2)/2
    my = (y1+y2)/2
    noStroke()
    fill(rcolor())
    circle(mx,my,sx)

def my_motif2(x1,y1,x2,y2):
    sx = x2-x1
    sy = y2-y1
    noStroke()
    fill(random(255))
    rect(x1,y1,sx,sy)

def keyPressed():
    if keyCode == 32:
        noiseSeed(int(random(100)))
        background(255)
        draw_()
    if key == "s":
        saveFrame("out-####.png")

def draw():
    pass
