class Bullet {
  
  PVector position;
  PVector velocity;
  float acceleration;
  
  
  Bullet (PVector tempPosition, PVector tempVelocity, float tempAcceleration) {
    
    position = tempPosition;
    velocity = tempVelocity;
    acceleration = tempAcceleration;
    
  }
  
  
  
  
  void display() {
   
    rectMode(CENTER);
    
    rect(position.x, position.y, 5, 20);
    
  }
  
  void update() {
    
   position.sub(velocity);
   velocity.mult(acceleration);
    
  }











}
