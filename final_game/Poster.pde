class Poster {
  private PImage posterInitial;
 private  PImage posterHover;
  private PImage passwordImage;
  private PImage currentView;
  private boolean isOpen;
  private boolean lockView;
  private String userInput;
  private PosterTextBox[] textBoxes;
  private int[] tlC;
  private int[] brC;

  public Poster() {
    
    isOpen = false;
    userInput= "";
  
    textBoxes = new PosterTextBox[5];
    textBoxes[0] = new PosterTextBox(new int[]{796, 380}, new int[]{1110, 455}, "it\'s");
    textBoxes[1] = new PosterTextBox(new int[]{796, 501}, new int[]{1110, 580}, "all");
    textBoxes[2] = new PosterTextBox(new int[]{797, 621}, new int[]{1110, 700}, "in");
    textBoxes[3] = new PosterTextBox(new int[]{796, 743}, new int[]{1110, 820}, "your");
    textBoxes[4] = new PosterTextBox(new int[]{795, 864}, new int[]{1110, 940}, "head");

    tlC = new int[]{646, 40};
    brC = new int[]{1270, 1036};
  }

  
   public void resetParameters(){
     isOpen = false;
    userInput= "";
    
    textBoxes = new PosterTextBox[5];
    textBoxes[0] = new PosterTextBox(new int[]{796, 380}, new int[]{1110, 455}, "it\'s");
    textBoxes[1] = new PosterTextBox(new int[]{796, 501}, new int[]{1110, 580}, "all");
    textBoxes[2] = new PosterTextBox(new int[]{797, 621}, new int[]{1110, 700}, "in");
    textBoxes[3] = new PosterTextBox(new int[]{796, 743}, new int[]{1110, 820}, "your");
    textBoxes[4] = new PosterTextBox(new int[]{795, 864}, new int[]{1110, 940}, "head");

   
  }
  

  //2732, 2048
  public void displayPoster() {
       
    int unlocked = 0;
    
    
    for (int j=0; j<textBoxes.length; j++) {
      textBoxes[j].checkBounds();
      if (textBoxes[j].isActive()) {
        //fill(169, 169, 169);
        //rect(textBoxes[j].tlC[0], textBoxes[j].tlC[1] +5, 300, 70);

        if (keyPressed && key != '\0' && keyCode != SHIFT) {
          keyPressed = false;

          if (key == BACKSPACE && textBoxes[j].getInput().length() >= 0) {
            if (textBoxes[j].getInput().length() == 0)
              continue;

            textBoxes[j].setInput(textBoxes[j].getInput().substring(0, textBoxes[j].getInput().length() - 1));
          } else {

            textBoxes[j].setInput(textBoxes[j].getInput() + key);
          
          }
        }
      }
    }


    for (int j=0; j<textBoxes.length; j++) {
      if(textBoxes[j].isUnlocked()){  //checks how many posters are unlocked
        unlocked++;
      }
      
      textBoxes[j].drawTextBox();
      
    }
    
    if(unlocked == 5){
      isOpen = true;
    }
    
    userInput = "";
  }
  
  public void setOpen(boolean status){
    isOpen = status;
  }
 public int[] getTlc(){
   return tlC;
 }
 
  public int[] getBrc(){
   return brC;
 }
 
  
  public boolean isOpen(){
    return isOpen;
  }

  public PImage getInitialImage() {
    return posterInitial;
  }

  public PImage getHoverImage() {
    return posterHover;
  }

  public PImage getPasswordImage() {
    return passwordImage;
  }
}
