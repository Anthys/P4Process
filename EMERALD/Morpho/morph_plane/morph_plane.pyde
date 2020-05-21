add_library("peasycam")

# WHEN MODIFYING THE SHAPE ON BLENDER, TICK "KEEP VERTEX ORDER" IN THE EXPORT BOX

def setup():
    global cam, t,shapes, state, otherv, n_file
    size(500,500,P3D)
    cam = PeasyCam(this, 400)
    n_file = "plano.obj"
    shutil.copy(n_file, "plana.obj")
    t = 0.
    shapes = {}
    state = 0
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

def make_wave_linear(inivec, vectors, t, speed=1./50, ampli=1,n_cycle = 1, le=1, puis=1, ss=4, loopp=False,rot=PVector(0,0,0) ):
    s = t*speed%(2*ss)-ss
    e = (t*speed-le)%(2*ss)-ss
    if not loopp: 
        s = t*speed-ss
        e = (t*speed-le)-ss
        
    for i,vv in enumerate(vectors):
        iniv = inivec[i]
        iniv_a = protateZ(protateY(protateX(iniv, rot.x), rot.y),rot.z)
        check = iniv_a.x
        if  between(e,check, s):
            vv.y = iniv.y+ampli*sin((-check + s)*PI/le*n_cycle)**puis
    #replace_v("plana.obj", cur_vec)
    return cur_vec



def make_wave_spheric(inivec, vectors, t, speed=1./50, ampli=1,n_cycle = 1, le=1, puis=1, ss=4, loopp=True, start = PVector(0,0,0)):
    s = t*speed%(2*ss)-ss
    e = (t*speed-le)%(2*ss)-ss
    if not loopp: 
        s = t*speed-ss
        e = (t*speed-le)-ss
    for i,vv in enumerate(vectors):
        d = vv.mag()
        iniv = inivec[i]
        if between(e,d,s):
            vv.y = iniv.y+ampli*sin((s-d)*PI/le*n_cycle)**puis
            stroke(255,0,0)
            strokeWeight(.5)
            point(vv.x,vv.y,vv.z)
    #replace_v("plana.obj", cur_vec)
    return cur_vec

def make_wave_circular(inivec, vectors, t, speed=1./50, ampli=1,n_cycle = 1, le=1, puis=1, ss=4, loopp=True, start = PVector(0,0,0),rot=PVector(0,0,0)):
    s = t*speed%(2*ss)-ss
    e = (t*speed-le)%(2*ss)-ss
    if not loopp: 
        s = t*speed-ss
        e = (t*speed-le)-ss
    for i,vv in enumerate(vectors):
        temp = PVector(vv.x,vv.z)
        d = temp.mag()
        iniv = inivec[i]
        if between(e,d,s):
            vv.y = iniv.y+ampli*sin((s-d)*PI/le*n_cycle)**puis
            stroke(255,0,0)
            strokeWeight(.5)
            point(vv.x,vv.y,vv.z)
    #replace_v("plana.obj", cur_vec)
    return cur_vec
        

def make_wave_turn(inivec, vectors, t, speed=1./50, ss=3, ampli=1,n_cycle = 1, puis=1, start = PVector(0,0,0), le=PI, le2 = PI/4, rot=PVector(0,0,0)):
    s = (t*speed)%TWO_PI
    e = (t*speed-le)%TWO_PI
    rx,ry,rz = rot.x, rot.y, rot.z
    #ry = PI/4
    for i,vv in enumerate(vectors):
        iniv = inivec[i]
        iniv_another = protateZ(iniv, rz)
        #iniv = protateY(iniv, ry)
        d = atan2(iniv_another.x,iniv_another.z)+PI
        #theta = atan2(vv.x,vv.y)
        theta = acos(iniv_another.y/iniv_another.mag())
        middle = PI/2
        #le2=PI/4
        #theta = PI/2
        if  between(e,d,s) and between(middle-le2/2,theta,middle+le2/2):#r/omega>=d and d >= (-PI+r)/omega:
            #vv.y = iniv.y+ampli*sin(r-d*omega)**puis
            #vv.y = iniv.y + sin((s-d)*2)
            temp = PVector(0,0,0) + iniv
            temp.normalize()
            temp *= ampli*(sin((s-d)*PI/le*n_cycle)**puis)*cos((middle-theta)*PI/le2)
            vv = PVector(0,0,0) + iniv + temp
            vectors[i] = vv
            #vv += iniv #*3#*sin((s-d)*2)
            stroke(255,0,0)
            strokeWeight(.5)
            #point(vv.x,vv.y,vv.z)
    #replace_v("plana.obj", cur_vec)
    return cur_vec

def between(a,b,c):
    if c < a:
        return not between(c,b,a)
    else:
        return a<=b and b<=c

