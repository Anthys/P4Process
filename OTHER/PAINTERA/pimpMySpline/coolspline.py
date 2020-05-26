class CoolSpline():
    
    def __init__(self, img, x , y, vertices):
        self.img = img
        self.x = x
        self.y = y 
        self.vertices = vertices
    
    def draw(self):
        self.img.beginDraw()
        self.img.beginShape()
        
        self.img.curveVertex(self.vertices[0].x, self.vertices[0].y)
        for p in self.vertices:
            self.img.curveVertex(p.x, p.y)
        self.img.curveVertex(p.x, p.y)
        
        self.img.endShape()
        self.img.endDraw()
        

def mycoolspline(img, x, y, l = 90, n = 2, col = color(0,0,0), vars = None):
    pass


def colpoint(x,y):
    uv = PVector(x/width, y/height)+PVector(1,1)
    varc = 10
    col = color(noise(uv.x*varc, varc*uv.y, 25)*255, 30,noise(uv.x*varc, varc*uv.y, 75)*255,20)
    return col 

def mnoise(a,b,c=0):
    return noise(a,b,c)*2-1

def find_it(dic, k, default = 0):
    if k not in dic.keys():
        return default
    else:
        return dic[k]

def make_cool_curve(img, x, y, l=90, n=2, type="dir", vars = None):
    pos = PVector(x,y)
    uv = PVector(x/width, y/height) 
    uvb = uv + PVector(1,1)
    
    partial_l = float(l)/n
    
    if vars is None:
        vars = {}
    
    var_s_a = find_it(vars, "var_s_a", 5) # Amplitude of size
    var_s_p = find_it(vars, "var_s_p", 3) # Resolution of size's noise grid
    
    s = var_s_a*noise(var_s_p*uv.x,var_s_p*uv.y)
    
    
    fract_s = s/n 
    
    P = [pos, pos]#, pos]
    
    for i in range(n):
        aaa = PI/2*i
        if type == "dir":
            res_a = (1./200)*(200-dist(width/2, height/2, pos.x, pos.y))
            tuvb = res_a*(PVector(pos.x/width, pos.y/height)+PVector(1,1))
            a = 2*TWO_PI*noise(res_a*tuvb.x ,res_a*tuvb.y)
            dir = PVector(cos(a), sin(a))
            n_pos = pos  + partial_l*dir
        elif type == "r":
            aa =2
            varx = aa*(pos.x/width+1)
            vary = aa*(pos.y/height+1)
            base_noise_x = 100+1*i*.5
            base_noise_y = 150+1*i*.5
            n_pos = pos  + partial_l*PVector(mnoise(varx,vary, base_noise_x),mnoise(varx,vary, base_noise_y))
        
        if False:
            n_pos += 20*PVector(sin(aaa),sin(aaa)) 
        P.append(n_pos)
        pos = n_pos
        
    
    P.append(n_pos)
    return P

def plot_cool_curve(img, P, debug= False):
    
    var1 = 0
    col = colpoint(P[-1].x+var1, P[-1].y+var1)
    
    img.beginDraw()
    img.stroke(col)
    #P.append(n_pos)
    
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
    col2 = colpoint(P[-1].x+var1, P[-1].y+var1)
    img.stroke(col2)
    #img.point(n_pos.x, n_pos.y)
    
    if debug:
        img.strokeWeight(7)
        img.stroke(0,255,0)
        for p in P:
            img.point(p.x, p.y)
    
    img.endDraw()

def draw_cool_curve(img, x,y, l=90,n=2, col=color(0,0,0,0), debug=False, type="dir"):
    pos = PVector(x,y)
    uv = PVector(x/width, y/height) 
    uvb = uv + PVector(1,1)
    
    partial_l = float(l)/n
    
    s = 5*noise(3*uv.x,3*uv.y)
    
    img.beginDraw()
    img.strokeWeight(s)
    
    fract_s = s/n 
    
    P = [pos, pos]#, pos]
    
    for i in range(n):
        img.strokeWeight(i)
        aaa = PI/2*i
        if type == "dir":
            res_a = 1.
            tuvb = res_a*(PVector(pos.x/width, pos.y/height)+PVector(1,1))
            a = 2*TWO_PI*noise(res_a*tuvb.x ,res_a*tuvb.y)
            dir = PVector(cos(a), sin(a))
            n_pos = pos  + partial_l*dir
        elif type == "r":
            aa =2
            varx = aa*(pos.x/width+1)
            vary = aa*(pos.y/height+1)
            base_noise_x = 100+1*i*.5
            base_noise_y = 150+1*i*.5
            n_pos = pos  + partial_l*PVector(mnoise(varx,vary, base_noise_x),mnoise(varx,vary, base_noise_y))
        
        if False:
            n_pos += 20*PVector(sin(aaa),sin(aaa)) 
        P.append(n_pos)
        pos = n_pos
        
    
    var1 = 0
    col = colpoint(n_pos.x+var1, n_pos.y+var1)
    
    img.stroke(col)
    #P.append(n_pos)
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
    
    if debug:
        img.strokeWeight(7)
        img.stroke(0,255,0)
        for p in P:
            img.point(p.x, p.y)
    
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
