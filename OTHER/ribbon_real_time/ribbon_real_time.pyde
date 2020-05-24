def setup():
    size(500,500)
    global t, michel
    t = 0.
    michel = Particle(random(0,width), random(0, height), PI)
    michel = Particle(0.,0., PI)
    michel.max_big = 100
    michel.max_small = 100
    michel.pivot, michel.dist,michel.pivotdir = michel.create_pivot()
    
    if False:
        loadPixels()
        for i in range(width):
            for j in range(height):
                x = float(i)
                y = float(j)
                pixels[i+j*width]=color(noise(x/width*3,y/height*3)*255)
        updatePixels()
        return
    
    

def draw():
    translate(width/2, height/2)
    if michel.cur_big > michel.max_big:
        return
    if michel.cur_small > michel.max_small:
        michel.cur_small = 0
        michel.max_small = random(1,100)
        michel.pivot, michel.dist, michel.pivotdir = michel.create_pivot()
        michel.cur_big += 1
    else:
        stroke(0, 20)
        strokeWeight(2)
        michel.dir = michel.dir + (PI/100)*(michel.pivotdir*-2+1)
        n = 5
        for i in range(5,-1,-1):
            newpos = michel.p + michel.dist*PVector(cos(michel.dir)+i, sin(michel.dir))*.01
            line(michel.p.x+i*3, michel.p.y+i*3, newpos.x+i*3, newpos.y+i*3)
        michel.p = newpos
        michel.cur_small += 1
        
    
    

class Particle():
    def __init__(self,x,y,dir):
        self.p = PVector(x,y)
        self.dir = dir
        self.cur_small = 0
        self.cur_big = 0
        self.max_small = 0
        self.max_big = 0
        self.pivot = PVector(0,0)
        self.dist = 0
        self.pivotdir = 0
    
    def create_pivot(self):
        dir = 1
        if random(0,1)<0.5:
            dir = 0
        dist = random(1,50)
        pivot = self.p + dist*PVector(cos(self.dir+dir*PI-PI/2), sin(self.dir+dir*PI-PI/2))
        return pivot, dist,dir 
        
