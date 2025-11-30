
PImage orangeAlien;
PImage pinkAlien;
PImage greenAlien;
PImage yellowAlien;
PImage playerSpaceship;

Spaceship player;


PVector playerPosition;

ArrayList<OrangeAlien> orangeList = new ArrayList<OrangeAlien>();

PVector orangeAlienPosition;
PVector orangeAlienVelocity;

PVector orangeAlienPosition2;

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

  orangeAlienVelocity = new PVector(1, 0);

  alienAcceleration = -1.0025;

  for (int i = 0; i < 250; i += 50) {


    OrangeAlien tempAlien = new OrangeAlien(orangeAlien, new PVector(30 + i, 0), orangeAlienVelocity, alienAcceleration);


    orangeList.add(tempAlien);
  }


  player = new Spaceship(playerSpaceship, playerPosition);
}

void draw() {

  background(0);


  player.move();

  player.position.x = constrain(player.position.x, 0, width - 40);

  player.display();

  for (int l = 0; l < player.bullets.size(); l++) {
    player.bullets.get(l).update();
    player.bullets.get(l).display();
  }

  for (int i = 0; i < orangeList.size(); i++) {
    boolean anyEdges = false;
    OrangeAlien alienCheck = orangeList.get(i);

    for (int k = 0; k < orangeList.size(); k++) {
      anyEdges = orangeList.get(k).edgeDetection();
      if (anyEdges) {
        break;
      }
    }



    if (anyEdges) {
      for (int j = 0; j < orangeList.size(); j++) {
        OrangeAlien alienCheck2 = orangeList.get(j);

        alienCheck2.reverseDirection();
        alienCheck2.update();
        alienCheck2.display();
        alienCheck2.shoot();

        for (int m = 0; m < alienCheck2.alienBullets.size(); m++) {
          alienCheck2.alienBullets.get(m).update();
          alienCheck2.alienBullets.get(m).display();
        }
      }
    } else {

      //println(alienCheck.position.x);

      alienCheck.update();
      alienCheck.display();
      alienCheck.shoot();

        for (int m = 0; m < alienCheck.alienBullets.size(); m++) {
          alienCheck.alienBullets.get(m).update();
          alienCheck.alienBullets.get(m).display();
        }
    }
  }
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


void mousePressed() {

  Bullet tempBullet = new Bullet(new PVector(player.position.x + 20, player.position.y), new PVector(0, 3), 1.025);

  player.bullets.add(tempBullet);
}
