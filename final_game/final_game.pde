PImage sceneImage; //<>// //<>//

SceneObject[] sceneObjects;

String initialStateImage;
boolean hoveringOverObject;
boolean calcRunning;
boolean posterRunning;
boolean passcodeRunning;
boolean questionsRunning;
boolean differentScene;
boolean playerIsAlive;
float startTime = 0;
Calculator calc;
Poster poster;
Questions questions;

void setup() {
  calcRunning = posterRunning = differentScene = passcodeRunning = questionsRunning = false;
  size(1920, 1080);
  calc = new Calculator();
  poster = new Poster();
  questions = new Questions();
  sceneObjects = new SceneObject[12];

  initialStateImage = "images/initialState.png";

  hoveringOverObject = false;
  sceneImage = loadImage(initialStateImage);

  sceneObjects[0] = new SceneObject("Cabinet", new int[]{896, 220}, new int[]{1029, 570}, "images/insideCabinet.png" );
  sceneObjects[1] = new SceneObject("Poster_1", new int[]{705, 200}, new int[]{800, 440}, "images/posterHover.png");
  sceneObjects[1].setInsideImage("images/posterLocked.png");
  sceneObjects[2] = new SceneObject("Window", new int[]{1218, 278}, new int[]{1350, 510}, "images/window-open.png");
  sceneObjects[3] = new SceneObject("Calendar", new int[]{1047, 346}, new int[]{1091, 440}, "images/test.png");
  sceneObjects[4] = new SceneObject("Drawer", new int[]{725, 770}, new int[]{832, 870}, "images/drawerOpen.png");
  sceneObjects[4].setInsideImage("images/Calculator_On.png");
  sceneObjects[5] = new SceneObject("Poster_2", new int[]{620, 270}, new int[]{685, 346}, "images/edenPoster.png");
  sceneObjects[6] = new SceneObject("Poster_3", new int[]{637, 375}, new int[]{687, 400}, "images/hint.png");
  sceneObjects[7] = new SceneObject("Poster_4", new int[]{640, 435}, new int[]{686, 491}, "images/phone.png");
  sceneObjects[8] = new SceneObject("Poster_5", new int[]{545, 405}, new int[]{625, 540}, "images/jojiPoster.png");
  sceneObjects[9] = new SceneObject("Poster_6", new int[]{540, 325}, new int[]{625, 350}, "images/koreaFlag.png");
  sceneObjects[10] = new SceneObject("multTables", new int[]{1145, 430}, new int[]{1185, 490}, "images/multTables.png");
  sceneObjects[11] = new SceneObject("flowers", new int[]{1345, 520}, new int[]{1395, 600}, "images/flowers.png");
}

public void playerDies() {
  println("you are dead");
}


public boolean isMouseInBounds(int[] tlC, int[] brC) {

  return (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1]);
}

public boolean isMouseInBoundsAndPressed(int[] tlC, int[] brC) {

  return (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1] && mousePressed);
}



void draw() {


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

  //    }else
  //       background(sceneImage);

  //}


  background(sceneImage);

    textSize(20);
  text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  fill(255, 255, 255);

  if (calcRunning) {

    sceneImage = calc.getCalcImage();

    calc.overButtons();

    if (!calc.insideOfCalc() && mousePressed) {
      calcRunning = false;
      differentScene = true;
    }
  } else if (posterRunning) {

    if (isMouseInBoundsAndPressed(poster.getTlc(), poster.getBrc()) ) {

      sceneImage = loadImage(sceneObjects[1].getInsideImage());
      passcodeRunning = true;
    } else if (!isMouseInBounds(poster.getTlc(), poster.getBrc()) && mousePressed && !questionsRunning) {
      mousePressed = false;
      posterRunning = false;
      passcodeRunning = false;
      sceneImage = loadImage(initialStateImage);
    }

    if (!poster.isOpen) {

      background(sceneImage);

      if (passcodeRunning)
        poster.displayPoster();
    } else { //poster unlocked

      questionsRunning = true;
      if (startTime == 0) {
        startTime = millis();
      }

      float elapsedTime = millis() - startTime;

      if (elapsedTime > 1000) {
        sceneImage = questions.drawQuestions();
        background(sceneImage);
        questions.handleUserInput();
        //         textSize(20);
        //text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
        //fill(255, 255, 255);
      } else
        background(sceneImage);
    }
  } else if (differentScene) {
    if (!isMouseInBounds(new int[]{550, 200}, new int[]{1200, 800}) && mousePressed) {
      differentScene = false;
      sceneImage = loadImage(initialStateImage);
      background(sceneImage);
    }
  } else {


    for (int i=0; i<sceneObjects.length; ++i) {
      
        if (sceneObjects[i].mouseInBounds()) {
          //cursor(MOVE);
          sceneObjects[i].setMouseOver(true);
          if (mousePressed) {
            sceneObjects[i].setClickAmount(sceneObjects[i].getClickAmount() + 1);

            mousePressed = false;


            cursor(ARROW);
            sceneImage = loadImage(sceneObjects[i].getOpenImage());


            if (sceneObjects[i].getClickAmount() % 2 == 0 && sceneObjects[i].getName().equals("Drawer")) {

              calcRunning = true;
            } else if (sceneObjects[i].getName().equals("Poster_1")) {
              println(sceneObjects[i].getClickAmount());
              posterRunning = true;
              
            }else if(sceneObjects[i].getName().equals("Window")){
              if(sceneObjects[i].getClickAmount() == 1){
                  sceneObjects[i].setOpenImage("images/windowDeath.png");
                  
              }else{//means  they clicked on it again
                playerDies();
              }
          
                
            } else {
              differentScene = true;
            }
          }
        } else {
          if (mousePressed)
            sceneObjects[i].setMouseOver(false);
        }
      }
    }

    //pass over all of the objects to make sure user is not hovering over anything to set
    // scene back to og image
    for (int j=0; j<sceneObjects.length; ++j) {
      if (sceneObjects[j] != null) {

        if (sceneObjects[j].isMouseOver() || calcRunning || posterRunning)
          break;
          if(!sceneObjects[j].getName().equals("Window"))
            sceneObjects[j].setClickAmount(0);
      }
      if (j == sceneObjects.length - 1) {
        cursor(ARROW);
        sceneImage = loadImage(initialStateImage);
      }
    }
  
}

//   textSize(20);
//  text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
//fill(255, 255, 255);
