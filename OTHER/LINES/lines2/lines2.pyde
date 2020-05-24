def setup():
    global t
    size(500,500)
    n = 30
    t = 0.
    s = sqrt(2*(n**2))
    translate(width/2, height/2)
    for i in range(0,width,n):
        for j in range(0,height, n):
            randomline(i-width/2,j-height/2,n)
    saveFrame("out.png")
def draw():
    global t
    t += 1.
    pass
    
def randomline(i,j,n):
    a = 0
    stroke(0)
    strokeWeight(1)
    stroke(0,0,200,100)
    if i*i+j*j<(width/3)**2:
        stroke(255,0,0,100) 
    if random(0,1) < 0.5:
        strokeWeight(15)
        line(i,j,i+n, j+n)
    else:
        strokeWeight(5)
        line(i+n,j,i, j+n)
