def setup():
    global t,numPoints, fract,poww,var1

    t=0.
    numPoints = 5000
    fract = (1+sqrt(5))/2
    #fract = 0.3
    poww = 0.5
    var1 = 300

    size(1000,1000)
    noSmooth()

def process():
    global fract, poww,var1
    fract +=  1./1000000
    #poww -= t/1000000
    poww = oscille(1, -1, t)
    #poww = 1.
    #var1 += 1.
    
def oscille(a,b,delta,full_time = 1):
    middle = (a+b)/2
    distt = abs(b-a)/2
    return middle + cos(delta/100)*distt

def draw():
    global t
    t +=1
    time_2_D()
    
def time_2_D():
    background(204)
    
    process()
    #plotText(str(fract), width/2, 100, color(255,255,255))
    #plotText(str(poww), width/2, 120, color(255,255,255))
    for i in range(0,numPoints):
        #dst = var1*i/(numPoints-1)#pow(,poww)
        #dst = pow(i/(numPoints-1), 1)
        dst = 300*pow(i/(numPoints-1.), poww)
        angle = 2*PI*fract*i
        x = dst*cos(angle)
        y = dst*sin(angle)
        plotPoint(x,y)
    #saveFrame("frames/yes-######.png")
    

def plotPoint(x,y,col=color(0,0,0)):
    x0,y0 = width/2, height/2
    stroke(col)
    strokeWeight(5)
    point(x+x0,y+y0)

def plotPoint3(x,y,z,col=color(0,0,0)):
    x0,y0,z0 = width/2, height/2,z
    stroke(col)
    strokeWeight(5)
    point(x+x0,y+y0,z0)


def plotText(txt,x,y,col):
    stroke(col)
    strokeWeight(1)
    text(txt,x,y)
