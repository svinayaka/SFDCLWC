public without sharing class SVMX_TimesheetRecursiveSaveHelper {


//TODO: This class will stop allowing triggers to fire-in twice 

  // initialize a variable to hold state  
  private static boolean alreadyRunPreInsertTimesheets = false;
  private static boolean alreadyRunPostInsertTimesheets = false;
  private static boolean alreadyRunPreUpdateTimesheets = false;
  private static boolean alreadyRunPostUpdateTimesheets = false;
  
  
  // get the state
    public static boolean isAlreadyRunPreInsertTimesheets() {
        return alreadyRunPreInsertTimesheets;
    }
    
    public static boolean isAlreadyRunPostInsertTimesheets() {
        return alreadyRunPostInsertTimesheets;
    }
    
  // get the state
    public static boolean isAlreadyRunPreUpdateTimesheets() {
        return alreadyRunPreUpdateTimesheets;
    }
    
    public static boolean isAlreadyRunPostUpdateTimesheets() {
        return alreadyRunPostUpdateTimesheets;
    }

    // set this to true to keep track of and avoid recursive updates.  Generally set after first time through
    // a trigger.  We can access this in the trigger and avoid recursive updates...
   
    public static void setAlreadyRunPreInsertTimesheets() {
        alreadyRunPreInsertTimesheets = true;
    }
    
     public static void setAlreadyRunPreUpdateTimesheets() {
        alreadyRunPreUpdateTimesheets = true;
    }

    
    public static void setAlreadyRunPostInsertTimesheets() {
        alreadyRunPostInsertTimesheets = true;
    }
    
     public static void setAlreadyRunPostUpdateTimesheets() {
        alreadyRunPostUpdateTimesheets = true;
    }
    
}