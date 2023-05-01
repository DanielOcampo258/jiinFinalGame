class CalculatorButton{
  private int[] tlC;
  private int[] brC;
  private String value;
  
  
  public CalculatorButton(String value, int[] tlC, int[] brC){
    this.value = value;
    this.tlC = tlC;
    this.brC = brC;
  }
  
  public int[] getTopCorner(){
    return tlC;
  }
  
  public int[] getBottomCorner(){
    return brC;
  }
  
  public String getValue(){
    return value;
  }
  
  
}
