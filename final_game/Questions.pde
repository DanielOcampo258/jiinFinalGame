class Questions {
  private float startTime;
  private float elapsedTime;
  private PImage[] questionImages;
  private PImage[] wrongAnswerImages;
  private PImage[] correctAnswerImages;
  private String[] correctAnswers;
  private String[] userAnswers;
  private String currentUserInput;
  private int currentQuestionIndex;
  private int currentResultIndex;

  public Questions() {
    elapsedTime = 0.0;
    userAnswers = new String[6];
    correctAnswers = new String[6];
    questionImages = new PImage[8];
    wrongAnswerImages = new PImage[2];
    correctAnswerImages = new PImage[2];

    questionImages[0] = loadImage("images/posterDoorOpen.png");
    questionImages[1] = loadImage("images/firstQ.png");
    questionImages[2] = loadImage("images/secondQ.png");
    questionImages[3] = loadImage("images/thirdQ.png");
    questionImages[4] = loadImage("images/fourthQ.png");
    questionImages[5] = loadImage("images/fifthQ.png");
    questionImages[6] = loadImage("images/sixthQ.png");
    questionImages[7] = loadImage("images/userQ.png");

    currentUserInput = "";

    correctAnswers[0] = "nectar"; //nectar
    correctAnswers[1] = "begonias"; //begonias
    correctAnswers[2] = "icymi";//icymi
    correctAnswers[3] = "saturday"; //saturday
    correctAnswers[4] = "red"; //red
    correctAnswers[5] = "south korea"; //south korea

    currentQuestionIndex = 0;
    currentResultIndex = -1;

    wrongAnswerImages[0] = loadImage("images/wrongA.png");
    wrongAnswerImages[1] = loadImage("images/doom.png");

    correctAnswerImages[0] = loadImage("images/correctA.png");
    correctAnswerImages[1] = loadImage("images/endScreen.png");

    startTime = millis();
  }



  public PImage drawQuestions() {

    if (currentQuestionIndex == 8) {
      elapsedTime = millis() - startTime;
 

      if (wasUserCorrect()) {

        

        if (currentResultIndex == correctAnswerImages.length - 1 && elapsedTime > 1000) { //we got to last image of correct answer, now restart game
          initializeObjects(); //restart game
        } 
        
        
        if (elapsedTime > 1500 && currentResultIndex + 1 <  correctAnswerImages.length) {
          currentResultIndex++;
          startTime = millis();
        }
        
          



      

        return correctAnswerImages[currentResultIndex];
        
      } else {

        if (elapsedTime > 700 && currentResultIndex + 1 <  wrongAnswerImages.length) {
          currentResultIndex++;
          startTime = millis();
        }
        
        if (currentResultIndex == wrongAnswerImages.length - 1) { //we got to last image of wrong answer, now player is dead
          playerIsAlive = false;
        }

        return wrongAnswerImages[currentResultIndex];
      }
    }


    return questionImages[currentQuestionIndex];
  }

  //350, 500 yes
  // 670, 660

  //1300, 500 no
  // 1620, 660


  public void handleUserInput() {

    if (currentQuestionIndex >= 7) {

      if (currentQuestionIndex == 7 && mouseX > 350 && mouseX < 1500 && mouseY > 500 && mouseY < 800 && mousePressed) {
        currentQuestionIndex++;
      }

      return;
    }

    fill(255);
    rect(1250, 800, 150, 100);
    fill(0);

    text(">", 1300, 880); //next button

    if ((mouseX > 1250 && mouseX < 1400 && mouseY> 800 && mouseY< 950 && mousePressed && currentQuestionIndex + 1 < questionImages.length )) {
      //next button was pressed

      if (currentQuestionIndex > 0) { //if we are not in posterDoorOpen scene, store answer when next button is clicked
        userAnswers[currentQuestionIndex - 1] = currentUserInput.toLowerCase();
      }
      currentUserInput = "";

      currentQuestionIndex++;
      mousePressed = false;
    }

    if (keyPressed && key != '\0' && keyCode != SHIFT && currentQuestionIndex > 0) {
      keyPressed = false;

      if (key == BACKSPACE && currentUserInput.length() >= 0) {
        if (currentUserInput.length() == 0) {
          currentUserInput = "";
        } else {

          currentUserInput = currentUserInput.substring(0, currentUserInput.length() - 1);
        }
      } else {

        currentUserInput += key;
      }
    }


    fill(255);
    textSize(90);

    if (currentQuestionIndex == 5) {
      text(currentUserInput, 910, 575);
    } else {
      text(currentUserInput, 830, 620);
    }
  }

  public boolean wasUserCorrect() {

    for (int i=0; i<userAnswers.length; i++) {
      if (!userAnswers[i].equals(correctAnswers[i]))
        return false;
    }

    return true;
  }
}
