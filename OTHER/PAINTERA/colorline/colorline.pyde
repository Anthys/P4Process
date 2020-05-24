## GOAL https://www.shvembldr.com/gallery/motion-generative/nox

def setup():
    size(500,500)
    n = 500
    
    for i in range(n):
        rx = random(0,width)
        ry = random(0,height)
        pos = PVector(rx,ry)
        uv = PVector(pos.x/height, pos.y/width)
        stroke(uv.x*255, 0,0,255)
        varx = uv.x
        vary = uv.y
        rxx = rx+90*noise(varx,vary, 100)
        ryy = ry+90*noise(varx,vary, 200)
        line(rx, ry, rxx, ryy)
    

def draw():
    pass
