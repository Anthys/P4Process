def setup():
    global t
    size(500,500)
    background(200)
    #translate(width/2, height/2)
    #circ(0,0,200)
    t = 0.

def circ(x,y,s):
    r = s
    stroke(0)
    strokeWeight(1)
    for i in range(-r,r,10):
        j = sqrt(-i*i +r*r)
        line(-j,i,j,i)
    
    stroke(200)
    fill(200)
    strokeWeight(0)
    circle(0,0,r*1.5) 

def draw():
    global t
    background(200)
    t += 1.
    translate(width/2, height/2)
    circ(0,0,int(t%400))
    circ(0,0,int((t+150)%400))
    circ(0,0,int((t+300)%400))
    #fill(20)
    #strokeWeight(5)
    #circle(0,0,50)
