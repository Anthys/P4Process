def setup():
    size(500,500)
    lP = [
      [0,0],
      [30,30],
      [60,60],
      [100,70],
      [90,90]
      
    ]
    P = []
    for v in lP:
        P.append(PVector(v[0], v[1]))
    
    for j in range( 1, len(P)-2 ):  # skip the ends
        n = 100
        for t in range(n):  # t: 0 .1 .2 .. .9
            p = spline_4p( float(t)/n, P[j-1], P[j], P[j+1], P[j+2] )
            strokeWeight(2)
            point(p.x,p.y)
    
    for j in range( 1, len(P)-2 ):  # skip the ends
        n = 100
        for t in range(n+100):  # t: 0 .1 .2 .. .9
            p = spline_4p( float(t)/n, P[j-1], P[j], P[j+1], P[j+2] ) + PVector(100,0)
            strokeWeight(2)
            point(p.x,p.y)
    
    
    
    for j in range( 1, len(P)-2 ):  # skip the ends
        n = 100
        for t in range(-100,n+100):  # t: 0 .1 .2 .. .9
            p = spline_4p( float(t)/n, P[j-1], P[j], P[j+1], P[j+2] ) + PVector(200,0)
            strokeWeight(2)
            point(p.x,p.y)
    
    
    # INCREASING SIZE
    
    ns = 20
    n = 100
    nj = len(P)-3
    for j in range( 1, len(P)-2 ):  # skip the ends
        for t in range(n):  # t: 0 .1 .2 .. .9
            p = spline_4p( float(t)/n, P[j-1], P[j], P[j+1], P[j+2] ) + PVector(0,100)
            strokeWeight(float(ns)*(t+(j-1)*n)/(nj*n))
            point(p.x,p.y)
    
    P.append(PVector(50,200))
    
    ns = 20
    n = 100
    nj = len(P)-3
    for j in range( 1, len(P)-2 ):  # skip the ends
        for t in range(n):  # t: 0 .1 .2 .. .9
            p = spline_4p( float(t)/n, P[j-1], P[j], P[j+1], P[j+2] ) + PVector(0,200)
            q = float((t+(j-1)*n))/(nj*n)
            strokeWeight(q*float(ns))
            stroke(q*255, 0,0,255)
            point(p.x,p.y)
    
    
# FROM https://stackoverflow.com/questions/1251438/catmull-rom-splines-in-python

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
        
        
