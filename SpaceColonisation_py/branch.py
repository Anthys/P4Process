class Branch():

    def __init__(self, pos, direction):
        self.count = 0
        self.len = 5
        self.parent = None
        self.pos = pos.copy()
        self.dir = direction.copy()
        self.saveDir = direction.copy()
    
    @classmethod
    def newFromBranch(cls, branch):    
        pos = branch.next()
        dirr = branch.dir.copy()    
        a = cls(pos, dirr)
        a.parent = branch
        a.saveDir = a.dir.copy()
        return a

    def next(self):
        v = PVector.mult(self.dir, self.len)
        nextBranch = PVector.add(self.pos, v)
        return nextBranch
    
    def reset(self):
        self.count = 0
        self.dir = self.saveDir.copy()

    def show(self):
        if self.parent != None:
            stroke(255)
            line(self.pos.x, self.pos.y, self.parent.pos.x, self.parent.pos.y)
