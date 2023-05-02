class Poster{
  PImage posterInitial;
  PImage posterHover;
  PImage passwordImage;
  PImage currentView;
  boolean lockView;
  String userInput;
  PosterTextBox[] textBoxes;
  int[] tlC; int[] brC;
  
  public Poster(){
    userInput= "";
    
    textBoxes = new PosterTextBox[5];
    textBoxes[0] = new PosterTextBox(new int[]{795,375}, new int[]{1110,455});
    textBoxes[1] = new PosterTextBox(new int[]{795,500}, new int[]{1110,580});
    textBoxes[2] = new PosterTextBox(new int[]{795,620}, new int[]{1110,700});
    textBoxes[3] = new PosterTextBox(new int[]{795,740}, new int[]{1110,820});
    textBoxes[4] = new PosterTextBox(new int[]{795,860}, new int[]{1110,940});
    
    tlC = new int[]{646,40};
    brC = new int[]{1270, 1036};
   
  }
  
  
  //2732, 2048
  public void displayPoster(){
    
  
        for(int j=0; j<textBoxes.length; j++){
          textBoxes[j].checkBounds();
        if(textBoxes[j].isActive){
          fill(169,169,169);
          rect(textBoxes[j].tlC[0], textBoxes[j].tlC[1] +5, 300,70);
          
          if(keyPressed && key != '\0'){
            keyPressed = false;
          
            if(key == BACKSPACE && textBoxes[j].getInput().length() >= 0){
              if(textBoxes[j].getInput().length() == 0)
                continue;
                
             textBoxes[j].setInput(textBoxes[j].getInput().substring(0,textBoxes[j].getInput().length() - 1));
           
            }else{
              
            textBoxes[j].setInput(textBoxes[j].getInput() + key);
            }
          }
        }
          
      
 
      
    }
    
    
     for(int j=0; j<textBoxes.length; j++){
       
        textBoxes[j].drawTextBox();
      }
      
      userInput = "";
      
      
 
  }
  
  public PImage getInitialImage(){
    return posterInitial;
  }
  
  public PImage getHoverImage(){
    return posterHover;
  }
  
  public PImage passwordImage(){
    return passwordImage;
  }
  
  
  
}
