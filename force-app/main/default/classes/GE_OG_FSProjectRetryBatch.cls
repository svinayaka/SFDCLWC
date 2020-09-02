global class GE_OG_FSProjectRetryBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String status = 'SUCCESS';
        Id SSProject = '012120000019EOx';
        return Database.getQueryLocator(
            'SELECT ID from GE_SS_Project__c  WHERE SSRetryCriteria__c = true'  
        );
    }
    
    global void execute(Database.BatchableContext bc, List<GE_SS_Project__c> ProjList){
           Set<Id> recordIdSet = new Set<Id>() ;
           for(GE_SS_Project__c record : ProjList){
                recordIdSet.add(record.Id) ;
           }
                      
            String dmzResponse = GE_OG_PCIntegrationUtility.getDMZAccessToken();
            //Invoke SOA endpoint
            GE_OG_SS_FSProject_Wrapper outInstance= new GE_OG_SS_FSProject_Wrapper();
            System.debug('The DMZ response is :' +dmzResponse);
            outInstance.submitFSProjectToOracle(recordIdSet,dmzResponse); 
    }
    global void finish(Database.BatchableContext bc){
        GE_OG_FSProjectLinesRetryBatch woBatch= new GE_OG_FSProjectLinesRetryBatch(); 
        database.executeBatch(woBatch, 20); 
    }    
    
}