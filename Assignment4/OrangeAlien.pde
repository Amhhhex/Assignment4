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


    if (position.x >= 360) {
      velocity.mult(acceleration);
      position.y += 3;
    }
    
    if (position.x < 0) {
      velocity.mult(acceleration);
      position.y += 3;
    }
  }
}
