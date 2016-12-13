import java.util.Hashtable;
import java.util.Random;

World world;


long previousTime = 0;
long currentTime = 0;
long deltaTime;
int timeState =0;
int exit = 0;
double direction = Math.PI/6;
Expression exp;
Drawing drawing;
Cloud cloud1;
Cloud cloud2;
boolean nextGen = false;
boolean wind = false;
ArrayList<Object> valeurs;

void setup () {
  fullScreen(1);
  //size (800, 600);
  //valeurs = new ArrayList<Object>();
  //valeurs.add(180); valeurs.add((float)width/2); valeurs.add((float)height/2); 
  world = new World();
  exp = new Expression("X");
  //world.display();
  cloud1 = new Cloud();
  cloud2 = new Cloud();
  drawing = new Drawing();
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;

    if(wind)
      drawGraphics();
      
      if(exit > 1200)
        //exit(); 
        timeState++;
    
 /* if(nextGen == true)
  {
    nextGen = false;
    exp.generation();
    cloud1 = new Cloud();
    cloud2 = new Cloud();
    world.incNombre();
    drawGraphics();
    
  }
    //drawGraphics();
  previousTime = currentTime; */
  timerState();
}

void keyPressed() {
  if (key == 'r') {
    restart();

}

if(key == 'k'){
  nextGen = true;
}

if(key == 'c'){
  world.accueil();
}

if(key == 'w'){
  wind = !wind;
}

if(key == '+'){
  if(drawing.getLength()>=1)
      drawing.setLength(drawing.getLength()+1);
  else
      drawing.setLength(drawing.getLength()*2);
  drawGraphics();
}

if(key == '-'){
  if(drawing.getLength() > 1)
      drawing.setLength(drawing.getLength()-1);
  else
      drawing.setLength(drawing.getLength()/2);
    drawGraphics();

}
    
}

void drawGraphics()
{
   world.display();
    cloud1.generateCloud();
    cloud2.generateCloud();
    drawing.drawShape(exp, wind);
    text ("branches: "+this.drawing.checkBracket(exp), 10, height - 115);
    text ("buffer: "+this.exp.getExpression().size(), 10, height - 100);
}


void restart()
{
    exp = null;
    exp = new Expression("X");
    world = new World();
    drawing = new Drawing();
    cloud1 = new Cloud();
    cloud2 = new Cloud();
    drawGraphics();
   // draw();
}

void timerState(){

   switch(timeState)
   {
     case 0:
       world.accueil();
       //if(deltaTime > 4000)
           timeState++;
       break;
       
     case 1:
       delay(4000);
       textSize(11);
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1000);
       timeState++;
       break;
       
     case 2:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1500);
       timeState++;
       break;
       
      case 3:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1500);
       timeState++;
       break;  
       
      case 4:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1500);
       timeState++;
       previousTime = 0;
       currentTime = 0;
       break;  
       
      case 5:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1500);
       timeState++;
       break;  
       
     case 6:
       if(drawing.getLength() > 1)
          drawing.setLength(drawing.getLength()-3);
       else
          drawing.setLength(drawing.getLength()/2);
      
      drawGraphics();
      delay(500);
      timeState++;
      break;

     case 7:
       if(drawing.getLength() > 1)
          drawing.setLength(drawing.getLength()-3);
       else
          drawing.setLength(drawing.getLength()/2);
      
      drawGraphics();
      delay(500);
      timeState++;
      break;
      
     case 8:
       if(drawing.getLength() > 1)
          drawing.setLength(drawing.getLength()-1);
       else
          drawing.setLength(drawing.getLength()/2);
      
      drawGraphics();
      delay(500);
      timeState++;
      break; 
      
     case 9:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1500);
       timeState++;
       break;   
      
     case 10:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1500);
       timeState++;
       break;   
       
     case 11:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       delay(1500);
       timeState++;
       break;   
      
     case 12:
       if(drawing.getLength() > 1)
          drawing.setLength(drawing.getLength()-1);
       else
          drawing.setLength(drawing.getLength()/2);
      
      drawGraphics();
      delay(500);
      timeState++;
      break; 

     case 13:
       if(drawing.getLength() > 1)
          drawing.setLength(drawing.getLength()-1);
       else
          drawing.setLength(drawing.getLength()/2);
      
      drawGraphics();
      delay(500);
      timeState++;
      break; 

     case 14:
       if(drawing.getLength() > 1)
          drawing.setLength(drawing.getLength()-1);
       else
          drawing.setLength(drawing.getLength()/2);
      
      drawGraphics();
      delay(500);
      timeState++;
      break; 

     case 15:
       if(drawing.getLength() > 1)
          drawing.setLength(drawing.getLength()-1);
       else
          drawing.setLength(drawing.getLength()/2);
      
      drawGraphics();
      delay(500);
      timeState++;
      break; 
      
     case 16:
       exp.generation();
       cloud1 = new Cloud();
       cloud2 = new Cloud();
       world.incNombre();
       drawGraphics();
       timeState++;
              delay(1000);
       restart();
       break;
       
     case 17:
       exp.generation();
       world.incNombre();
       drawGraphics();
       
        exp.generation();
       world.incNombre();
       drawGraphics();
       
       exp.generation();
       world.incNombre();
       drawGraphics();
       
       exp.generation();
       world.incNombre();
       drawGraphics();
       
       delay(1500);
       timeState++;
       break;
       
     case 18: 
     wind = true;
     exit++;
     break;
     
     case 19: 
     wind = false;
     timeState = 0;
     exit = 0;
     currentTime = 0;
     previousTime=0;
     restart();
         
       
       
         
   }
  
}