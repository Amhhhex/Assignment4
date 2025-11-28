class OrangeAlien {
 
  PImage image;
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  OrangeAlien(PImage tempImage, PVector tempPosition, PVector tempVelocity, PVector tempAcceleration) {
    
   image = tempImage;
   position = tempPosition;
   velocity = tempVelocity;
   acceleration = tempAcceleration;
    
  }
  
  
  void display() {
   
    image(image, position.x, position.y);
    
    
  }
  
  
  void update() {
    
   position.add(velocity);
   
   
   if(position.x >= 360) {
     velocity.add(accleration);
     velocity.mult(new PVector(-1, 0));
    
  }
  
}
