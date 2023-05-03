class SceneObject {

  private String name;

  //represents the corners of the object with respect to the image
  private int[] tlC;
  private int[] brC;
  private boolean mouseOver;
  private String openImageURL;
  private int numOfClicks;
  private boolean isCalculator;
  private String insideImage;

  public SceneObject(String name, int[] tlC, int[] brC, String openImageURL) {
    this.name = name;
    this.tlC = tlC;
    this.brC = brC;
    this.openImageURL = openImageURL;
    mouseOver = false;
    numOfClicks = 0;
    isCalculator = false;
    insideImage = "";
  }
  
  public void resetParameters(){
     mouseOver = false;
    numOfClicks = 0;
    isCalculator = false;
    insideImage = "";
  }
  
  

  public String getName() {
    return name;
  }

  public int getClickAmount() {
    return numOfClicks;
  }

  public void setClickAmount(int amount) {
    numOfClicks = amount;
  }

  public void setInsideImage(String insideImagePath) {
    insideImage = insideImagePath;
  
  }

  public String getInsideImage() {
    return insideImage;
  }

  public boolean mouseInBounds() {

    if (mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1]) {
      return true;
    } else {
      return false;
    }
  }

  public void setCalculator(boolean calculatorStatus) {
    isCalculator = calculatorStatus;
  }

  public boolean isCalculator() {
    return isCalculator;
  }


  public void setOpenImage(String url){
    openImageURL = url;
  }
  public String getOpenImage() {
    return openImageURL;
  }

  public void setMouseOver(boolean status) {
    mouseOver = status;
  }

  public boolean isMouseOver() {
    return this.mouseOver;
  }
}
