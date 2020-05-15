from object import Object


def randomcol():
    return color(random(255),random(255),random(255))

def setup():
    global things
    size(1000,800)
    
    things = []
    n_objects = 2
    
    things += [Object(width/2, height/2, random(30), random(30), randomcol())]
    things[0].anchor = True
    
    for i in range(n_objects-1):
        r = random(400)
        theta = random(PI*2)
        x = r*cos(theta) + width/2
        y = r*sin(theta) + height/2
        mass = random(30)
        r = random(30)
        c = randomcol()
        mxvel = 5
        vx = random(-mxvel,mxvel)
        vy = random(-mxvel,mxvel)
        things += [Object(x,y,mass,r,c,vx,vy)]
    


def draw():
    background(0)
    for o in things:
        if o.anchor == False:
            for o2 in things:
                if o2 != o:
                    o.attractTo(o2)
            o.update()
            o.border()
        o.draw()
    
