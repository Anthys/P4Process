add_library("videoExport")
def setup():
    global videoExport, listAngles, video
    size(500,400)
    video = True
    if video:
        videoExport = VideoExport(this);
        videoExport.startMovie();
    n= 100
    listAngles = list_angles(100)
    
t = 0.

def draw():
    global t
    t += 1.
    background(151)
    radius1 = 90
    radius2 = 110
    translate(width/2, height/2)
    make_donut(radius1,radius2)    
    
    make_donut(30,50, 300)   

    if video:
        videoExport.saveFrame();

def make_donut(radius1,radius2, offset=0):
    diff = 50
    fill(0,0,0)
    beginShape()
    for a in listAngles:
        r2 = radius2+noise(cos(a)+1, sin(a)+1, t/50+offset)*70
        x= r2*cos(a)
        y = r2*sin(a)
        vertex(x,y)
    endShape(CLOSE)
    
    fill(151)
    beginShape()
    for a in listAngles:
        r1 =radius1+ noise(cos(a)+1, sin(a)+1, t/50+diff+offset)*50
        x= r1*cos(a)
        y = r1*sin(a)
        vertex(x,y)
    endShape(CLOSE)

def list_angles(n):
    fract = TWO_PI/n
    out = [fract*i for i in range(n)]
    return out

def keyPressed():
    if key =="q" and video:
        videoExport.endMovie()
        exit()
