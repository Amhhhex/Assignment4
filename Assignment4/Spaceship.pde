class Spaceship {
  PImage image;
  PVector position;

  boolean moveRight;
  boolean moveLeft;


  Spaceship(PImage tempImage, PVector tempPosition) {
    image = tempImage;
    position = tempPosition;
  }




  void display() {

    image(image, position.x, position.y);
  }

  void move() {

    if (moveRight) {

      player.position.x += 5;
    }

    if (moveLeft) {
      player.position.x -= 5;
    }
  }
}
