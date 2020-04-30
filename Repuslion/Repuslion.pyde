from particle import Particle
from spring import Spring

def setup():
    global particules, n_particles, elastiques
    size(800,600)

    elastiques = []
    particules = []
    n_particles = 20
    
    for n in range(n_particles):
        radius = 200
        angle = TWO_PI  / n_particles
        x = radius * sin(angle * n) + map(noise(random(-20, 20)), 0, 1, -20, 20) 
        y = radius * cos(angle * n) 
        particules.append(Particle(width / 2 + x, height / 2 + y))

def draw():
    global particules, elastiques
    background(0)

    for e in particules:
        e.draw()
        e.update()

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