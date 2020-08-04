slat = 0
import csv

def setup():
    global slat, res, LAT, LONG, DIAM
    size(500,500);
    #noLoop();
    
    s_degree = 87.;
    
    slat = (90.-s_degree)*PI/180
    
    #cam = new PeasyCam(this, 200);
    name_f = "large.csv"

    fileA = open(name_f)
    s = csv.DictReader(fileA)
    keyss = s.fieldnames
    
    NAME = keyss[0]
    
    LAT = keyss[1]
    LONG = keyss[2]
    DIAM = "DIAM_CIRC_IMG"
    
    res = []
    
    for r in s:
        r[LAT] = (float(r[LAT])+90.)*PI/180
        r[LONG] = (float(r[LONG]))*PI/180
        r[DIAM] = float(r[DIAM])
        if (r[LAT] > PI-slat and r[DIAM]>1):
            res.append(r)
    print(len(res));

    
    res.sort(key=lambda child: child[DIAM], reverse=True)
    
table = None
lats = []
longs = []
diams = []

LAT = ""
LONG = ""
DIAM = ""


def draw():
    translate(width/2, height/2);
    rotate(PI)
    background(200);
    strokeWeight(5);
    
    base_r = 250;
    
    fill(255);
    circle(0,0,base_r*2);
    
    r = 250/sin(slat);
    
    strokeWeight(1);
    for i in range(len(res)):
        lat = res[i][LAT]
        lon = res[i][LONG]
        x = r*sin(lat)*cos(lon);
        y = r*sin(lat)*sin(lon);
        #point(x, y);
        circle(x, y, res[i][DIAM]/1);
    
    x = r*sin(slat)*cos(0);
    y = r*sin(slat)*sin(0);
    fill(255, 0,0);
    circle(x, y, 10);
