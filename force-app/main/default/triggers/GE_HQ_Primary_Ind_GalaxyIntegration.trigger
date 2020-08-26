/*Trigger name : GE_HQ_Primary_Ind_GalaxyIntegration
Created by : Sneha Joshi
Created Date : 26/06/2012
Functional Area : Integration
Test Class Name : GEESGalaxyCustomerTest
*/
trigger GE_HQ_Primary_Ind_GalaxyIntegration on GE_HQ_P_L_Specific_Info__c (After Insert,After Update) {
    List<GE_HQ_P_L_Specific_Info__c> accountsToProcess = new List<GE_HQ_P_L_Specific_Info__c>(); //to hold the list of P&L to pass to WS
    Set<Id> UserIds = new Set<Id>();
    Set<Id> RegionIds = new Set<Id>();
    Set<Id> AccountIDs = new Set<Id>();

    if(Trigger.isInsert) {
        System.debug('Is Insert');
        for(GE_HQ_P_L_Specific_Info__c objPL : System.Trigger.new)
        {
            Account oAcc = [Select Id, CreatedById, LastModifiedById, GE_HQ_DUNS_Number__c, GE_HQ_Request_Status__c, GE_HQ_Region_Tier1__c from Account where Id = :objPL.GE_HQ_Account__c];

            if(oAcc.GE_HQ_DUNS_Number__c != null && oAcc.GE_HQ_Request_Status__c == 'CMF Approved' && objPL.GE_ES_Env_Prim_Ind__c != null)
            {
                System.debug('Is Insert - Adding to Process');
                accountsToProcess.add(objPL);
                AccountIDs.add(oAcc.Id);
                UserIds.add(oAcc.CreatedById);
                UserIds.add(oAcc.LastModifiedById);
                RegionIds.add(oAcc.GE_HQ_Region_Tier1__c);
            }
        }
    }
    if(Trigger.isUpdate) {
    System.debug('Is Update');
        for(GE_HQ_P_L_Specific_Info__c objPL : System.Trigger.new)
        {
            System.debug('In for');
            GE_HQ_P_L_Specific_Info__c oPL = Trigger.oldmap.get(objPL.ID);
            Account oAcc = [Select Id, CreatedById, LastModifiedById, GE_HQ_DUNS_Number__c, GE_HQ_Request_Status__c, GE_HQ_Region_Tier1__c from Account where Id = :objPL.GE_HQ_Account__c];

            if(oAcc.GE_HQ_DUNS_Number__c != null && oAcc.GE_HQ_Request_Status__c == 'CMF Approved' && objPL.GE_ES_Env_Prim_Ind__c != null)
            {
                System.debug('Is Update - Primary Industry Condition');
                if(objPL.GE_ES_Env_Prim_Ind__c != oPL.GE_ES_Env_Prim_Ind__c)
                {
                    System.debug('Is Update - Adding to process');
                    accountsToProcess.add(objPL);
                    AccountIDs.add(oAcc.Id);
                    UserIds.add(oAcc.CreatedById);
                    UserIds.add(oAcc.LastModifiedById);
                    RegionIds.add(oAcc.GE_HQ_Region_Tier1__c);
                }
            }
        }
    }
    //only if there are accounts to send to WS, then only WS will be called
    if(accountsToProcess.size()>0)
    {
        try {
        System.debug('Final - Calling Integration Wrapper');
        GE_ES_CustomerGalaxyIntegrationWrapper.newAccountRequest(AccountIDs,UserIDs,RegionIds);
        } catch(Exception ex){}
    }

}