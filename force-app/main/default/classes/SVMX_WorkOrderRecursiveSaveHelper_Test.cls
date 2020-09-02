@istest(SeeAllData=false)
public class SVMX_WorkOrderRecursiveSaveHelper_Test {
  
    static testMethod void runRecursiveHelper(){
        test.startTest();
        SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostInsertWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder();
        WorkOrderRecursiveSaveHelper.isAlreadyRunPreInsertWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPreUpdateWorkOrder();
        
        SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder2();
        SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPreUpdateDTSWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateDTSWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrderDRL();
        
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostInsertWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPreInsertWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPreUpdateWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder2();
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPreUpdateDTSWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateDTSWorkOrder();
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrderDRL();        
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPreUpdateWorkOrder();
        
        WorkOrderRecursiveSaveHelper.isAlreadyRunPostInsertWorkOrder();
        WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder();
        WorkOrderRecursiveSaveHelper.isAlreadyRunPreInsertWorkOrder();
        WorkOrderRecursiveSaveHelper.isAlreadyRunPreUpdateWorkOrder();
        WorkOrderRecursiveSaveHelper.setAlreadyRunPostInsertWorkOrder();
        WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder();
        WorkOrderRecursiveSaveHelper.setAlreadyRunPreInsertWorkOrder();
        
        test.stopTest();
    }
    
}