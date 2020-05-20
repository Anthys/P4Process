import painter
def setup():
    global t, img, painters
    size(1280,1014)
    img = loadImage("nuit.jpg")
    painters = []
    init()

def better_color(rgb):
    return ((float(rgb)/255)-.5)*2.

def clamp(a,b,c):
    return max(min(b,c),a)

def clampPic(img, x, y):
    return PVector(clamp(0,x,img.width-1),clamp(0,y,img.height-1))

def pixelPic(img, p):
    return img.pixels[int(p.x+img.width*p.y)]

def find_gradient(img,x,y, col1=red, col2=blue):
    pn = pixelPic(img,clampPic(img, x,y-1))
    ps = pixelPic(img,clampPic(img, x,y+1))
    pw = pixelPic(img,clampPic(img, x-1,y))
    pe = pixelPic(img,clampPic(img, x+1,y))
    yy = col1(pn)-col1(ps)
    xx = col2(pw)-col2(pe)
    return PVector(xx,yy).normalize()*1

def init():
    global painters
    n = 5
    for i in range(n):
        x = random(0,width)
        y = random(0,height)
        painters.append(painter.Painter(x,y,0,0))

def draw():
    #background(200)
    #image(img,0,0)
    for ip in range(len(painters)-1,-1,-1):
        p = painters[ip]
        p.border(width, height)
        x = int(p.p.x)
        y = int(p.p.y)
        p.v += find_gradient(img, x, y)
        p.v *= 0.95
        p.update()
        p.border(width-1, height-1)
        p.draw()
        print(p.p)
        if False and p.t > 10 and p.v.mag()<.1:
            global painters
            painters = painters[:ip]+painters[ip+1:]+[painter.Painter(random(0,width),random(0,height),0,0)]
        
def keyPressed():
    if keyCode == 32:
        init()
