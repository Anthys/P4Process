static class spmchl{
  
  static PVector[] uniform_sphere_2D(int numPoints, float radius){
    return uniform_sphere_2D(numPoints, .5, (1+sqrt(5))/2, radius);
  }
  
  static PVector[] uniform_sphere_2D(int numPoints, float power, float fract, float radius){
    PVector [] out = new PVector[numPoints];
    for (int i = 0; i<numPoints; i++){
      float dst = radius*pow((float)i/(numPoints-1), power);
      float angle = TAU*fract*i;
      float x = dst*cos(angle);
      float y = dst*sin(angle);
      out[i] = new PVector(x, y);
    }
    return out;
  }
  
  static PVector[] uniform_surface_sphere_3D(int numPoints, float radius){
    return uniform_surface_sphere_3D(numPoints, .5, (1+sqrt(5))/2, radius);
  }
  
  static PVector[] uniform_surface_sphere_3D(int numPoints, float power, float fract, float radius){
    PVector [] out = new PVector[numPoints];
    for (int i = 0; i<numPoints; i++){
      float tt = pow((float)i/(numPoints-1), power);
      float inclination = acos(1-2*tt);
      float azimuth = TAU*fract*i;
      float x = radius*sin(inclination)*cos(azimuth);
      float y = radius*sin(inclination)*sin(azimuth);
      float z = radius*cos(inclination);
      out[i] = new PVector(x, y,z);
    }
    return out;
  }

}
