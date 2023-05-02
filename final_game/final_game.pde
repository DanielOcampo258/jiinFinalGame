PImage sceneImage;

SceneObject[] sceneObjects;

String initialStateImage;
Boolean hoveringOverObject;
Boolean calcRunning;
Calculator calc;

void setup(){
  calcRunning = false;
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
  sceneObjects[4] = new SceneObject("Drawer", new int[]{725, 770}, new int[]{832,870}, "images/drawerOpen.png");
  sceneObjects[4].setInsideImage("images/Calculator_On.png");
}

void draw(){
  
     background(sceneImage);
  
  if(calcRunning){
    sceneImage = calc.getCalcImage();
       textSize(20);
    text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  fill(255, 255, 255);
    calc.overButtons();
  }else{
    
    //calc.overButtons();
     
   for(int i=0; i<sceneObjects.length; ++i){
     if(sceneObjects[i] != null){
       if(sceneObjects[i].inBounds(mouseX, mouseY)){
         //cursor(MOVE); //<>//
          sceneObjects[i].setMouseOver(true); 
         if(mousePressed){
           sceneObjects[i].setClickAmount(sceneObjects[i].getClickAmount() + 1);
     
           mousePressed = false;
                 
          
            cursor(ARROW);
           sceneImage = loadImage(sceneObjects[i].getOpenImage());
            if(sceneObjects[i].getClickAmount() % 2 == 0 && sceneObjects[i].getName().equals("Drawer")){
              
              hoveringOverObject = true;
              calcRunning = true;
        
           
            }
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
    
       if(sceneObjects[j].isMouseOver() || hoveringOverObject)
         break;
        sceneObjects[j].setClickAmount(0);
     }
     if(j == sceneObjects.length - 1){
         cursor(ARROW);
         sceneImage = loadImage(initialStateImage);
       }
   }
  }
   



  //   textSize(20);
  //  text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  //fill(255, 255, 255);
}
