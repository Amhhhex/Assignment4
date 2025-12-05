
//Generic star class
class Star {
  
  //declaring the local variables
  PVector position;
  PVector velocity;
  float acceleration;
  
  //this ensures the stars are random colours
  int red = int(random(0,255));
  int green = int(random(0,255));
  int blue = int(random(0,255));
  
  
  //constructor takes 3 arguments, two PVectors for position and velocity, and a float for acceleration
  Star (PVector tempPosition, PVector tempVelocity, float tempAcceleration) {
    
    position = tempPosition;
    velocity = tempVelocity;
    acceleration = tempAcceleration;
    
  }
  
  
  
  //displays a rectangle at the current positions x and y values
  //uses the random RGB colours to colour the star
  void display() {
   
    rectMode(CENTER);
    
    fill(red, green, blue);
    rect(position.x, position.y, 5, 5);
    
  }
  
  //moves the star by the velocity of the star
  void update() {
    
   position.sub(velocity);
   //velocity.mult(acceleration);
    
  }



}
