class Maze {
 Cell[][] tiles;
 int totalvisited, nbvoisin;
 int[] voisins = new int[4];
 int currentx, currenty, lastx, lasty, Startx, Starty, Endx, Endy;
 CellularAutomata CA;

 int cols, rows;

 Maze(int cols, int rows) {
  this.cols = cols;
  this.rows = rows;

  tiles = new Cell[sizeH / cellSize][sizeW / cellSize];

  for (int i = 0; i < sizeW / cellSize; i++) {
   for (int j = 0; j < sizeH / cellSize; j++) {
    // Initialize each object
    tiles[i][j] = new Cell(i * cellSize, j * cellSize, cellSize, cellSize);

   }

  }
 }

 Maze() {

  this.cols = sizeW / cellSize;
  this.rows = sizeH / cellSize;

  tiles = new Cell[cols][rows];

  for (int i = 0; i < rows; i++) {
   for (int j = 0; j < cols; j++) {
    // Initialize each object
    tiles[i][j] = new Cell(i * cellSize, j * cellSize, cellSize, cellSize);

   }

  }

  CA = new CellularAutomata(tiles);
  totalvisited = 0;
  currentx = 1;
  currenty = 1;
  huntingDone = false;
  Startx = 1;
  Starty = 1;
  Endx = sizeW / cellSize - 2;
  Endy = sizeH / cellSize - 2;

  tiles[Startx][Starty].SetState(EtatCell.START);
  tiles[Endx][Endy].SetState(EtatCell.END);
 }

 void Display() {
  for (int i = 1; i < sizeW / cellSize - 1; i++) {
   for (int j = 1; j < sizeH / cellSize - 1; j++) {
    tiles[i][j].display();
   }
  }
 }

 void Update() {
  for (int i = 1; i < sizeW / cellSize - 1; i++) {
   for (int j = 1; j < sizeH / cellSize - 1; j++) {
    for (int k = 0; k < 4; k++) //trouver les voisin disponible
    {
     switch (k) {
      case 0: //up
       if (tiles[i][j].HaveWall(0) && !tiles[i][j - 1].HaveWall(2)) {
        tiles[i][j - 1].BuildWall(2);
       }
       break;

      case 1: //right
       if (tiles[i][j].HaveWall(1) && !tiles[i + 1][j].HaveWall(3)) {
        tiles[i + 1][j].BuildWall(3);
       }
       break;

      case 2: //down
       if (tiles[i][j].HaveWall(2) && !tiles[i][j + 1].HaveWall(0)) {
        tiles[i][j + 1].BuildWall(0);
       }
       break;

      case 3: //left
       if (tiles[i][j].HaveWall(3) && !tiles[i - 1][j].HaveWall(1)) {
        tiles[i - 1][j].BuildWall(1);
       }
       break;
     }
    }
   }
  }
 }

 void SetEdge() {
  for (int i = 0; i < sizeW / cellSize - 1; i++) //haut
   tiles[i][0].SetEdge();

  for (int i = 0; i < sizeW / cellSize - 1; i++) //bas    
   tiles[i][sizeW / cellSize - 1].SetEdge();

  for (int i = 0; i < sizeH / cellSize - 1; i++)
   tiles[0][i].SetEdge();

  for (int i = 0; i < sizeH / cellSize - 1; i++)
   tiles[sizeH / cellSize - 1][i].SetEdge();

 }

