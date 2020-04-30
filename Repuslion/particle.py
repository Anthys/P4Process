class Particle():

    def __init__(self, x, y):
        self.pos = PVector(x,y)
        self.vel = PVector(0,0)
        self.acc = PVector(0,0)
        self.mass = 4
        self.g = 1
        self.c = color(255,0,200,255)
        self.r1 = 6
        self.r2 = 6

    def applyForce(self, f):
        f = f / self.mass
        self.vel += f

    def update(self):
        self.vel += self.acc
        self.pos += self.vel
        self.acc *= 0
    
    def draw(self):
        fill(255)
        noStroke()
        ellipse(self.pos.x, self.pos.y, self.r1, self.r2)