W,N=540,200
P=[[0,0]]*W
def setup():
    size(W,W,P3D)
    stroke(N,20)
    
def draw():
    clear()
    translate(W/2,W/2)
    [F(i)for i in range(W)]
    #saveFrame("frames/out-####.png")
    
def F(i):
    t=frameCount*.01
    x=sin(i+t)*cos(t)*N
    y=cos(i*i)*sin(i+t)*N
    P[i]=[x,y]
    [line(x,y,u,v)for u,v in P if dist(x,y,u,v)<20]
