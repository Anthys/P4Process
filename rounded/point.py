class Point():

    def __init__(self, x, y,s=5):
        self.x =x 
        self.y =y
        self.s = s
    
    def draw(self):
        strokeWeight(self.s)
        point(self.x,self.y)
