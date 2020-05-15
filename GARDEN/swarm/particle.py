class Particle():
    
    def __init__(self, x, y,vx=0,vy=0,s=5):
        self.x = x
        self.y = y
        self.s = s
        self.c = 50
        self.vx = vx
        self.vy = vy
    
    def update(self):
        self.x += self.vx
        self.y += self.vy
        self.vx *= 0.99
        self.vy *= 0.99
        self.vx = clamp(-5,self.vx,5)
        self.vy = clamp(-5,self.vy,5)
    
    def draw(self):
        strokeWeight(self.s)
        stroke(self.c)
        point(self.x,self.y)
    
    def get_pos_on_grid(self,gridsize):
        return PVector(floor(self.x/gridsize), floor(self.y/gridsize))
    
    def border(self):
        if self.x <0:self.x = width
        elif self.x > width:
            self.x = 0
        if self.y < 0: self.y = height
        elif self.y > width:self.y = 0

def clamp(a,b,c):
    temp = max(a,b)
    return min(temp,c)    

class Grid():
    
    def __init__(self,vx,vy):
        self.vx=vx
        self.vy=vy
        self.pop = 0
