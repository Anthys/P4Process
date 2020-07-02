add_library('peasycam');

import shutil
import ObjMod as om

def setup():
    global cam, t
    t = 0.
    size(500,500,P3D)
    cam = PeasyCam(this, 400);
    orig_file = "sphero.obj"
    shutil.copy(orig_file , "mesh.obj");

def draw():
    global t
    background(200);
    scale(30);
    t += 1.
    mesh = loadShape("mesh.obj")
    om.draw_shape(mesh)
    
    
