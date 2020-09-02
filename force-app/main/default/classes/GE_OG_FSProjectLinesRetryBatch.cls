global class GE_OG_FSProjectLinesRetryBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String status = 'SUCCESS';
        Id SSProject = '0123F000000gYAl';
        String LineType = 'Tools';
        return Database.getQueryLocator(
            'SELECT ID from GE_OG_FS_Project_Detail__c  WHERE SSRetryCriteria__c = true '  
        );
    }
    
    global void execute(Database.BatchableContext bc, List<GE_OG_FS_Project_Detail__c> ProjLineList){
           Set<Id> recordIdSet = new Set<Id>() ;
           for(GE_OG_FS_Project_Detail__c record : ProjLineList){
                recordIdSet.add(record.Id) ;
           }
                      
            String dmzResponse = GE_OG_PCIntegrationUtility.getDMZAccessToken();
            //Invoke SOA endpoint
            GE_OG_SS_FSProjectDetail_Wrapper outInstance= new GE_OG_SS_FSProjectDetail_Wrapper();
            System.debug('The DMZ response is :' +dmzResponse);
            outInstance.submitFSProjectDetailUpdatesToOracleERP(recordIdSet,dmzResponse); 
    }
    global void finish(Database.BatchableContext bc){
    }    
    
}