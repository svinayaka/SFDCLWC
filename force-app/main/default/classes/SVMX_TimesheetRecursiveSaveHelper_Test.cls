@istest(SeeAllData=false)
public class SVMX_TimesheetRecursiveSaveHelper_Test {
	
    static testMethod void runRecursiveHelper(){
        test.startTest();
        SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostInsertTimesheets();
        SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostUpdateTimesheets();
        SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPreInsertTimesheets();
        SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPreUpdateTimesheets();
        SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostInsertTimesheets();
        SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostUpdateTimesheets();
        SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPreInsertTimesheets();
        SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPreUpdateTimesheets();
        test.stopTest();
    }
    
}