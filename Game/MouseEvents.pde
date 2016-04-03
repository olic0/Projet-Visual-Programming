void mouseDragged(){
 mx += (mouseX - pmouseX)*change;
 mz += (mouseY - pmouseY)*change;
 
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
  angleX = map(mz, 0, width, PI/6, -PI/6);
  angleZ = map(mx, 0, height, -PI/6, PI/6);
}

void mouseWheel(MouseEvent event){
  change += event.getCount();
  if(change < 0.2){
   change = 0.2; 
  } else if(change > 1.5){
   change = 1.5; 
  }
  println(change);
}

void mouseClicked(){
 if(shifted){
   PVector position = new PVector(mouseX, mouseY);
   PVector upLeft = new PVector(width/2f - boxX/2f, height/2f - boxZ/2f);
   PVector bottomRight = new PVector(width/2f + boxX/2f, height/2f + boxZ/2f);
   
   if( position.x >= upLeft.x + Cylinder.cylinderBaseSize
     && position.x <= bottomRight.x - Cylinder.cylinderBaseSize
     && position.y >= upLeft.y + Cylinder.cylinderBaseSize
     && position.y <= bottomRight.y - Cylinder.cylinderBaseSize){ 
        cylinders.add(position);
     }
 }
}