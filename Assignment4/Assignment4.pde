/*
  Orange Alien image retrieved from: https://www.pngegg.com/en/png-ffmzv
  Pink Alien image retrieved from: https://www.pngegg.com/en/png-zxqqa/download
  Green Alien image retrived from: https://www.pngegg.com/en/png-ffmzl
  Yellow Alien image retrived from: https://www.pngegg.com/en/png-ffmzu

  Player Spaceship image retrived from: https://www.pngegg.com/en/png-bjneh/download
  
  Alien Bullet sound retrieved from: https://samplefocus.com/samples/retro-gun-laser
  All other sounds retrived from the following: https://classicgaming.cc/classics/space-invaders/sounds#google_vignette

*/



//Importing the Processing sound library
import processing.sound.*;

//Declaring the image variables for all alien types and the space ship
PImage orangeAlien;
PImage pinkAlien;
PImage greenAlien;
PImage yellowAlien;
PImage playerSpaceship;

//Declaring the Win screen image
PImage youWinScreen;

//Declaring the player
Spaceship player;

//Creating the PImage array for the explosion, and the index of the explosion
PImage[] explosionGif;
int explosionFrame;


//Declaring the explosion arrayList, which will store all explosions
ArrayList<Explosion> explosionList = new ArrayList<Explosion>();

//Declaring the playerPosition variable, used to start the player in a specific location on screen
PVector playerPosition;

//The Alien arrayList, stores all aliens within it
ArrayList<Alien> alienList = new ArrayList<Alien>();

//Declaring the alien acceleration
float alienAcceleration;

//Declaring the moving variables
boolean moveRight;
boolean moveLeft;

//Declaring the game state booleans
boolean gameOver;
boolean gameWon;

//Declaring the sound file variables
SoundFile playerShot;
SoundFile playerExplosion;
SoundFile alienExplode;
SoundFile alienLaser;

//Declaring and assigning the seed variable, used to create the stars
int seed = int(random(0, 120));

//Declaring the star arraList, which stores all created stars
ArrayList<Star> starList = new ArrayList<Star>();


void setup() {
  //Establishing the size of the screen
  size(600, 600);
  
  //Settings the gameState
  gameOver = false;

  //Loading the alien images
  orangeAlien = loadImage("OrangeSpaceInvader.png");
  pinkAlien = loadImage("PinkSpaceInvader.png");
  greenAlien = loadImage("GreenSpaceInvader.png");
  yellowAlien = loadImage("YellowSpaceInvader.png");
  playerSpaceship = loadImage("PlayerSpaceship.png");
  
  //loading the winning screen image
  youWinScreen = loadImage("YouWinScreen.png");
  
  
  //loading the sound files
  playerShot = new SoundFile(this, "shoot.wav");
  playerExplosion = new SoundFile(this, "explosion.wav");
  alienExplode = new SoundFile(this, "invaderkilled.wav");
  alienLaser = new SoundFile(this, "alien-laser.wav");

  //resizing all images to the same size
  playerSpaceship.resize(40, 40);
  orangeAlien.resize(40, 40);
  pinkAlien.resize(40, 40);
  greenAlien.resize(40, 40);
  yellowAlien.resize(40, 40);

  //assigning the starting player position
  playerPosition = new PVector(width/2, 500);


  //assigning the alienAcceleration 
  alienAcceleration = -1.0025;

  //calling the spawn aliens function
  spawnAliens();



  //assigning the player variable with the starting player position and image
  player = new Spaceship(playerSpaceship, playerPosition);

  //assigning the explosion array size
  explosionGif = new PImage[13];

  //populating the explosion array with its image
  for (int g = 0; g < explosionGif.length; g++) {
    explosionGif[g] = loadImage("frame_" + g + "_delay-0.08s.gif");
  }
}

