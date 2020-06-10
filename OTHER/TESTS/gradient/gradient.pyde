def setup():
    size(200,100)
    draw_n()
    
def draw_two_colrs():
    background(200)
    
    c1 = color(200, 100, 180)
    c2 = color(50, 150, 255)
    
    loadPixels()
    for x in range(width):
        for y in range(height):
            c = lerpColor(c1, c2, float(x)/float(width))
            pixels[x+width*y] = c
    updatePixels()
          
def draw_n():
    background(200)
    
    c1 = color(200, 100, 180)
    c2 = color(50, 150, 255)
    c3 = color(100, 190, 45)
    cols = [c1, c2, c3]
    
    loadPixels()
    for x in range(width):
        for y in range(height):
            my_x = float(x)/float(width)*(len(cols)-1)
            i1 = floor(my_x)
            
            c = lerpColor(cols[i1], cols[i1+1], float(my_x)%1)
            pixels[x+width*y] = c
    updatePixels()
                
