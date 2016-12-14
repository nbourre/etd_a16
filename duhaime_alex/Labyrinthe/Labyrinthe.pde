int gridwidth, gridheight, caseswidth, casesheight;
int startX, startY, endX, endY;
int gridX, gridY;
int sizecase;
int mill, nbsecs;

int currentX, currentY;

boolean created, solved;
boolean newStart, newEnd;

Case cases[][];
Case currentNode, tempNode;

ArrayList<Case> OpenList;
ArrayList<Case> CloseList;


// --------------------------------------------
// ---------- FONCTION SETUP() ----------------
// --------------------------------------------

void setup() {

  fullScreen();  //1366 x 768
  //size(800, 600);

  gridX = width / 9;
  gridY = height / 15;

  if (gridX < 0)  gridX = 0;
  if (gridY < 0)  gridY = 0;

  caseswidth  = 60;
  casesheight = 30;
  sizecase = 8;

  if (sizecase > (width - gridX) / 5 || sizecase > (height - gridY) / 5)
  {
    if (width - gridX < height - gridY - 120)
      sizecase = (width - gridX) / 5;
    else
      sizecase = (height - gridY) / 5;
  }

  if ((caseswidth * 2 + 1) * sizecase + gridX > width)
    caseswidth = (((width - gridX)/ sizecase) - 1) / 2;
  if ((casesheight * 2 + 1) * sizecase + gridY > height - 120)
    casesheight = (((height - 120 - gridY)/ sizecase) - 1) / 2;

  gridwidth = 2 * caseswidth + 1;
  gridheight = 2 * casesheight + 1;

  /*startX = 1;
  startY = 1;

  if (startX < 1 || startX > gridwidth - 1 || startX % 2 == 0)
    startX = 1;
  if (startY < 1 || startY > gridheight - 1 || startY % 2 == 0)
    startY = 1;

  endX = gridwidth - 2;
  endY = gridheight - 2;

  if (endX < 1 || endX > gridwidth - 1 || endX % 2 == 0)
    endX = 1;
  if (endY < 1 || endY > gridheight - 1 || endY % 2 == 0)
    endY = 1;*/
    
  startX = int(random(0, caseswidth / 3)) * 2 + 1;
  startY = int(random(0, casesheight)) * 2 + 1;
  
  endX = int(random((caseswidth * 2) / 3, caseswidth)) * 2 + 1;
  endY = int(random(0, casesheight)) * 2 + 1;
  
  if (endX == startX && endY == startY)
  {
    if (endX <= 1)
      endX += 2;
    else
      endX -= 2;
  }

  nbsecs = 10;

  if (nbsecs < 3)
    nbsecs = 3;

  cases = new Case[gridheight][gridwidth];

  resetMaze();

  PFont f;
  f = createFont("Georgia", 16, true);
  textFont(f, 24);
  textSize(width / 50);

  frameRate(100);
}

void resetMaze() {

  mill = millis();

  currentX = startX;
  currentY = startY;

  created = false;
  solved = false;

  newStart = false;
  newEnd = false;

  for (int j = 0; j < gridheight; j++)
  {
    for (int i = 0; i < gridwidth; i++)
    {
      cases[j][i] = new Case();

      cases[j][i].x = i;
      cases[j][i].y = j;

      if (j % 2 == 1 && i % 2 == 1)
        cases[j][i].iswall = false;
    }
  }

  cases[startY][startX].parent = -1;
}

// --------------------------------------------
// ---------- FONCTION DRAW() -----------------
// --------------------------------------------

