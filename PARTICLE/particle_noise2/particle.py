def anoise(x,y):
    return 1-noise(x,y)

def clamp(a,b,c):
    return min(max(b,a),c)

class Particle():
    
    def __init__(self, x, y, vx=0, vy=0, res = 1.):
        self.p = PVector(x, y)
        self.v = PVector(vx, vy)
        self.c = color(100,0,20,5)
        self.res = res
        
    
    def find_gradient2(self, res = 1.):
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
    
    def find_gradient(self, res = 1.):
        dx = res*1./width
        dy = res*1./height
        uv = res*PVector(self.p.x/width+1, self.p.y/height+1)
        
        v = PVector(0,0)
        
        #stroke(255,255,0)
        
        rr = 50
        for i in range(-rr,rr, 5):
            for j in range(-rr, rr, 5):
                cp = PVector(uv.x+i*dx, uv.y+j*dy)
                val = anoise(cp.x, cp.y)
                #point((cp.x/res-1)*width, (cp.y/res-1)*height)
                #stroke(val*255,val*255,0, 200)
                #point((cp.x/res-1)*width, (cp.y/res-1)*height)
                v += (cp-uv).normalize()*val
        
        out = v.normalize()*.1
        #stroke(0,255,0)
        #line(self.p.x, self.p.y, self.p.x+out.x*1000, self.p.y)
        #stroke(255,0,0)
        #line(self.p.x, self.p.y, self.p.x, self.p.y+out.y*1000)
        
        return out
        
    def update(self):
        self.v *= .99
        uv = PVector(self.p.x/width+1, self.p.y/height+1)
        self.v += self.find_gradient(self.res)
        
        self.p += self.v
    
    def border(self):
        if self.p.x < 0:
            self.p.x = width
        elif self.p.x > width:
            self.p.x = 0
        if self.p.y < 0:
            self.p.y = height
        elif self.p.y > height:
            self.p.y = 0
    
    def draw(self):
        #self.border()
        self.update()
        strokeWeight(10)
        stroke(self.c)
        point(self.p.x, self.p.y)
