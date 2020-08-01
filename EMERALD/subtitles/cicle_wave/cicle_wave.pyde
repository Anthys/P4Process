def setup():
    size(500,500);
    draw_()

def draw():
    pass

def draw_():
    px, py = -50, 0
    stroke(0)
    strokeWeight(5);
    translate(width/2, height/2)
    r = 200
    n = 180
    noFill()
    beginShape()
    for i in range(n):
        noi = random(1)**.3*200
        angle = TAU/n*i+randomGaussian()*.01
        r1 = r-noi*(abs((PI-angle)/PI)**4)
        x = r1*cos(angle);
        y = r1*sin(angle);
        vertex(x, y);
        stroke(0,20);
        line(px,py, x, y)
    
    stroke(0)
    strokeWeight(5);
    endShape(CLOSE)
    strokeWeight(2)
    stroke(0)
    fill(255)
    circle(px,py,10)
    strokeWeight(3)
    point(px,py); 
        
def keyPressed():
    background(200)
    draw_();
