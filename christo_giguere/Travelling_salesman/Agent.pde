class Agent implements Comparable{
  
  float fitness;
  ArrayList<Integer> path = new ArrayList<Integer>();
  Agent(){
    int cityIndex;
    for(int i = 0 ; i < cityAmount ; i++){
      while(path.contains(cityIndex = (int)random(cityAmount))){}
      path.add(cityIndex);
    }
  }
  
  //constructor from parents
  Agent(ArrayList<Integer> path){
    this.path = path;
  }
  
  void calculFitness(){
    fitness = 0;
    for(int i = 0 ; i < cityAmount-1 ; i++)
        fitness += PVector.dist(cities.get(path.get(i)).location , cities.get(path.get(i+1)).location);
  }
  
  void setPath (ArrayList<Integer> path){
    this.path = path;
  }
  int compareTo(Object other){
    Agent agent = (Agent)other;
    return (int)(fitness - agent.fitness);
  }
}