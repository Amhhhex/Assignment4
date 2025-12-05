
//The player class
class Spaceship {
  
  //declaring the local variables
  PImage image;
  PVector position;

  boolean moveRight;
  boolean moveLeft;
  
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();


  //Takes two arguements, a PImage variable for the ships look, and a PVector for its position
  
  Spaceship(PImage tempImage, PVector tempPosition) {
    image = tempImage;
    position = tempPosition;
  }



  //displays the image at the current x and y positions
  void display() {

    image(image, position.x, position.y);
  }

  //updates the player characters position
  //if either is true, the character will move in that direction until its false
  void move() {

    if (moveRight) {

      player.position.x += 5;
    }

    if (moveLeft) {
      player.position.x -= 5;
    }
  }
}
