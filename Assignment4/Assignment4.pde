
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

boolean gameOver;


void setup() {
  size(400, 400);

  gameOver = false;

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


    OrangeAlien tempAlien = new OrangeAlien(orangeAlien, new PVector(30 + i, 0), new PVector(1, 0), -1.0025);


    orangeList.add(tempAlien);
  }


  player = new Spaceship(playerSpaceship, playerPosition);
}

void draw() {

  if (!gameOver) {


    if (orangeList.isEmpty()) {

      gameOver = true;
    }

    fill(255);
    background(0);



    player.move();

    player.position.x = constrain(player.position.x, 0, width - 40);

    player.display();

    for (int l = 0; l < player.bullets.size(); l++) {
      player.bullets.get(l).update();
      player.bullets.get(l).display();

      for (int n = orangeList.size() - 1; n >= 0; n--) {
        if (player.bullets.get(l).position.x > orangeList.get(n).position.x && player.bullets.get(l).position.x < orangeList.get(n).position.x + 40 && player.bullets.get(l).position.y > orangeList.get(n).position.y && player.bullets.get(l).position.y < orangeList.get(n).position.y + 40) {
          orangeList.remove(n);
        }
      }
    }



    for (int i = 0; i < orangeList.size(); i++) {
      boolean anyEdges = false;
      OrangeAlien alienCheck = orangeList.get(i);


      anyEdges = orangeList.get(i).edgeDetection();

      if (anyEdges) {

        for (int k = 0; k < orangeList.size(); k++) {

          orangeList.get(k).reverseDirection();

          if (orangeList.get(k).velocity.x < 0) {
            if(k == 4) {
              orangeList.get(k).position.x +=1;
            }
            orangeList.get(k).position.x -= 1;
          }
          if (orangeList.get(k).velocity.x > 0){
            orangeList.get(k).position.x += 1;
          }
        }

        alienCheck.update();
        alienCheck.display();
        alienCheck.shoot();

        for (int m = 0; m < alienCheck.alienBullets.size(); m++) {
          alienCheck.alienBullets.get(m).update();
          alienCheck.alienBullets.get(m).display();
        }
      } else {

        //println(alienCheck.position.x);

        alienCheck.update();
        alienCheck.display();
        alienCheck.shoot();

        for (int m = 0; m < alienCheck.alienBullets.size(); m++) {
          alienCheck.alienBullets.get(m).update();
          alienCheck.alienBullets.get(m).display();

          if (alienCheck.alienBullets.get(m).position.x > player.position.x && alienCheck.alienBullets.get(m).position.x < player.position.x + 40 && alienCheck.alienBullets.get(m).position.y > player.position.y && alienCheck.alienBullets.get(m).position.y < player.position.y + 40) {
            gameOver = true;
          }
        }
      }
    }
  } else {
    background(255);
    fill(0);
    textSize(50);
    text("GAME OVER", 75, height/2);
    textSize(25);
    text("Press Space to continue", 75, 300);
  }
}



void keyPressed() {

  if (key == 'a') {
    player.moveLeft = true;
  }

  if (key == 'd') {
    player.moveRight = true;
  }

  if (key == ' ' && gameOver == true) {

    orangeList.clear();

    for (int i = 0; i < 250; i += 50) {


      OrangeAlien tempAlien = new OrangeAlien(orangeAlien, new PVector(30 + i, 0), orangeAlienVelocity, alienAcceleration);


      orangeList.add(tempAlien);
    }

    player = new Spaceship(playerSpaceship, playerPosition);



    gameOver = false;
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
