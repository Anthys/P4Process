add_library("videoExport")
r = 500
a = 0.05
def setup():
    global cx,cy,videoExport,video
    size(1000, 1000);
    cx = width / 2;
    cy = height / 2;
    video = True
    if video:
        videoExport = VideoExport(this);
        videoExport.startMovie();
    
t = 0.
def draw():
    background(0)
    global t
    var1 = 50
    n = 1600+int(t)
    t += 1.
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
    if video:
        videoExport.saveFrame();
        
def keyPressed():
    if key =="q" and video:
        videoExport.endMovie()
        exit()
