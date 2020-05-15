import copy

def setup():
    global img, pimage, rimage, pool, ci
    size(481,680)
    img = loadImage("alpha.jpg")
    img.resize(width, height)
    pimage = make_perlin_map()
    rimage = melt_image(img, pimage)
    pool = [img, pimage, rimage]
    ci = len(pool)-1

def make_perlin_map():
    temp = createImage(width, height, RGB)
    for i in range(width):
        for j in range(height):
            c = 10
            x = float(i)*c
            y = float(j)*c
            temp.pixels[i+width*j]=color(noise(x/width,y/height)*255)
    return temp

def clamp(a,b,c):
    return max(min(b,c),a)

def melt_image(a,b):
    c = a.copy()
    for i in range(width):
        for j in range(height):
            bright = red(b.pixels[i+width*j])
            v = map(bright, 0,255,0,20)
            v = int(v)
            if i == 50:
                print(v)
            if i-v >= 0 and j-v >= 0:
                c.pixels[(i-v)+width*(j-v)] = a.pixels[i+width*j]
    return c

def draw():
    #image(img,0,0)
    #image(pimage, 0,0)
    image(pool[ci], 0,0)
    
def keyPressed():
    if keyCode == 32:
        global ci
        ci = (ci+1)%len(pool)
