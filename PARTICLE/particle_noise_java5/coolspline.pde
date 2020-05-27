ArrayList<PVector> make_cool_curve(float x,float y,float l,int n, String type){
    PVector pos = new PVector(x,y);
    PVector uv = new PVector(x/width, y/height); 
    PVector uvb = PVector.add(uv,new PVector(1.,1.));
    
    float partial_l = l/n;
    
    float var_s_a = 5; // Amplitude of size
    float var_s_p = 3; // Resolution of size's noise grid
    
    float s = var_s_a*noise(var_s_p*uv.x,var_s_p*uv.y);
    
    
    float fract_s = s/n;
    
    ArrayList<PVector> P = new ArrayList<PVector>();
    P.add(pos);
    P.add(pos);
    
    PVector n_pos = pos;
    for (int i=0;i<n;i++){
        float aaa = PI/2*i;
        if (type == "dir"){
            float res_a = (1./200)*(200-dist(width/2, height/2, pos.x, pos.y));
            PVector te = new PVector(pos.x/width, pos.y/height);
            PVector te2 = new PVector(1,1);
            PVector tuvb = (te.add(te2)).mult(res_a);
            float a = 2*TWO_PI*noise(res_a*tuvb.x ,res_a*tuvb.y);
            PVector dir = new PVector(cos(a), sin(a));
            n_pos = PVector.add(pos,(dir.mult(partial_l)));
        }
        else if (type == "r"){
            float aa =2;
            float varx = aa*(pos.x/width+1);
            float vary = aa*(pos.y/height+1);
            float base_noise_x = 100+1*i*.5;
            float base_noise_y = 150+1*i*.5;
            PVector te = new PVector(mnoise(varx,vary, base_noise_x),mnoise(varx,vary, base_noise_y));
            n_pos = te.mult(partial_l).add(pos);
        }
        if (false){
            n_pos.add((new PVector(sin(aaa),sin(aaa))).mult(20) );
        }
        P.add(n_pos);
        pos = n_pos;
    }
    
    P.add(n_pos);
    return P;
}


void plot_cool_curve(PGraphics img, ArrayList<PVector> P, boolean debug){    
    float var1 = 0;
    int lp = P.size()-1;
    color col = colpoint(P.get(lp).x+var1, P.get(lp).y+var1);
    
    img.beginDraw();
    img.stroke(col);
    //P.append(n_pos)
    
    float ns = 20; // TAILLE MAXIMALE DE LA SPHERE
    int n= 10;
    int nj = P.size()-3;
    for (int j=1;j<P.size()-2;j++)
    for (int tt=0;tt<n;tt++){
        //println(P);
        float q = float((tt+(j-1)*n))/(nj*n);
        PVector pp = spline_4p(float(tt)/n, P.get(j-1), P.get(j), P.get(j+1), P.get(j+2));
        float s = ns-ns*q;
        img.strokeWeight(s);
        img.point(pp.x,pp.y);
        //spray(img, p.x,p.y, int(s))
    }
    
    img.strokeWeight(ns+2);
    var1 = 20;
    lp = P.size()-1;
    color col2 = colpoint(P.get(lp).x+var1, P.get(lp).y+var1);
    img.stroke(col2);
    //img.point(n_pos.x, n_pos.y);
    
    if (debug){
        img.strokeWeight(7);
        img.stroke(0,255,0);
        for (PVector p:P){
            img.point(p.x, p.y);
        }
    }
    
    img.endDraw();
}



PVector spline_4p(float  t, PVector p_1, PVector p0, PVector p1, PVector p2 ){
  PVector a = PVector.mult(p_1,   t*((2-t)*t - 1)   );
  PVector b = PVector.mult(p0,    (t*t*(3*t - 5) + 2)   );
  PVector c = PVector.mult(p1,   t*((4 - 3*t)*t + 1)   );
  PVector d = PVector.mult(p2,    (t-1)*t*t   );
  PVector e = a.add(b.add(c.add(d))).mult(1./2);
  return e;
}

float mnoise(float a, float b,float c){
    return noise(a,b,c)*2-1;
}

color colpoint(float x, float y){
    PVector uv = new PVector(x/width, y/height).add( new PVector(1,1));
    float varc = 10;
    color col = color(noise(uv.x*varc, varc*uv.y, 25)*255, 30,noise(uv.x*varc, varc*uv.y, 75)*255,4);
    return col;
}
