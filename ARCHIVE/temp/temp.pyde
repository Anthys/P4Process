
def setup():
    size(1000,800)
    background(0,0,0)
    
    stroke(200,200,200)
    stroke(0,0,0)
    
    
t = 0.

dx = 10
dy = 10

sx = 10
sy = 10

def draw():
    global t
    clear()
    t += 1.
    translate(width/2,height/2)
    rect(0,0,5,5)
    rect(0,10,5,5)
    rect(10,0,5,5)
    

    for x in range(-width/2,width/2,dx):
        for y in range(-height/2,height/2,dy):
            x,y = float(x),float(y)
            theta = t/64
            theta = atan2(y,x)
            theta = theta + PI/2
            nm = norm(x,y)
            x,y = nm*cos(theta),nm*sin(theta)
            #x,y = x*cos(theta)+y*sin(theta), -x*sin(theta)+y*cos(theta)
            col = get_col(x,y)
            fill(*col)
            stroke(*col)
            rect(x,y,sx,sy)
    #saveFrame("alpha/out-####.png")
def norm(x,y):
        return sqrt(x**2+y**2)
    
def get_col(x,y):
    global t
    theta = atan2(y,x)
    tm = t/50
    x,y = x/100,y/100
    a = (1-noise((theta+PI/3)%(2*PI)-PI,tm))*255
    b = (1-noise(theta,tm))*255
    c = noise(theta,tm)*255
    return  [a,b,c]
    
def get_col2(x,y):
    theta = atan2(y,x)
    x,y = x/100,y/100
    a = (1-noise((theta+PI/3)%(2*PI)-PI))*255
    b = (1-noise(theta))*255
    c = noise(theta)*255
    return  [a,b,c]
    
