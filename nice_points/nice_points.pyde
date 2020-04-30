add_library('peasycam')
add_library("videoExport")
import particle
from peasy import PeasyCam

def setup():
    global t,numPoints, fract,poww,var1, video, michel, lastpow,doVideo, the_inx, particles

    t=0.
    numPoints = 1000
    fract = (1+sqrt(5))/2
    #fract = 0.295
    poww = 1
    lastpow = [0.5,0.5]
    var1 = 300
    michel = False
    the_inx = 1
    particles = []
    fill_particles(particles, the_inx)

    size(1000,1000,P3D)
    noSmooth()
    cam = PeasyCam(this, 0,0,0,700)
    cam.setMinimumDistance(50)
    cam.setMaximumDistance(1000)
    
    doVideo= False
    
    if doVideo:
        video = VideoExport(this)
        video.startMovie()

def process():
    global fract, poww,var1, michel, lastpow
    #fract +=  1./1000000
    #poww -= t/1000000
    lastpow = [lastpow[1],poww]
    #poww = oscille(2, 0, t)
    #poww = 1.
    #var1 += 1.
    if lastpow[1]<poww and lastpow[0]>lastpow[1]:
        print(1)
        michel = not michel
    
def oscille(a,b,delta,full_time = 1):
    middle = (a+b)/2
    distt = abs(b-a)/2
    return middle + cos(delta/100)*distt

def fill_particles(particles,michel):
    cur_i = 0
        
    s = len(particles)
    for i in range(numPoints):
        
        i= float(i)
        tt = pow(i/(numPoints-1.), poww)
        inclination = acos(1-2*tt)
        azimuth = 2*PI*fract*i
        x = var1*sin(inclination)*cos(azimuth)
        y = var1*sin(inclination)*sin(azimuth)
        z = var1*cos(inclination)
        
        if i%michel == 0:
            if len(particles)<=cur_i:
                if s >1:
                    x1 = particles[int(i)%s].x
                    y1 = particles[int(i)%s].y
                    z1 = particles[int(i)%s].z
                else:
                    x1,y1,z1 = 0,0,0
                temp = particle.Particle(x1,y1,z1)
                temp.target = [x,y,z]
                particles.append(temp)
            else:
                particles[cur_i].target = [x,y,z]
            cur_i+=1
    if cur_i < len(particles):
        particles = particles[:cur_i]
    return particles
            
    
            

def draw():
    global t, video
    gilbert = 0#float(t)*PI/1000
    if False:
        if michel:
            pass
            rotateY(PI+gilbert)
            #rotateX(-PI/8)
            #rotateZ(PI/2)
            rotateY(-PI/6)
            #rotateY(-PI/6)
            rotateX(-PI/8)
        else:
            rotateY(-PI/6+gilbert)
            #rotateY(-PI/6)
            rotateX(PI/8)
            #rotateZ(PI/2)
    t +=1
    new_thing()
    if doVideo:
        video.saveFrame()

def new_thing():
    background(204)
    
    process()
    draw_particles()
    fill(0,0,0)
    textSize(50)
    text("n="+str(the_inx),-50,-350)
    
            
def time_3_D():
    background(204)
    
    process()
    #plotText(str(fract), width/2, 100, color(255,255,255))
    #plotText(str(poww), width/2, 120, color(255,255,255))
    if False:
        for i in range(0,numPoints):
            i= float(i)
            tt = pow(i/(numPoints-1.), poww)
            inclination = acos(1-2*tt)
            azimuth = 2*PI*fract*i
            x = var1*sin(inclination)*cos(azimuth)
            y = var1*sin(inclination)*sin(azimuth)
            z = var1*cos(inclination)
            #print(x,y,z)
            c = color(0,0,0)
            s=5
            tyi = int(t/10)
            #print(tyi)
            varA = 1
            varB= the_inx
            if i%varB == 0:
                c = color(150,0,0)
                s=(numPoints/2-abs(numPoints/2-i))/8
            if False and i%varB == 0 and (i/varB)%varA==tyi%varA:
                c = color(150,0,0)
                s=(numPoints/2-abs(numPoints/2-i))/8
            if False and i%13 == 0 and (i/13)%varA==tyi%varA: #i==(tyi%floor(numPoints/13))*13:#i==(tyi*13)%int(numPoints):# and i==13*(tyi%ceil(numPoints/13)):
                #print(i)
                #print("-",tyi)
                c = color(150,0,0)
                s=(numPoints/2-abs(numPoints/2-i))/9
            plotPoint3(x,y,z,c,s)
    #stroke(0,0,0)
    #point(0,0,0)
    
def draw_particles():
    a = particles[52]
    #print(a.x,a.y,a.z)
    #print(a.target)
    for i in particles:
        i.move_toward(i.target)
        i.draw()

def keyPressed():
    if key == "q" and doVideo:
        video.endMovie()
        exit()
    elif key == "p":
        global the_inx, particles
        the_inx +=1
        particles = fill_particles(particles, the_inx)
    elif key == "m":
        global the_inx, particles
        the_inx -=1
        the_inx = max(the_inx, 1)
        particles = fill_particles(particles, the_inx)


def plotPoint(x,y,col=color(0,0,0)):
    x0,y0 = width/2, height/2
    stroke(col)
    strokeWeight(5)
    point(x+x0,y+y0)

def plotPoint3(x,y,z,col=color(0,0,0),siz = 5):
    x0,y0,z0 = width/2, height/2,z
    stroke(col)
    strokeWeight(siz)
    point(x,y,z0)


def plotText(txt,x,y,col):
    stroke(col)
    strokeWeight(1)
    text(txt,x,y)
