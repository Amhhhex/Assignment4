
//An explosion class
class Explosion {

  //declaring the local variables
  float xPosition;
  float yPosition; 
  boolean active=true;
  int explosionFrame;

  //Uses two arguments, two float values for the x and y position of the explosion
  Explosion(float xPositionTemp, float yPositionTemp) {
    
    
    xPosition = xPositionTemp;
    yPosition = yPositionTemp;
  
  
  }
  
  
  
  //Displays the explosionGif array in sequence
  //Each png stays on screen for 3 frames
  void display() {
  
    //grabs the frame from the Array
    if (frameCount % 3 == 0) {
    explosionFrame = (explosionFrame + 1) % explosionGif.length;
  }
  
  //if the explosion is active, displays the image
  if(active) {
      image(explosionGif[explosionFrame], xPosition, yPosition, 80, 80);

    
  }
  
  //once 12 frames have been used, turns the active value to false. This disables the animation from repeating
  if(explosionFrame == 12) {
   active = false; 
  }


  
    
  
  
  
  }
  
  
}
