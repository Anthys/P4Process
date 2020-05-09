from particle import *

def setup():
    size(500,500)
    global t,th, gridsize, particles, matrix
    t = 0
    th= "a"
    gridsize = 50
    numbParticle = 50
    particles = [randParticle() for i in range(numbParticle)]
    matrix = [[Grid(noise(float(i)*2/gridsize)*2-1, noise(float(j)*2/gridsize)*2-1) for i in range(gridsize)] for j in range(gridsize)]

def clamp(a,b,c):
    temp = max(a,b)
    return min(temp,c)    

def draw():
    global t
    background(200)
    t+= 1
    
    for j,v in enumerate(matrix):
        for i,k in enumerate(v):
            k.vx *= 0.99
            k.vy *= 0.99
            k.vx = clamp(-5,k.vx,5)
            k.vy = clamp(-5,k.vy,5)
            #fill((abs(k.vx)+abs(k.vy))*255/3, 0,0,50)
            fill((k.pop)*255/5, 0,0,50)
            rect(i*gridsize,j*gridsize,gridsize,gridsize)
            middlex,middley=i*gridsize+gridsize/2,j*gridsize+gridsize/2
            line(middlex,middley, middlex+k.vx*50,middley+k.vy*50)
            k.pop = 0
    
    for i,p in enumerate(particles):
        p.update()
        temp = p.get_pos_on_grid(gridsize)
        gx,gy =int(temp.x),int(temp.y)
        tpg = matrix[gy][gx]
        tpg.pop += 1
        p.vx += tpg.vx
        p.vy += tpg.vy
        if gy+1 < len(matrix):
            matrix[gy][gx].vx -= 0.3
        if gy-1 >=0:
            matrix[gy][gx].vx += 0.3
    
    strokeWeight(1)
    stroke(150)
    for i in range(floor(width/gridsize)):
        line(i*gridsize, 0,i*gridsize, height)
    for j in range(floor(height/gridsize)):
        line(0,j*gridsize, width,j*gridsize)
        
    for i,p in enumerate(particles):
        p.border()
        p.draw()

def randParticle():
    return Particle(random(width), random(height))
    
    
    
