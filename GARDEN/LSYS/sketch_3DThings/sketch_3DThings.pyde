from turtle import *

add_library("peasycam")

def setup():
    size(700,700,P3D)
    global rules, t, th, actions, operations, initial,initial_rest,mx_n,cam
    t = 0
    rules = {}
    th = 'a'
    operations = ""
    initial = [0,0,0,0,0,0]
    initial_rest = [5,PI]
    mx_n = 1
    cam = PeasyCam(this, 300)
    
    
def init():
    global rules, operations,initial,mx_n,initial_rest
    if th == "1_8":
        rules["F"] = "F+f-FF+F+FF+Ff+FF-f+FF-F-FF-Ff-FFF"
        rules["f"] = "ffffff"
        operations = "F-F-F-F"
        initial = [0,0,0,0,0,PI/2]
        initial_rest=[4,PI*25.7/180]
        mx_n = 2
    elif th == "a":
        rules["A"] = "B-F+CFC+F-D&F^D-F+&&CFC+F+B//"
        rules["B"] = "A&F^CFB^F^D^^-F-D^|F^B|FC^F^A//"
        rules["C"] = "|D^|F^B-F+C^F^A&&FA&F^C+F+B^F^D//"
        rules["D"] = "|CFB-F+B|FA&F^A&&FB-F+B|FC//"
        operations = "A"
        initial = [0,0,0,1,0,0]
        initial_rest=[10,PI*90/180]
        mx_n = 3
    operations = transform_process(operations, rules, mx_n)
    
    
def make_rpr(r=20):
    stroke(255,0,0)
    line(0,0,0,r,0,0)
    stroke(0,255,0)
    line(0,0,0,0,r,0)
    stroke(0,0,255)
    line(0,0,0,0,0,r)
        

def process_basic(op, initial, inital_rest):
    background(200)
    strokeWeight(10)
    point(100,0,0)
    posh = []
    turtle = Turtle()
    turtle.load(initial)
    l = initial_rest[0]
    d = initial_rest[1]
    
    make_rpr()
    
    stroke(0)
    
    for i,v in enumerate(op):
        #print(turtle.state())
        if v == "F":
            xx = turtle.x + turtle.ax*l
            yy = turtle.y + turtle.ay*l
            zz = turtle.z + turtle.az*l
            line(turtle.x,turtle.y,turtle.z,xx,yy,zz)
            turtle.x = xx
            turtle.y = yy
            turtle.z = zz
        elif v == "f":
            xx = turtle.x + turtle.ax*l
            yy = turtle.y + turtle.ay*l
            zz = turtle.z + turtle.az*l
            #line(turtle.x,turtle.y,turtle.z,xx,yy,zz)
            turtle.x = xx
            turtle.y = yy
            turtle.z = zz
        elif v == "+":
            theta = d
            nx,ny,nz = rotate_x(turtle.ax,turtle.ay,turtle.az,theta)
            turtle.ax,turtle.ay,turtle.az = nx,ny,nz
        elif v == "-":
            theta = -d
            nx,ny,nz = rotate_x(turtle.ax,turtle.ay,turtle.az,theta)
            turtle.ax,turtle.ay,turtle.az = nx,ny,nz
        elif v == "|":
            theta = PI
            nx,ny,nz = rotate_x(turtle.ax,turtle.ay,turtle.az,theta)
            turtle.ax,turtle.ay,turtle.az = nx,ny,nz
        elif v == "&":
            theta = d
            nx,ny,nz = rotate_y(turtle.ax,turtle.ay,turtle.az,theta)
            turtle.ax,turtle.ay,turtle.az = nx,ny,nz
        elif v == "^":
            theta = -d
            nx,ny,nz = rotate_y(turtle.ax,turtle.ay,turtle.az,theta)
            turtle.ax,turtle.ay,turtle.az = nx,ny,nz
        elif v == "/":
            theta = -d
            nx,ny,nz = rotate_z(turtle.ax,turtle.ay,turtle.az,theta)
            turtle.ax,turtle.ay,turtle.az = nx,ny,nz
        elif v == "\\":
            theta = -d
            nx,ny,nz = rotate_z(turtle.ax,turtle.ay,turtle.az,theta)
            turtle.ax,turtle.ay,turtle.az = nx,ny,nz
        elif v == "[":
            posh += [turtle.state()]
        elif v == "]":
            turtle.load(posh[-1])
            posh = posh[:-1]

def rotate_x(ax,ay,az, theta):
    ny = ay*cos(theta)-sin(theta)*az
    nz = ay*sin(theta)+cos(theta)*az
    nx = ax
    return nx,ny,nz

def rotate_y(ax,ay,az,theta):
    nx = ax*cos(theta)-sin(theta)*az
    nz = -ax*sin(theta)+cos(theta)*az
    ny = ay
    return nx,ny,nz

def rotate_z(ax,ay,az, theta):
    nx = ax*cos(theta)-sin(theta)*ay
    ny = -ax*sin(theta)+cos(theta)*ay
    nz = az
    return nx,ny,nz
    


def transform_process(operations, rules,n):
    for i in range(n):
        new_op = ""
        for j in operations:
            if j in rules.keys():
                new_op += rules[j]
            else:
                new_op += j
        operations = new_op
    return new_op

def draw():
    global t
    
    if t == 0:
        init()
    
    #translate(width/2, height/2)
    
    t += 1
    if False:
        pass
    else:
        process_basic(operations, initial,initial_rest)
