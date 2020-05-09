class State():
    
    def __init__(self, ptc =10):
        self.x = [0.0 for i in range(ptc)]
        self.y = [0.0 for i in range(ptc)]
        self.oldX = [0.0 for i in range(ptc)]
        self.oldY = [0.0 for i in range(ptc)]
        self.vx = [0.0 for i in range(ptc)]
        self.vy = [0.0 for i in range(ptc)]
        self.p = [0.0 for i in range(ptc)]
        self.pNear = [0.0 for i in range(ptc)]
        self.g = [0.0 for i in range(ptc)]
        self.mesh = []
