void keyPressed(){
  if(key == CODED){
   if(keyCode == SHIFT){
       shifted = true;
     }
  }
}

void keyReleased(){
 if(key == CODED){
  if(keyCode == SHIFT){
    shifted = false;
  }
 }
}