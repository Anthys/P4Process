final int nb = 46;
final float weight = 2;
final float friction = .6;
final float maxRot = PI / 10;
float[] tabAngles;
float nroot1 = random(123), nroot2 = random(123);
float nroot3 = random(123), nroot4 = random(123);
float nspeed1 = random(-.01, .01), nspeed2 = random(-.01, .01);
float nspeed3 = random(-.05, .05), nspeed4 = random(-.01, .01);
float rY = 0, rZ = 0, defaultAngle, gap = 2;

void setup()
{
  size(450, 450, OPENGL);
  noFill();
  strokeWeight(weight);
  stroke(250, 70);
  gap = (gap + weight) * 2;
  tabAngles  = new float[nb];
  for (int i = 0; i < nb; i ++)
  {
    tabAngles[i] = 0;
  }
}

void draw()
{
  background(10);
  translate(width/2, height/2);

  nroot3 += nspeed3;
  nroot4 += nspeed4;  
  defaultAngle = map(mouseX, 0, width, -PI/12, PI/12);  
  
  rotateY(rY += (noise(nroot1 += nspeed1) - .5) * PI / 10);
  rotateZ(rZ += (noise(nroot2 += nspeed2) - .5) * PI / 10);
  
  pushMatrix();  
  tabAngles[0] = map(mouseY, 0, height, -1.5*PI, 1.5*PI);
  rotateX(tabAngles[0]);
  arc(0.0, 0.0, 1, 1, 0.0, PI);
  popMatrix();

  float deltaTheta, thetaSpeed, angle;
  for (int i = 1; i < nb; i ++)
  {    
    deltaTheta = tabAngles[i-1] - tabAngles[i];
    thetaSpeed = constrain((deltaTheta + defaultAngle) * friction, -maxRot, maxRot);    
    tabAngles[i] += thetaSpeed;

    angle = (noise(nroot3 + i) + .3) * PI;
    pushMatrix();
    rotateX(tabAngles[i]);
    rotateZ(noise(nroot4 + i) * PI * 10);
    arc(0.0, 0.0, gap * i, gap * i, -angle, angle);//-PI/1.4, PI/1.4);
    popMatrix();
  }
}
