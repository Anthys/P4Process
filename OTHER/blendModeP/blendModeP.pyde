def setup():
    size(500,500);
    #blendMode(REPLACE);
    draw_();
    
def draw():
    pass

def draw_():
    for i in range(15):
        c = color(random(255), 100, 200);
        x = random(width);
        y = random(height);
        s = random(20,300);
        fill(c,50);
        noStroke();
        circle(x,y,s);
    
def keyPressed():
    if keyCode == 32:
        background(200);
        draw_()
