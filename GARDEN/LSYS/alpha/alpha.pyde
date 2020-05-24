from turtle import *

def setup():
    size(700,700)
    global rules, t, th, actions, operations, initial,mx_n
    t = 0
    rules = {}
    th = 'f'
    operations = ""
    initial = [0,0,0,0,0]
    mx_n = 1
    
    
def init():
    global rules, operations,initial,mx_n
    if th == "1_8":
        rules["F"] = "F+f-FF+F+FF+Ff+FF-f+FF-F-FF-Ff-FFF"
        rules["f"] = "ffffff"
        operations = "F-F-F-F"
        initial = [0,0,0,5,PI/2]
        mx_n = 2
    elif th == "a":
        rules["F"] = "F[+F]F[-F]F"
        operations = "F"
        initial = [0,300,-PI/2,4,PI*25.7/180]
        mx_n = 5
    elif th == "b":
        rules["F"] = "F[+F]F[-F][F]"
        operations = "F"
        initial = [0,300,-PI/2,9,PI*20/180]
        mx_n = 5
    elif th == "c":
        rules["F"] = "FF-[-F+F+F]+[+F-F-F]"
        operations = "F"
        initial = [0,300,-PI/2,9,PI*22.5/180]
        mx_n = 4
    elif th == "e":
        rules["X"] = "F[+X][-X]FX"
        rules["F"] = "FF"
        operations = "X"
        initial = [0,300,-PI/2,2,PI*25.7/180]
        mx_n = 7
    elif th == "f":
        rules["F"] = "FF"
        rules["X"] = "F-[[X]+X]+F[+FX]-X"
        operations = "X"
        initial = [0,300,-PI/2,6,PI*22.5/180]
        mx_n = 5
    operations = transform_process(operations, rules, mx_n)
        
        

def process_basic(op, ix,iy,ia,step,d):
    posh = []
    turtle = Turtle(ix,iy,ia)
    l = step
    d = d
    for i,v in enumerate(op):
        if v == "F":
            xx = turtle.x + cos(turtle.a)*l
            yy = turtle.y + sin(turtle.a)*l
            line(turtle.x,turtle.y,xx,yy)
            turtle.x = xx
            turtle.y = yy
        elif v == "f":
            xx = turtle.x + cos(turtle.a)*l
            yy = turtle.y + sin(turtle.a)*l
            #line(turtle.x,turtle.y,xx,yy)
            turtle.x = xx
            turtle.y = yy
        elif v == "+":
            turtle.a += d
        elif v == "-":
            turtle.a -= d
        elif v == "[":
            posh += [turtle.state()]
        elif v == "]":
            turtle.load(posh[-1])
            posh = posh[:-1]

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
    
    translate(width/2, height/2)
    
    t += 1
    if False:
        pass
    else:
        process_basic(operations, initial[0], initial[1],initial[2],initial[3],initial[4])
        saveFrame("out.png")