void draw() {

  //setting the anyEdges variable to false, is used to determine if an alien is touching the edge
  boolean anyEdges = false;

  //if the game isn't over, play the game
  if (!gameOver) {


    //if all aliens have been eliminated, switch the game state and switch the game to won
    if (alienList.isEmpty()) {

      gameOver = true;
      gameWon = true;
    }
    
    //creating the background
    fill(255);
    background(0);

    //Moves and displays every star in the arrayList, if the the star is off the screen, it gets deleted
    for (int j = starList.size() - 1; j >= 0; j--) {

      if(starList.get(j).position.y > height) {
      
         starList.remove(j);
         continue;
      
      }

      starList.get(j).update();
      starList.get(j).display();
    }

    //set the seed for the noise
    noiseSeed(seed);

    //Loops for every pixel on the width of the screen
    for (int i = 0; i <= width; i++) {

      //saves the noise value into a variable
      float y = noise(i);

      //if the noise variable is greater than the specified amoun, create a new star at that location and store it in the star arrayList
      if (y > 0.88) {

        if (i > 0 && i < width - 1) {
          Star tempStar = new Star(new PVector(i, 0), new PVector(0, -3), 1.0025);

          starList.add(tempStar);
        }
      }
      //increment the seed by 1
      seed++;
    }



    //makes the bullets white to increase visibility
    fill(255);


    //updates the players position
    player.move();
    
    //constrains the player within the screen
    player.position.x = constrain(player.position.x, 0, width - 40);

    //displays the player
    player.display();


    //A nested for loop for the bullets
    //First the bullets positions are updated and then displayed, if the bullet is off screen it is removed from the arrayList
    //The second for loop is for collision detection
    for (int l = player.bullets.size() - 1; l >= 0; l--) {
      
      if(player.bullets.get(l).position.y <= 0) {
        
        player.bullets.remove(l);
        continue;
      
      
      }
      player.bullets.get(l).update();
      player.bullets.get(l).display();

      //Collision detection for the bullets and the aliens
      for (int n = alienList.size() - 1; n >= 0; n--) {
        //if a bullet and the aliens hitbox overlap then an explosion is added to the explosion arrayList
        //then the alien explode sound is played, with the alien being removed from the list and the bullet being removed from the bullet arrayList
        if (player.bullets.get(l).position.x > alienList.get(n).position.x && player.bullets.get(l).position.x < alienList.get(n).position.x + 40 && player.bullets.get(l).position.y > alienList.get(n).position.y && player.bullets.get(l).position.y < alienList.get(n).position.y + 40) {


          explosionList.add(new Explosion(alienList.get(n).position.x, alienList.get(n).position.y));

          alienExplode.play();
          alienList.remove(n);
          player.bullets.remove(l);
          break;
        }
      }
    }


    //for every explosion in the explosion arrayList display the explosion
    for (int a = 0; a < explosionList.size(); a++) {

      explosionList.get(a).display();
    }



    



    //This is a series of for loops going through the alien arrayList
    for (int i = 0; i < alienList.size(); i++) {

      Alien alienCheck = alienList.get(i);


      //first, it checks to see if any aliens are touching the edge of the screen
      anyEdges = alienList.get(i).edgeDetection();

      //if any alien is touching the edge of the screen
      if (anyEdges) {

        

        //loops through the list of aliens again, then it reverses the direction of every alien
        //Each alien is also bumped slightly to ensure they stay within the screen space
        for (int k = 0; k < alienList.size(); k++) {

          alienList.get(k).reverseDirection();

          if (alienList.get(k).velocity.x < 0) {
            alienList.get(k).position.x -= 1;
          }
          if (alienList.get(k).velocity.x > 0) {
            alienList.get(k).position.x += 1;
          }
        }

        //then the aliens position is updated, then displayed, then they shoot (if possible, see alien class for more)
        alienCheck.update();
        alienCheck.display();
        alienCheck.shoot();


        //The aliens bullets have their position updated and then displayed
        //If the bullet is offscreen, the bullet is removed
        for (int m = 0; m < alienCheck.alienBullets.size(); m++) {
          
          if(alienCheck.alienBullets.get(m).position.y >= height) {
            
            alienCheck.alienBullets.remove(m);
            continue;
          
          }
          
          alienCheck.alienBullets.get(m).update();
          alienCheck.alienBullets.get(m).display();
        }
      //If the alien isn't touching the edge of the screen
      } else {


        //the aliens position is then updated, displayed, then they shoot
        alienCheck.update();
        alienCheck.display();
        alienCheck.shoot();

        //Then every alien bullet is updated and then displayed
        //If the bullet is off screen, the bullet is removed
        for (int m = 0; m < alienCheck.alienBullets.size(); m++) {
          
          if(alienCheck.alienBullets.get(m).position.y >= height) {
            
            
            alienCheck.alienBullets.remove(m);
            continue;
          
          }
          
          alienCheck.alienBullets.get(m).update();
          alienCheck.alienBullets.get(m).display();

          //A collision check for the alien bullet
          //If any part of the alien bullet intersects with the player hit box the game state is swapped
          //also an explosion sound is played for the player
          if (alienCheck.alienBullets.get(m).position.x > player.position.x && alienCheck.alienBullets.get(m).position.x < player.position.x + 40 && alienCheck.alienBullets.get(m).position.y > player.position.y && alienCheck.alienBullets.get(m).position.y < player.position.y + 40) {
            
            playerExplosion.play();
            gameOver = true;
          }
        }
      }
    }
  //executes once the game state has flipped
  } else {
    
    //if the player eliminated all aliens, display the youWinScreen image
    if (gameWon) {
      
      image(youWinScreen, 0, 0);

    //if the player hasn't won, then display the game over screen
    } else {
      background(255);
      fill(0);
      textSize(50);
      text("GAME OVER", 180, height/2);
      textSize(25);
      text("Press Space to continue", 180, 500);
    }
  }
  //reset anyEdges to false
  anyEdges = false;
}



