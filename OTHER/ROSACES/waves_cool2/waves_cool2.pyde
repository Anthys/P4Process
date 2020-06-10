# FROM https://www.bit-101.com/blog/2020/04/animated-sinusoidal-cardiods/

def setup():
    size(700,700)
    global t
    t = 0.
    

def draw():
    global t
    t += 1.
    if frameCount == 1 or True:
        background(200)
        
        
        radius = 200 
        res = 1440
        slice = PI*2/res
        mul = 2+t/100
        waves = 6#+t/10
        stroke(0,20)
        translate(width/2, height/2)
        phase = t/10
        
        for i in range(res):
            a1 = slice*i
            a2 = slice*i*mul
            r1 = radius + sin(a1*waves+phase)*100
            r2 = radius + sin(a2*waves+phase)*100
            line(cos(a1)*r1, sin(a1)*r1, cos(a2)*r2, sin(a2)*r2)
    #saveFrame("out-####.png")
