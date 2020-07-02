def setup():
    global t, particles, vals
    t = 0.
    size(500,500)
    init()
        
def init():
    global particles, vals
    particles = []
    vals = []    
    n = 70
    for i in range(n):
        particles += [PVector(50,height/n*i)]
        vals += [randomGaussian()*.1]

particles = []
vals = []

def draw():
    global t
    t = float(frameCount)/10
    for i in range(len(particles)):
        update(i)
        p = particles[i]
        point(p.x, p.y)

def update(i):
    p = particles[i]
    r = 1;
    res = 4;
    tt = vals[i]
    v = PI-noise(p.x/width*res, tt)*TWO_PI
    p.add(PVector(cos(v)*r, sin(v)*r))

def keyPressed():
    if (keyCode == 32):
        background(200)
        noiseSeed(int(random(100)))
        init()
