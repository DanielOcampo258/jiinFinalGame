PImage sceneImage;

SceneObject[] sceneObjects;

String initialStateImage;
boolean hoveringOverObject;
boolean calcRunning;
boolean posterRunning;
boolean passcodeRunning;
boolean questionsRunning;
boolean playerIsAlive;
float startTime = 0;
Calculator calc;
Poster poster;
Questions questions;

void setup(){
  calcRunning = posterRunning =  passcodeRunning = questionsRunning = false;
  size(1920, 1080);
  calc = new Calculator();
  poster = new Poster();
  questions = new Questions();
  sceneObjects = new SceneObject[12];
  
  initialStateImage = "images/initialRoomState.png";

 hoveringOverObject = false;
  sceneImage = loadImage(initialStateImage);
  
  sceneObjects[0] = new SceneObject("Cabinet", new int[]{896,220}, new int[]{1029,570}, "images/open_cabinet.png" );
  sceneObjects[1] = new SceneObject("Poster_1", new int[]{705, 200}, new int[]{800, 440}, "images/posterHover.png");
  sceneObjects[1].setInsideImage("images/posterLocked.png");
  sceneObjects[2] = new SceneObject("Window", new int[]{1218,278}, new int[]{1350,510}, "images/window-open.png");
  sceneObjects[3] = new SceneObject("Calendar", new int[]{1047,346}, new int[]{1091,440}, "images/test.png");
  sceneObjects[4] = new SceneObject("Drawer", new int[]{725, 770}, new int[]{832,870}, "images/drawerOpen.png");
  sceneObjects[4].setInsideImage("images/Calculator_On.png");
  
 
}

public void playerDies(){
   
}


public boolean isMouseInBounds(int[] tlC, int[] brC){
  
  return (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1]);
  
}

public boolean isMouseInBoundsAndPressed(int[] tlC, int[] brC){
  
  return (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1] && mousePressed);
  
}



void draw(){
  
  
  //if(!poster.isOpen){
  //  sceneImage = loadImage(sceneObjects[1].getInsideImage());
  //  background(sceneImage);
  //  poster.displayPoster();
  //}else{
  //    if(startTime == 0){
  //      startTime = millis();
  //    }
      
  //    float elapsedTime = millis() - startTime;
      
  //    if(elapsedTime > 1000){
  //      sceneImage = questions.drawQuestions();
  //      background(sceneImage);
  //      questions.handleUserInput();
  //         textSize(20);
  //text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  //fill(255, 255, 255);
  
  //    }else
  //       background(sceneImage);
         
  //}
    
    
  background(sceneImage);
  
  if(calcRunning){
    
    sceneImage = calc.getCalcImage(); //<>//
     
    calc.overButtons();
    
   if(!calc.insideOfCalc()){
      calcRunning = false;
    }
    
  }else if(posterRunning){
    
    if(isMouseInBoundsAndPressed(poster.getTlc(), poster.getBrc()) ){
    
      sceneImage = loadImage(sceneObjects[1].getInsideImage());
      passcodeRunning = true;
    } else if(!isMouseInBounds(poster.getTlc(), poster.getBrc()) && mousePressed && !questionsRunning){
      mousePressed = false;
      posterRunning = false;
      passcodeRunning = false;
      sceneImage = loadImage(initialStateImage);
    }
    
     if(!poster.isOpen){
    
    background(sceneImage);
   
    if(passcodeRunning)
      poster.displayPoster();
    
  }else{ //poster unlocked
   
       questionsRunning = true;
      if(startTime == 0){
        startTime = millis();
      }
      
      float elapsedTime = millis() - startTime;
      
      if(elapsedTime > 1000){
        sceneImage = questions.drawQuestions();
        background(sceneImage);
        questions.handleUserInput();
  //         textSize(20);
  //text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  //fill(255, 255, 255);
  
      }else
         background(sceneImage);
         
  }
  }else{
    
     
   for(int i=0; i<sceneObjects.length; ++i){
     if(sceneObjects[i] != null){
       if(sceneObjects[i].mouseInBounds()){
         //cursor(MOVE); //<>//
          sceneObjects[i].setMouseOver(true); 
         if(mousePressed){
           sceneObjects[i].setClickAmount(sceneObjects[i].getClickAmount() + 1);
     
           mousePressed = false;
                 
          
            cursor(ARROW);
           sceneImage = loadImage(sceneObjects[i].getOpenImage());
           
            if(sceneObjects[i].getClickAmount() % 2 == 0 && sceneObjects[i].getName().equals("Drawer")){
             
              calcRunning = true;
           
            }else if(sceneObjects[i].getName().equals("Poster_1")){
              println(sceneObjects[i].getClickAmount());
              posterRunning = true;
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
    
       if(sceneObjects[j].isMouseOver() || calcRunning || posterRunning)
         break;
        sceneObjects[j].setClickAmount(0);
     }
     if(j == sceneObjects.length - 1){
         cursor(ARROW);
         sceneImage = loadImage(initialStateImage);
       }
   }
  
  }
     
}

  //   textSize(20);
  //  text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  //fill(255, 255, 255);
