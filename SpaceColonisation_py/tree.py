from branch import *
from leaf import *

class Tree():

    def __init__(self, max_dist, min_dist):

        max_leaves = 500
        self.leaves = []
        self.branches = []
        self.max_dist = max_dist
        self.min_dist = min_dist

        for i in range(max_leaves):
            self.leaves.append(Leaf())
        
        pos = PVector(width/2, height)
        dirr = PVector(0,-1)
        root = Branch(pos, dirr)

        self.branches.append(root)

        current = Branch.newFromBranch(root)

        while not self.closeEnough(current):
            trunk = Branch.newFromBranch(current)
            branches.append(trunk)
            current = trunk

    def closeEnough(self,b):
        for l in self.leaves:
            d = PVector.dist(b.pos, l.pos)
            if d<self.max_dist:
                return True
        return False
    
    def grow(self):
        for l in self.leaves:
            closest = None
            clostestDir = None
            record = -1

            for b in self.branches:
                dirr = PVector.sub(l.pos, b.pos)
                d = dirr.mag()
                if d < self.min_dist:
                    l.reached = True
                    closest = None
                    break
                elif d > self.max_dist:
                    pass
                elif closest == None or d < record:
                    closest = b
                    closestDir = dirr
                    record = d
                
            if closest != None:
                closestDir.normalize()
                closest.dir.add(closestDir)
                closest.count += 1
        for i in range(len(self.leaves)-1, -1, -1):
            if self.leaves[i].reached:
                self.leaves = self.leaves[:i] + self.leaves[i+1:]
        
        for i in range(len(self.branches)-1, -1,-1):
            b = self.branches[i]
            if b.count > 0 :
                b.dir.div(b.count)
                b.dir.normalize()
                newB = Branch.newFromBranch(b)
                self.branches.append(newB)
                b.reset()

    def show(self):
        for i in self.leaves:
            i.show()

        for b in self.branches:
            if b.parent != None:
                stroke(255)
                line(b.pos.x, b.pos.y, b.parent.pos.x, b.parent.pos.y)
