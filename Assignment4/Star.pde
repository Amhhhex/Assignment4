class Star {
  
  PVector position;
  PVector velocity;
  float acceleration;
  
  int red = int(random(0,255));
  int green = int(random(0,255));
  int blue = int(random(0,255));
  int alpha = int(random(0,255));
  
  
  Star (PVector tempPosition, PVector tempVelocity, float tempAcceleration) {
    
    position = tempPosition;
    velocity = tempVelocity;
    acceleration = tempAcceleration;
    
  }
  
  
  
  
  void display() {
   
    rectMode(CENTER);
    
    fill(red, green, blue);
    rect(position.x, position.y, 5, 5);
    
  }
  
  void update() {
    
   position.sub(velocity);
   //velocity.mult(acceleration);
    
  }











}
