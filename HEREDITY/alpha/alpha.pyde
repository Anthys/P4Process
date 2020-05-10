from subject import *

def setup():
    size(500,500)
    global indiv
    indiv = []
    a,b = ColorRect(50,50), ColorRect(300,300)
    g1 = Gene(150,"d",10)
    g2 = Gene(300,"d",10)
    a.add_gene("x", g1)
    b.add_gene("x", g2)
    a.birth()
    b.birth()
    c = a.mate(b)
    c.birth()
    indiv += [a,b,c]
    
def draw():
    
    for i,v in enumerate(indiv):
        v.draw()
