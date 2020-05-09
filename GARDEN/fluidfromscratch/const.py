class Const():
    
    def __init__(self,pc=0,g=0,gc=0,ir=0,s=0,rd=0,sn=0,rb=0):
        self.particle_count= pc
        self.gravity = g
        self.grid_cells = gc
        self.interaction_radius = ir
        self.stiffness = s
        self.rest_density =rd
        self.stiffness_near =sn
        self.radius_blob = rb
