
//A generic alien class
class Alien {

  //declaring the local alien variables
  PImage image;
  PVector position;
  PVector velocity;
  float acceleration;

  int fireRate;

  ArrayList<Bullet> alienBullets = new ArrayList<Bullet>();
  
  
  //constructor class takes in an image, two PVectors for position and velocity, and float for acceleration and an int for the fireRate
  Alien(PImage tempImage, PVector tempPosition, PVector tempVelocity, float tempAcceleration, int tempFireRate) {

    image = tempImage;
    position = tempPosition;
    velocity = tempVelocity;
    acceleration = tempAcceleration;
    fireRate = tempFireRate;
  }


  //displays the image at the current x and y positions
  void display() {

    image(image, position.x, position.y);
  }


  //moves the aliens in the current direction
  void update() {


    position.add(velocity);
  }

  //reverses the velocity while also slightly increasing the velocity. Also moves the alien down 3 pixels
  void reverseDirection() {
    
    position.y += 3;
    velocity.mult(acceleration);
  }
  

  //shoots an alien bullet given a specified time
  void shoot() {


    //everytime the fireRate can modulo the frameCOunt variable it fires
    //it creates the bullet, adds it to the arrayList and plays a sound
    if (frameCount % fireRate == 0) {


  
      Bullet tempAlienBullet = new Bullet(new PVector(position.x + 20, position.y + 40), new PVector(0, -3), 1.025);

      alienLaser.play();
      alienBullets.add(tempAlienBullet);
    }
  }
  
  

  //checks if the alien is touch of the edge of the screen
  //returns a value based on whether this is true or not
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
