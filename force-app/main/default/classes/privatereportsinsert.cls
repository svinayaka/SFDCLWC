global class privatereportsinsert implements Database.Batchable<sObject>{
    
    
    global Database.QueryLocator start(Database.BatchableContext BC){
       
        String query = 'SELECT Id,Name,CreatedById,CreatedBy.name,CreatedDate,DeveloperName,FolderName,Format,LastModifiedById,LastModifiedBy.name,LastModifiedDate FROM Report USING SCOPE allPrivate';
         if(Test.isRunningTest()){
            query = 'SELECT Id,Name,CreatedById,CreatedBy.name,CreatedDate,DeveloperName,FolderName,Format,LastModifiedById,LastModifiedBy.name,LastModifiedDate FROM Report USING SCOPE allPrivate limit 10';
         
        }
        return Database.getQueryLocator(query);  
    }
    
    global void execute(Database.BatchableContext BC, List<Report> scope)
    {
        
        List<Private_Reports__c> tobeinserted = new List<Private_Reports__c>();
        for(Report pr : scope)
        {
            
            Private_Reports__c pvr = new Private_Reports__c();
            pvr.Report_ID__c=pr.id;
            pvr.Name=pr.name;
            pvr.Report_Created_By__c=pr.CreatedById;
            pvr.Report_Created_date__c=pr.CreatedDate;
            pvr.Report_Developer_Name__c=pr.DeveloperName; 
            pvr.Report_Folder_Name__c=pr.FolderName;
            pvr.Report_Format__c=pr.Format; 
            pvr.Report_Modified_By__c=pr.LastModifiedById;
            pvr.Report_Modified_date__c=pr.LastModifiedDate;
            
            tobeinserted.add(pvr);
            
        }
        
        
        Database.SaveResult[]  insertprivatereports;
        insertprivatereports = Database.insert(tobeinserted,false);    }
    
    global void finish(Database.BatchableContext BC){
        
        
    }
}