import random, copy

def repart_random(mid, incert):
    #pass
    return random.uniform(mid-incert, mid+incert)

def repart_gaussian(mid,incert):
    return random.gauss(mid, incert*0.3)
    

class Subject(object):
    
    def __init__(self):
        self.genome = {}
        self.traits = {}
    
    def birth(self):
        for i,v in self.genome.items():
            self.traits[i] = v.gener_trait()
    
    def mate(self,other, method="melt"):
        temp = copy.deepcopy(self)
        
        for k in self.genome.keys():
            if method == "melt":
                temp.genome[k] = self.genome[k].melt(other.genome[k])
            elif method == "cross":
                temp.genome[k] = self.genome[k].cross(other.genome[k])
        return temp
    
    def add_gene(self,k, gene):
        self.genome[k] = gene
                

class Gene():
    
    def __init__(self,val = 0., priority ="d", incerti=1., typee = "float", repart = "gauss"):
        self.priority = priority
        self.val = val
        self.type = typee
        self.incerti=incerti
        print(repart, incerti, val)
        if callable(repart): #== function:
            self.repart = repart
        if repart == "gauss":
            self.repart = repart_gaussian
        else:
            self.repart = repart_random
    
    def gener_trait(self):
        temp = 0
        trait = 0
        
        if self.incerti == 0:
            return Trait(self.val)
        
        if self.type == "int":
            # Maybe a fonction to change the uniform repartition in something more gaussian looking
            temp = self.repart(self.val, self.incerti)
            temp = int(temp)
            trait = Trait(temp)
        elif self.type == "float":
            temp = self.repart(self.val, self.incerti)
            trait = Trait(temp)
        return trait
        
    
    def melt(self,other):
        temp = Gene((self.val+other.val)/2, self.priority, max(self.incerti,other.incerti), self.type, self.repart)
        return temp 
    
    def cross(self,other):
        if self.priority_to_value()  > other.priority_to_value():
            return copy.deepcopy(self)
        elif self.priority_to_value() < other.priority_to_value():
            return copy.deepcopy(other)
        else:
            if random() > 0.5:
                return copy.deepcopy(self)
            else:
                return copy.deepcopy(other)
    
    def priority_to_value(self):
        if self.priority.lower() == "d":
            return float("inf")
        elif self.priority.lower() == "r":
            return -1.
        else:
            return float(self.priority)
    
class Trait():
    
    def __init__(self, val = 0.):
        self.val = val

class ColorRect(Subject):
    
    def __init__(self,x=0.,y=0.,s=20.,c=100.):
        super(ColorRect, self).__init__()
        gx = Gene(x, "d", 100.)
        gy = Gene(y, "d", 100.)
        self.add_gene("x", gx)
        self.add_gene("y", gy)
        self.s = s
        self.c = c
    
    def draw(self):
        rect(self.traits["x"].val, self.traits["y"].val, self.s, self.s)
        
