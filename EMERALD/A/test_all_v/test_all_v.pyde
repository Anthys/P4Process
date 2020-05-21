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

def get_all_vertices(file):
    file1 = open(file)
    all_v = []
    c_i = 0
    for l in file1:
        temp = l.split()
        if temp and temp[0] == "v":
            vec = PVector(float(temp[1]), float(temp[2]), float(temp[3]))
            all_v += [[c_i, vec]]
            c_i += 1
    return all_v
                
def replace_v(file, vec):
    file_r = open(file)
    file1 = file_r.read()
    file1 = file1.split("\n")
    
    i_s = -1
    i_e = -1
    for i,l in enumerate(file1):
        temp = l.split()
        if i_s != -1 and temp[0] != "v":
            i_e = i
            break
        if i_s == -1 and temp[0] == "v":
            i_s = i
            
    tmp_string = ""
    for v in vec:
        tmp_string += "v "+ str(v.x) + " " + str(v.y) + " "+ str(v.z)+ "\n"
    
    file1 = file1[:i_s] + [tmp_string] + file1[i_e:]
    file1 = "\n".join(file1)
    file_r.close()
    file_w = open(file, "w+")
    file_w.write(file1)
    

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
    if frameCount == 1:
        a = (get_all_vertices("keke.obj"))
        return
        for i,v in a:
            print(v)
        replace_v("keke.obj", [v for i,v in a])
    background(100)
    if frameCount%30 == 0 and False:
        print(millis()-a)
    a = millis()
    draw_things()
    
