public class Case {
 
  boolean iswall;
  boolean inpath;
  boolean isAnimated;
  color animatedColorStart = color(0, 255, 0);
  color animatedColorEnd = color(255, 0, 255);
  color fillColor = color(255, 255, 255);
  int parent;
  int h;
  int g;
  int f;
  int x;
  int y;
  int currentTime;
  int previousTime;
  int animationDelay = 125;
  int animationAcc = 0;
  int frameIndex = 1;
  
  public Case() {
    iswall = true;
    inpath = false;
    isAnimated = false;
    parent = 0;
    h = 0;
    g = 10000;
    f = 0;
    x = 0;
    y = 0;
  }
  
  public void update(int startX, int startY, int endX, int endY) {
    currentTime = millis();
    animationAcc += currentTime - previousTime;
    previousTime = currentTime;
    if(isAnimated) {
      if(animationAcc > animationDelay) {
        animationAcc = 0;
        frameIndex = -frameIndex;
        if(frameIndex < 0) {
          if(x == startX && y == startY)
            fillColor = animatedColorStart;
          else if(x == endX && y == endY)
            fillColor = animatedColorEnd;
        }
        else
          fillColor = color(255, 255, 255);
      }
    }
  }
  
}