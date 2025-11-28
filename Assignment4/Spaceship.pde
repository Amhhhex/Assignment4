class Spaceship {
 PImage image;
 PVector position;
 
 
 
 Spaceship(PImage tempImage, PVector tempPosition) {
    image = tempImage;
    position = tempPosition;
   
 }
 
 
 
 
 void display() {
  
   image(image, position.x, position.y);
      
 }
 
 void move() {
   
   
   
 }
  
  
  
  
}
