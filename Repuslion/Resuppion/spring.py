class Spring():
 
    def __init__(self, x, y, longueur):
        self.startpoint = PVector(x, y)
        self.constante = .2
        self.longueur = longueur
        self.g = 1
        self.mass = 4
 
    def connect(self, p):
        force = PVector.sub(p.pos, self.startpoint)
        distance = force.mag()
        stretch = distance - self.longueur
 
        force.normalize()
        force *= -1 * self.constante * stretch
        force.limit(.1) 
        p.applyForce(force)
 
 
    def displayLine(self, p):
        stroke(255)
        strokeWeight(.2)
        line(p.pos.x, p.pos.y, self.startpoint.x, self.startpoint.y) 