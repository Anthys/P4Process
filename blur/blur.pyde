def setup():
    global ball_list
    size(640, 360, P2D)
    background(0,0,0)
    ball_list = list_ball(100)
    

def list_ball(n):
    ball_list = []
    for i in range(n):
        ball_list += [random_ball()]
    return ball_list

def random_ball():
    x = random(30,width-30)
    y = random(30,height-30)
    r = random(2,10)
    vx = random(-4,4)
    vy = random(-4,4)
    c1,c2,c3 = random(0,255),random(0,255),random(0,255)
    c = [c1,c2,c3]
    return Michel(x,y,vx,vy,r,c)

class Michel():
    def __init__(self,x,y,vx,vy,r,c):
        self.x = x
        self.y = y
        self.vx = vx
        self.vy = vy
        self.r = r
        self.c = c

i = 1

def draw():
    global i
    global ball_list
    i += 1
    if i%70 == 0:
        ball_list = list_ball(100)
    if i < 400:
        pass
        saveFrame("beta/out-####.png")
    for ball in ball_list:
        ball = update_rect(ball)
        draw_rect(ball)
    fill(0, 0, 0,5)
    rect(0,0,width,height)
    
def update_rect(obj):
    fr = 0.97
    if obj.x + obj.vx +obj.r> width:
        obj.vx *= -1
    if obj.x + obj.vx -obj.r < 0:
        obj.vx *= -1
    if obj.y + obj.vy +obj.r > height:
        obj.vy *= -1
    if obj.y + obj.vy -obj.r< 0:
        obj.vy *= -1
    obj.vx *=fr
    obj.vy *= fr
    obj.x += obj.vx
    obj.y += obj.vy
    return obj
    
def draw_rect(obj):
    r = obj.r
    mx = obj.x
    my = obj.y
    nx = lerp(obj.x,mx,.2)
    ny = lerp(obj.y,my,.2)
    obj.x = nx
    obj.y = ny
    c1,c2,c3 = obj.c[0],obj.c[1],obj.c[2]
    fill(c1,c2,c3)
    stroke(c1,c2,c3)
    circle(obj.x, obj.y, r)
