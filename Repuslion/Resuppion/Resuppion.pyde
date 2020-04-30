from particle import Particle
from spring import Spring
import sys

def setup():
    global particules, n_particles, elastiques
    size(800,600)

    elastiques = []
    particules = []
    n_particles = 4
    
    for n in range(n_particles):
        radius = 200
        angle = TWO_PI  / n_particles
        x = radius * sin(angle * n) + map(noise(random(-20, 20)), 0, 1, -20, 20) 
        y = radius * cos(angle * n) 
        particules.append(Particle(width / 2 + x, height / 2 + y))
    
    elastiques = [[0,1],[1,2],[2,3],[0,3]]
    particules[0].anchor = True

t = 0

def draw():
    global particules, elastiques, t
    background(0)
    dt = millis() -t
    t = millis()
    it= 0.0001

    for e in particules:
        e.draw()
        e.move(it)
        
    
    
    for couple in elastiques:
        e1 = particules[couple[0]]
        e2 = particules[couple[1]]
        if not e1.anchor:
            e1.attract_To(e2)
        if not e2.anchor:
            e2.attract_To(e1)
        stroke(255)
        strokeWeight(.2)
        line(e1.pos.x, e1.pos.y, e2.pos.x, e2.pos.y)
        
    
    for e in particules:
        if not e.anchor:
            for e2 in particules:
                if e2 != e:
                    e.repelFrom(e2)
        
    
        
    if False:
        for e in range(n_particles):
            n = 1
            if e+n == n_particles:
                n = - (n_particles - 1)
            elastiques.append(Spring(particules[e+n].pos.x, particules[e+n].pos.y, 1))
    
            if len(elastiques) - 1 == n_particles:
                del elastiques[0]
    
        for j, e in enumerate(elastiques):
            for i, p in enumerate(particules):
                e.displayLine(p)
                e.connect(p)
 
    if False:
        beginShape()
        fill(255)
        stroke(255)
        for e in range(n_particles):
            vertex(particules[e].pos.x,particules[e].pos.y)
        endShape()
 
 
    if False:
        for i, e in enumerate(particules):
            for j, f in enumerate(particules):
                if e != f:
                    force = PVector.sub(e.pos, f.pos)
                    dsq = force.magSq()
                    strength = (e.g * e.mass * f.mass) / dsq
                    force *= -strength / dsq 
                    f.applyForce(force)
                    e.applyForce(force)
        saveFrame("frames/####.png")
