PImage sceneImage;

SceneObject[] sceneObjects;

String initialStateImage;
Boolean hoveringOverObject;
Calculator calc;

void setup(){
   size(1920, 1080);
  calc = new Calculator();

  
    sceneObjects = new SceneObject[12];
    initialStateImage = "images/initialRoomState.png";
    
 hoveringOverObject = false;
  sceneImage = loadImage(initialStateImage);
  
  sceneObjects[0] = new SceneObject("wardrobe", new int[]{896,220}, new int[]{1029,570}, "images/wardrobeOpen.png" );
  sceneObjects[1] = new SceneObject("Poster_1", new int[]{548, 300}, new int[]{624, 368}, initialStateImage);
  sceneObjects[2] = new SceneObject("Window", new int[]{1218,278}, new int[]{1350,510}, "images/window-open.png");
  sceneObjects[3] = new SceneObject("Calendar", new int[]{1047,346}, new int[]{1091,440}, "images/test.png");
  
}

void draw(){
  
 

   image(sceneImage,0,0);
    calc.overButtons();
     
    textSize(20);
    text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  fill(255, 255, 255);
  
  
   for(int i=0; i<sceneObjects.length; ++i){
     if(sceneObjects[i] != null){
       if(sceneObjects[i].inBounds(mouseX, mouseY)){
         //cursor(MOVE);
          sceneObjects[i].setMouseOver(true); 
         if(mousePressed){
            cursor(ARROW);
           sceneImage = loadImage(sceneObjects[i].getOpenImage());
            
         }
       }else{
         if(mousePressed)
          sceneObjects[i].setMouseOver(false); 
     }
    }  
   }
   
   //pass over all of the objects to make sure user is not hovering over anything to set
   // scene back to og image
   for(int j=0; j<sceneObjects.length; ++j){
     if(sceneObjects[j] != null){
       if(sceneObjects[j].isMouseOver())
         break;
       
     }
     if(j == sceneObjects.length - 1){
         cursor(ARROW);
         sceneImage = loadImage(initialStateImage);
       }
   }
   
  image(sceneImage,0,0);

  
}
