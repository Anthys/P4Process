def clamp(a,b,c):
    return max(min(b,c),a)

class Painter():

    def __init__(self, x, y,z, vx, vy,vz):
        self.p = PVector(x,y,z)
        self.v = PVector(vx,vy,vz)
        y = 20
        self.c = color(y+100,y,y,250)
        self.s = 30
        self.t = 0
    
    def border(self,w,h):
        if self.p.x <0:
            self.p.x = w
        elif self.p.x > w:
            self.p.x = 0
        if self.p.y < 0:
            self.p.y = h
        elif self.p.y > h:
            self.p.y=0
    
    def update(self):
        a = 10
        self.v.x = clamp(-a, self.v.x, a)
        self.v.y = clamp(-a, self.v.y, a)
        self.p += self.v
        self.t += 1
    
    def draw(self):
        stroke(self.c)
        strokeWeight(self.s)
        point(self.p.x, self.p.y,self.p.z)