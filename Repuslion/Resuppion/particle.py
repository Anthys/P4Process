class Particle():

    def __init__(self, x, y):
        self.pos = PVector(x,y)
        self.vel = PVector(0,0)
        self.acc = PVector(0,0)
        self.mass = 3
        self.g = 1
        self.c = color(255,0,200,255)
        self.r1 = 6
        self.r2 = 6
        self.anchor = False

    def applyForce2(self, f):
        f = f / self.mass
        self.vel += f
    
    def clamp(self,a,b,c):
        b = max(a,b)
        b = min(b,c)
        return b
    
    def applyForce(self, f):
        FORCE_MAX = 4
        self.acc.x = self.clamp(-FORCE_MAX, self.acc.x + f.x, FORCE_MAX)
        self.acc.y = self.clamp(-FORCE_MAX, self.acc.y + f.y, FORCE_MAX)

    def update(self):
        self.vel += self.acc
        self.pos += self.vel
        self.acc *= 0
 
    def move(self, dt):
        NODE_SPEED = 128
        DAMPING_FACTOR = 0.95
        self.vel.x = (self.vel.x + self.acc.x * dt * NODE_SPEED) * DAMPING_FACTOR;
        self.vel.y = (self.vel.y + self.acc.y * dt * NODE_SPEED) * DAMPING_FACTOR;
        self.pos.x = self.pos.x + self.vel.x;
        self.pos.y = self.pos.y + self.vel.y;
        self.acc.x, self.acc.y = 0, 0;
    
    def draw(self):
        fill(255)
        noStroke()
        ellipse(self.pos.x, self.pos.y, self.r1, self.r2)
    
    def get_man_dist(self,other):
        return PVector(other.pos.x - self.pos.x, other.pos.y - self.pos.y)
    
    def get_real_dist(self, other):
        a,b = other.pos.x - self.pos.x, other.pos.y - self.pos.y
        return sqrt(a*a+b*b)
    
    def attract_To(self, other):
        vect = self.get_man_dist(other)
        dx,dy = vect.x,vect.y
        distance = self.get_real_dist(other)
        dx = dx/distance
        dy = dy/distance
        
        FORCE_SPRING = 0.1
        
        strength = -1 * FORCE_SPRING * distance * 0.5
        #print("A",dx* strength)
        self.applyForce(PVector(dx*strength, dy*strength))
        
    def repelFrom(self, other):
        vect = self.get_man_dist(other)
        dx,dy = vect.x,vect.y
        distance = self.get_real_dist(other)
        #print(dx,distance)
        dx = dx/distance
        dy = dy/distance
        
        FORCE_CHARGE = 20000
        
        strength = FORCE_CHARGE * (( self.mass * other.mass) / (distance*distance))
        #print("R",dx* strength)
        self.applyForce(PVector(dx* strength,dy*strength))
        
