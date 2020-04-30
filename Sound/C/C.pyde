add_library("minim")
add_library("VideoExport")

from drawings import *

minim = None
allie = None
fft = None
beat =  None
eRadius = 20
t = 0.
video = None
audio_name = "Allie X - Devil I Know (lyrics).mp3"
fps_mov = 60
cur_val = []
speed = 1

style = 5

def setup():
    global minim, fft, allie, beat, video, cur_val
    size(1000,1000,P3D)
    minim = Minim(this)
    allie = minim.loadFile(audio_name, 1024)
    allie.play()
    fft = FFT(allie.bufferSize(), allie.sampleRate())
    beat = BeatDetect()
    ellipseMode(RADIUS)
    
    video = VideoExport(this)
    video.setFrameRate(fps_mov)
    #video.setAudioFileName(audio_name)
    video.startMovie()


    

def draw():
    global fft, allie, beat, eRadius,t, video, cur_val, speed
    t += 1
    fill(0, 100);
    rect(0, 0, width, height);
    stroke(255)
    
    fft.forward(allie.mix)
    
    if style == 1:
        linearA(fft)
    elif style == 2:
        circleA(fft, t)
    elif style == 3:
        circleB(fft, t)
    elif style == 4:
        cur_val = circleC(fft, t, cur_val)
    elif style == 5:
        cur_val = circleD(fft, t, cur_val, speed)
            
        
    beat.detect(allie.mix)
    a = map(eRadius, 20, 80, 60, 255);
    fill(60, 255, 0, a);
    if beat.isOnset():
        eRadius = 80
    ellipse(width/2, height/2, eRadius, eRadius);
    eRadius *= 0.95;
    if eRadius < 20:
        eRadius = 20;
    
    video.saveFrame()
    
    if keyPressed:
        if key == "p":
            speed = lerp(speed, 0.5, 0.01)
        if key == "m":
            speed = lerp(speed, 1,0.01)
        if key == "x":
            video.endMovie()
            exit()
