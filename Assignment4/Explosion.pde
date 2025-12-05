class Explosion {

  
  float xPosition;
  float yPosition; 
  boolean active=true;
  int explosionFrame;

  
  Explosion(float xPositionTemp, float yPositionTemp) {
    
    
    xPosition = xPositionTemp;
    yPosition = yPositionTemp;
  
  
  }
  
  
  
  void display() {
  
  
    if (frameCount % 3 == 0) {
    explosionFrame = (explosionFrame + 1) % explosionGif.length;
  }
  
  println(explosionFrame);
  
  //constrain(explosionFrame, 0, 12);
  
  if(active) {
      image(explosionGif[explosionFrame], xPosition, yPosition, 80, 80);

    
  }
  
  if(explosionFrame == 12) {
   active = false; 
  }


  
    
  
  
  println("this is the explosion frame " + explosionFrame);
  
  }
  
  
}
