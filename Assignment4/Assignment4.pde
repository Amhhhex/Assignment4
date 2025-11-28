
PImage orangeAlien;
PImage pinkAlien;
PImage greenAlien;
PImage yellowAlien;
PImage playerSpaceship;

Spaceship player;
OrangeAlien orangeOne;

PVector playerPosition;

PVector orangeAlienPosition;
PVector orangeAlienVelocity;

float alienAcceleration;

boolean moveRight;
boolean moveLeft;



void setup() {
  size(400, 400);
  orangeAlien = loadImage("OrangeSpaceInvader.png");
  pinkAlien = loadImage("PinkSpaceInvader.png");
  greenAlien = loadImage("GreenSpaceInvader.png");
  yellowAlien = loadImage("YellowSpaceInvader.png");
  playerSpaceship = loadImage("PlayerSpaceship.png");

  playerSpaceship.resize(40, 40);
  orangeAlien.resize(40, 40);

  playerPosition = new PVector(185, 345);
  
  orangeAlienPosition = new PVector(50, 50);
  orangeAlienVelocity = new PVector(3, 0);
  
  alienAcceleration = -1.025;

  player = new Spaceship(playerSpaceship, playerPosition);
  orangeOne = new OrangeAlien(orangeAlien, orangeAlienPosition, orangeAlienVelocity, alienAcceleration);
}

void draw() {

  background(255);
  player.move();
  
  player.position.x = constrain(player.position.x, 0, 360);
  
  player.display();
  
  orangeOne.update();
  orangeOne.display();
}

void keyPressed() {

  if (key == 'a') {
    player.moveLeft = true;
  }

  if (key == 'd') {
    player.moveRight = true;
  }
}

void keyReleased() {
  
  if (key == 'a') {
    player.moveLeft = false;
  }

  if (key == 'd') {
    player.moveRight = false;
  }
  
}
