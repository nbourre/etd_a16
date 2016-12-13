

class Cell {
  int x,y;  
  int w,h;  
  boolean visited, isEdge;
  EtatCell etat;

  Wall[] walls = new Wall[4];//0 up 1 right 3 down 4 left (sens horaire)
  
  // Cell Constructor 
  Cell(int tempX, int tempY, int tempW, int tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    visited = false;
    isEdge = false;
    etat = EtatCell.OPEN;
    
    for(int i=0; i<4; i++)
    {
      walls[i] = new Wall();
    }
  } 
  
 
  void display() {
    switch(etat) //couleur des cell sleon etat
    {
      case OPEN:
                  stroke(255);
                  fill(255);
                  rect(x,y,w,h); 
      break;
      
      case CLOSE:  
                  stroke(1);
                  fill(0,0,255);
                  rect(x,y,w,h);
      break;
      
      case DEATHEND:
                  stroke(100);
                  fill(100);
                  rect(x,y,w,h); 
                  this.ResetWall();
      break;
      
      case START:  
                  stroke(0,255,0);
                  fill(0,255,0);
                  rect(x,y,w,h);
      break;
      
      case END:  
                  stroke(255,0,0);
                  fill(255,0,0);
                  rect(x,y,w,h);
      break;
      
    }
    
    stroke(1); //display des mur de la cell
    if (!walls[0].isOpen())
    {
      line(x,y,x+w,y);
    }
    if (!walls[1].isOpen())
    {
     line(x+w,y,x+w,y+w);      
    }
    if (!walls[2].isOpen())
    {
      line(x,y+w,x+w,y+w);
    }
    if (!walls[3].isOpen())
    {
     line(x,y,x,y+w);
    }
      
  }
  
  int nbWall()
  {
    int totalwall = 0;
    if(etat == EtatCell.START || etat == EtatCell.END)
      return 0;
    
    for(int i=0;i<4;i++)
    {
      if(!walls[i].isOpen())
        totalwall++;
        
    }
    
    return totalwall;
  }
  
  boolean HaveWall(int pos)
  {
   if(!walls[pos].isOpen())
     return true;
   else
    return false;
  }
  
  void SetState(EtatCell state) {etat = state;}
  
  boolean CheckStartEnd()
  {
    if(this.GetState() == EtatCell.START || this.GetState() == EtatCell.END)
        return true;        
    else
      return false;
  }
  
  EtatCell GetState() {return etat;}
  
  void SetVisited() {visited = true;}
  
  boolean isVisited() {return visited;}
  
  void SetEdge() {isEdge = true;}
  
  boolean isEdge() {return isEdge;}
  
  void CarveWall(int pos){
    walls[pos].SetOpen(true);
  }
  
  void ResetWall()
  {
    walls[0].SetOpen(false);
    walls[1].SetOpen(false);
    walls[2].SetOpen(false);
    walls[3].SetOpen(false);
  }
  
  void BuildWall(int pos){
    walls[pos].SetOpen(false);
  }
  
  int x(){ return x;}
  
  int y(){return y;}
  
  int w(){return w;}
  
  int h(){return h;}
}