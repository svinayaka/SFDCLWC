global class Batch_Oppty_CPR_Checkboxsync implements Database.Batchable<sObject>{
    global final String Query;
    global final String Entity;
    global final String Field;
    global final String Value;
    Map<Id, String> errorMap    = new Map<Id, String>();  
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id,has_commercial_primary_resource_ge_og__c, isclosed from Opportunity where id NOT IN (Select Opportunityid from opportunityTeamMember where teammemberrole IN (\'Commercial Primary Resource\')) and has_commercial_primary_resource_ge_og__c = true and isclosed=false');
    }
    
    global void execute(Database.BatchableContext BC, 
                        List<sObject > scope){
                            List<Opportunity> upatelstoppty = new List<Opportunity>();
                            system.debug('scope==='+scope);
                            for(sObject s : scope){
                                Opportunity oppty = (Opportunity)s;
                                system.debug('==== '+oppty);
                                if(oppty.has_commercial_primary_resource_ge_og__c ){
                                    oppty.has_commercial_primary_resource_ge_og__c = false;
                                    upatelstoppty.add(oppty);
                                }
                            }
                            try{
                                Database.SaveResult[] updateResult =  Database.update(upatelstoppty, false);
                                integer index=0;
                                for (Database.SaveResult r : updateResult)
                                {
                                    if (!r.isSuccess())
                                    {
                                        String errMsg = r.getErrors()[0].getMessage();
                                        errorMap.put(upatelstoppty[index].Id, errMsg);
                                    }
                                    index++;
                                }
                            }catch(Exception exc){
                                
                            }
                            
                        }
    
    global void finish(Database.BatchableContext BC){
        // Get the ID of the AsyncApexJob representing this batch job
        // from Database.BatchableContext.
        // Query the AsyncApexJob object to retrieve the current job's information.
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
                          TotalJobItems, CreatedBy.Email
                          FROM AsyncApexJob WHERE Id =
                          :BC.getJobId()];
        // Send an email to the Apex job's submitter notifying of job completion.
        String attName = 'CPRBatch_Errors.csv';
        String finalstr = 'Id, Error \n';
        for(Id id  : errorMap.keySet()){
            string err = errorMap.get(id);
            string recordString = '"'+id+'","'+err+'"\n';
            finalstr = finalstr +recordString;
        } 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
            mail.setToAddresses(toAddresses);
        mail.setSubject('CPR Batch Completed ' + a.Status);
        mail.setPlainTextBody
            ('The batch Apex job processed ' + a.TotalJobItems +
             ' batches with '+ errorMap.size() + ' failures.');
        if(!errorMap.isEmpty()){  
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(attName);
            efa.setBody(Blob.valueOf(finalstr));
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        }
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
    
}