void keyPressed() {

  //if a or d is pressed, move the player left or right 
  if (key == 'a') {
    player.moveLeft = true;
  }

  if (key == 'd') {
    player.moveRight = true;
  }

  //resets the game state if the gameOver state is true and the space bar is pressed
  if (key == ' ' && gameOver == true) {

    //clear the alienList
    alienList.clear();

    //clear the explosion list
    explosionList.clear();

    //spawn all aliens
    spawnAliens();

    //center the player character
    player = new Spaceship(playerSpaceship, playerPosition);

    //reset the game states
    gameOver = false;
    
    gameWon = false;
  }
}

//once the keys are released, stop moving the player character in that direction
void keyReleased() {

  if (key == 'a') {
    player.moveLeft = false;
  }

  if (key == 'd') {
    player.moveRight = false;
  }
}

//whenever the mouse is pressed, create a new bullet, add it to the bullet arrayList and play a sound
void mousePressed() {

  Bullet tempBullet = new Bullet(new PVector(player.position.x + 20, player.position.y), new PVector(0, 3), 1.025);

  player.bullets.add(tempBullet);
  
  playerShot.play();
}

//A series of for loops that spawn the aliens, each for loop gives the aliens a different y value to use
void spawnAliens() {

  for (int i = 0; i < 550; i += 70) {


    Alien tempOrangeAlien = new Alien(orangeAlien, new PVector(30 + i, 0), new PVector(1, 0), alienAcceleration, int(random(60, 180))); 


    alienList.add(tempOrangeAlien);
  }

  for (int i = 30; i < 550; i += 70) {


    Alien tempPinkAlien = new Alien(pinkAlien, new PVector(30 + i, 50), new PVector(1, 0), alienAcceleration, int(random(120, 180)));


    alienList.add(tempPinkAlien);
  }

  for (int i = 0; i < 550; i += 70) {


    Alien tempGreenAlien = new Alien(greenAlien, new PVector(30 + i, 100), new PVector(1, 0), alienAcceleration, int(random(240, 360)));


    alienList.add(tempGreenAlien);
  }
  
  for (int i = 30; i < 550; i += 70) {


    Alien tempYellowAlien = new Alien(yellowAlien, new PVector(30 + i, 150), new PVector(1, 0), alienAcceleration, int(random(180, 240)));


    alienList.add(tempYellowAlien);
  }
}
