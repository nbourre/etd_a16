class CellularAutomata
{
  EtatCell[] ruleset = {EtatCell.OPEN,EtatCell.OPEN,EtatCell.CLOSE,EtatCell.OPEN,EtatCell.OPEN};
  int nbmur, nbDE;
  Cell[][] nextTiles,baseTiles;
  
  CellularAutomata(Cell[][] tiles)
  {
    nextTiles = new Cell[sizeH/cellSize][sizeW/cellSize];
    baseTiles = new Cell[sizeH/cellSize][sizeW/cellSize];
    arrayCopy(tiles, nextTiles);  
  }
  
  
  void NextGen(Cell[][] tiles)
  {
    nbDE = 0;
    for (int i = 1; i <sizeW/cellSize-1; i++){
      for (int j = 1; j < sizeH/cellSize-1; j++) {
          if(!tiles[i][j].CheckStartEnd())
          {   
                switch(tiles[i][j].nbWall())
                {
                  case 1:
                        nextTiles[i][j].SetState(EtatCell.OPEN);
                  break;
                  
                  case 2:
                        nextTiles[i][j].SetState(EtatCell.OPEN);
                  break;
                  
                  case 3:
                        nextTiles[i][j].SetState(EtatCell.DEATHEND);
                        nbDE++;
                  break;
                  
                  case 4:
                        nextTiles[i][j].SetState(EtatCell.CLOSE);
                  break;
                }       
          }
      } 
    } 
    
    arrayCopy(nextTiles, tiles);
    if(nbDE == 0)
     findDone = true;
     
     //print(nbDE, " ");
    
  }
 
  
}