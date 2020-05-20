import painter
add_library("peasycam")
def setup():
    global t, img, painters,cam, divide_n
    size(1280,1014,P3D)
    img = loadImage("nuit2.jpg")
    painters = []
    init()
    cam = PeasyCam(this, 300)

def better_color(rgb):
    return ((float(rgb)/255)-.5)*2.

def clamp(a,b,c):
    return max(min(b,c),a)

def clampPic(img, x, y):
    return PVector(clamp(0,x,img.width-1),clamp(0,y,img.height-1))

def pixelPic(img, p):
    return img.pixels[int(p.x+img.width*p.y)]

def find_gradient(img,x,y):
    pn = height_val(img,clampPic(img, x,y-1))
    ps = height_val(img,clampPic(img, x,y+1))
    pw = height_val(img,clampPic(img, x-1,y))
    pe = height_val(img,clampPic(img, x+1,y))
    yy = pn-ps
    xx = pw-pe
    return PVector(xx,yy)#.normalize()

def init():
    global painters
    n = 15
    for i in range(n):
        x = random(0,width)
        y = random(0,height)
        xx =random(-1,1)
        yy =random(-1,1)
        zz =random(-1,1)
        painters.append(painter.Painter(x,y,0,xx,yy,zz))

def lerp(a,b,t):
    return (1-t)*a + t*b

def height_val(img,x,y=None):
    if y == None:
        y = x.y
        x = x.x
    x = int(x/divide_n)*divide_n
    y = int(y/divide_n)*divide_n
    col = img.pixels[int(x+y*img.width)]
    col = 255-col
    col = red(col)/255*100
    col *= 5
    return col
    
def draw():
    global divide_n
    background(200)
    #image(img,0,0)
    strokeWeight(10)
    stroke(0)
    d = 100
    rotateX(0)
    #point(100,100,100)
    translate(-img.width/2, -img.height/2,0)
    divide_n = int(img.width*.01)
    n= divide_n
    draw_all = True
    if draw_all:
        for x in range(0,img.width,n):
            for y in range(0,img.height,n):
                col = height_val(img, x, y)
                point(x,y,col)
        image(img, 0,0)
    else:
        ortho(-width/2-d,width/2+d,-height/2-d,height/2+d)
    for ip in range(len(painters)-1,-1,-1):
        p = painters[ip]
        p.border(width, height)
        x = int(p.p.x)
        y = int(p.p.y)
        p.v += find_gradient(img, x, y)*10
        p.v *= 0.95
        col = height_val(img, x, y)
        p.p.z = lerp(p.p.z,col,.1)
        p.update()
        p.border(width-1, height-1)
        p.draw()
        print(p.p)
        if False and p.t > 10 and p.v.mag()<.1:
            global painters
            painters = painters[:ip]+painters[ip+1:]+[painter.Painter(random(0,width),random(0,height),0,0)]
        
def keyPressed():
    global painters
    if key == "a":
        p = painter.Painter(cam.position[0]+mouseX,cam.position[1]+mouseY,0,1.,0,0)
        p.c = color(0,255,0)
        painters += [p]
    if keyCode == 32:
        init()
