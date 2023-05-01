class Calculator{ //<>//
  PImage onImage;
  PImage offImage;
  PImage calcImage;
  boolean isOn;
  CalculatorButton[] numberButtons;
  int[] enterButton; //holds the x,y coordinates of the enter button
  
  public Calculator(){
    numberButtons = new CalculatorButton[12];
    numberButtons[0] = new CalculatorButton("1", new int[]{749,478}, new int[]{807,540});
    numberButtons[1] = new CalculatorButton("2", new int[]{868,478}, new int[]{929,540});
    numberButtons[2] = new CalculatorButton("3", new int[]{989,478}, new int[]{1050,540});
    numberButtons[3] = new CalculatorButton("4", new int[]{749,600}, new int[]{807,665});
    numberButtons[4] = new CalculatorButton("5", new int[]{868,600}, new int[]{929,665});
    numberButtons[5] = new CalculatorButton("6", new int[]{989,600}, new int[]{1050,665});
    numberButtons[6] = new CalculatorButton("7", new int[]{749,720}, new int[]{807,785});
    numberButtons[7] = new CalculatorButton("8", new int[]{868,720}, new int[]{929,785});
    numberButtons[8] = new CalculatorButton("9", new int[]{989,720}, new int[]{1050,785});
    numberButtons[9] = new CalculatorButton("0", new int[]{799,840}, new int[]{869,900});
    numberButtons[10] = new CalculatorButton("*" , new int[]{1110, 570}, new int[]{1170, 690});
    numberButtons[10] = new CalculatorButton("enter" , new int[]{1110, 720}, new int[]{1170, 900});
    calcImage = loadImage("images/Calculator_On.png");
    isOn = false;
    enterButton = new int[2];
    
  }
  
  public void overButtons(){
    for(CalculatorButton button: numberButtons){
      if(mouseX > button.getTopCorner()[0] && mouseX < button.getBottomCorner()[0] && mouseY > button.getTopCorner()[1] 
      && mouseY < button.getBottomCorner()[1] && mousePressed)
     println(button.getValue());
    }
    
  }
  
  public PImage getCalcImage(){
    return calcImage;
    
  }
  
  
  
  
}
