
void settings() {
size(500, 500,P3D);
}
float boxX = 100;
float boxY = 100;
float boxZ = 10;
float mx;
float mz;
float angleX;
float angleZ;
Mover ball;
boolean shifted = false;
ArrayList<PVector> cylinders = new ArrayList<PVector>();

void setup () {
  noStroke();
  ball = new Mover();
  pushMatrix();
  translate(width/2, height/2, 0);
  mx = width/2.0;
  mz = height/2.0;
  popMatrix();
}

float change = 1;

void draw() {
  background(100, 100, 200);
  lights();
  translate(width/2, height/2, 0);
  fill(100);
  
  if(shifted == false){
  pushMatrix();
  rotateX(PI/2);
  rotateX(angleX); //The plates move in the right direction when I invert the angles with rotate()
  rotateY(angleZ);
  box(boxX, boxY, boxZ);
  
  for(int i = 0; i < cylinders.size(); i++){
   Cylinder newCylinder = new Cylinder();
   newCylinder.display(cylinders.get(i).x, cylinders.get(i).y, boxZ/2);
   println("x : " + cylinders.get(i).x + " y : "+  cylinders.get(i).y);
  }
  
  pushMatrix();
  ball.update(angleZ, angleX);
  ball.checkEdges();
  ball.display();
  popMatrix();
  popMatrix();
  } else {
    box(boxX, boxY, boxZ);
  }
}