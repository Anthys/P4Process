add_library("peasycam")
def setup():
    global cam
    cam = PeasyCam(this, 400)
    size(500,500,P3D)

def draw():
    background(200)
    noFill()
    stroke(255, 102, 0);
    curve(5, 26, 5, 26, 73, 24, 73, 61);
    stroke(0); 
    curve(5, 26, 73, 24, 73, 61, 15, 65); 
    stroke(255, 102, 0);
    curve(73, 24, 73, 61, 15, 65, 15, 65);
    draw_plane(0,0,0,100,100,100,0,100,0,0,0,100)
    
def draw_plane(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4):
    stroke(0)
    fill(200,0,0)
    beginShape()
    curveVertex(x1,y1,z1)
    curveVertex(x2,y2,z2)
    curveVertex(x3,y3,z3)
    curveVertex(x4,y4,z4)
    endShape(CLOSE)
    
