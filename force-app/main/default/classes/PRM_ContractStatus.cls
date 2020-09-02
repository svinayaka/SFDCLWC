/**
* Created by Kiru
* part of PRM Upgrade Project
* called from COntract trigger when PRM Addendum or PRM AMendment is executed.
* Test Class - PRM_CLtoContractStatus_Test
* */

public class PRM_ContractStatus {
    
     @InvocableMethod
    public static void passID(List<Contract> conLst){
        Set<Id> conset = new Set<Id>();
        for(Contract cntr :conLst ){
            conset.add(cntr.Id);
        }
        List<PRM_Commercial_Line_GE_OG__c> updatedlst = new List<PRM_Commercial_Line_GE_OG__c>();
        if(conset != null){
            
            List<PRM_Commercial_Line_GE_OG__c> CLlst = [Select Id,PRM_Status__c from PRM_Commercial_Line_GE_OG__c where PRM_Status__c='Under Contracting' AND (PRM_Addendum_ID__c in :conset OR PRM_Amendment_ID__c in :conset)];
            for(PRM_Commercial_Line_GE_OG__c cl : CLlst){
                cl.PRM_Status__c = 'Executed';
                    updatedlst.add(cl);
            }
        }
        
        if(updatedlst != null){
            update updatedlst;
        }
    }

}