global class DealMachineContractStageAutomation {
    @InvocableMethod(label='DM Contract Stage Automation' description='Automate the DM Contract stages')
    public static void stageautomationDMContract(List<Id> contractId){
        List<Contract> lstContractsToUpdate =  [Select Id, Name, Primary_Opportunity_Count__c, Primary_Contract_Manager__c, GE_PRM_Type__c,
                                                Language_GEOG__c,GE_Scope_of_Work__c,StartDate, GE_OG_Contract_End_Date__c, Status,Key_Dates_Linked__c,
                                                Dataload__c, GE_OG_Evergreen__c
                                                FROM Contract 
                                                WHERE Id IN: contractId]; 
        for(Contract objCon: lstContractsToUpdate){    
            if((objCon.Primary_Opportunity_Count__c > 0 || objCon.Dataload__c) && objCon.Primary_Contract_Manager__c != null && objCon.GE_PRM_Type__c != null){
                objCon.Is_Status_Automation__c = true;
                objCon.Status = 'In Progress';
                if(objCon.Language_GEOG__c != null && (objCon.GE_Scope_of_Work__c !=null || objCon.Dataload__c) && objCon.StartDate!= null && (objCon.GE_OG_Contract_End_Date__c!= null || objCon.GE_OG_Evergreen__c) && (objCon.Key_Dates_Linked__c !=0 || objCon.Dataload__c || objCon.GE_OG_Evergreen__c)){
                    objCon.Is_Status_Automation__c = true;
                    objCon.Status = 'Activated';
                }
                else{
                    objCon.Is_Status_Automation__c = true;
                    objCon.Status = 'In Progress';
                }
            }
            else{
                objCon.Is_Status_Automation__c = true;
                objCon.Status = 'Draft';
            }
            
        }
        if(!lstContractsToUpdate.isEmpty()){
            try{
                update lstContractsToUpdate;
                for(Contract oCon: lstContractsToUpdate){
                    oCon.Is_Status_Automation__c = false;   
                }
                update lstContractsToUpdate;
            }
            catch(Exception e){
                system.debug('Exception in updating the Status '+e.getMessage());
            }
            
        }
        
    }
}