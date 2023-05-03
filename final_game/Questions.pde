class Questions{
  private float startTime;
  private PImage[] questionImages;
  private PImage[] wrongAnswerImages;
  private PImage[] correctAnswerImages;
  private String[] correctAnswers;
  private String[] userAnswers;
  private String currentUserInput;
  private int currentQuestionIndex;
  private int currentResultIndex;
  public Questions(){
    startTime = 0.0;
    
    correctAnswers = new String[5];
   questionImages = new PImage[7];
   wrongAnswerImages = new PImage[3];
   correctAnswerImages = new PImage[2];
   
   questionImages[0] = loadImage("images/posterDoorOpen.png");
   questionImages[1] = loadImage("images/firstQ.png");
   questionImages[2] = loadImage("images/secondQ.png");
   questionImages[3] = loadImage("images/thirdQ.png");
   questionImages[4] = loadImage("images/fourthQ.png");
   questionImages[5] = loadImage("images/fifthQ.png");
   questionImages[6] = loadImage("images/userQ.png");
   
   currentUserInput = "";
   
   correctAnswers[0] = "nectar";
   correctAnswers[1] = "begonias";
   correctAnswers[2] = "icymi";
   correctAnswers[3] = "icymi";
   correctAnswers[4] = "saturday";
   
   currentQuestionIndex = 0;
   
   wrongAnswerImages[0] = loadImage("images/wrongA.png");
   wrongAnswerImages[1] = loadImage("images/doom.png");
    wrongAnswerImages[2] = loadImage("images/deathScreen.png");
   
   correctAnswerImages[0] = loadImage("images/correctA.png");
   correctAnswerImages[1] = loadImage("images/endScreen.png");
   
    
  }
  
  public PImage drawQuestions(){
      
    return questionImages[currentQuestionIndex];
    
  }
  
  
  
  public void handleUserInput(){
    
    if(currentQuestionIndex >= 6){
      
      if(startTime == 0){
        startTime = millis();
      }
      
      if(currentQuestionIndex == 6){
        if(wasUserCorrect()){
          
        }else{
        
        }
      }
      
      return;
    }
    
    fill(255);
    rect(1250, 800, 150, 100);
    fill(0);
    
    text(">", 1300, 880); //next button
    
    if(mouseX > 1250 && mouseX < 1400 && mouseY> 800 && mouseY< 950 && mousePressed && currentQuestionIndex + 1 < questionImages.length){ 
      //next button was pressed
      if(currentQuestionIndex > 0){ //if we are not in posterDoorOpen scene, store answer when next button is clicked
        userAnswers[currentQuestionIndex - 1] = currentUserInput.toLowerCase();
      }
      currentUserInput = "";
      
      currentQuestionIndex++;
      mousePressed = false;
    }
    
     if (keyPressed && key != '\0' && currentQuestionIndex > 0) {
          keyPressed = false;

          if (key == BACKSPACE && currentUserInput.length() >= 0) {
            if (currentUserInput.length() == 0){
              currentUserInput = "";
              
            }else{
    
              currentUserInput = currentUserInput.substring(0, currentUserInput.length() - 1);
            }
          } else {

            currentUserInput += key;
          }
     }
        
    
    fill(255);
    textSize(90);
    text(currentUserInput, 830, 620);
  }
  
  public boolean wasUserCorrect(){
    
    for(int i=0; i<userAnswers.length; i++){
      if(!userAnswers[i].equals(correctAnswers[i]))
          return false;   
    }
    
    return true;
    
    
  }
  
  
  
}
