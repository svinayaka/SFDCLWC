public Class checkRecursive{
   
        private static boolean runbefore = true;
        private static boolean runafter = true;
        Public Static Boolean Var_bypasstrigger = true;  
    public static boolean runBeforeOnce(){
      
    if(runbefore){
     runbefore=false;
     return true; 
    }
    else{
        return runbefore;
    }
      
    }
    
  /*  public static boolean runAfterOnce(){
     
    if(runafter){
     runafter=false;
     return true;
    }
    else{
        return runafter;
    }
     
    } */
}