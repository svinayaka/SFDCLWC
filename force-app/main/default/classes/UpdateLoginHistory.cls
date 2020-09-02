global class UpdateLoginHistory implements Database.Batchable<sObject> 
    {
    public String Query;
    global Database.QueryLocator start(Database.BatchableContext BC)
        { 
        System.debug('Start Execution'); 
        Return Database.getQueryLocator(Query);
        }
    
    global void execute(Database.BatchableContext BC,List< LoginHistory> objloginHistory)
        {
        system.debug('execute execute>>-> '+objloginHistory.size());

        GE_HQ_Update_Login_History UpdateLoginHistory = new GE_HQ_Update_Login_History();
        
        List<GE_HQ_Login_History__c> lstCustLoginHis = new List<GE_HQ_Login_History__c>();
        
        if(objloginHistory!=null && objloginHistory.size()>0)
            {
            for(Integer i = 0; i<objloginHistory.size(); i++)
                {
        
                GE_HQ_Login_History__c objCustomLoginHistory = new GE_HQ_Login_History__c();
                
                objCustomLoginHistory.GE_HQ_Login_History_Id__c = objLoginHistory.get(i).Id;
                objCustomLoginHistory.GE_HQ_UserID__c = objLoginHistory.get(i).UserId;
                objCustomLoginHistory.GE_HQ_LoginTime__c = objLoginHistory.get(i).LoginTime;
                objCustomLoginHistory.GE_HQ_LoginType__c = objLoginHistory.get(i).LoginType;
                objCustomLoginHistory.GE_HQ_SourceIp__c = objLoginHistory.get(i).SourceIp;
                objCustomLoginHistory.GE_HQ_LoginURL__c = objLoginHistory.get(i).LoginUrl;
                objCustomLoginHistory.GE_HQ_Browser__c = objLoginHistory.get(i).Browser;
                objCustomLoginHistory.GE_HQ_Platform__c = objLoginHistory.get(i).Platform;
                objCustomLoginHistory.GE_HQ_Status__c = objLoginHistory.get(i).Status;
                objCustomLoginHistory.GE_HQ_Application__c = objLoginHistory.get(i).Application;
                objCustomLoginHistory.GE_HQ_ClientVersion__c = objLoginHistory.get(i).ClientVersion;
                objCustomLoginHistory.GE_HQ_ApiType__c = objLoginHistory.get(i).ApiType;
                objCustomLoginHistory.GE_HQ_APIVersion__c = objLoginHistory.get(i).ApiVersion;
                
                System.debug(objCustomLoginHistory+'*************');
                lstCustLoginHis.add(objCustomLoginHistory);
                }
            if(lstCustLoginHis.size() > 0)
                {
                try
                    {
                    upsert lstCustLoginHis GE_HQ_Login_History_Id__c;
                    }
                catch(Exception e)
                    {
                    system.debug('Exception for Insert - '+e);
                    }
                }
            }
        }            
    
    global void finish(Database.BatchableContext BC)
        {
    
       // Query the AsyncApexJob object to retrieve the current job's information. 
    
       AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
          TotalJobItems, CreatedBy.Id
          FROM AsyncApexJob WHERE Id =
          :BC.getJobId()];
       // Send an email to the Apex job's submitter notifying of job completion. 
        
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       mail.setTargetObjectId(a.CreatedBy.Id);
       mail.setSaveAsActivity(false);
       mail.setSubject('Update Login History to Custom ' + a.Status);
       mail.setPlainTextBody
           ('The batch Apex job processed ' + a.TotalJobItems +
       ' batches with '+ a.NumberOfErrors + ' failures.');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        }
    }