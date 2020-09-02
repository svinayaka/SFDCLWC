public without sharing class SVMX_WorkOrderRecursiveSaveHelper {


//TODO: This class will stop allowing triggers to fire-in twice 

  // initialize a variable to hold state  
  private static boolean alreadyRunPreInsertWorkOrder = false;
  private static boolean alreadyRunPostInsertWorkOrder = false;
  private static boolean alreadyRunPreUpdateWorkOrder = false;
  private static boolean alreadyRunPostUpdateWorkOrder = false;
  private static boolean alreadyRunPreUpdateDTSWorkOrder = false;
  private static boolean alreadyRunPostUpdateDTSWorkOrder = false;
  private static boolean alreadyRunPostUpdateWorkOrder2 = false;
  private static boolean alreadyRunPostUpdateWorkOrderDRL = false;
  private static boolean alreadyRunPostUpdateWorkOrder3 = false;
  private static boolean alreadyRunPostUpdateWorkOrder4 = false;
  
  // get the state
  
      public static boolean isAlreadyRunPostUpdateWorkOrderDRL(){
        return alreadyRunPostUpdateWorkOrderDRL;
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
    
    // get the state
    public static boolean isAlreadyRunPreUpdateDTSWorkOrder() {
        return alreadyRunPreUpdateDTSWorkOrder;
    }
    
    public static boolean isAlreadyRunPostUpdateDTSWorkOrder() {
        return alreadyRunPostUpdateDTSWorkOrder;
    }
    
    public static boolean isAlreadyRunPostUpdateWorkOrder2 () {
        return alreadyRunPostUpdateWorkOrder2;
    }
    public static boolean isAlreadyRunPostUpdateWorkOrder3 () {
        return alreadyRunPostUpdateWorkOrder3;
    }

    public static boolean isAlreadyRunPostUpdateWorkOrder4 () {
        return alreadyRunPostUpdateWorkOrder4;
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
    
    public static void setAlreadyRunPreUpdateDTSWorkOrder() {
        alreadyRunPreUpdateDTSWorkOrder = true;
    }
    
     public static void setAlreadyRunPostUpdateDTSWorkOrder() {
        alreadyRunPostUpdateDTSWorkOrder = true;
    }
    
    public static void setAlreadyRunPostUpdateWorkOrder2() {
        alreadyRunPostUpdateWorkOrder2= true;
    }
    
    public static void setAlreadyRunPostUpdateWorkOrderDRL(){
        alreadyRunPostUpdateWorkOrderDRL = true;
    }
    public static void setAlreadyRunPostUpdateWorkOrder3() {
        alreadyRunPostUpdateWorkOrder3= true;
    }
     public static void setAlreadyRunPostUpdateWorkOrder4() {
        alreadyRunPostUpdateWorkOrder4= true;
    }
}