class Mover {
PVector location;
PVector velocity;
PVector gravity;
PVector friction;

float gravityConstant = 3;
float normalForce = 1;
float mu = 0.1;
float frictionMagnitude = normalForce * mu;
float r;

Mover() {
location = new PVector(0, 0);
velocity = new PVector(1, 1);

}
void update(float angleZ, float angleX) {
gravity = new PVector(sin(angleZ) * gravityConstant, -sin(angleX) * gravityConstant);
friction = velocity.copy();
friction.mult(-1);
friction.normalize();
friction.mult(frictionMagnitude);
location.add(velocity.add(friction.add(gravity)));
}

void display() {
noStroke();
fill(200,0, 0);
r = 6;
pushMatrix();
translate(location.x, -boxY/2-r, location.y);
sphere(r);
popMatrix();
}

void checkEdges() {
if (location.x > boxX/2f - r/2f) {
location.x = boxX/2f - r/2f;
velocity.x = velocity.x * -1;
score -= ball.velocity.mag();
}
else if (location.x < r/2f - boxX/2f) {
location.x = r/2f - boxX/2f;
velocity.x = velocity.x * -1;
score -= ball.velocity.mag();
}
if (location.y > boxZ/2f - r/2f) {
location.y = boxZ/2 - r/2;
velocity.y = velocity.y * -1;
score -= ball.velocity.mag();
}
else if (location.y < r/2f - boxZ/2f) {
location.y = r/2 - boxZ/2f;
velocity.y = velocity.y * -1;
score -= ball.velocity.mag();
}
}

void checkCylinderCollision(){
    for(int i = 0; i < cylinders.size(); i++){
      PVector tmpL = location.copy();
      PVector cyl = new PVector(cylinders.get(i).x - width/2, cylinders.get(i).y - height/2);
      if(cyl.dist(location) <= r + Cylinder.cylinderBaseSize){
        PVector tmpV = velocity.copy();
        PVector n = (location.sub(cyl)).normalize();
        n = n.mult(2*tmpV.dot(n));
        velocity = tmpV.sub(n);
        location = tmpL.add(velocity);
        score += ball.velocity.mag();
        cylinders.remove(i);
      }
    }
    
  }
}