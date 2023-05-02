class Poster{
  PImage posterInitial;
  PImage posterHover;
  PImage passwordImage;
  PImage currentView;
  boolean lockView;
  int[] tlC; int[] brC;
  
  public Poster(){
    
    tlC = new int[]{646,40};
    brC = new int[]{1270, 1036};
    posterInitial = currentView =  loadImage("images/posterInitial.png");
    posterHover = loadImage("images/posterHover.png");
    passwordImage = loadImage("images/posterLocked.png");
    
  }
  //2732, 2048
  public PImage displayPoster(){
    
    if(mouseX > tlC[0] && mouseX < brC[0] && mouseY > tlC[1] && mouseY < brC[1]){
      if(mousePressed || currentView == passwordImage){
        currentView = passwordImage;
      }else 
          currentView = posterHover;
      
      
    }else if(mousePressed){
        currentView = posterInitial;
     
    }else if(currentView == posterHover ){
       currentView = posterInitial;
    }
    
    return currentView;
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
