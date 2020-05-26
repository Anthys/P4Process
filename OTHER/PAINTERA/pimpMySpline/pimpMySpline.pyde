## GOAL https://www.shvembldr.com/gallery/motion-generative/nox


## DIMINUEr la taille du tracé plus on avance dans le trait

### USE Bezier or curves to trace the lines: 
## we save the points of the curve in an array and then trace the path
## with n=fract_l circles with deceasing sizes, following a path that is
## given by the Bezier curves between these points.

from coolspline import *


def setup():
    size(500, 500, P2D)
    global t, a
    t = 0.
    cur_example()
    
def cur_example():
    example_4()
    
def example_1():
    img = createGraphics(width, height)
    
    draw_cool_curve(img, width/2,height/2,type ="dir", l=200,n=2, col=color(255,0,0,255), debug=True)
    image(img, 0,0)

def example_2():
    img = createGraphics(width, height)
    n = 50
    for i in range(n):
        x = random(0,width)
        y = random(0, height)
        draw_cool_curve(img, x,y,type ="dir", l=200,n=2, col=color(255,0,0,100), debug=False)
    image(img, 0,0)

def example_3():
    img = createGraphics(width, height)
    n = 3000
    radius = 200
    for i in range(n):
        r = random(0, radius*2)/2
        theta = random(0, TWO_PI*2)
        x = cos(theta)*r+width/2
        y = sin(theta)*r + height/2
        P = make_cool_curve(img, x,y,type ="dir", l=50,n=2)
        plot_cool_curve(img, P, debug = False)
    image(img, 0,0)
    
def example_4():
    img = createGraphics(width, height)
    n = 1000
    radius = 200
    for i in range(n):
        r = random(0, radius*2)/2
        theta = random(0, TWO_PI*2)
        x = cos(theta)*r+width/2
        y = sin(theta)*r + height/2
        P = make_cool_curve(img, x,y,type ="dir", l=50,n=2)
        plot_cool_curve(img, P, debug = False)
    image(img, 0,0)
 
def setup2():
    size(700,700,P2D)
    global t,sh
    t = 0.
    init()
    sh = loadShader("sph.glsl")
    draw_()
    
def init():
    noiseSeed(int(random(0,1000)))


def get_x_y2(i, radius, n, poww=.5, fract=(1+sqrt(5))/2):
    #dst = var1*i/(numPoints-1)#pow(,poww)
    #dst = pow(i/(numPoints-1), 1)
    dst = radius*pow(i/(n-1.), poww)
    angle = 2*PI*fract*i
    x = dst*cos(angle)
    y = dst*sin(angle)
    return x, y


def get_x_y(i, radius):
    r = radius*random(0,1)
    a = random(0,1)*TWO_PI
    rx = r*cos(a)
    ry = r*sin(a)
    return rx, ry

def draw_():
    global sh
    img = createGraphics(width, height)
    background(200)
    n = 100
    translate(width/2, height/2)
    radius = 200
    for i in range(n):
        #rx,ry = get_x_y2(i, radius, n)
        rx,ry = get_x_y(i,radius)
        pos = PVector(rx,ry)
        uv = PVector(pos.x/height, pos.y/width)+PVector(1,1)
        col = colpoint(pos.x, pos.y)
        img.fill(0,0)
        make_curve(img, rx,ry, l=300,n=10, col = col)
    sh.set("u_resolution", float(width), float(height))
    sh.set("u_time", float(t))
    sh.set("texture", img)
    image(img, -width/2,-height/2)
    
def mnoise(a,b,c=0):
    return noise(a,b,c)*2-1

def colpoint(x,y):
    uv = PVector(x/width, y/height)+PVector(1,1)
    varc = 10
    col = color(noise(uv.x*varc, varc*uv.y, 25)*255, 30,noise(uv.x*varc, varc*uv.y, 75)*255,20)
    return col 



def mycoolspline(img, x, y, l = 90, n = 2, col = color(0,0,0), vars = None):
    pass
    

def make_curve(img, x,y, l=90,n=2, col=color(0,0,0,0)):
    pos = PVector(x,y)
    uv = PVector(x/width, y/height) 
    
    partial_l = float(l)/n
    
    s = 5*noise(3*uv.x,3*uv.y)
    
    img.beginDraw()
    img.translate(width/2, height/2)
    img.strokeWeight(s)
    img.stroke(col)
    
    fract_s = s/n 
    
    P = [pos, pos, pos]
    
    for i in range(n):
        img.strokeWeight(i)
        aa =2
        varx = aa*(pos.x/width+1)
        vary = aa*(pos.y/height+1)
        base_noise_x = 100+1*i*.5
        base_noise_y = 150+1*i*.5
        aaa = PI/2*i
        n_pos = pos + 20*PVector(sin(aaa),sin(aaa))  + partial_l*PVector(mnoise(varx,vary, base_noise_x),mnoise(varx,vary, base_noise_y))
        P.append(n_pos)
        pos = n_pos
    
    P.append(n_pos)
    P.append(n_pos)
    
    ns = 20 # TAILLE MAXIMALE DE LA SPHERE
    n= 20
    nj = len(P)-3
    for j in range( 1, len(P)-2 ):  # skip the ends
        for tt in range(n):  # t: 0 .1 .2 .. .9
            q = float((tt+(j-1)*n))/(nj*n)
            p = spline_4p( float(tt)/n, P[j-1], P[j], P[j+1], P[j+2] )
            s = ns-ns*q
            img.strokeWeight(s)
            img.point(p.x,p.y)
            #spray(img, p.x,p.y, int(s))
    
    img.strokeWeight(s+2)
    var1 = 20
    col2 = colpoint(n_pos.x+var1, n_pos.y+var1)
    img.stroke(col2)
    #img.point(n_pos.x, n_pos.y)
    img.endDraw()

def spray(img, x,y,s):
    n = s*5
    img.strokeWeight(1)
    for i in range(n):
        r = random(0,s)
        a = random(0,TWO_PI)
        img.point(r*cos(a)+x, y+r*sin(a))

def spline_4p( t, p_1, p0, p1, p2 ):
    """ Catmull-Rom
        (Ps can be numpy vectors or arrays too: colors, curves ...)
    """
        # wikipedia Catmull-Rom -> Cubic_Hermite_spline
        # 0 -> p0,  1 -> p1,  1/2 -> (- p_1 + 9 p0 + 9 p1 - p2) / 16
    # assert 0 <= t <= 1
    return (t*((2-t)*t - 1)* p_1
        + (t*t*(3*t - 5) + 2) * p0 
        + t*((4 - 3*t)*t + 1) * p1
        + (t-1)*t*t         * p2 ) / 2

def draw():
    global t
    t += 1.
    #draw_()
    
def keyPressed():
    if key == "p":
        saveFrame("out-####.png")
    elif key == "c":
        cur_example()
    elif keyCode == 32:
        init()
        cur_example()
        #draw_()
