class Element(object):
    
    def __init__(self, x,y):
        self.x = x
        self.y = y
        
    def move(self, dx, dy):
        self.x += dx
        self.y += dy
    

class Circle(Element):
    
    def __init__(self,x,y,s=50,c=color(50)):
        super(Circle, self).__init__(x,y)
        self.s = s
        self.c = c
    
    def draw(self):
        fill(self.c)
        circle(self.x, self.y, self.s)
