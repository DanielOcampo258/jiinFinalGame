PImage titleScreen;
PImage sceneImage;
PImage deathScreen;
SceneObject[] sceneObjects;

String initialStateImage;
boolean hoveringOverObject;

public boolean titleScreenRunning;
boolean calcRunning;
boolean drawerOpen;
boolean posterRunning;
boolean passcodeRunning;
boolean questionsRunning;
boolean differentScene;
boolean cabinetOpen;
public boolean playerIsAlive;

private float startTime = 0;
private float deathScreenStartTime = 0;
private float elapsed = 0;
Calculator calc;
Poster poster;
Questions questions;

void setup() {
  size(1920, 1080);
  initializeObjects();
}

public void initializeObjects() {

  cabinetOpen = calcRunning = posterRunning = differentScene = passcodeRunning = questionsRunning = false;
  titleScreenRunning = true;
  playerIsAlive = true;

  calc = new Calculator();
  poster = new Poster();
  questions = new Questions();
  sceneObjects = new SceneObject[13];

  initialStateImage = "images/initialRoomState.png";

  deathScreen = loadImage("images/deathScreen.png");

  titleScreen = loadImage("images/titleScreen.png");

  hoveringOverObject = false;
  sceneImage = loadImage(initialStateImage);

  sceneObjects[0] = new SceneObject("Cabinet", new int[]{896, 220}, new int[]{1029, 570}, "images/cabinetOpen.png" );
  sceneObjects[0].setInsideImage("images/insideCabinet.png");
  sceneObjects[1] = new SceneObject("Poster_1", new int[]{705, 200}, new int[]{800, 440}, "images/posterHover.png");
  sceneObjects[1].setInsideImage("images/posterLocked.png");
  sceneObjects[2] = new SceneObject("Window", new int[]{1218, 278}, new int[]{1350, 470}, "images/window-open.png");
  sceneObjects[3] = new SceneObject("Calendar", new int[]{1047, 346}, new int[]{1091, 440}, "images/test.png");
  sceneObjects[4] = new SceneObject("Drawer", new int[]{725, 770}, new int[]{832, 870}, "images/drawerOpen.png");
  sceneObjects[4].setInsideImage("images/Calculator_On.png");
  sceneObjects[5] = new SceneObject("Poster_2", new int[]{620, 270}, new int[]{685, 346}, "images/edenPoster.png");
  sceneObjects[6] = new SceneObject("Poster_3", new int[]{637, 375}, new int[]{687, 400}, "images/hint.png");
  sceneObjects[7] = new SceneObject("Poster_4", new int[]{640, 435}, new int[]{686, 491}, "images/phone.png");
  sceneObjects[8] = new SceneObject("Poster_5", new int[]{545, 405}, new int[]{625, 540}, "images/jojiPoster.png");
  sceneObjects[9] = new SceneObject("Poster_6", new int[]{540, 325}, new int[]{625, 350}, "images/koreaFlag.png");
  sceneObjects[10] = new SceneObject("MultTables", new int[]{1120, 486}, new int[]{1240, 560}, "images/multTables.png");
  sceneObjects[11] = new SceneObject("Flowers", new int[]{1345, 520}, new int[]{1395, 600}, "images/flowers.png");
  sceneObjects[12] = new SceneObject("Hint Book", new int[]{1256, 540}, new int[]{1450, 600}, "images/hint1.png");
  titleScreenRunning = true;
}

public void playerDies() {
  if (deathScreenStartTime == 0.0) {
    deathScreenStartTime = millis();
  }
  elapsed = millis() - deathScreenStartTime;

  if (elapsed > 600) {


    background(deathScreen);
    textSize(20);

    if (isMouseInBounds(new int[]{775, 620}, new int[]{1130, 715})) { //restart button
      cursor(HAND);
      if (mousePressed) {
        initializeObjects();
      }
    } else if (isMouseInBounds(new int[]{830, 775}, new int[]{1075, 865})) { //quit button
      cursor(HAND);

      if (mousePressed)
        exit();
    } else {
      cursor(ARROW);
    }

    text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
    fill(255, 255, 255);
  }
}


public boolean isMouseInBounds(int[] tlC, int[] brC) {

  return (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1]);
}

public boolean isMouseInBoundsAndPressed(int[] tlC, int[] brC) {

  return (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1] && mousePressed);
}



void draw() {


  if (titleScreenRunning) { //title screen running or run game
    sceneImage = titleScreen;
    if (isMouseInBounds( new int[]{830, 578}, new int[]{1130, 700})) { //start button
      cursor(HAND);
      if (mousePressed) {
        mousePressed = false;
        titleScreenRunning = false;
      }
    } else {
      cursor(ARROW);
    }
    background(sceneImage);
  } else {

    background(sceneImage);


    if (!playerIsAlive) { //game is running and player is alive
      playerDies();
    } else if (calcRunning) {

      sceneImage = calc.getCalcImage();

      calc.overButtons();

      if (!calc.insideOfCalc() && mousePressed) {
        calcRunning = false;
        differentScene = true;
      }
    } else if (cabinetOpen) {
      sceneImage = loadImage(sceneObjects[0].getInsideImage());
      
       if (!isMouseInBounds(new int[]{550, 200}, new int[]{1200, 800}) && mousePressed) {
         cabinetOpen = false;
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
        //textSize(20);
        //text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
        //fill(255, 255, 255);
      } else
        background(sceneImage);
    }
  } else if (differentScene) {
    if (!isMouseInBounds(new int[]{550, 200}, new int[]{1200, 800}) && mousePressed) {
      differentScene = false;
      mousePressed = false;
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

          if (sceneObjects[i].getName().equals("Cabinet") && sceneObjects[i].getClickAmount() % 2 == 0) {
            
            cabinetOpen = true;
          } else if (sceneObjects[i].getName().equals("Drawer") && sceneObjects[i].getClickAmount() % 2 == 0) { //when user clicks on drawer which leads to calculator
            println("hello");
            calcRunning = true;
          } else if (sceneObjects[i].getName().equals("Poster_1")) { //when user clicks on poster which leads to poster running sequence

            posterRunning = true;
          } else if (sceneObjects[i].getName().equals("Window")) { //for window death situation
            if (sceneObjects[i].getClickAmount() == 1) {
              sceneObjects[i].setOpenImage("images/windowDeath.png");
            } else {//means  they clicked on it again
              startTime = 0.0;
              playerIsAlive = false;
            }
          } else {
            if (!sceneObjects[i].getName().equals("Drawer") && !sceneObjects[i].getName().equals("Cabinet") )
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
      if (!sceneObjects[j].getName().equals("Window"))
        sceneObjects[j].setClickAmount(0);
    }
    if (j == sceneObjects.length - 1) {
      cursor(ARROW);
      sceneImage = loadImage(initialStateImage);
    }
  }
  //textSize(20);
  //text("x: " + mouseX + " y: " + mouseY, mouseX + 10, mouseY + 5);
  //fill(255, 255, 255);
}
}
