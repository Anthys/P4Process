def setup():
    size(500,500)
    n = 5
    s = sqrt(2*(n**2))
    for i in range(0,width,n):
        for j in range(0,height, n):
            randomline(i,j,s)
    
def draw():
    pass
    
def randomline(i,j,s):
    if random(0,1) < 0.5:
        line(i,j,i+s*cos(-PI/4), j+s*sin(-PI/4))
