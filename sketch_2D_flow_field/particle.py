class Particle():
    def __init__(self):
        self.pos = PVector(random(width), random(height))
        self.vel = PVector(0,0)
        self.acc = PVector(0,0)
        self.maxspeed = 4
        self.prevPos = self.pos.copy()
        a = int(random(0,3))
        tm = [color(94,28,159,5),color(0,0,0,5),color(64,0,134,5)]
        self.c = tm[a]
        self.c = color(int(random(60,150)), 0, int(random(140,220)),5)
        #self.c = color(int(random(255)), int(random(255)), int(random(255)),5)
        
    def update(self):
        self.vel.add(self.acc)
        self.vel.limit(self.maxspeed)
        self.pos.add(self.vel)
        self.acc.mult(0)
    
    def applyForce(self, force):
        self.acc.add(force)
        
    def show(self):
        stroke(self.c)
        strokeWeight(2)
        line(self.pos.x, self.pos.y, self.prevPos.x, self.prevPos.y)
        self.updatePrev()
    
    def updatePrev(self):
        self.prevPos.x = self.pos.x
        self.prevPos.y = self.pos.y
    
    def edges(self):
        if self.pos.x > width:
            self.pos.x = 0
            self.updatePrev()
        if self.pos.x < 0:
            self.pos.x = width
            self.updatePrev()
        if self.pos.y > height:
            self.pos.y = 0
            self.updatePrev()
        if self.pos.y < 0:
            self.pos.y = height
            self.updatePrev()
            
    def follow(self, vectors,scl,cols):
        x = floor(self.pos.x/scl)
        y = floor(self.pos.y/scl)
        #print(self.pos.x, self.pos.y)
        #print(x,y)
        index = x + y*cols
        force = vectors[index]
        self.applyForce(force)
