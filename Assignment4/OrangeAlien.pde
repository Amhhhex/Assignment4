class OrangeAlien {

  PImage image;
  PVector position;
  PVector velocity;
  float acceleration;

  OrangeAlien(PImage tempImage, PVector tempPosition, PVector tempVelocity, float tempAcceleration) {

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

    
  }
  
  void reverseDirection() {
    
      velocity.mult(acceleration);
      position.y += 3;
    
  }
  
  boolean edgeDetection() {
    
    if (position.x >= width - 40) {
      return true;
    }
    
    if (position.x <= 0) {
      return true;
    }
    
    else {
      return false;
    }
  }
}
