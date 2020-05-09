class State():
    
    def __init__(self, ptc =10):
        self.pos = [PVector(0,0) for i in range(ptc)]
        self.oldpos = [PVector(0,0) for i in range(ptc)]
        self.v = [PVector(0,0) for i in range(ptc)]
        self.p = [0.0 for i in range(ptc)]
        self.pNear = [0.0 for i in range(ptc)]
        self.g = [0.0 for i in range(ptc)]
        self.mesh = []
