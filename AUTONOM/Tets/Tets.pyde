import painter
def setup():
    global t, img, painters
    size(1280,1014)
    img = loadImage("nuit.jpg")
    painters = []
    init()

def better_color(rgb):
    return ((float(rgb)/255)-.5)*2.

def init():
    global painters
    n = 500
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
        p.v.x += better_color(blue(img.pixels[x+img.width*y]))/10
        p.v.y += better_color(green(img.pixels[x+img.width*y]))/10*2
        p.v *= 0.95
        p.update()
        p.border(width-1, height-1)
        p.draw()
        if p.t > 10 and p.v.mag()<.1:
            global painters
            painters = painters[:ip]+painters[ip+1:]+[painter.Painter(random(0,width),random(0,height),0,0)]
        
def keyPressed():
    if keyCode == 32:
        init()
