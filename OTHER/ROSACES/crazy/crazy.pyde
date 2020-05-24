# FROM https://www.bit-101.com/blog/2020/04/animated-sinusoidal-cardiods/

def setup():
    size(500,500)
    global t
    t = 0.
    

def draw():
    global t
    t += 1.
    if frameCount == 1:
        background(200)
        
        
        radius = 200 
        res = 1440
        slice = PI*2/res
        mul = 25
        stroke(0,20)
        translate(width/2, height/2)
        
        for i in range(res):
            a1 = slice*i
            a2 = slice*i*mul
            line(cos(a1)*radius, sin(a1)*radius, cos(a2)*radius, sin(a2)*radius)
