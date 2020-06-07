def setup():
    size(500,500)
    draw_()

def draw():
    pass

def draw_():
    iter_n = 5
    
    lWidth = 20
    rad = lWidth
    
    translate(width*.5, height*.5)
    
    for iter in range(iter_n):
        
        px0 = 0;
        py0 = 0;
        px1 = 0;
        py1 = 0;
        
        shad_n = 0
        
        for shad in range(shad_n+1):
            
            seg_n = 3
            beginShape(QUAD)
            
            for seg in range(seg_n):
                
                delt = float(seg)/seg_n
                angle = delt*TWO_PI
                x = cos(seg+angle)*rad
                y = sin(seg+angle)*rad
                
                a0 = angle
                a1 = angle+PI
                x0 = x + cos(a0)*lWidth
                y0 = y + sin(a0)*lWidth
                x1 = x + cos(a1)*lWidth
                y1 = y + sin(a1)*lWidth
                
                c = color(0)
                #noStoke()
                fill(c)
                
                vertex(px0, py0)
                vertex(x0,y0)
                vertex(x1,y1)
                vertex(px1,py1)
                
                px0 = x0
                py0 = y0
                px1 = x1
                py1 = y1
            
            endShape()

def keyPressed():
    if keyCode == 32:
        background(200)
        draw_()
