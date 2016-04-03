class Cylinder{
  
  static final float cylinderBaseSize = 8;
  static final float cylinderHeight = 25;
  static final int cylinderResolution = 8;
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
      openCylinder.vertex(x[i], 0 , y[i]);
      openCylinder.vertex(x[i], cylinderHeight, y[i]);
    }
    openCylinder.endShape();

    bottomCylinder = createShape();
    bottomCylinder.beginShape(TRIANGLES);
    for(int i = 0; i < x.length; i++) {
      bottomCylinder.vertex(x[i], 0, y[i]);
      bottomCylinder.vertex(0, 0, 0);
      bottomCylinder.vertex(x[(i+1) %(x.length)], 0, y[(i+1) %(y.length)]);
    }
    bottomCylinder.endShape();

    topCylinder = createShape();
    topCylinder.beginShape(TRIANGLES);
    for(int i = 0; i < x.length; i++) {
      topCylinder.vertex(x[i], cylinderHeight, y[i]);
      topCylinder.vertex(0, cylinderHeight, 0);
      topCylinder.vertex(x[(i+1) %(x.length)], cylinderHeight, y[(i+1) %(y.length)]);
    }
    topCylinder.endShape();
}
  
  void display(float x, float y, float z){
    pushMatrix();
    translate(x, y, z);
    if(shifted){
     rotateX(PI/2); 
    }
    shape(openCylinder);
    shape(bottomCylinder);
    shape(topCylinder);
    popMatrix();
  }
  
}