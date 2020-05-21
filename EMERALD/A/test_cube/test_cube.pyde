add_library("peasycam")

def setup():
    global cube, cam, a
    size(500,500,P3D)
    cam = PeasyCam(this, 400)
    a = millis()
    cube = loadShape("monkey.obj")
    print(millis()-a)

def draw_things2():
    strokeWeight(10)
    point(0,0,0)
    point(100,100,100)
    point(0,100,0)
    point(0,100,100)
    beginShape()
    vertex(-100,-100,-100)
    vertex(-400,-100,-200)
    vertex(-400,-300,-300)
    vertex(-100,-300,-100)
    endShape(CLOSE)

def alternate_shape(s, x0=0,y0=0):
    fill(255)
    stroke(0)
    strokeWeight(0.1)
    for i in range(s.getChildCount()):
        f = s.getChild(i)
        beginShape()
        for j in range(f.getVertexCount()):
            v = f.getVertex(j)
            vertex(v.x,v.y,v.z)
        endShape(CLOSE)
            

def draw_things():
    global cube
    stroke(0)
    strokeWeight(10)
    scale(50)
    #print(cube.getChildCount())
    a = (cube.getChild(0).getVertex(0))
    a.x += 0.001
    cube.getChild(0).setVertex(0,a)
    alternate_shape(cube)
    return
    shape(cube)
    #a = cube.getVertex(1)
    #print(a.x)
    
def draw():
    global a
    background(100)
    if frameCount%30 == 0:
        print(millis()-a)
    a = millis()
    draw_things()
    
