add_library('peasycam')
add_library("videoExport")
from peasy import PeasyCam

def setup():
    global t,numPoints, fract,poww,var1, video, michel, lastpow

    t=0.
    numPoints = 1000
    #fract = (1+sqrt(5))/2
    fract = 0.295
    poww = 0.5
    lastpow = [0.5,0.5]
    var1 = 300
    michel = False

    size(1000,1000,P3D)
    noSmooth()
    cam = PeasyCam(this, 0,0,0,700)
    cam.setMinimumDistance(50)
    cam.setMaximumDistance(1000)
    
    video = VideoExport(this)
    video.startMovie()

def process():
    global fract, poww,var1, michel, lastpow
    fract +=  1./1000000
    #poww -= t/1000000
    lastpow = [lastpow[1],poww]
    poww = oscille(2, 0, t)
    #poww = 1.
    #var1 += 1.
    if lastpow[1]<poww and lastpow[0]>lastpow[1]:
        print(1)
        michel = not michel
    
def oscille(a,b,delta,full_time = 1):
    middle = (a+b)/2
    distt = abs(b-a)/2
    return middle + cos(delta/100)*distt

def draw():
    global t, video
    gilbert = float(t)*PI/1000
    if michel:
        pass
        rotateY(PI+gilbert)
        #rotateX(-PI/8)
        #rotateZ(PI/2)
        rotateY(-PI/6)
        #rotateY(-PI/6)
        rotateX(-PI/8)
    else:
        rotateY(-PI/6+gilbert)
        #rotateY(-PI/6)
        rotateX(PI/8)
        #rotateZ(PI/2)
    t +=1
    time_3_D()
    video.saveFrame()
    
def time_3_D():
    background(204)
    
    process()
    #plotText(str(fract), width/2, 100, color(255,255,255))
    #plotText(str(poww), width/2, 120, color(255,255,255))
    for i in range(0,numPoints):
        i= float(i)
        tt = pow(i/(numPoints-1.), poww)
        inclination = acos(1-2*tt)
        azimuth = 2*PI*fract*i
        x = var1*sin(inclination)*cos(azimuth)
        y = var1*sin(inclination)*sin(azimuth)
        z = var1*cos(inclination)
        #print(x,y,z)
        plotPoint3(x,y,z)
    #stroke(0,0,0)
    #point(0,0,0)

def keyPressed():
    if key == "q":
        video.endMovie()
        exit()


def plotPoint(x,y,col=color(0,0,0)):
    x0,y0 = width/2, height/2
    stroke(col)
    strokeWeight(5)
    point(x+x0,y+y0)

def plotPoint3(x,y,z,col=color(0,0,0)):
    x0,y0,z0 = width/2, height/2,z
    stroke(col)
    strokeWeight(5)
    point(x,y,z0)


def plotText(txt,x,y,col):
    stroke(col)
    strokeWeight(1)
    text(txt,x,y)
