class Cylinder{
  
  static final float cylinderBaseSize = 5;
  static final float cylinderHeight = 5;
  static final int cylinderResolution = 4;
  PShape openCylinder;
  PShape bottomCylinder;
  PShape topCylinder;
  
  Cylinder(){
    openCylinder = new PShape();
    bottomCylinder = new PShape();
    topCylinder = new PShape();
    
    float angle;
float[] x = new float[cylinderResolution + 1];
float[] y = new float[cylinderResolution + 1];
//get the x and y position on a circle for all the sides
for(int i = 0; i < x.length; i++) {
angle = (TWO_PI / cylinderResolution) * i;
x[i] = sin(angle) * cylinderBaseSize;
y[i] = cos(angle) * cylinderBaseSize;
}
openCylinder = createShape();
openCylinder.beginShape(QUAD_STRIP);
//draw the border of the cylinder
for(int i = 0; i < x.length; i++) {
openCylinder.vertex(x[i], y[i] , 0);
openCylinder.vertex(x[i], y[i], cylinderHeight);
}
openCylinder.endShape();

bottomCylinder = createShape();
bottomCylinder.beginShape(TRIANGLES);
for(int i = 0; i < x.length; i++) {
bottomCylinder.vertex(x[i], y[i] , 0);
bottomCylinder.vertex(0, 0, 0);
bottomCylinder.vertex(x[(i+1) %(x.length)], y[(i+1) %(y.length)], cylinderHeight);
}
bottomCylinder.endShape();

topCylinder = createShape();
topCylinder.beginShape(TRIANGLES);
for(int i = 0; i < x.length; i++) {
topCylinder.vertex(x[i], y[i] , cylinderHeight);
topCylinder.vertex(0, 0, cylinderHeight);
topCylinder.vertex(x[(i+1) %(x.length)], y[(i+1) %(y.length)], cylinderHeight);
}
topCylinder.endShape();
}
  
  void display(float x, float y, float z){
    pushMatrix();
    rotateX(PI/2f);
    translate(x, y, z);
    shape(openCylinder);
    shape(bottomCylinder);
    shape(topCylinder);
    popMatrix();
  }
  
  
}