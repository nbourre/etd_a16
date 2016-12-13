class World{
  int nombre = 0;
  int direction = 0;
  
  World(){
  nombre = 1;
  }
  
  void display(){
    background (168,201,255);
    fill(100,75,0);
    stroke(100,75,0);
    rect(0,height*2/3, width, height);
    
    showThanks();
    /*for(int i=0;i<direction;i++)  
    {
      rotate((float)Math.PI/6);  
    }
    direction++;*/
  }
  
    void showThanks() {
    //delay(10);
    fill(255);
    text ("génération: " + nombre, width - 275, height - 15);
  }
  
  int getNombre(){
    return this.nombre;
  }
  
  void decNombre()
  {
    nombre--;
  }
  
  void incNombre()
  {
    nombre++;
  }
  
  void accueil(){
    background(50);
    
    textSize(80);
    text ("Système L-Tree", width/3, height/4);
    text ("Alexandre Lebel, 2016", width/5, height*3/4);
  }

}