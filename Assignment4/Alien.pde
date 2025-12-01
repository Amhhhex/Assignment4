class Alien {

  PImage image;
  PVector position;
  PVector velocity;
  float acceleration;

  int fireRate;

  ArrayList<Bullet> alienBullets = new ArrayList<Bullet>();

  Alien(PImage tempImage, PVector tempPosition, PVector tempVelocity, float tempAcceleration, int tempFireRate) {

    image = tempImage;
    position = tempPosition;
    velocity = tempVelocity;
    acceleration = tempAcceleration;
    fireRate = tempFireRate;
  }


  void display() {

    image(image, position.x, position.y);
  }


  void update() {


    position.add(velocity);
  }

  void reverseDirection() {
    
    position.y += 3;
    velocity.mult(acceleration);
  }
  

  void shoot() {

    //println(frameCount % fireRate);

    if (frameCount % fireRate == 0) {

      //println("PEW!!");


      Bullet tempAlienBullet = new Bullet(new PVector(position.x + 20, position.y + 40), new PVector(0, -3), 1.025);

      alienBullets.add(tempAlienBullet);
    }
  }

  boolean edgeDetection() {

    if (position.x >= width - 40) {
      
      //position.x = width - 40;
      
      return true;
    }

    if (position.x <= 0) {
      
      //position.x = 0;
      return true;
    } else {
      return false;
    }
  }
}
