import copy
add_library("videoExport")

def setup():
    global img, t, pool
    size(481,680)
    t = 0.
    img = loadImage("alpha.jpg")
    img.resize(width, height)
    pool = [make_map_B()]
    
def fbm(p,h=1.,n=1):
    t = 0.
    for i in range(n):
        f = pow(2.0, float(i))
        a = pow(f, -h)
        t += a*noise(f*p.x, f*p.y, f*p.z)
    return t

def make_map_B():
    temp = createImage(width, height, RGB)
    for i in range(width):
        for j in range(height):
            d = 10
            x = d*float(i)/width
            y = d*float(j)/height
            p = PVector(x,y,0)
            q = PVector(fbm(p+PVector(0,0,0)), fbm(p+PVector(5.2, 1.3,0)))
            v = fbm(p+4.0*q)
            temp.pixels[i+width*j] = color(v*255)
    return temp

def make_map_A():
    temp = createImage(width, height, RGB)
    for i in range(width):
        for j in range(height):
            d = 10
            x = d*float(i)/width
            y = d*float(j)/height
            a = PVector(x,y,0)
            v = fbm(a, 1, 1)
            temp.pixels[i+width*j] = color(v*255)
    return temp

def make_perlin_map():
    temp = createImage(width, height, RGB)
    for i in range(width):
        for j in range(height):
            c = 3
            x = float(i)*c
            y = float(j)*c
            temp.pixels[i+width*j]=color(noise(x/width,y/height)*255)
    return temp

def clamp(a,b,c):
    return max(min(b,c),a)

def draw():
    global t
    t += 1
    image(pool[0],0,0)
