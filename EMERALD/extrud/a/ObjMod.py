def get_vertices(file):
    file1 = open(file)
    all_v = []
    ci = 0
    for l in file1:
        temp = l.split()
        if temp and temp[0] == "v":
            vec = PVector(float(temp[1]), float(temp[2]), float(temp[3]))
            all_v += [[ci, vec]]
            ci += 1
    return all_v


def replace_vectors(file, vec):
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

def draw_shape(s, x0=0,y0=0, z0=0, sx = 1, sy=1, sz=1, ss= 1, rx=0, ry=0, rz=0, cf = color(255), cstroke=color(0), wstroke=.1):
    if ss != 1:
        sx = ss
        sy = ss
        sz = ss
    fill(cf)
    stroke(cstroke)
    strokeWeight(wstroke)
    for i in range(s.getChildCount()):
        f = s.getChild(i)
        beginShape()
        for j in range(f.getVertexCount()):
            v = f.getVertex(j)
            mg = v.mag()
            dir = v.copy().normalize()
            if rx:
                v = protateX(v,rx)
            if ry:
                v = protateY(v,ry)
            if rz:
                v = protateZ(v,rz)
            #v = protateZ(protateY(protateX(v, rx), ry), rz)
            vertex(v.x*sx+x0,v.y*sy+y0,v.z*sz+z0)
        endShape(CLOSE)