void draw() {

  // Gestion d'événements -----

  if (keyPressed)
    if (key == 'r')
      setup();
    else if (key == 'c')
    {
      newStart = false;
      newEnd = false;
    } else if (key == 's')
    {
      newStart = true;
      newEnd = false;
    } else if (key == 'e')
    {
      newStart = false;
      newEnd = true;
    }

  // Dessiner la grille -----

  background(30);

  for (int j = 0; j < gridheight; j++)
  {
    for (int i = 0; i < gridwidth; i++)
    {
      // Détermine la couleur de chaque case -----
      if ((cases[j][i].x == startX && cases[j][i].y == startY) || (cases[j][i].x == endX && cases[j][i].y == endY)) {
        cases[j][i].isAnimated = true;
        cases[j][i].update(startX, startY, endX, endY);
        fill(cases[j][i].fillColor);
      }
      else if (cases[j][i].inpath)
        fill(0, 0, 255);
      else if (cases[j][i].iswall)
        fill(0);
      else
        fill(255);

      // Nouveeau début ou Nouvelle fin -----
      if (mousePressed && (mouseX - gridX) / sizecase == i && (mouseY - gridY) / sizecase == j && !cases[j][i].iswall && j % 2 == 1 && i % 2 == 1 && (newStart || newEnd))
      {
        if (newStart && !((mouseX - gridX) / sizecase == endX && (mouseY - gridY) / sizecase == endY))
        {
          startX = (mouseX - gridX) / sizecase;
          startY = (mouseY - gridY) / sizecase;
          resetMaze();
          break;
        } else if (newEnd && !((mouseX - gridX) / sizecase == startX && (mouseY - gridY) / sizecase == startY))
        {
          endX = (mouseX - gridX) / sizecase;
          endY = (mouseY - gridY) / sizecase;
          resetMaze();
          break;
        }
      }

      // Gestion d'événements -----
      if (keyPressed) {
        if (key == 'r') {
          setup();
          break;
        } else if (key == 'c')
        {
          newStart = false;
          newEnd = false;
        } else if (key == 's')
        {
          newStart = true;
          newEnd = false;
        } else if (key == 'e')
        {
          newStart = false;
          newEnd = true;
        }
      }

      rect(gridX + i * sizecase, gridY + j * sizecase, sizecase, sizecase);

      // Dessine le carré actuel de la création / résolution du labyrinthe -----
      fill(255, 0, 0);
      if (!created)
        rect(gridX + currentX * sizecase, gridY + currentY * sizecase, sizecase, sizecase);
      else if (created && !solved)
        rect(gridX + currentNode.x * sizecase, gridY + currentNode.y * sizecase, sizecase, sizecase);
    }
  }
  // Génère la labyrinthe et la solution ------------------------------------------
  // while() -> Dessine une fois que la création et résolution sont completes -----
  // for(i de 1 a 10) -> Montrer le developpement, Dessine a chaque 10 appels -----
  frameRate(100);

   /*while(!created)
   createMaze();
   
   while(!solved)
   solveMaze();*/


   if(!created) {
   for(int i = 0; i < 20; i++)
   if(!created)
   createMaze();
   }
   
   else if(created && !solved) {
   for(int i = 0; i < 20; i++)
   if(!solved)
   solveMaze();
   }

  /*if (!created)
    createMaze();
  else if (created && !solved)
    solveMaze();*/

  if (!solved)
    mill = millis();

  // Affiche a l'écran mon nom, le temps actuel sur le temps de réinitialisation du labyrinthe et les cases de début/fin -----
  
  int rectx = width / 4 - 50;
  if(rectx < 0)
    rectx = 0;
    
  fill(0, 255, 0);
  rect(rectx, (height / 6) * 5, width / 50, width / 50);
  fill(255, 0, 255);
  rect(rectx, (height / 12) * 11, width / 50, width / 50);

  fill(255);
  text("Debut", width / 4, (height / 6) * 5 + width / 50);
  text("Fin", width / 4, (height / 12) * 11 + width / 50);
  text((millis() - mill) / 1000 + "   Reset a " + nbsecs + " secs", (width / 16) * 9, (height / 6) * 5 + width / 50);
  text("Alexandre Duhaime, 2016", (width / 16) * 9, (height / 12) * 11 + width / 50);

  if ((millis() - mill) / 1000 >= nbsecs)
    setup();
}

// --------------------------------------------
// --------------------------------------------
// ---------- CRÉATION DU LABYRINTHE ----------
// --------------------------------------------
// --------------------------------------------

