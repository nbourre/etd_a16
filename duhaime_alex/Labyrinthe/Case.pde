public class Case {
 
  boolean iswall;
  boolean inpath;
  int parent;
  int h;
  int g;
  int f;
  int x;
  int y;
  
  public Case() {
    iswall = true;
    inpath = false;
    parent = 0;
    h = 0;
    g = 10000;
    f = 0;
    x = 0;
    y = 0;
  }
  
}