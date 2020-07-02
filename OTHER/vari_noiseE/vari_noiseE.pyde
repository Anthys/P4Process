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
    v = PI-noise(p.x/width*res, tt, p.y/height*res)*TWO_PI
    p.add(PVector(cos(v)*r, sin(v)*r))

def keyPressed():
    if (keyCode == 32):
        background(200)
        noiseSeed(int(random(100)))
        init()
