class Turtle():
    
    def __init__(self, x, y, a):
        self.x = x
        self.y =y
        self.a = a
    
    def state(self):
        return [self.x, self.y, self.a]
    
    def load(self, l):
        self.x = l[0]
        self.y = l[1]
        self.a = l[2]
