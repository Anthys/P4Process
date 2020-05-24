W,N=540,200
P=[[0,0,0]]*W

add_library("peasycam")

def setup():
    global cam,t
    t = 0.
    cam = PeasyCam(this,width/2, height/2,0,300)
    size(W,W,P3D)
    stroke(N,20)
    
def draw():
    global t
    t += 1.
    clear()
    ortho()
    background(230)
    stroke(50,0,150,50)
    translate(W/2,W/2)
    rotateY(PI/2)
    scale(2)
    [F(i)for i in range(W)]
    #saveFrame("frames/out-####.png")
    #print(cam.getRotations())
    #saveFrame("out-####.png")
    

def F(i):
    i= float(i)
    tt = pow(i/(W-1.), 1.)
    inclination = acos(1-2*tt)
    fract = (1.+sqrt(5))/2# + t/10000
    azimuth = 2*PI*fract*i
    var1 = 100
    x = var1*sin(inclination)*cos(azimuth)
    y = var1*sin(inclination)*sin(azimuth)
    z = var1*cos(inclination)
    P[int(i)]=[x,y,z]
    for u,v,w in P:
        screenx = screenX(x,y,z)
        screeny = screenY(x,y,z)
        screenu = screenX(u,v,w)
        screenv = screenY(u,v,w)
        if dist(screenx,screeny,screenu,screenv) < 30:
            line(x,y,z,u,v,w)

def F2(i):
    t=frameCount*.01
    x=sin(i+t)*cos(t)*N
    y=cos(i*i)*sin(i+t)*N
    P[i]=[x,y]
    [line(x,y,u,v)for u,v in P if dist(x,y,u,v)<20]
