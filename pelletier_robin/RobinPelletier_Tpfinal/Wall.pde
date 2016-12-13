class Wall {
     boolean isOpen =false; // open walls are passages
     boolean isEdge = false; // edges have nothing on the other side.
     
     Wall(){}
     
     void SetOpen(boolean b)
     {
       isOpen = b;
     }
     
     boolean isOpen()
     {
       return isOpen;
     }
 }