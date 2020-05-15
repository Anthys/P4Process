size(1000,800)
background(0,0,0)

stroke(200,200,200)
stroke(0,0,0)

translate(width/2,height/2)

def norm(x,y):
    return sqrt(x**2+y**2)

def get_col(x,y):
    theta = atan2(y,x)
    x,y = x/100,y/100
    return  [(1-noise((theta+PI/3)%(2*PI)-PI))*255,(1-noise(theta))*255,noise(theta)*255]

for x in range(-width/2,width/2,4):
    for y in range(-height/2,height/2,4):
        x,y = float(x),float(y)
        col = get_col(x,y)
        fill(*col)
        rect(x,y,4,4)
