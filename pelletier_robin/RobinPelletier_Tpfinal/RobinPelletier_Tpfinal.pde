int cellSize = 25;
int sizeW = 1000;
int sizeH = 1000;
Maze maze;

boolean edit = true;
boolean findPath = false;
boolean isHunting = false;
boolean demo = true;
boolean findDone = false;
boolean huntingDone = false;
int demoStep = 0; 
enum EtatCell{  // 0 up 1 right 2 down 3 left (sens horaire)
  OPEN,CLOSE,START,END,DEATHEND
 };
 
void setup()
{  
  //size(800,800);
  fullScreen(1);
  background(255);
  maze = new Maze();
  maze.SetEdge();
}

void keyPressed() {
  if (key == 'r') //RESET
  { 
    maze = new Maze();
    maze.SetEdge();
    edit = true;
    findPath = false;
    huntingDone = false;
  }
  if (key == 'g') //GENERATE
  {
    maze.Hunt_and_Kill();
   isHunting = true;
  }    
  if(key == ' ')//FIND PATH
  {
    edit = false;
    findPath = true;
    maze.FindPath();
  }

  if(key == 's' && edit)//set start
    maze.Start(mouseX,mouseY);    
  
  if(key == 'e' && edit)//set end
    maze.End(mouseX,mouseY);    
}


void draw()
{
  
  if(!demo)
  {
    background(255);
    maze.Display();
    maze.Update();
    if(isHunting)
      maze.Hunt_and_Kill();
    if(findPath)
      maze.FindPath();
    
    //delay(100);
     
  }
  
  else
  {   
      background(255);
      maze.Display();
      maze.Update();
     
        
        delay(100);
    
     
     switch(demoStep)
     {
       case 0://reset
            
            maze = new Maze();
            maze.SetEdge();
            edit = true;
            findPath = false;
            findDone = false;
            huntingDone = false;
            demoStep = 1;
       break;
       
       case 1:         
             maze.Hunt_and_Kill();
            
             demoStep = 2;
       break;
       
        case 2:
             
             findPath = true;
             maze.FindPath();
             
             if(findDone)
             { 
               maze.FindPath();
               demoStep = 0;   
               delay(5000);
             }
                
       break;
       

     }
     
     
     
     
  }

}