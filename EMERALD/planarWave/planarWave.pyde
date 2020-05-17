add_library("peasycam")

def setup():
    global cam, t,shapes
    size(500,500,P3D)
    cam = PeasyCam(this, 400)
    shutil.copy("circo.obj", "plana.obj")
    t = 0.
    shapes = {}
    shapes["ppp"] = loadShape("paperplane.obj")

def protateX(v,th):
    temp = PVector(v.y, v.z)
    temp.rotate(th)
    return PVector(v.x, temp.x, temp.y)

def protateY(v,th):
    temp = PVector(v.x, v.z)
    temp.rotate(th)
    return PVector(temp.x, v.y, temp.y)

def protateZ(v,th):
    temp = PVector(v.x, v.y)
    temp.rotate(th)
    return PVector(temp.x, temp.y, v.z)
    

def alternate_shape(s, x0=0,y0=0, z0=0, sx = 1, sy=1, sz=1, ss= 1, rx=0, ry=0, rz=0):
    if ss != 1:
        sx = ss
        sy = ss
        sz = ss
    fill(255)
    stroke(0)
    strokeWeight(0.1)
    for i in range(s.getChildCount()):
        f = s.getChild(i)
        beginShape()
        for j in range(f.getVertexCount()):
            v = f.getVertex(j)
            if rx:
                v = protateX(v,rx)
            if ry:
                v = protateY(v,ry)
            #v = protateZ(protateY(protateX(v, rx), ry), rz)
            vertex(v.x*sx+x0,v.y*sy+y0,v.z*sz+z0)
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


import shutil, copy

def global_lerp():
    coeff = 0.1
    for i,vv in enumerate(cur_vec):
        iniv = ini_vec[i]
        vv.x = lerp(vv.x, iniv.x, coeff)
        vv.y = lerp(vv.y, iniv.y, coeff)
        vv.z = lerp(vv.z, iniv.z, coeff)

def draw_paperplane(t):
    speed = t/40
    amp = 0.5
    alternate_shape(shapes["ppp"], z0=speed%4-2, y0=cos(speed)*amp+4,ss=0.3, rx=sin(speed)*amp)

def make_wave(inivec, vectors, t, speed=1./50, ss=3, ampli=1,n_cycle = 2, omega=1, puis=1 ):
    one_cycle = PI*n_cycle
    start = (t*speed) - ss
    for i,vv in enumerate(vectors):
        iniv = inivec[i]
        if  True and start-omega*vv.x>0 and start-omega*vv.x < one_cycle:
            vv.y = iniv.y+ampli*sin(vv.x*omega - t*speed)**puis
    #replace_v("plana.obj", cur_vec)
    return cur_vec

def make_wave_3D(inivec, vectors, t, speed=1./50, ss=3, ampli=1,n_cycle = 1, omega=1, puis=1, start = PVector(0,0,0)):
    speed = speed*omega
    r = t*speed
    for i,vv in enumerate(vectors):
        d = PVector(vv.x, vv.z).mag()
        iniv = inivec[i]
        if  r/omega>=d and d >= (-PI+r)/omega:
            vv.y = iniv.y+ampli*sin(r-d*omega)**puis
            stroke(255,0,0)
            strokeWeight(.4)
            point(vv.x,vv.y,vv.z)
    #replace_v("plana.obj", cur_vec)
    return vectors
        

def draw():
    global t, ini_vec, cur_vec
    background(200)
    scale(30)
    rotateX(PI)
    rotateX(-PI/2)
    t += 1.
    if frameCount == 1:
        a = (get_all_vertices("plana.obj"))
        ini_vec = [v for i,v in a]
        cur_vec = copy.deepcopy(ini_vec)
    plan = loadShape("plana.obj")
    alternate_shape(plan)
    omega = 2
    speed = 1./20
    quanti = (10/(speed))
    n = 3
    for i in range(n):
        if i == 0:
            cur_vec = make_wave_3D(ini_vec, cur_vec, (t+quanti/n*i)%quanti, speed = speed, omega = omega)
        else:
            cur_vec = make_wave_3D(ini_vec, cur_vec, (t+quanti/n*i)%quanti, speed = speed, omega = omega)
    replace_v("plana.obj", cur_vec)
    speed = t/100
    alternate_shape(shapes["ppp"], y0 = 4+cos(t/50)*0.5, x0 = cos(speed)*4, z0 = sin(speed)*4, ry = speed, rx= sin(t/50)*0.5, ss = 0.7)
    #replace_v("plana.obj", ini_vec)
    #saveFrame("out/out-####.png")

def keyPressed():
    pass