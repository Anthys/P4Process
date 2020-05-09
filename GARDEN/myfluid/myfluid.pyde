add_library("themidibus")

from state_class import *
from spatialHashMap import *

def setup():
    frameRate(60)
    MidiBus.list()
    size(500,500)
    global state, PARTICLE_COUNT, GRAVITY, hashmap, GRID_CELLS,INTERACTION_RADIUS
    global STIFFNESS,REST_DENSITY,STIFFNESS_NEAR,INTERACTION_RADIUS_SQ, RADIUS_BLOB
    global myBus
    myBus = MidiBus(this, 0,1)
    GRID_CELLS = 54
    GRAVITY = [0.,50.]
    PARTICLE_COUNT = 200
    INTERACTION_RADIUS = 40.
    INTERACTION_RADIUS_SQ = INTERACTION_RADIUS**2
    STIFFNESS = 10.
    REST_DENSITY = 10.
    STIFFNESS_NEAR = 1.
    RADIUS_BLOB = 100.
    hashmap = SpatialHashMap(GRID_CELLS,GRID_CELLS)
        
    
    state = State(PARTICLE_COUNT)
    if True:   
        for i in range(PARTICLE_COUNT):
            a = random(-100,100)
            b = random(-100,100)
            state.x[i] = a
            state.y[i] = b
            state.oldX[i] = a
            state.oldY[i] = b
def applyGlobalForces(i,dt):
    global state
    force = GRAVITY
    state.vx[i] += force[0]*dt
    state.vy[i] += force[1]*dt


def relax(i, neighbours, dt):
    pos = PVector(state.x[i], state.y[i])
    
    for k in range(len(neighbours)):
        n = neighbours[k]
        g = state.g[n]
        
        nPos = PVector(state.x[n], state.y[n])
        magnitude = state.p[i]*g+state.pNear[i]*g*g
        
        direction = (nPos-pos).normalize()
        force = direction*magnitude
        
        d = force*(dt*dt)
        
        state.x[i] += d.x * -0.5
        state.y[i] += d.y * -0.5
        
        state.x[n] += d.x*0.5
        state.y[n] += d.y*0.5

def updatePressure(i, neighbours):
    density = 0
    nearDensity = 0
    
    for k in range(len(neighbours)):
        g = state.g[neighbours[k]]
        density += g*g
        nearDensity += g*g*g
    
    state.p[i] = STIFFNESS * (density-REST_DENSITY)
    state.pNear[i] = STIFFNESS_NEAR * nearDensity

def gradient(i,n):
    particle = PVector(state.x[i], state.y[i])
    neighbour = PVector(state.x[n],state.y[n])
    
    lsq = particle.dist(neighbour)**2
    
    if lsq > INTERACTION_RADIUS_SQ:
        return 0
    
    distance = sqrt(lsq)
    
    return 1 - distance/INTERACTION_RADIUS

def getNeighboursWithGradients(i):
    gridX = (state.x[i] / width + 0.5) * GRID_CELLS;
    gridY = (state.y[i] / height + 0.5) * GRID_CELLS;
    radius = (INTERACTION_RADIUS / width) * GRID_CELLS;

    results = hashmap.query(gridX, gridY,radius)
    neighbours = [];

    for k in range(len(results)):
        n = results[k]
        if i == n:
            continue

        g = gradient(i, n)
        if g == 0:
           continue

        state.g[n] = g
        neighbours += [n]

    return neighbours

def contain2(i,dt):
    
    pos = [state.x[i], state.y[i]]
    
    if mag(pos[0], pos[1])**2 > RADIUS_BLOB**2:
        magg = mag(pos[0], pos[1])
        unitPos = [pos[0], pos[1]]
        if magg:
            unitPos = [unitPos[0]/magg, unitPos[1]/magg]
        newPos = [unitPos[0]*RADIUS_BLOB, unitPos[1]*RADIUS_BLOB]
        
        state.x[i] = newPos[0]
        state.y[i] = newPos[1]
    
def contain(i,dt):
    
    pos = PVector(state.x[i], state.y[i])
    
    if pos.mag()**2 > RADIUS_BLOB**2:
        unitPos = pos.normalize()
        newPos = unitPos*RADIUS_BLOB
        
        state.x[i] = newPos.x
        state.y[i] = newPos.y
        
        if True:
            antiStick = unitPos * INTERACTION_RADIUS * dt/100
            
            state.oldX[i] += antiStick.x
            state.oldY[i] += antiStick.y

def calculateVelocity(i, dt):
    global state
    pos = PVector(state.x[i], state.y[i])
    old = PVector(state.oldX[i], state.oldY[i])
    v = (pos-old)*1/dt
    state.vx[i] = v.x
    state.vy[i] = v.y

def draw():
    global state, hashmap
    
    #midi_things()
    
    background(200)
    
    dt = 0.0166
    dt = 0.03
    dt = 0.04
    # PASS 1
    
    for i in range(PARTICLE_COUNT):
        state.oldX[i] = state.x[i]
        state.oldY[i] = state.y[i]
        applyGlobalForces(i,dt)
        
        state.x[i] += state.vx[i]*dt
        state.y[i] += state.vy[i]*dt
        
        gridX = (state.x[i] / width + 0.5) * GRID_CELLS
        gridY = (state.y[i] / height + 0.5) * GRID_CELLS
        hashmap.add(gridX,gridY,i)
    
    # PASS 2
    
    for i in range(PARTICLE_COUNT):
        neighbours = getNeighboursWithGradients(i)
        updatePressure(i,neighbours)
        relax(i,neighbours,dt)
    
    # PASS 3
    
    for i in range(PARTICLE_COUNT):
        contain(i,dt)
        
        calculateVelocity(i,dt)
        
        ## state.mesh
    
    
    
    for i in range(PARTICLE_COUNT):
        strokeWeight(5)
        point(state.x[i]+width/2, state.y[i]+height/2)
    
    hashmap.clear()
        
def midi_things():
    channel = 0
    pitch = 64
    velocity = 127
    number = 0
    value = 90
    myBus.sendControllerChange(channel,number, value)
    

def controllerChange(channel, number, value):
    print()
    print("change:")
    print("---")
    print("channel:", channel)
    print("numb",number)
    print("val",value)
    allmax= 127
    if number == 75:
        global GRAVITY
        mxg = 600
        ming = 0
        GRAVITY = [0,mxg*value/allmax]
    