void createMaze() {
  int count = 0;
  int dir[] = new int[4];

  // Verifie s'il peut aller a Droite / Bas / Gauche / Haut ----------------------------
  // Si la case suivante n'a pas été visitée et qu'il y a un mur entre les 2 cases -----
  if (currentX < gridwidth - 2)
  {
    if (cases[currentY][currentX + 2].parent == 0 && cases[currentY][currentX + 1].iswall)
    {
      dir[count] = 1;
      count++;
    }
  }

  if (currentY < gridheight - 2)
  {
    if (cases[currentY + 2][currentX].parent == 0 && cases[currentY + 1][currentX].iswall)
    {
      dir[count] = 2;
      count++;
    }
  }

  if (currentX > 1)
  {
    if (cases[currentY][currentX - 2].parent == 0 && cases[currentY][currentX - 1].iswall)
    {
      dir[count] = 3;
      count++;
    }
  }

  if (currentY > 1)
  {
    if (cases[currentY - 2][currentX].parent == 0 && cases[currentY - 1][currentX].iswall)
    {
      dir[count] = 4;
      count++;
    }
  }

  // Si il y a au moins 1 cas possible de déplacement
  if (count > 0)
  {
    int nextdir = int(random(0, count));

    switch(dir[nextdir])
    {
    case 1:
      cases[currentY][currentX + 1].iswall = false;
      currentX += 2;
      break;
    case 2:
      cases[currentY + 1][currentX].iswall = false;
      currentY += 2;
      break;
    case 3:
      cases[currentY][currentX - 1].iswall = false;
      currentX -= 2;
      break;
    default:
      cases[currentY - 1][currentX].iswall = false;
      currentY -= 2;
      break;
    }

    cases[currentY][currentX].parent = dir[nextdir];
  }

  //Sinon, revient a la case précédente
  else
  {
    switch(cases[currentY][currentX].parent)
    {
    case 1:    
      currentX -= 2;  
      break;
    case 2:    
      currentY -= 2;  
      break;
    case 3:    
      currentX += 2;  
      break;
    case 4:    
      currentY += 2;  
      break;

      // Une fois arrivée a la case de début (Parent = -1) ---------------------------------
      // Supprime aléatoirement 10 murs pour que le labyrinthe ait plus d'une solution -----
    default :
      created = true;
      initSolveMode();

      boolean flag;
      int rand_x, rand_y;

      if (gridwidth * gridheight > 300)
        for (int i = 0; i < 10; i++)
        {
          flag = false;
          rand_x = 0;
          rand_y = 0;

          while (!flag)
          {
            rand_x = int(random(0, gridwidth));
            rand_y = int(random(0, gridheight));

            //Si il y a un autre mur a (Gauche et Droite) ou (Haut et Bas)
            if (cases[rand_y][rand_x].iswall && rand_x % 2 == 0 && rand_y % 2 == 0 && rand_x > 0 && rand_y > 0 && rand_x < gridwidth - 1 && rand_y < gridheight - 1 
              && ( (cases[rand_y-1][rand_x].iswall && cases[rand_y+1][rand_x].iswall && cases[rand_y][rand_x-1].iswall == false && cases[rand_y][rand_x + 1].iswall == false) 
              || (cases[rand_y][rand_x-1].iswall && cases[rand_y][rand_x+1].iswall && cases[rand_y-1][rand_x].iswall == false && cases[rand_y+1][rand_x].iswall == false) ) )
            {
              cases[rand_y][rand_x].iswall = false;
              flag = true;
            }
          }
        }

      break;
    }
  }
}

// --------------------------------------------
// ---------- INITIALISATION SOLVE MODE -------
// --------------------------------------------

void initSolveMode() {

  currentNode = cases[startY][startX];
  tempNode = currentNode;

  OpenList = new ArrayList<Case>();
  CloseList = new ArrayList<Case>();

  int tempX = 0, tempY = 0;

  for (int j = 0; j < gridheight; j++)
  {
    for (int i = 0; i < gridwidth; i++)
    {
      cases[j][i].f = 0;
      cases[j][i].g = 10000;

      tempY = endY - j;
      tempX = endX - i;
      if (tempY < 0)    tempY *= -1;
      if (tempX < 0)    tempX *= -1;
      cases[j][i].h = (tempY + tempX) * 10;

      cases[j][i].parent = 0;
    }
  }
  currentNode.g = 0;
  currentNode.f = currentNode.h;

  OpenList.add(currentNode);
}

// --------------------------------------------
// --------------------------------------------
// ---------- RÉSOULUTION DU LABYRINTHE -------
// --------------------------------------------
// --------------------------------------------

