
import gifAnimation.*;

PImage orangeAlien;
PImage pinkAlien;
PImage greenAlien;
PImage yellowAlien;
PImage playerSpaceship;

Spaceship player;

PImage[] explosionGif;
int explosionFrame;

ArrayList<Explosion> explosionList = new ArrayList<Explosion>();


PVector playerPosition;

ArrayList<Alien> alienList = new ArrayList<Alien>();

PVector orangeAlienPosition;
PVector orangeAlienVelocity;

PVector orangeAlienPosition2;

float alienAcceleration;

boolean moveRight;
boolean moveLeft;

boolean gameOver;
boolean gameWon;


int seed = int(random(0, 120));

ArrayList<Star> starList = new ArrayList<Star>();


void setup() {
  size(600, 600);

  gameOver = false;

  orangeAlien = loadImage("OrangeSpaceInvader.png");
  pinkAlien = loadImage("PinkSpaceInvader.png");
  greenAlien = loadImage("GreenSpaceInvader.png");
  yellowAlien = loadImage("YellowSpaceInvader.png");
  playerSpaceship = loadImage("PlayerSpaceship.png");

  playerSpaceship.resize(40, 40);
  orangeAlien.resize(40, 40);
  pinkAlien.resize(40, 40);
  greenAlien.resize(40, 40);

  playerPosition = new PVector(width/2, 500);

  orangeAlienVelocity = new PVector(1, 0);

  alienAcceleration = -1.0025;

  spawnAliens();



  player = new Spaceship(playerSpaceship, playerPosition);

  explosionGif = new PImage[13];

  for (int g = 0; g < explosionGif.length; g++) {
    explosionGif[g] = loadImage("frame_" + g + "_delay-0.08s.gif");
  }
}

void draw() {

  boolean anyEdges = false;

  if (!gameOver) {


    if (alienList.isEmpty()) {

      gameOver = true;
      gameWon = true;
    }
    fill(255);
    background(0);

    for (int j = 0; j < starList.size(); j++) {



      starList.get(j).update();
      starList.get(j).display();
    }

    noiseSeed(seed);

    for (int i = 0; i <= width; i++) {

      float y = noise(i);

      if (y > 0.88) {

        if (i > 0 && i < width - 1) {
          Star tempStar = new Star(new PVector(i, 0), new PVector(0, -3), 1.0025);

          starList.add(tempStar);
        }
      }

      seed++;
    }





    fill(255);



    player.move();

    player.position.x = constrain(player.position.x, 0, width - 40);

    player.display();

    println(player.bullets.size());

    for (int l = player.bullets.size() - 1; l >= 0; l--) {
      player.bullets.get(l).update();
      player.bullets.get(l).display();

      for (int n = alienList.size() - 1; n >= 0; n--) {
        if (player.bullets.get(l).position.x > alienList.get(n).position.x && player.bullets.get(l).position.x < alienList.get(n).position.x + 40 && player.bullets.get(l).position.y > alienList.get(n).position.y && player.bullets.get(l).position.y < alienList.get(n).position.y + 40) {


          explosionList.add(new Explosion(alienList.get(n).position.x, alienList.get(n).position.y));

          alienList.remove(n);
          player.bullets.remove(l);
          break;
        }
      }
    }


    for (int a = 0; a < explosionList.size(); a++) {

      println("This is the a value " + a);
      explosionList.get(a).display();
    }



    for (int h = 0; h < alienList.size(); h++) {
      anyEdges = alienList.get(h).edgeDetection();
    }



    for (int i = 0; i < alienList.size(); i++) {

      Alien alienCheck = alienList.get(i);


      anyEdges = alienList.get(i).edgeDetection();

      if (anyEdges) {

        //5th alien is one pixel closer bc the other aliens get 1 frame of movement more before the edge detection occurs
        // e.g when the 5th alien is touch the edge of the screen on the right side the for loop counts forwards moving each
        // alien up by their velocity amount before the 5th notifys them of touching the edge
        //

        for (int k = 0; k < alienList.size(); k++) {

          alienList.get(k).reverseDirection();

          if (alienList.get(k).velocity.x < 0) {
            alienList.get(k).position.x -= 1;
          }
          if (alienList.get(k).velocity.x > 0) {
            alienList.get(k).position.x += 1;
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
    if (gameWon) {

      background(0);
      fill(255);
      textSize(50);
      text("You Won!!!", 180, height/2);
      textSize(25);
      text("Press Space to continue", 180, 500);
    } else {
      background(255);
      fill(0);
      textSize(50);
      text("GAME OVER", 180, height/2);
      textSize(25);
      text("Press Space to continue", 180, 500);
    }
  }
  anyEdges = false;
}



void keyPressed() {

  if (key == 'a') {
    player.moveLeft = true;
  }

  if (key == 'd') {
    player.moveRight = true;
  }

  if (key == ' ' && gameOver == true) {

    alienList.clear();

    explosionList.clear();

    spawnAliens();

    player = new Spaceship(playerSpaceship, playerPosition);

    gameOver = false;
    
    gameWon = false;
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

void spawnAliens() {

  for (int i = 0; i < 550; i += 70) {


    Alien tempOrangeAlien = new Alien(orangeAlien, new PVector(30 + i, 0), new PVector(1, 0), alienAcceleration, int(random(60, 180)));


    alienList.add(tempOrangeAlien);
  }

  for (int i = 30; i < 550; i += 70) {


    Alien tempPinkAlien = new Alien(pinkAlien, new PVector(30 + i, 50), new PVector(1, 0), alienAcceleration, int(random(90, 180)));


    alienList.add(tempPinkAlien);
  }

  for (int i = 0; i < 550; i += 70) {


    Alien tempGreenAlien = new Alien(greenAlien, new PVector(30 + i, 100), new PVector(1, 0), alienAcceleration, int(random(90, 360)));


    alienList.add(tempGreenAlien);
  }
}
