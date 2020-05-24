def setup():
    size(500,500)
    global t, michel
    t = 0.
    michel = Particle(random(0,width), random(0, height), PI)
    michel = Particle(0.,0., PI)
    translate(width/2, height/2)
    
    if False:
        loadPixels()
        for i in range(width):
            for j in range(height):
                x = float(i)
                y = float(j)
                pixels[i+j*width]=color(noise(x/width*3,y/height*3)*255)
        updatePixels()
        return
    
    big_steps = 50
    for i in range(big_steps):
        small_steps = int(random(0,100))
        dist = random(1,50)
        pivot = michel.p + dist*PVector(cos(michel.dir+PI/2), sin(michel.dir+PI/2))
        for j in range(small_steps):
            stroke(0)
            strokeWeight(2)
            michel.dir += PI/100
            newpos = michel.p + dist*PVector(cos(michel.dir), sin(michel.dir))*.1
            line(michel.p.x, michel.p.y, newpos.x, newpos.y)
            michel.p = newpos
    

def draw():
    pass

    

class Particle():
    def __init__(self,x,y,dir):
        self.p = PVector(x,y)
        self.dir = dir
        self.cur_small = 0
        self.cur_big = 0
        self.max_small = 0
        self.max_big = 0
