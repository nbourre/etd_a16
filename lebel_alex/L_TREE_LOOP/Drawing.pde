import java.util.Random;
import java.util.Hashtable;
import java.util.Stack;

class Drawing{
  Hashtable<String, Float> currentPoint; 
  ArrayList<Float> sin;
  ArrayList<Float> cos;
  Stack stack;
  int angle;
  int currentAngle;
  float perlinCoeff = 0;
  int perlinNoise = 0;
  float line_length;
  //ArrayList<Object> vals

  Drawing(){
    
    sin = new ArrayList<Float>();
    cos = new ArrayList<Float>();

    //vals = new ArrayList<Object>();
    //vals.add(180); vals.add((float)width/2); vals.add((float)height/2);
    stack = new Stack();
    currentPoint = new Hashtable();
    currentPoint.put("x",0.0);
    currentPoint.put("y",0.0);
    angle = 25;
    line_length = 11;
    currentAngle = 25;
    
    for(int i=0;i<360;i++)
    {
      sin.add((float)Math.sin(i * Math.PI / 180));
      cos.add((float)Math.cos(i * Math.PI / 180));
    }
  }
  
  void drawShape (Expression exp, boolean wind){
    //vals: [0] = currentAngle, [1] = currentPoint(x), [2] = currentPoint(y)
    float tempX = 0;
    float tempY = 0;
    int bracketsOpen=0, bracketsClose=0, brackets=0;
    
    if(wind)
    {
      perlinCoeff+=0.02;
      perlinNoise = (int)map(noise(perlinCoeff), 0, 1, -15, 15);
    }
    
    
    stroke(125,170,0);
    //System.out.println("values: "+vals.get(1)+ " " +vals.get(2));
    
    //line_length *= 0.50;
    currentAngle = 225;
    currentPoint.put("x",(float)width-width/10);
    currentPoint.put("y", (float)height-height/10);
   /* if(angle >359)
      angle-=360;
    angle++;  */
    
    //for(String elem: exp.expression)
    for(int i=0; i<exp.expression.size(); i++)
    {
       brackets = bracketsOpen - bracketsClose;
       if(brackets>2)
         brackets=2;
         
       
      
          strokeWeight(3-brackets);
      // draw line
      if(exp.expression.get(i).equals("+"))
        updateAngle("+");
      else if(exp.expression.get(i).equals("-"))
        updateAngle("-");
      else if(exp.expression.get(i).equals("["))
      {
        /*vals.set(0, currentAngle);
        vals.set(1, currentPoint.get("x"));
        vals.set(2, currentPoint.get("y"));*/
        stack.push(currentAngle);
        stack.push(currentPoint.get("x"));
        stack.push(currentPoint.get("y"));
        bracketsOpen++;

        
      }
      else if(exp.expression.get(i).equals("]"))
     {
        currentPoint.put("y",(float)stack.pop());
        currentPoint.put("x",(float)stack.pop());
        currentAngle = (int)stack.pop();
        bracketsClose++;
        
        
        /*currentAngle = (int)vals.get(0);
        currentPoint.put("x", (float)vals.get(1));
        currentPoint.put("y", (float)vals.get(2));*/
     }
      else 
      {
        tempX = currentPoint.get("x")+line_length * sin.get(currentAngle);
        tempY = currentPoint.get("y")+line_length * cos.get(currentAngle);  
        //System.out.println(tempX + "    " + tempY);
       // System.out.println(currentAngle);
       if((currentPoint.get("x")>0 && tempX>0) || (currentPoint.get("y")>0 && tempY>0))
          line(currentPoint.get("x"), currentPoint.get("y"), tempX, tempY);
        currentPoint.put("x",tempX);
        currentPoint.put("y",tempY);
        /*line(10,10,50,50+angle);
        angle+=10;*/
        
      }
      // updateAngle
        
    }
    
   // return values;
  }
  
  void updateAngle(String dir)
  {
      
     //println(currentAngle + dir); 
    if(dir.equals("-"))
    {
      if(currentAngle-angle+perlinNoise < 0)
        currentAngle+=360;
        
      //currentAngle-=angle;
      currentAngle = currentAngle-angle+perlinNoise;
      
      if(currentAngle>359){ currentAngle = 359; }
    }
    else if(dir.equals("+"))
    {
      if(currentAngle+angle+perlinNoise > 359)
        currentAngle-=360;
        
      //currentAngle+=angle;
      currentAngle = currentAngle+angle+perlinNoise;
      if(currentAngle<0)
        currentAngle = 0;
    }
   // println(currentAngle);
  }
  
  void setLength(float l)
  {
    this.line_length = l;
  }
  
  float getLength()
  {
    return line_length;
  }
  
  int checkBracket(Expression expr)
  {
    int nbBracket = 0;
    for(String elem: expr.expression)
    {
      if(elem.equals("["))
      {
        nbBracket++;
      }
    }
    return nbBracket;
  }
  
  
}