
//A generic bullet class
class Bullet {
  
  PVector position;
  PVector velocity;
  float acceleration;
  
  //takes 3 arguements, A PVector for position and velocity, and a flot for acceleration
  Bullet (PVector tempPosition, PVector tempVelocity, float tempAcceleration) {
    
    position = tempPosition;
    velocity = tempVelocity;
    acceleration = tempAcceleration;
    
  }
  
  
  
  //displays a rectangle at positions x and y values
  void display() {
   
    
    rect(position.x, position.y, 5, 20);
    
  }
  
  
  //updates the position by its velocity, then multiplies the velocity by the acceleration value
  void update() {
    
   position.sub(velocity);
   velocity.mult(acceleration);
    
  }











}
