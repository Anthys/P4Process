add_library("peasycam")
add_library("videoExport")
def setup():
    global cube, cam, a, truc, t, waves, vid
    size(500,500,P3D)
    cam = PeasyCam(this, 600)
    a = millis()
    cube = loadShape("monkey.obj")
    print(millis()-a)
    shutil.copy("data/plano.obj", "data/plana.obj")
    truc = False
    t = 0.
    waves = [t]
    vid = VideoExport(this)
    vid.startMovie()

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
        if i_s != -1 and temp and temp[0] != "v":
            i_e = i
            break
        if i_s == -1 and temp and  temp[0] == "v":
            i_s = i
            
    tmp_string = ""
    for v in vec:
        tmp_string += "v "+ str(v.x) + " " + str(v.y) + " "+ str(v.z)+ "\n"
    
    file1 = file1[:i_s] + [tmp_string] + file1[i_e:]
    file1 = "\n".join(file1)
    file_r.close()
    file_w = open(file, "w+")
    file_w.write(file1)
    file_w.close()
    

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

import shutil, copy

def global_lerp():
    coeff = 0.1
    for i,vv in enumerate(cur_vec):
        iniv = ini_vec[i]
        vv.x = lerp(vv.x, iniv.x, coeff)
        vv.y = lerp(vv.y, iniv.y, coeff)
        vv.z = lerp(vv.z, iniv.z, coeff)

def draw():
    global a, cube, ini_vec, cur_vec, t, waves
    rotateX(-PI/6)
    rotateY(PI/6-t/1000)
    cube = loadShape("plana.obj")
    if t == 0:
        a = (get_all_vertices("plano.obj"))
        ini_vec = [v for i,v in a]
        cur_vec = copy.deepcopy(ini_vec)
        
    ss = 3 # SemiSize
    speed1 = 1./100
    speed2 = 1./50
    ampli = 1
    n_cycle = 1
    omega = 1
    puis = 3
    #n_cycle = float("inf")
    #omega = 0.5 + float(frameCount)/1000
    one_cycle = PI*50*speed2*n_cycle
    for j in range(len(waves)-1, -1, -1):
        waves[j] += 1
        w = waves[j]
        start = (w*speed2) - ss
        for i,vv in enumerate(cur_vec):
            iniv = ini_vec[i]
            distt = (start-omega*vv.x)
            if  True and start-omega*vv.x>0 and start-omega*vv.x < one_cycle:
                ampli = sin((start-omega*vv.x))*0.5
                #ampli = noise(float(frameCount)/10000, vv.x/100)*3
                vv.y = vv.y + random(1)*ampli-ampli/2
        if w*speed2 > ss*4:
            waves = waves[:j] + waves[j+1:]
    #print(len(waves))
    
    if truc:
        global_lerp()    

    replace_v("plana.obj", cur_vec)
    
    background(100)
    if t%30 == 0 and False:
        print(millis()-a)
    a = millis()
    draw_things()
    t += 1.
    vid.saveFrame();

def send_wave(n=1):
    global waves
    for i in range(n):
       waves += [0.]

def keyPressed():
    global truc, t 
    if key == "l":
        truc = not truc
    if keyCode == 32:
        send_wave()
    if key == "q":
        vid.endMovie()
        exit()
        
