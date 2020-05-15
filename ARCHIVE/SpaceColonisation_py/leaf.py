class Leaf():
    
    def __init__(self):
        self.pos = PVector.random2D()
        self.pos.mult(random(width/2))
        self.pos.x += width/2
        self.pos.y += height/2
        self.reached = False
    
    def show(self):
        fill(255)
        noStroke()
        ellipse(self.pos.x, self.pos.y, 4,4)

    def reached(self):
        self.reached = True
