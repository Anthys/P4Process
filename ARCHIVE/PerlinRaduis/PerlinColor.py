def setup():
    size(1000,800)
    background(0,0,0)
    pass

t = 0.
numb_points = 40
col = [100,100,100,200]
def draw():
    global t,numb_points,col
    clear()
    t += 1.
    keeper = []
    the_list = linspace(0,2*PI,numb_points)
    temp = abs(sin(t/120))
    r = temp*width/5
    if temp <0.01:
        noiseSeed(int(random(0,100)))
        col = [int(random(0,255)),random(0,255),random(0,255),200]
        print(1)
    numb_points = 40 + int(abs(r)*2)//4
    #print(r)
       
    
    for i,theta in enumerate(the_list):
        #theta += t/20
        
        cx,cy = get_point(t,r,theta)
        
        
        stroke(*col)
        strokeWeight(3)
        line(width/2,height/2,cx,cy)

        
        stroke(200,200,200)
        strokeWeight(10)
        point(cx,cy)
        if keeper:
            line(cx,cy,keeper[0],keeper[1])
        if i == len(the_list)-1:
            o1,o2 = get_point(t,r,the_list[0])
            line(cx,cy,o1,o2)
        
        keeper = [cx,cy]
        #col = get_col_t(t)
        #col += [200]
        #stroke(*col)
        
    #saveFrame("epsi\out-####.png")

def get_point(t,r,theta):
    x,y = r*cos(theta)+width/2,r*sin(theta)+height/2
    r2 = r+r*noise(x/100,y/100)
    cx,cy = r2*cos(theta)+width/2,r2*sin(theta)+height/2
    return cx,cy

def get_point2(t,r,theta):
    x,y = r*cos(theta)+width/2,r*sin(theta)+height/2
    r2 = r*noise(t/1000,theta)
    cx,cy = r2*cos(theta)+width/2,r2*sin(theta)+height/2
    return cx,cy

def linspace(start,endd,numb):
    out = [(endd-start)/numb*i+start for i in range(numb)]
    return out

def get_col(x,y):
    theta = atan2(y,x)
    x,y = x/100,y/100
    return  [(1-noise((theta+PI/3)%(2*PI)-PI))*255,(1-noise(theta))*255,noise(theta)*255]

    
