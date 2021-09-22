add_library('peasycam')

import os, re

cam = None

infile = open("bsc5.dat")
rfile = infile.read()
infile.close()

group_m = re.findall(".*Lyr.*", rfile)

bsnames_file = open("bs_names.txt")
bsnames = {}
for line in bsnames_file:
    tmp = line.split()
    HRn = int(tmp[0])
    name = tmp[1]
    bsnames[HRn] = name

if False:
    for m in group_m:
        name = m[4:14]
        mag = m[102:107]
        print(name, mag)

def dec2rad(degs, mins, secs):
    degs = float(degs)
    mins = float(mins)
    secs = float(secs)
    dec_degs = degs + (mins+secs/60)/60
    return dec_degs*PI/180

def ra2rad(hours, mins, secs):
    hours = float(hours)
    mins = float(mins)
    secs = float(secs)
    dec_degs = (hours + (mins+secs/60)/60)*15
    return dec_degs*PI/180

R = 500
MSIZE = 10

stars = []
rfile = rfile.split("\n")
for star in rfile:
    magg = star[102:107].replace(" ", "")
    if not magg:
        continue
    magg = float(magg)
    if magg < 5:
        name = star[4:15].replace(" ", "")
        HRn = int(star[0:4])
        if HRn in bsnames:
            name = bsnames[HRn]
        #print(star)
        ra1 = star[75:77]
        ra2 = star[77:79]
        ra3 = star[79:83]
        dec1 = star[83:86]
        dec2 = star[86:88]
        dec3 = star[88:90]
        ra = ra2rad(ra1, ra2, ra3)
        dec = dec2rad(dec1, dec2, dec3)
        stars.append({"HRN": HRn, "name":name, "x":cos(ra)*cos(dec)*R, "y":sin(ra)*cos(dec)*R, "z":sin(dec)*R, "mag":8-(magg+2)})
        #print(ra1, ra2, ra3, dec1, dec2, dec3)
        #print(5-(magg+2))

posCam = {"ra":0, "dec":0, "r":0}
myCam = {"x":0, "y":0, "z":-R, "x0":0, "y0":0, "z0":0}

def radec2xyz(ra, dec, r=1):
    return cos(ra)*cos(dec)*r, sin(ra)*cos(dec)*r, sin(dec)*r

def truc(dx,dy):
    posCam["ra"] += dx* .001
    posCam["dec"] += dy*.001
    x,y,z = radec2xyz(posCam["ra"], posCam["dec"])
    cam.lookAt(x*R, y*R, z*R)

def setup():
    global cam
    size(1000,1000,P3D);
    #cam = PeasyCam(this,0,0, 0, 0);
    #cam.setWheelHandler(None)
    #cam.setLeftDragHandler(truc);
    #cam.setCenterDragHandler(cam.getRotateDragHandler());
    #cam.setRightDragHandler(None);
    #cam.setResetOnDoubleClick(False);
    #cam.setSuppressRollRotationMode(); 

def keyPressedd():
    inc = .01
    if (key == "q"):
        posCam['ra'] += inc
    elif (key == "d"):
        posCam['ra'] -= inc
    myCam["x"],myCam["y"],myCam["z"] = radec2xyz(posCam["ra"], posCam["dec"])    
                
def draw():
    if keyPressed:
        inc = .01
        inc2 = 5
        if (key == "q"):
            posCam['ra'] += inc
        if (key == "d"):
            posCam['ra'] -= inc
        if (key == "z"):
            posCam['dec'] += inc
        if (key == "s"):
            posCam['dec'] -= inc
        if (key == "a"):
            posCam['r'] += inc2
        if (key == "e"):
            posCam['r'] = max(posCam["r"]-inc2, 0)
        myCam["x"],myCam["y"],myCam["z"] = radec2xyz(posCam["ra"], posCam["dec"], R)  
        myCam["x0"],myCam["y0"],myCam["z0"] = radec2xyz(posCam["ra"], posCam["dec"], posCam["r"])  
        print(posCam["r"], myCam["x0"])   
    clear()
    perspective()
    camera(myCam["x0"],myCam["y0"],myCam["z0"],myCam["x"],myCam["y"],myCam["z"],1,0,0)
    
    for star in stars:
        strokeWeight(star["mag"]*MSIZE)
        if star["name"] == "Vega":
            stroke(255, 0, 0)
        elif star["HRN"] == 7051:
            stroke(0, 255, 0)
            strokeWeight(10)
        else:
            stroke(255);
        point(star["x"], star["y"], star["z"])
