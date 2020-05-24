W,N=540,200
P=[[0,0,0]]*W

add_library("peasycam")

def setup():
    global cam
    cam = PeasyCam(this,width/2, height/2,0,300)
    size(W,W,P3D)
    stroke(N,20)
    
def draw():
    clear()
    translate(W/2,W/2)
    [F(i)for i in range(W)]
    saveFrame("frames/out-####.png")
    

def F(i):
    i= float(i)
    tt = pow(i/(W-1.), 1.)
    inclination = acos(1-2*tt)
    fract = (1.+sqrt(5))/2
    azimuth = 2*PI*fract*i
    var1 = 100
    x = var1*sin(inclination)*cos(azimuth)
    y = var1*sin(inclination)*sin(azimuth)
    z = var1*cos(inclination)
    P[int(i)]=[x,y,z]
    [line(x,y,u,v)for u,v,w in P if dist(x,y,u,v)<20]

def F2(i):
    t=frameCount*.01
    x=sin(i+t)*cos(t)*N
    y=cos(i*i)*sin(i+t)*N
    P[i]=[x,y]
    [line(x,y,u,v)for u,v in P if dist(x,y,u,v)<20]
