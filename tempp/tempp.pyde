add_library("videoExport")
def setup():
    global cx,cy,videoExport,video
    size(500, 500);
    cx = width / 2;
    cy = height / 2;
    video = True
    if video:
        videoExport = VideoExport(this);
        videoExport.startMovie();
    
t = 0.


def aaa(t,th):
    if th == 0:
        background(0)
        r = 700
        a = 0.05
        var1 = 50
        n = 1600+int(t)
        bras = 3#int(t/30)
        for i in range(n):
            for j in range(bras):
                j = float(j+1)/bras
                tt = radians(i)#+cos(t/100)*PI*2
                x = cx + a * tt * r * cos(tt+2*PI*j) + noise(tt, t/100)*40
                y = cy + a * tt * r * sin(tt+2*PI*j)+ noise(tt, t/100)*40
                stroke((cos(t/5+tt*2+j*2*PI)+1)*255/2,0,0)
                strokeWeight(var1-i*var1/n)
                point(x, y)
    elif th == 1:
        background(180)
        var1 = 50
        r = 500
        a = 0.05
        n = 500#+int(t)
        bras = 3#int(t/30)
        numb_circles = 5
        for i in range(n):
            for j in range(bras):
                j = float(j+1)/bras
                tt = radians(i)#+cos(t/100)*PI*2
                x = cx + a * tt * r * cos(tt+2*PI*j) #+ noise(tt, t/100)*40
                y = cy + a * tt * r * sin(tt+2*PI*j) #+ noise(tt, t/100)*40
                #stroke((cos(t/5+tt*2+j*2*PI)+1)*255/2,0,0)
                stroke(0,0,0,3)
                for k in range(numb_circles):
                    k+=1
                    thing = var1-i*var1/n
                    strokeWeight(thing/k)
                    point(x, y)
         
cur = 1

def draw():
    global t
    t += 1.
    
    aaa(t, cur)
    
    if video:
        videoExport.saveFrame();
        
def keyPressed():
    if key =="q" and video:
        videoExport.endMovie()
        exit()
