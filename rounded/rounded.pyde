from point import Point

def setup():
    global points, translation, a,th
    a = 100
    translation = [width/2,height/2]
    #points = [Point(0,0),Point(a,0), Point(a,a), Point(0,a)]
    points = []
    th = "b"
    size(500,500)

def draw():
    global points
    background(200)
    translate(translation[0], translation[1])
    
    for i,p in enumerate(points):
        p.draw()
        textSize(20)
        text(i,p.x,p.y)
    
    fill(255,0,0)
    noFill()
    beginShape()
    if len(points)>=3:
        rounded_shape(points)
        if th == "a":
            points[-1] = Point(mouseX-translation[0], mouseY-translation[1])

def find_nearest_couple(x,y,points):
    ini_dist = dist(x,y,points[0].x,points[0].y)+dist(x,y,points[-1].x,points[-1].y)
    best_c = [-1,0,ini_dist]
    for i,p in enumerate(points):
        if i >=1:
            one = points[i-1]
            two = points[i]
            cur_dist = dist(x,y,one.x,one.y)+dist(x,y,two.x,two.y)
            if cur_dist < best_c[2]:
                best_c = [i-1,i,cur_dist]
    return best_c[0],best_c[1]
        
        
def rounded_shape(vertx):
    for i,p in enumerate(vertx):
        curveVertex(p.x,p.y)
    for i in range(3):
        p = vertx[i]
        curveVertex(p.x,p.y)
    endShape()
    
def mouseClicked():
    global points
    if th == "a":
        points += [Point(mouseX-translation[0],mouseY-translation[1])]
    elif th =="b":
        if len(points)<3:
           points += [Point(mouseX-translation[0],mouseY-translation[1])]
           return
        cp = find_nearest_couple(mouseX-translation[0],mouseY-translation[1],points)
        print(cp)
        a = points[:cp[0]+1] 
        a += [Point(mouseX-translation[0],mouseY-translation[1])] 
        a += points[cp[0]+1:]
        points = a
