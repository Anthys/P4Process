class Particle():
    
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
        self.col = color(150,0,0)
        self.size = 10
        self.target = [x,y,z]
    
    def move_toward(self, target):
        self.x = lerp(self.x, target[0])
        self.y = lerp(self.y, target[1])
        self.z = lerp(self.z, target[2])
    
    def draw(self):
        stroke(self.col)
        strokeWeight(self.size)
        point(self.x,self.y,self.z)
        
        

def lerp(a,b,t=0.05):
    return (1-t)*a + t*b
