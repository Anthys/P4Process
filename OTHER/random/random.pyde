def setup():
    size(500,500, P2D)
    draw_("r");

def draw_(val):
    background(200)
    ni = 500
    nj = 50
    fi = width/ni
    fj = height/nj
    stroke(0)
    strokeWeight(5)
    vals = []
    stats = {"moy":0, "med":0, "sum":0, "abssum":0, "std":0, "len":ni}
    for i in range(ni):
        x = fi*i
        y = 0
        if val == "n":
            y = mynoise(5*float(x)/width)
        elif val == "g":
            y = randomGaussian()
        elif val == "r":
            y = mrandom()
        vals += [y]
        stats["sum"] += y
        stats["abssum"] += abs(y)
        line(x, height/2, x, y*50+height/2)
    
    stats["moy"] = float(stats["sum"])/len(vals)
    vals.sort();
    stats["med"] = vals[int(len(vals)/2)]
    for i in vals:
        stats["std"] += (stats['moy']-i)**2
    stats["std"] = sqrt(stats["std"]/len(vals))
    print()
    for k,v in stats.items():
        print(k, v)

    
def draw_g():
    background(200)
    ni = 50
    nj = 50
    fi = width/ni
    fj = height/nj
    stroke(0)
    strokeWeight(5)
    for i in range(ni):
        x = fi*i
        y = height/2 + randomGaussian()*50
        line(x, height/2, x, y)

def draw():
    pass      

def keyPressed():
    if keyCode == 32:
        draw_("r");
    if key == "g":
        draw_("g")
    if key == "r":
        draw_("r")
    if key == "n":
        noiseSeed(int(random(100)))
        draw_("n")

def mynoise(x):
    return noise(x)*2-1
        
        
def mrandom():
    return random(2)-1
    
