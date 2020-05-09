class Turtle():
    
    def __init__(self, x=0, y=0,z=0, ax=0,ay=0,az=0):
        self.x = x
        self.y =y
        self.z =z
        self.ax = ax
        self.ay = ay
        self.az = ay
    
    def state(self):
        return [self.x, self.y, self.z, self.ax,self.ay,self.az]
    
    def load(self, l):
        self.x = l[0]
        self.y = l[1]
        self.z = l[2]
        self.ax = l[3]
        self.ay = l[4]
        self.az = l[5]
