class PosterTextBox {

  boolean isUnlocked;
  int[] tlC;
  int[] brC;
  
  int[] locktlC;
  int[] lockBrC;

  PImage unlockedImage;

  String input;
  String answer;
  boolean isActive;

  public PosterTextBox(int []tlC, int []brC, String answer) {
    isActive = false;
    isUnlocked = false;
    this.tlC = tlC;
    this.brC = brC;
    this.answer = answer;
    unlockedImage = loadImage("images/passcodeUnlocked.png");
    input = "";
  }

  public String getInput() {
    return input;
  }

  public void checkInput(){
    if(input.equals(answer)){
      isUnlocked = true;
      println("unlocked");
    }
  }

  public void setInput(String newInput) {
    input = newInput;
    if(!isUnlocked){
      checkInput();
    }
  }


  public void drawTextBox() {
    textSize(30);
    fill(255);

    text(input, tlC[0] + 10, tlC[1]+ 30);
    
    if(isUnlocked()){
      image(unlockedImage,tlC[0] + 360, tlC[1] + 5);
    }
  }

  public boolean isUnlocked() {
    return isUnlocked;
  }


  public void checkBounds() {

    if (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1] && mousePressed) {

      mousePressed = false;
      isActive = true;
    } else if (mousePressed)
      isActive = false;
  }


  public void setActive(boolean status) {
    isActive = status;
  }
  public boolean isActive() {
    return isActive;
  }

  public int[] getTLC() {
    return tlC;
  }

  public int[] getBRC() {
    return brC;
  }
}
