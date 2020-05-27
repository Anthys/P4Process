def anoise(x,y):
    return 1-noise(x,y)

class Particle():
    
    def __init__(self, x, y, vx=0, vy=0, res = 1.):
        self.p = PVector(x, y)
        self.v = PVector(vx, vy)
        self.c = color(100,0,200, 10)
        self.res = res
        
    
    def find_gradient(self, res = 1.):
        dx = res*1./width
        dy = res*1./height
        uv = res*PVector(self.p.x/width+1, self.p.y/height+1)
        
        vx = anoise(uv.x+dx, uv.y)-anoise(uv.x-dx, uv.y)
        vy = anoise(uv.x, uv.y+dy)-anoise(uv.x, uv.y-dy)
        
        out = PVector(vx, vy).normalize()*0.01
        """stroke(0,255,0)
        line(self.p.x, self.p.y, self.p.x+out.x*1000, self.p.y)
        stroke(255,0,0)
        line(self.p.x, self.p.y, self.p.x, self.p.y+out.y*1000)
        """
        return out
        
    def update(self):
        self.v *= .999
        uv = PVector(self.p.x/width+1, self.p.y/height+1)
        self.v += self.find_gradient(self.res)
        
        self.p += self.v
            
    
    def draw(self):
        self.update()
        strokeWeight(10)
        stroke(self.c)
        point(self.p.x, self.p.y)
