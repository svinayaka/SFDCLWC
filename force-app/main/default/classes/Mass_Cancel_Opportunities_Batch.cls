global class Mass_Cancel_Opportunities_Batch implements Database.Batchable<sObject>{
    
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        date duedate ;
        if (Test.isRunningTest()) { 
            duedate  = System.today(); 
        } else { 
            duedate = Date.today().addDays(-1); 
        }
        Integer d = duedate.day();
        Integer mo = duedate.month();
        Integer yr = duedate.year();
        
        Datetime GMTDate = Datetime.newInstanceGmt(yr,mo,d,0,0,0);
        Datetime GMTDate2 = Datetime.newInstanceGmt(yr,mo,d,11,59,59);
        
        Id recordtypeId =Schema.SObjectType.Upload_Request_ge_og__c.getRecordTypeInfosByDeveloperName().get('Opportunity_Upload_Request').getRecordTypeId();
        
        String query = 'SELECT Id, CreatedDate,(Select Id,Name,ParentId from attachments),Name FROM Upload_Request_ge_og__c where CreatedDate >=: GMTDate and  CreatedDate <=: GMTDate2 and RecordTypeId=:recordtypeId';
        //String query = 'SELECT Id, CreatedDate,(Select Id,Name,ParentId from attachments),Name FROM Upload_Request_ge_og__c where Id=\'a5t3F0000000RRF\'';
        
        return Database.getQueryLocator(query);  
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> UploadRequest){
        List<Upload_Request_ge_og__c>  urlist = UploadRequest; 
        List<Id> urId = new List<Id>();
        for(Upload_Request_ge_og__c ur : urlist ){
            urId.add(ur.Id); 
        }
        List<Attachment> attList = [SELECT Id, ParentId, Name, BodyLength, Body FROM Attachment where ParentId IN :urId];
        List<Mass_Cancel_Opportunities_ge_og__c> masscancelOpty = Mass_Cancel_Batch_Helper.massCancelOptyRecords(attList);
        
        Database.SaveResult[]  SaveResultListmasscancelOpty;
        SaveResultListmasscancelOpty = Database.insert(masscancelOpty, false);    }
    
    global void finish(Database.BatchableContext BC){
        Opportuity_Cancel_Batch  optycancelbatch = new Opportuity_Cancel_Batch();
        database.executebatch(optycancelbatch,20); 
        
    }
}