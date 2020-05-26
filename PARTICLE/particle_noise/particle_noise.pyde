from particle import *

def setup():
    size(500,500)
    global t, particles, img
    t = 0.
    particles= []
    n= 200
    res = 5.
    a = 3.
    for i in range(n):
        particles.append(Particle(random(0,width), random(0,height),random(-a,a), random(-a,a), res = res))
    
    img = createImage(width, height, RGB)
    for i in range(img.width):
        for j in range(img.height):
            uv = res*PVector(float(i)/img.width +1 , float(j)/img.height+1)
            img.pixels[i+img.width*j] = color(noise(uv.x, uv.y)*255)  

def draw():
    #background(200)
    #image(img, 0,0)
    for p in particles:
        p.draw()
