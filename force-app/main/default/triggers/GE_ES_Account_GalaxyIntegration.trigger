//Number of SOQL queries: 0 out of 100
//Number of DML statements: 0
//Number of DML rows: 0
//test class : GEESGalaxyCustomerTest 

/* Change History:
Modified By:                Date:                Purpose:
Sneha Joshi                05/06/2012            For Region changes - R-8332, S-05938

*/
trigger GE_ES_Account_GalaxyIntegration on Account (After Insert, After Update) {
  //Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_ES_Account_GalaxyIntegration');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
       
        return;  
    }
    else{
    List<Account> accountsToProcess = new List<Account>(); //to hold the list of accounts to pass to WS
    Set<Id> UserIds = new Set<Id>();
    Set<Id> RegionIds = new Set<Id>();
    Set<Id> AccountIDs = new Set<Id>();

    if(Trigger.isInsert) {
        System.debug('Is Insert');
        for(Account objAccount: System.Trigger.new)
        {
            if(objAccount.GE_HQ_DUNS_Number__c != null & objAccount.GE_HQ_Request_Status__c == 'CMF Approved')
            {
                System.debug('Is Insert - Adding to Process');
                accountsToProcess.add(objAccount);
                AccountIDs.add(objAccount.ID);
                UserIds.add(objAccount.CreatedById);
                UserIds.add(objAccount.LastModifiedById);
                RegionIds.add(objAccount.GE_HQ_Region_Tier1__c);
            }
        }
    }
    if(Trigger.isUpdate) {
    System.debug('Is Update');
        for(Account objAccount: System.Trigger.new)
        {
            Account oAcc = Trigger.oldmap.get(objAccount.ID);
            if(objAccount.GE_HQ_DUNS_Number__c != null & objAccount.GE_HQ_Request_Status__c == 'CMF Approved')
            {
                System.debug('Is Update - DUNS Condition');
                if((objAccount.GE_HQ_DUNS_Number__c != oAcc.GE_HQ_DUNS_Number__c) || (objAccount.GE_HQ_Region_Tier1__c != oAcc.GE_HQ_Region_Tier1__c) ||
                (objAccount.GE_ES_Primary_Industry__c != oAcc.GE_ES_Primary_Industry__c))
                {
                    System.debug('Is Update - Adding to process');
                    accountsToProcess.add(objAccount);
                    AccountIDs.add(objAccount.ID);
                    UserIds.add(objAccount.CreatedById);
                    UserIds.add(objAccount.LastModifiedById);
                    RegionIds.add(objAccount.GE_HQ_Region_Tier1__c);
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
}