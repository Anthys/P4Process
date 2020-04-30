from leaf import *
from tree import *

max_dist = 100
min_dist = 10

tree = None

def setup():
    global tree
    size(600,600)
    tree = Tree(max_dist, min_dist)

def draw():
    background(51)
    tree.show()
    tree.grow()
