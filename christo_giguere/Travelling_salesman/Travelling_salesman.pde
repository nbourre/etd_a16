//time management variables
enum Algorithm{GENETIC,ANTCOLONY,NEURALNETWORK}
long previousTime = 0;
long currentTime = 0;
long deltaTime;
long displayAcc = 100;
long displayDelay = 100;
long updateAcc = 0;
long updateDelay = 0;
long resetAcc = 0;
long resetDelay = 5000;
ArrayList<City> cities;
int cityAmount = 50;

GeneticAlgorithm geneticAlgorithm;
AntColony antColony;
//NeuralNetworkAlgorithm neuralNetWorkAlgorithm;
boolean onPause;
Algorithm algorithm;
void setup(){
  fullScreen();
  //size(640,480);
  cities = new ArrayList<City>();
  for(int i = 0 ; i < cityAmount ; i++)
    cities.add(new City(random(50,width-50),random(50,height-50),i));
  
  geneticAlgorithm = new GeneticAlgorithm();
  antColony = new AntColony();
  onPause = false;
  algorithm  = Algorithm.ANTCOLONY;
}


void draw(){
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime; 
  if(antColony.generationInfo.homogenity >= 99.90){
    resetAcc += deltaTime;
    if(resetAcc > resetDelay)
    {
      resetAcc = 0;
      cities = new ArrayList<City>();
      for(int i = 0 ; i < cityAmount ; i++)
        cities.add(new City(random(50,width-50),random(50,height-50),i));
      antColony = new AntColony();
    }
  }else{
    if(!onPause){
      updateAcc += deltaTime;
      if(updateAcc > updateDelay){
        updateAcc = 0 ;
        //neuralNetWorkAlgorithm.update();
        //geneticAlgorithm.update();
        antColony.update();
      }
    }
  } 
   displayAcc += deltaTime;
   if(displayAcc > displayDelay){
     displayAcc = 0 ;
     display();
   }
}

void display(){
  
  background(255);
  switch(algorithm){
    case GENETIC:
      geneticAlgorithm.display();
      break;
    case ANTCOLONY:
      antColony.display();
      break;
    case NEURALNETWORK:
      //neuralNetWorkAlgorithm.display();
      break;
  }

  for(City c:cities)
    c.display();
}

void keyPressed(){
  
  switch(key){
    case 'a':
      algorithm = Algorithm.ANTCOLONY;
      break;
    case 'g':
      algorithm = Algorithm.GENETIC;
      break;
    case 'n':
      algorithm = Algorithm.NEURALNETWORK;
      break;
    case 't':
      antColony.showPheromones = !antColony.showPheromones;
      break;
    case 'p':
      onPause = true;
      break;
    case ' ':
      onPause = false;
      break;
    default:
      break;
  }
}