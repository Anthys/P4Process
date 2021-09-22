//iquiles

float sdCircle( PVector p, float r ) 
{
    return p.mag()-r;
}


float sdBox( PVector p, PVector b ) 
{
    PVector d = PVector.add(new PVector(abs(p.x), abs(p.y)), b.mult(-1));
    return (new PVector(max(d.x, 0), max(d.y, 0))).mag() + min(max(d.x, d.y), 0);
}
