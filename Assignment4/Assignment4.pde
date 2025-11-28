
PImage orangeAlien;
PImage pinkAlien;
PImage greenAlien;
PImage yellowAlien;
PImage playerSpaceship;

Spaceship player;

PVector playerPosition;



void setup() {
  size(400, 400);
  orangeAlien = loadImage("OrangeSpaceInvader.png");
  pinkAlien = loadImage("PinkSpaceInvader.png");
  greenAlien = loadImage("GreenSpaceInvader.png");
  yellowAlien = loadImage("YellowSpaceInvader.png");
  playerSpaceship = loadImage("PlayerSpaceship.png");

  playerSpaceship.resize(40, 40);

  playerPosition = new PVector(185, 345);

  player = new Spaceship(playerSpaceship, playerPosition);
}

void draw() {

  background(255);
  player.display();
}

void keyPressed() {

  if (key == 'a' && player.position.x > 0) {
    player.position.x -= 5;
  }

  if (key == 'd' && player.position.x < 360) {
    player.position.x += 5;
  }
}
