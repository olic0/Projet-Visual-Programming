class Mover {
PVector location;
PVector velocity;
PVector gravity;
PVector friction;

float gravityConstant = 0.9;
float normalForce = 1;
float mu = 0.1;
float frictionMagnitude = normalForce * mu;
float r;

Mover() {
location = new PVector(0, 0, 0);
velocity = new PVector(1, 1, 1);

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
r = 5;
pushMatrix();
translate(location.x, location.y, 2*r);
sphere(r);
popMatrix();
}
void checkEdges() {
if (location.x > 50 - r/2) {
location.x = 50 - r/2;
velocity.x = velocity.x * -1;
}
else if (location.x < r/2 - 50) {
location.x = r/2 - 50;
velocity.x = velocity.x * -1;
}
if (location.y > 50 - r/2) {
location.y = 50 - r/2;
velocity.y = velocity.y * -1;
}
else if (location.y < r/2 - 50) {
location.y = r/2 - 50;
velocity.y = velocity.y * -1;
}
}
}