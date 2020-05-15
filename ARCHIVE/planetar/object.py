class Object():
    
    def __init__(self, x, y, mass=10, r=6, c = color(255,255,0,255), vx=0,vy=0):
        self.pos = PVector(x,y)
        self.vel = PVector(vx,vy)
        self.acc = PVector(0,0)
        self.mass = mass
        self.r = r
        self.anchor = False
        self.c = c
        self.g = 20
    
    def attractTo(self,other):
        vect = other.pos-self.pos
        vect.normalize()
        distance = dist(self.pos.x, self.pos.y, other.pos.x, other.pos.y)
        if distance**2 != 0:
            value = self.g*self.mass*other.mass/(distance**2)
            self.acc += vect*value
    
    def update(self):
        fro = 1
        self.pos += self.vel
        self.vel += self.acc
        self.acc *= 0
        self.vel *= fro
        
    def draw(self):
        stroke(self.c)
        circle(self.pos.x, self.pos.y, self.r)
    
    def border(self):
        if self.pos.x > width:
            self.pos.x = 0
        elif self.pos.x < 0:
            self.pos.x = width
        if self.pos.y > height:
            self.pos.y = 0
        elif self.pos.y < 0:
            self.pos.y = height
    
