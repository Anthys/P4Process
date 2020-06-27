

pos = PVector(0,0);
vel = PVector(0,0);
acc = PVector(0,0);

def setup():
    global pos, vel, acc
    size(500,500);
    pos = PVector(width/2, height/2);
    vel = PVector(.01,-2);
    



def draw():
    global pos, vel, acc
    strokeWeight(10);
    background(200);
    acc = PVector(0,.01);
    vel += acc;
    pos += vel;
    
    point(pos.x, pos.y);