void solveMaze() {

  // Si la OpenList est vide
  if (!(OpenList.isEmpty()))
  {
    currentNode = OpenList.get(OpenList.size() - 1);

    // On trouve le plus petit f de la OpenList
    for (int i = 0; i < OpenList.size(); i++)
      if (OpenList.get(i).f < currentNode.f)
        currentNode = OpenList.get(i);

    // Si le noeud courrant est la case de fin
    if (currentNode == cases[endY][endX])
    {
      solved = true;
      reconstructPath();
    } else
    {
      // Ne depasse pas les bordures et la case suivante n'est pas un mur, et n'est pas dans la CloseList. 
      // Vérifie Droite / Bas / Gauche / Haut
      if (currentNode.x <= gridwidth - 1 && cases[currentNode.y][currentNode.x + 1].iswall == false)
      {
        if (!CloseList.contains(cases[currentNode.y][currentNode.x + 1]))
        {
          OpenList.add(cases[currentNode.y][currentNode.x + 1]);
          cases[currentNode.y][currentNode.x + 1].g = currentNode.g + 10;
          cases[currentNode.y][currentNode.x + 1].f = cases[currentNode.y][currentNode.x + 1].g + cases[currentNode.y][currentNode.x + 1].h;
          cases[currentNode.y][currentNode.x + 1].parent = 1;
        }
      }

      if (currentNode.y <= gridheight - 1 && cases[currentNode.y + 1][currentNode.x].iswall == false)
      {
        if (!CloseList.contains(cases[currentNode.y + 1][currentNode.x]))
        {
          OpenList.add(cases[currentNode.y + 1][currentNode.x]);
          cases[currentNode.y + 1][currentNode.x].g = currentNode.g + 10;
          cases[currentNode.y + 1][currentNode.x].f = cases[currentNode.y + 1][currentNode.x].g + cases[currentNode.y + 1][currentNode.x].h;
          cases[currentNode.y + 1][currentNode.x].parent = 2;
        }
      }

      if (currentNode.x >= 1 && cases[currentNode.y][currentNode.x - 1].iswall == false)
      {
        if (!CloseList.contains(cases[currentNode.y][currentNode.x - 1]))
        {
          OpenList.add(cases[currentNode.y][currentNode.x - 1]);
          cases[currentNode.y][currentNode.x - 1].g = currentNode.g + 10;
          cases[currentNode.y][currentNode.x - 1].f = cases[currentNode.y][currentNode.x - 1].g + cases[currentNode.y][currentNode.x - 1].h;
          cases[currentNode.y][currentNode.x - 1].parent = 3;
        }
      }

      if (currentNode.y >= 1 && cases[currentNode.y - 1][currentNode.x].iswall == false)
      {
        if (!CloseList.contains(cases[currentNode.y - 1][currentNode.x]))
        {
          OpenList.add(cases[currentNode.y - 1][currentNode.x]);
          cases[currentNode.y - 1][currentNode.x].g = currentNode.g + 10;
          cases[currentNode.y - 1][currentNode.x].f = cases[currentNode.y - 1][currentNode.x].g + cases[currentNode.y - 1][currentNode.x].h;
          cases[currentNode.y - 1][currentNode.x].parent = 4;
        }
      }

      //Affiche le chemin de la case de début jusqu'au noeud courant.
      tempNode = currentNode;
      reconstructPath();
      currentNode = tempNode;

      //Enleve le noeud courant de la OpenList car il vient d'etre vérifié, l'ajoute a la CloseList
      OpenList.remove(currentNode);
      CloseList.add(currentNode);
    }
  } else
  {
    solved = true;
    reconstructPath();
  }
}

// Pour réinitialiser le chemin entre le noeud courant et le noeud de début
void resetPath() {
  for (int j = 0; j < gridheight; j++)
    for (int i = 0; i < gridwidth; i++)
      cases[j][i].inpath = false;
}

// --------------------------------------------
// ---------- RECONSTRUCTION DU CHEMIN --------
// --------------------------------------------

void reconstructPath() {

  resetPath();

  //Tant que le noeud courant n'est pas a la position de début
  while (currentNode.x != startX || currentNode.y != startY)
  {
    cases[currentNode.y][currentNode.x].inpath = true;

    //Noeud courant = son parent
    switch(currentNode.parent)
    {
    case 1:
      currentNode = cases[currentNode.y][currentNode.x - 1];
      break;
    case 2:
      currentNode = cases[currentNode.y - 1][currentNode.x];
      break;
    case 3:
      currentNode = cases[currentNode.y][currentNode.x + 1];
      break;
    case 4:
      currentNode = cases[currentNode.y + 1][currentNode.x];
      break;
    }
  }
  cases[currentNode.y][currentNode.x].inpath = true;
}