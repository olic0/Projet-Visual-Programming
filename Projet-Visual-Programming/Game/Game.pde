float depth = 100;
void settings() {
size(700,700,P3D);
}
void setup () {
  noStroke();
}

float mx = mouseX;
float mz = mouseY;
float change = 1;

void draw() {
  background(100, 100, 200);
  lights();
  translate(width/2, height/2, 0);
  fill(100);
  
  if(mx > width){
   mx = width; 
  } else if(mx < 0){
   mx = 0; 
  }
  
  if(mz < 0){
    mz = 0;
  } else if(mz > height){
   mz = height; 
  }
  float angleX = map(mouseX, 0, width, -PI/6, PI/6);
  float angleZ = map(mouseY, 0, height, PI/6, -PI/6);
  rotateX(angleZ); //The plates move in the right direction when I invert the angles with rotate()
  rotateY(angleX);
  box(100, 100, 10);
}


void mouseDragged(){
 mx = (mouseX - pmouseX)*change;
 mz = (mouseY - pmouseY)*change;
}

void mouseWheel(MouseEvent event){
  change += event.getCount();
  change = change*0.1;
  if(change < 0.2){
   change = 0.2; 
  } else if(change > 1.5){
   change = 1.5; 
  }
}