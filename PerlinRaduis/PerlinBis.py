def setup():
    size(1000,800)
    background(0,0,0)
    pass

t = 0.
numb_points = 40

def draw():
    global t,numb_points
    clear()
    t += 1.
    keeper = []
    the_list = linspace(0,2*PI,numb_points)
    temp = abs(sin(t/120))
    r = temp*width/5
    if temp <0.01:
        noiseSeed(int(random(0,100)))
        print(1)
    numb_points = 40 + int(abs(r)*2)//4
    #print(r)
    for i,theta in enumerate(the_list):
        #theta += t/20
        stroke(200,200,200)
        cx,cy = get_point(t,r,theta)
        point(cx,cy)
        if keeper:
            line(cx,cy,keeper[0],keeper[1])
        else:
            o1,o2 = get_point(t,r,the_list[-1])
            line(cx,cy,o1,o2)
        
        stroke(200,200,200,100)
        line(width/2,height/2,cx,cy)

        keeper = [cx,cy]
    #saveFrame("delta\out-####.png")

def get_point(t,r,theta):
    x,y = r*cos(theta)+width/2,r*sin(theta)+height/2
    r2 = r+r*noise(x/100,y/100)
    cx,cy = r2*cos(theta)+width/2,r2*sin(theta)+height/2
    col = [noise(x/100,y/100)*255,noise(x/100,y/100)*255,noise(x/100,y/100)*255]
    return cx,cy,col

def get_point2(t,r,theta):
    x,y = r*cos(theta)+width/2,r*sin(theta)+height/2
    r2 = r*noise(t/1000,theta)
    cx,cy = r2*cos(theta)+width/2,r2*sin(theta)+height/2
    return cx,cy

def linspace(start,endd,numb):
    out = [(endd-start)/numb*i+start for i in range(numb)]
    return out
    
