def setup():
    global t, particles, vals
    t = 0.
    size(500,500)
    init()
        
def init():
    global particles, vals, cvs, cols, t
    particles = []
    vals = []
    cols = 0
    t = 0
    cvs = createGraphics(width, height)
    cvs.beginDraw()
    cvs.background(200)
    cvs.endDraw()
    n = 75
    for i in range(n):
        particles += [PVector(50,height/(n+1)*i+5)]
        #vals += [randomGaussian()*.1]
        vals += [float(i)/n]

def mnoise(x, y=0,z=0):
    return noise(x, y, z)*2-1 

def fbm(x,y=0,z=0):
    val = 0.
    amplitude = .5
    frequency = 0.
    n_octaves = 6
    for i in range(n_octaves):
        val += amplitude * noise(x,y,z)
        x*=2
        y*=2
        z*=2
        amplitude *= .5
    return val

cvs = None
particles = []
vals = []
cols = 0

def inside(x, y):
    return x>0 and x<width and y>0 and y<height

def draw():
    global t, cols
    cvs.beginDraw()
    t = float(frameCount)/10
    for i in range(len(particles)):
        update(i)
        p = particles[i]
        if inside(p.x, p.y) and color(cvs.get(int(p.x), int(p.y)))!= color(200):
            cols += 1
        cvs.set(int(p.x), int(p.y), color(0))
    print(cols)
    cvs.endDraw()
    image(cvs, 0,0)

def update(i):
    p = particles[i]
    r = 1.5;
    res = 4;
    res2 = 1;
    tt = vals[i]
    aa = PI*2
    v = noise(p.x/width*res, tt, t*.1)*aa-aa/2
    p.add(PVector(cos(v)*r, sin(v)*r))

def keyPressed():
    if (keyCode == 32):
        background(200)
        noiseSeed(int(random(100)))
        init()
