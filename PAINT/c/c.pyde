import copy

def setup():
    global img, pimage, rimage, pool, ci, f
    size(481,680)
    img = loadImage("alpha.jpg")
    img.resize(width, height)
    pimage = make_perlin_map()
    f = 20
    rimage = melt_image(img, pimage, 50)
    pool = [img, pimage, rimage]
    ci = len(pool)-1

def make_perlin_map():
    temp = createImage(width, height, RGB)
    for i in range(width):
        for j in range(height):
            c = 50
            x = float(i)*c
            y = float(j)*c
            temp.pixels[i+width*j]=color(noise(x/width,y/height)*255)
    return temp

def clamp(a,b,c):
    return max(min(b,c),a)

def melt_image(a,b,f=20):
    c = a.copy()
    for i in range(width):
        for j in range(height):
            bright = red(b.pixels[i+width*j])
            v = map(bright, 0,255,0,f)
            v = floor(v)
            if i == 50:
                print(v)
            if i-v >= 0 and j-v >= 0:
                c.pixels[(i-v)+width*(j-v)] = a.pixels[i+width*j]
                c.pixels[(i-v+1)+width*(j-v+1)] = a.pixels[i+width*j]
    return c

def draw():
    #translate(f,f)
    #image(img,0,0)
    #image(pimage, 0,0)
    image(pool[ci], 0,0)
    
def keyPressed():
    if keyCode == 32:
        global ci
        ci = (ci+1)%len(pool)
