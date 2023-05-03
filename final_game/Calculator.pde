class Calculator{ //<>//
  //PImage onImage;
  //PImage offImage;
  PImage calcImage;
  //boolean isOn;
  String firstNumber; String secondNumber;
  String calculatorDisplayText;
  CalculatorButton[] numberButtons;
  int[] tlC; int[] brC; //holds the x,y coordinates of the tlC and brC of calculator view
  
  public Calculator(){
    
    tlC = new int[]{685, 115};
    
    brC = new int[]{1220, 965};
    
    numberButtons = new CalculatorButton[14];
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
    numberButtons[11] = new CalculatorButton("enter" , new int[]{1110, 720}, new int[]{1170, 900});
    numberButtons[12] = new CalculatorButton("del", new int[]{930,840}, new int[]{1050, 900});
    numberButtons[13] = new CalculatorButton("clear", new int[]{1110,478 }, new int[]{1170,540});
    
    calculatorDisplayText = "";
    calcImage = loadImage("images/Calculator_On.png");
    //isOn = false;   
  }
  
  public void resetParameters(){
    calculatorDisplayText = "";
  }
  
  
   public boolean insideOfCalc(){
             
           if(mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1])
            return true;
          else
            return false;
   }
  
  public String calculate(){
    String output = "";
    for(int i=0; i<Integer.parseInt(secondNumber); i++){
      output += firstNumber;
      
    }
    return output;
  }
  
  
  public void overButtons(){
    println(calculatorDisplayText);
    for(CalculatorButton button: numberButtons){
      if(mouseX > button.getTopCorner()[0] && mouseX < button.getBottomCorner()[0] && mouseY > button.getTopCorner()[1] 
      && mouseY < button.getBottomCorner()[1] && mousePressed){
        if(button.getValue().equals("*")){
          firstNumber = calculatorDisplayText;
        }
        
       if(button.getValue().equals("enter")){
          secondNumber = calculatorDisplayText.substring(calculatorDisplayText.indexOf("*") + 1);
          calculatorDisplayText = calculate();
        }else if(button.getValue().equals("clear")){
        calculatorDisplayText = ""; 
        }else if(button.getValue().equals("del")){
          calculatorDisplayText = calculatorDisplayText.substring(0,calculatorDisplayText.length() - 1);
       
      }else{
            calculatorDisplayText += button.getValue();
      }    
        
       mousePressed = false; //we set mousePressed to false to prevent number repeating
    }
   
     displayCalculator();
    }
  }
  
  public void displayCalculator(){
    textSize(30);
    fill(0);
    text(calculatorDisplayText, 754, 210);
    
  }
  
  public PImage getCalcImage(){
    return calcImage;
    
  }
  
}
