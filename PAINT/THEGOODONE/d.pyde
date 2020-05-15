def setup():
    size(481,680) #width and height should be similar to the picture's dimensions
    
    img = loadImage("alpha.jpg")
    loadPixels()
    for y in range(img.height):
        for x in range(img.width):
            i = x + y * img.width
            n = warp(x, y, .003, 615)
            c = img.pixels[i-int(n)]  #selecting a color's index accordingly with the noise value 
            pixels[i] = color(c)
    updatePixels()
    saveFrame("out2.png")
    
            
def warp(_x, _y, factor, n_range):
    n1 = noise((_x+0.0) * factor, (_y+0.0) * factor) * n_range
    n2 = noise((_x+5.2) * factor, (_y+1.3) * factor) * n_range
    q = PVector(n1, n2)
            
    n3 = noise(((_x + q.x * 4) + 1.7) * factor, ((_y + q.y * 4) + 9.2) * factor) * n_range
    n4 = noise(((_x + q.x * 4) + 8.3) * factor, ((_y + q.y * 4) + 2.8) * factor) * n_range
    r = PVector(n3, n4)
                
    return noise((_x + r.x * 4) * factor, (_y + r.y * 4) * factor) * n_range
