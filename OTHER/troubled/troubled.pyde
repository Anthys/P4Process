def setup():
    size(500,500)
    global particles
    particles = []
    n = 10
    for i in range(n):
        particles.append(Particle(width/2+random(-50,50),random(0,50)))

def mnoiseA(x,y,t=0):
    res = 1
    intensity = 5
    xx = x/width*res
    yy = y/height*res
    return (noise(x,y,t)*2-1)*intensity
    
    
def draw():
    #background(200)
    for i,v in enumerate(particles):
        v.v *= .5
        v.v += PVector(mnoiseA(v.p.x,v.p.y),noise(v.p.y/height))
        v.update()
        v.draw()
        
        
class Particle():
    
    def __init__(self, x=0., y=0., vx=0., vy=0.):
        self.p = PVector(x, y);
        self.v = PVector(vx, vy)
    
    def update(self):
        self.p += self.v
    
    def draw(self):
        noFill()
        stroke(200, 100, 180, 50)
        circle(self.p.x, self.p.y, 8)
        
