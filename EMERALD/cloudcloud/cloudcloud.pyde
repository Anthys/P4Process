add_library("peasycam")

def setup():
    size(500,500,P3D)
    cam = PeasyCam(this, 400)

def axes():
    strokeWeight(5)
    stroke(255,0,0)
    line(0,0,0,100,0,0)
    stroke(0,255,0)
    line(0,0,0,0,100,0)
    stroke(0,0,255)
    line(0,0,0,0,0,100)

def cloud():
    stroke(50,50,50,50)
    strokeWeight(10)
    for i in range(1000):
        theta = random(0,TWO_PI)
        phi = random(0,PI)
        r = random(0,100)
        x = r*sin(phi)*cos(theta)
        y = r*sin(phi)*sin(theta)
        z = r*cos(phi)
        point(x,y,z)

def draw():
    background(200)
    axes()
    cloud()
