def setup():
    size(200,200)
    global bs, detailLvl
    bs = []
    detailLvl = 1
    bladeCount = 30
    for i in range(bladeCount):
        bs += [Blade(random(width), float(height), int(random(3,10)), 1.0)]
    
def draw():
    background(200)
    for b in bs:
        b.update(-50, height/4, 1.5, 1.5)
        b.draw()

#  Blade class code from pastebin.com/7YVSNczK

class Blade():
    
    def __init__(self, setAnchorx, setAnchory, setSegments, preOffset):
        self.anchorx = setAnchorx
        self.anchory = setAnchory
        self.segments = []
        for x in range(setSegments):
            self.segments += [PVector(self.anchorx, self.anchory + 10*x)]
        self.offset = random(100)/100 + preOffset
        self.green = color(int(random(0,50)), int(random(100,255)), int(random(0,100)))
        self.stiffness = random(1,2)
        self.segments[0].x = self.anchorx
        self.segments[0].y = self.anchory
    
    def update(self, blowx, blowy, forcex, forcey):
        wind = (noise(frameCount/100.0+self.offset)-0.5)
        
        for x in range(1,len(self.segments)):
            segment = self.segments[x]
            segment.y -= (((len(self.segments)-x)*1)/detailLvl)*self.stiffness
            segment.x += x*wind*(4/detailLvl)
            
            secondWind = dist(blowx, blowy, segment.x, segment.y)
            if secondWind < 100:
                segment.x += forcex*(20/secondWind*(4/detailLvl))
                segment.y += forcey*(20/secondWind*(4/detailLvl))
        
        for x in range(len(self.segments)-1):
            jointx = self.segments[x].x - self.segments[x+1].x
            jointy = self.segments[x].y - self.segments[x+1].y
            jointLength = sqrt(jointx*jointx+jointy*jointy)
            if jointLength > 5*(4/detailLvl):
                tempvar = 1.0/jointLength
                jointx *= tempvar
                jointy *= tempvar
                jointx *= -5*(4/detailLvl)
                jointy *= -5*(4/detailLvl)
                self.segments[x+1].x = self.segments[x].x + jointx
                self.segments[x+1].y = self.segments[x].y + jointy
    
    def draw(self):
        fill(self.green)
        stroke(self.green)
        h = len(self.segments)-2
        beginShape(TRIANGLE_STRIP)
        for x in range(len(self.segments)-1):
            segmentx = self.segments[x].x
            segmenty = self.segments[x].y
            vertex(segmentx+1*(h-x), segmenty)
            vertex(segmentx-1*(h-x), segmenty)
        endShape()
