global class privatereportsdelete implements Database.Batchable<sObject>{
    
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        
        String query = 'SELECT Id FROM Private_Reports__c';
        
        return Database.getQueryLocator(query);  
    }
    
    global void execute(Database.BatchableContext BC, List<sobject> scope){
        
        delete scope;
             
}
        
        
        
    global void finish(Database.BatchableContext BC){

privatereportsinsert pvtreports =new privatereportsinsert();
database.executeBatch(pvtreports);
        
    }
}