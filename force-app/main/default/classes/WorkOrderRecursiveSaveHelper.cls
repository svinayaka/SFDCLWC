public without sharing class WorkOrderRecursiveSaveHelper {


//TODO: This class will stop allowing triggers to fire-in twice 

  // initialize a variable to hold state  
  private static boolean alreadyRunPreInsertWorkOrder = false;
  private static boolean alreadyRunPostInsertWorkOrder = false;
  private static boolean alreadyRunPreUpdateWorkOrder = false;
  private static boolean alreadyRunPostUpdateWorkOrder = false;
  
  
  // get the state
    public static boolean isAlreadyRunPreInsertWorkOrder() {
        return alreadyRunPreInsertWorkOrder;
    }
    
    public static boolean isAlreadyRunPostInsertWorkOrder() {
        return alreadyRunPostInsertWorkOrder;
    }
    
  // get the state
    public static boolean isAlreadyRunPreUpdateWorkOrder() {
        return alreadyRunPreUpdateWorkOrder;
    }
    
    public static boolean isAlreadyRunPostUpdateWorkOrder() {
        return alreadyRunPostUpdateWorkOrder;
    }

    // set this to true to keep track of and avoid recursive updates.  Generally set after first time through
    // a trigger.  We can access this in the trigger and avoid recursive updates...
   
    public static void setAlreadyRunPreInsertWorkOrder() {
        alreadyRunPreInsertWorkOrder = true;
    }
    
     public static void setAlreadyRunPreUpdateWorkOrder() {
        alreadyRunPreUpdateWorkOrder = true;
    }

    
    public static void setAlreadyRunPostInsertWorkOrder() {
        alreadyRunPostInsertWorkOrder = true;
    }
    
     public static void setAlreadyRunPostUpdateWorkOrder() {
        alreadyRunPostUpdateWorkOrder = true;
    }
    
}