 void Hunt_and_Kill() {
  print("hunt");
  do {
   //print(currenty," ");
   //print(tiles[1][19].isEdge());

   nbvoisin = 0;

   for (int i = 0; i < 4; i++) //trouver les voisin disponible
   {
    switch (i) {
     case 0: //up
      if (!tiles[currentx][currenty - 1].isVisited() && !tiles[currentx][currenty - 1].isEdge()) {
       voisins[nbvoisin] = i;
       nbvoisin++;
      }
      break;

     case 1: //right
      if (!tiles[currentx + 1][currenty].isVisited() && !tiles[currentx + 1][currenty].isEdge()) {
       voisins[nbvoisin] = i;
       nbvoisin++;
      }
      break;

     case 2: //down
      if (!tiles[currentx][currenty + 1].isEdge() && !tiles[currentx][currenty + 1].isVisited()) {
       voisins[nbvoisin] = i;
       nbvoisin++;
      }
      break;

     case 3: //left
      if (!tiles[currentx - 1][currenty].isVisited() && !tiles[currentx - 1][currenty].isEdge()) {
       voisins[nbvoisin] = i;
       nbvoisin++;
      }
      break;
    }
   }
   //choisir un voisin aleatoire 

   if (nbvoisin > 0) {
    switch (voisins[int(random(nbvoisin))]) {
     case 0:

      tiles[currentx][currenty].CarveWall(0);
      tiles[currentx][currenty - 1].CarveWall(2);
      tiles[currentx][currenty].SetVisited();
      totalvisited++;
      lastx = currentx;
      lasty = currenty;
      currenty = lasty - 1;


      break;

     case 1:
      tiles[currentx][currenty].CarveWall(1);
      tiles[currentx + 1][currenty].CarveWall(3);
      tiles[currentx][currenty].SetVisited();
      totalvisited++;
      lastx = currentx;
      lasty = currenty;
      currentx = lastx + 1;
      break;

     case 2:
      tiles[currentx][currenty].CarveWall(2);
      tiles[currentx][currenty + 1].CarveWall(0);
      tiles[currentx][currenty].SetVisited();
      totalvisited++;
      lastx = currentx;
      lasty = currenty;
      currenty = lasty + 1;
      break;

     case 3:
      tiles[currentx][currenty].CarveWall(3);
      tiles[currentx - 1][currenty].CarveWall(1);
      tiles[currentx][currenty].SetVisited();
      totalvisited++;
      lastx = currentx;
      lasty = currenty;
      currentx = lastx - 1;
      break;
    }
   } else //Hunt
   {
    tiles[currentx][currenty].SetVisited();
    totalvisited++;
    HuntLoop:
     for (int i = 1; i < sizeW / cellSize - 1; i++) {
      for (int j = 1; j < sizeH / cellSize - 1; j++) {
       for (int k = 0; k < 4; k++) {
        switch (k) // 0 up 1 right 2 down 3 left (sens horaire)  
        {
         case 0:
          if (!tiles[i][j].isVisited() && tiles[i][j - 1].isVisited() && !tiles[i][j].isEdge()) {
           tiles[i][j].CarveWall(0);
           tiles[i][j - 1].CarveWall(2);

           currentx = i;
           currenty = j;
           break HuntLoop;
          }
          break;

         case 1:
          if (!tiles[i][j].isVisited() && tiles[i + 1][j].isVisited() && !tiles[i][j].isEdge()) {
           tiles[i][j].CarveWall(1);
           tiles[i + 1][j].CarveWall(3);

           currentx = i;
           currenty = j;

           break HuntLoop;
          }
          break;

         case 2:
          if (!tiles[i][j].isVisited() && tiles[i][j + 1].isVisited() && !tiles[i][j].isEdge()) {
           tiles[i][j].CarveWall(2);
           tiles[i][j + 1].CarveWall(0);

           currentx = i;
           currenty = j;
           break HuntLoop;
          }
          break;

         case 3:
          if (!tiles[i][j].isVisited() && tiles[i - 1][j].isVisited() && !tiles[i][j].isEdge()) {
           tiles[i][j].CarveWall(3);
           tiles[i - 1][j].CarveWall(1);

           currentx = i;
           currenty = j;
           break HuntLoop;
          }
          break;
        }
       }
      }
     }
   }
  } while (totalvisited <= ((sizeW / cellSize - 2) * (sizeH / cellSize - 2))); //totalvisited != (((width/cellSize)*(height/cellSize))- ((cellSize*4)-4))
  // print("  done_hunting");
  huntingDone = true;

  //if(totalvisited <= ((width/cellSize-2)*(height/cellSize-2)))
  // huntingDone = true;

 }

 int countDeath() {
  for (int i = 0; i < sizeW / cellSize; i++) {
   for (int j = 0; j < sizeH / cellSize; j++) {


   }
  }

  return 1;
 }

 void FindPath() {
  if (huntingDone) {
   CA.NextGen(tiles);
  }
 }

 void Start(int mx, int my) {
  print("setstart ");

  int posx, posy;


  posx = cellSize;
  posy = cellSize;

  for (int j = 1; j < sizeW / cellSize; j++) {
   posx = cellSize;
   for (int i = 1; i < sizeH / cellSize; i++) {

    if (!tiles[i][j].isEdge() && !tiles[i][j].CheckStartEnd() && mx >= posx && mx <= posx + cellSize && my >= posy && my <= posy + cellSize) {
     tiles[Startx][Starty].SetState(EtatCell.OPEN);
     tiles[i][j].SetState(EtatCell.START);

     Startx = i;
     Starty = j;
    }

    posx += cellSize;
   }
   posy += cellSize;
  }

 }

 void End(int mx, int my) {
  int posx, posy;


  posx = cellSize;
  posy = cellSize;

  for (int j = 1; j < sizeW / cellSize; j++) {
   posx = cellSize;
   for (int i = 1; i < sizeH / cellSize; i++) {

    if (!tiles[i][j].isEdge() && !tiles[i][j].CheckStartEnd() && mx > posx && mx < posx + cellSize && my > posy && my < posy + cellSize) {
     tiles[Endx][Endy].SetState(EtatCell.OPEN);
     tiles[i][j].SetState(EtatCell.END);

     Endx = i;
     Endy = j;
    }

    posx += cellSize;
   }
   posy += cellSize;
  }
 }





}