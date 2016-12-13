
class Cloud{
  
    float rectX;
    float rectY;
    float posRectX;
    float posRectY;
    
    float radius1;
    float radius2;
    float radius3;
    float radius4;
    float radius5;
    float radius6;
    float mean;
    float deviation;
  
  
  Cloud(){
    
    rectX=randomGaussian()*5 +width/9 ;
    rectY=(height/6)-height/8;
    posRectX=random(width-rectX);
    posRectY=random(height/12, (height/12)+rectY);
    mean = width/12;
    deviation = width/100;
    
    radius1=randomGaussian() *deviation +mean;
    radius2=randomGaussian() *deviation +mean;
    radius3=randomGaussian() *deviation +mean;
    radius4=randomGaussian() *deviation +mean;
    radius5=randomGaussian() *deviation +mean;
    radius6=randomGaussian() *deviation +mean;
    
  }
  
  void generateCloud(){
    
    //random(8);
    //rd.nextGaussian();
    //Min + (int)(Math.random() * ((Max - Min) + 1))

    
    fill(0);
    strokeWeight(1);
    stroke(255);
      fill(255);

    ellipse(posRectX+rectX, posRectY+(rectY/2), radius1, radius1); // right most
    ellipse(posRectX+(rectX/4), posRectY, radius2, radius2); // left up
    ellipse(posRectX+(rectX*3/4), posRectY, radius3, radius3); // right up
    ellipse(posRectX+(rectX/4), posRectY+rectY, radius4, radius4); // left down
    ellipse(posRectX+(rectX*3/4), posRectY+rectY, radius5, radius5); // right down
    ellipse(posRectX, posRectY+(rectY/2), radius6, radius6); // left most
  }
  
  
  
}