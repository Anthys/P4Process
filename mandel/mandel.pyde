MAX_ITER = 80



type = "m"

if type == "m":
    RE_START = -2
    RE_END = 1
    IM_START = -1
    IM_END = 1
    a,b = 1000,800
elif type == "j":
    RE_START = -1
    RE_END = 1
    IM_START = -1.2
    IM_END = 1.2
    a,b = 900,1000

size(1000,800)
background(212)

palette = []

#c0 = complex(0.285, 0.01)
#c0 = complex(-0.7269, 0.1889)
c0 = complex(-0.8, 0.156)
#c0 = complex(-0.4, 0.6)
c0 = complex(0.3,0.)

def julia(c, z0):
    z = z0
    n = 0
    while abs(z) <= 2 and n < MAX_ITER:
        z = z*z + c
        n += 1    
    return n

def mandelbrot(c):
    z = 0
    n = 0
    while abs(z) <= 2 and n < MAX_ITER:
        z = (z*z + c).conjugate()
        n += 1
    return n

if True:
    for x in range(0, width):
        for y in range(0, height):
            x = float(x)
            y = float(y)
            # Convert pixel coordinate to complex number
            c = complex(RE_START + (x / width) * (RE_END - RE_START),
                        IM_START + (y / height) * (IM_END - IM_START))
            #c = complex(x,y)
            #c = complex(x/width, y/height)
            #m = mandelbrot(c)
            m = mandelbrot(c)
            if False and int(random(1,500)) == 400:
                print(x,y)
                print(c)
                print(m)
                break
            # Compute the number of iterations
            #print(m)
            # The color depends on the number of iterations
            a = 255 - int(m * 255 / MAX_ITER)
            # Plot the point
            stroke(a,a,a)
            point(x, y)

#print(1)
#stroke(0,0,0)
#point(width/2, height/2)
