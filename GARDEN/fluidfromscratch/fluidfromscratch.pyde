from const import *
from spatialhashmap import *
from state_class import *
from spring import *

def setup():
    size(500,500)
    
    global state
    global C
    global hashmap
    global springs
    springs = []
    GRID_CELLS = 54
    GRAVITY = PVector(0,50)
    PARTICLE_COUNT = 100
    INTERACTION_RADIUS = 60
    STIFFNESS = 20
    REST_DENSITY = 10
    STIFFNESS_NEAR = 50
    RADIUS_BLOB = 200
    hashmap = SpatialHashMap(GRID_CELLS,GRID_CELLS)
    state = State(PARTICLE_COUNT)
    for i in range(PARTICLE_COUNT):
        a = random(-100,100)
        b = random(-100,100)
        state.pos[i] = PVector(a,b)
        state.oldpos[i] = PVector(a,b)
    C = Const(PARTICLE_COUNT,GRAVITY,GRID_CELLS,INTERACTION_RADIUS,STIFFNESS,REST_DENSITY,STIFFNESS_NEAR,RADIUS_BLOB)

def applyViscosity():
    pass

def adjustSprings(i, neighbours, dt):
    for j in neighbours:
        if j > i:
            q = PVector.dist(state.pos[i], state.pos[j])
            if q < 1:
                
    
def applySpringDisplacements(dt):
    k_spring = 1
    h = C.interaction_radius
    for L in springs:
        dir = state.pos[L.i] - state.pos[L.j]
        dir = dir.normalize()
        D = (dt**2)*k_spring*(1-L.val/h)*(L.val-PVector.dist(state.pos[L.i],state.pos[L.j]))*dir
        state.pos[L.i] -= D/2
        state.pos[L.j] += D/2
    
def get_neighbours(i):
    return [i for i in range(C.particle_count)]
    
def doubleDensityRelaxation(i,neighbours=None,dt=0.1):
    h = C.interaction_radius
    k = C.stiffness
    k_near = C.stiffness_near
    rho_0 = C.rest_density

    rho = 0
    rho_near = 0
    if neighbours == None:
        neighbours = [i for i in range(C.particle_count)]
        
    for j in neighbours:
        if j != i:
            q = PVector.dist(state.pos[i], state.pos[j])/h
            if q < 1:
                rho += (1-q)**2
                rho_near += (1-q)**3
    P = k*(rho-rho_0)
    P_near = k_near*rho_near
    dx = PVector(0,0)
    for j in neighbours:
        q = PVector.dist(state.pos[i], state.pos[j])/h
        if q < 1:
            dir = (state.pos[i] - state.pos[j]).normalize()
            D = (dt**2)*(P*(1-q)+P_near*((1-q)**2))*dir
            state.pos[j] += D/2
            dx -= D/2
    state.pos[i] += dx

def resolveCollisions():
    pass

def draw():
    background(200)
    dt = 0.05
    
    for i in range(C.particle_count):
        state.v[i] += dt*C.gravity 
    
    applyViscosity()
    
    for i in range(C.particle_count):
        state.oldpos[i] = state.pos[i]
        state.pos[i] += dt*state.v[i]
    
    adjustSprings()
    for i in range(C.particle_count):
        neighbours = get_neighbours(i)
        applySpringDisplacements(i,neighbours,dt)
        doubleDensityRelaxation(i,neighbours,dt)
    resolveCollisions()
    
    for i in range(C.particle_count):
        state.v[i] = (state.pos[i]-state.oldpos[i])/dt
    
    for i in range(C.particle_count):
        strokeWeight(5)
        point(state.pos[i].x+width/2, state.pos[i].y+width/2)
