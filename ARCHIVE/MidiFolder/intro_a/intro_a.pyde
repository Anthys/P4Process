add_library('themidibus')
W=540
t=o=0
def setup():
    global m
    size(W,W)
    m=MidiBus(this,0,3)
    noFill()
    stroke(255)
    
def draw():
    global t
    clear()
    translate(W/2,W/2)
    t+=(o-t)*.1
    [circle(9,9,i*8)or rotate(t)for i in range(99)]
    
def noteOn(c,n,v):
    global o
    o=v/130.
