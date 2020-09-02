global class Opportuity_Cancel_Batch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Name, OpportunityId_ge_og__c, Upload_Request_ge_og__c, Processed_ge_og__c, Uploaded_File_Name_ge_og__c, Opportunity_Win_Loss_Comments_ge_og__c, Success_Error_Message_ge_og__c FROM Mass_Cancel_Opportunities_ge_og__c where Processed_ge_og__c = false';
        return Database.getQueryLocator(query);  
    }
    
    global void execute(Database.BatchableContext BC, List<Mass_Cancel_Opportunities_ge_og__c> masscancel){
        List<Mass_Cancel_Opportunities_ge_og__c> masscancelList = Opportuity_Cancel_Batch_Helper.processOptyCancellation(masscancel);
        database.update(masscancelList);
        
    }
    
    global void finish(Database.BatchableContext BC){
        Process_masscancelObject_Records.buildCsvFile();
    }
    
}