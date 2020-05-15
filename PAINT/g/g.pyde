import copy
add_library("videoExport")

def setup():
    global img, pimage, rimage, pool, ci, f, t, video
    size(481,680)
    img = loadImage("alpha.jpg")
    img.resize(width, height)
    pimage = make_perlin_map()
    f = 20
    rimage = melt_image(img, pimage, 100)
    pool = [img, pimage, rimage]
    ci = len(pool)-1
    t = 0.

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

def melt_image(a,b,f=20):
    #c = a.copy()
    c = createImage(a.width, a.height, RGB)
    for i in range(width):
        for j in range(height):
            bright = red(b.pixels[i+width*j])
            v = map(bright, 0,255,0,f)
            v = floor(v)
            if i == 50:
                print(v)
            n_i = (i-v)
            n_j = (j-v)
            n_i = map(n_i, -f, width, 0, width)
            n_j = map(n_j, -f, height, 0, height)
            n_i = floor(n_i)
            n_j = floor(n_j)
            new_i = n_i+width*n_j
            c.pixels[new_i] = a.pixels[i+width*j]
            c.pixels[new_i+1+width] = a.pixels[i+width*j]
    return c

def melt_image_better(a,f=20):
    c = createImage(a.width, a.height, RGB)
    width = a.width
    height = a.height
    for i in range(width):
        for j in range(height):
            dd = 3
            x = float(i)*dd/width
            y = float(j)*dd/height
            bright = noise(x,y, t/10)*255#red(b.pixels[i+width*j])
            v = map(bright, 0,255,0,f)
            #v = floor(v)
            n_i = (i-v)
            n_j = (j-v)
            n_i = map(n_i, -f, width, 0, width)
            n_j = map(n_j, -f, height, 0, height)
            n_i = floor(n_i)
            n_j = floor(n_j)
            new_i = n_i+width*n_j
            c.pixels[new_i] = a.pixels[i+width*j]
            c.pixels[new_i+1+width] = a.pixels[i+width*j]
    return c

def draw():
    global rimage, t
    image(melt_image_better(img, 100), 0,0)
    t += 1
    #saveFrame("out/out-####.png")
    
def keyPressed():
    if keyCode == 32:
        global ci
        ci = (ci+1)%len(pool)
