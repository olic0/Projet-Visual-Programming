PShape triangle = new PShape();
void settings() {
size(400, 400, P3D);
}
void setup() {
triangle = createShape();
triangle.beginShape(TRIANGLES);
triangle.vertex(0, 0);
triangle.vertex(50, 0);
triangle.vertex(50, 50);
triangle.endShape();
}
void draw() {
background(0);
translate(mouseX, mouseY);
shape(triangle);
}