def separate(source):
    a = (get_all_vertices(source))
    ini_vec = [v for i,v in a]
    cur_vec = copy.deepcopy(ini_vec)
    cur_vec = copy.deepcopy(ini_vec)
    return ini_vec, cur_vec

def make_wave_linear_morph_temp(inivec, vectors, othervec, t, speed=1./50, ampli=1,n_cycle = 1, le=1, puis=1, ss=4, loopp=False,rot=PVector(0,0,0) ):
    s = t*speed%(2*ss)-ss
    e = (t*speed-le)%(2*ss)-ss
    if not loopp: 
        s = t*speed-ss
        e = (t*speed-le)-ss
        
    for i,vv in enumerate(vectors):
        iniv = inivec[i]
        otherv = othervec[i]
        iniv_a = protateZ(protateY(protateX(iniv, rot.x), rot.y),rot.z)
        check = iniv_a.x
        if  between(e,check, e+(s-e)/2):
            ampli2 = ampli + (iniv.y-otherv.y)
            vv.y = otherv.y+ampli2*sin((-check + s)*PI/le*n_cycle)**puis
        elif  between(e+(s-e)/2,check, s):
            vv.y = iniv.y+ampli*sin((-check + s)*PI/le*n_cycle)**puis
        elif between(e-2, check, e):
            vv.y = otherv.y
            stroke(255,0,0)
            strokeWeight(.5)
            point(vv.x, vv.y, vv.z)
    #replace_v("plana.obj", cur_vec)
    return cur_vec

def make_wave_linear_morph(inivec, vectors, othervec, t, speed=1./50, ampli=1,n_cycle = 1, le=1, puis=1, ss=4, loopp=False,rot=PVector(0,0,0) ):
    s = t*speed%(2*ss)-ss
    e = (t*speed-le)%(2*ss)-ss
    if not loopp: 
        s = t*speed-ss
        e = (t*speed-le)-ss

    for i,vv in enumerate(vectors):
        iniv = inivec[i]
        otherv = othervec[i]# + PVector(0,-2,0)
        iniv_a = protateZ(protateY(protateX(iniv, rot.x), rot.y),rot.z)
        check = iniv_a.x
        if  between(e,check, e+(s-e)/2):
            ampli2 = ampli + (iniv.y-otherv.y)
            vv.y = otherv.y+ampli2*sin((-check + s)*PI/le*n_cycle)**puis
        elif  between(e+(s-e)/2,check, s):
            vv.y = iniv.y+ampli*sin((-check + s)*PI/le*n_cycle)**puis
        elif between(e-2, check, e):
            #vv.y = otherv.y
            #vv.x= otherv.x
            stroke(255,0,0)
            strokeWeight(.5)
            point(vv.x, vv.y, vv.z)
    #replace_v("plana.obj", cur_vec)
    return cur_vec

def draw():
    global t, ini_vec, cur_vec, othervectors
    rotateX(-PI/6)
    #rotateY(PI/6-t/1000)
    background(200)
    scale(30)
    rotateX(PI)
    t += 1.
    if frameCount == 1:
        ini_vec, cur_vec = separate("plana.obj")
        othervectors = separate("plana4.obj")[0]
    plan = loadShape("plana.obj")
    alternate_shape(plan)
    speed = 1./20
    n = 3
    rot1 = PVector(0,0,PI/4)
    rot2 = PVector(0,0,-PI/4)
    if state == 0:
        #cur_vec = make_wave_linear(ini_vec, cur_vec, t, loopp=True,speed = speed, n_cycle=1,le=2, ss=6, rot = PVector(0,PI/4,0))
        cur_vec = make_wave_linear_morph(ini_vec, cur_vec, othervectors,t, loopp=False,speed = speed, n_cycle=1,le=2, ss=6, rot = PVector(0,PI/4,0))
    elif state == 1:
        cur_vec = make_wave_spheric(ini_vec, cur_vec, t, speed = speed, n_cycle=1,le=1, ss=7)
    elif state == 2:
        cur_vec = make_wave_circular(ini_vec, cur_vec, t, speed = speed, n_cycle=1,le=2, ss=6)
        cur_vec = make_wave_circular(ini_vec, cur_vec, t+12./speed/2, speed = speed, n_cycle=1,le=2, ss=6)
    elif state == 3:
        for i in range(n):
            cur_vec = make_wave_turn(ini_vec, cur_vec, t+i*TWO_PI/speed/n, speed = speed, n_cycle=1, le = PI/2, rot=rot1)
    replace_v("plana.obj", cur_vec)
    #saveFrame("out/out-####.png")


def keyPressed():
    if keyCode == 32:
        global state, ini_vec, cur_vec, t
        t = 0
        state = (state+1)%4
        if state == 3:
            shutil.copy("sphero.obj", "plana.obj")
        else:
            shutil.copy("plano.obj", "plana.obj")
        ini_vec, cur_vec = separate("plana.obj")
            
