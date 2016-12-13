class Expression{
  ArrayList<String> expression;
  ArrayList<String> result;
  
  Expression(String e){
    expression = new ArrayList<String>();
    result = new ArrayList<String>();
   // angle = 45;
   // line_length = 30;
   String temp;
   
    
    for(int i=0; i<e.length();i++)
    {
      temp = String.valueOf(e.charAt(i));
      expression.add(temp);
    }
  }
  
  void generation(){
    
    result.clear();
    
    // (X → F−[[X]+X]+F[+FX]−X), (F → FF)
    //      F-[[X]+X]+F[+FX]-X
    
    for(String elem: expression)
    {
      if(elem.equals("F"))
        {
          result.add("F");
          result.add("F");
        }
        
      else if(elem.equals("X"))
      {                  // F-[[X]+X]+F[+FX]-X
        result.add("F");    
        result.add("-"); 
        result.add("[");
        result.add("["); 
        result.add("X"); 
        result.add("]"); 
        result.add("+"); 
        result.add("X"); 
        result.add("]");  
        result.add("+"); 
        result.add("F"); 
        result.add("["); 
        result.add("+"); 
        result.add("F"); 
        result.add("X"); 
        result.add("]"); 
        result.add("-"); 
        result.add("X"); 
      }
        
      else
        {
          result.add(elem);
        }
        
        /*if(elem.equals("-"))
          result.add("-");
        if(elem.equals("+"))
          result.add("+");  */
    }
    //result.add(" ");
    expression.clear();
    for(String elem: result)
    {
      expression.add(elem);
    }
    //expression = result;
    //return result;
    
}

  ArrayList<String> getExpression(){
    return expression;
  }

}