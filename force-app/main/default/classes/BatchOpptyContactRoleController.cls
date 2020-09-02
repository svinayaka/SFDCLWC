global class BatchOpptyContactRoleController implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        String strDateTime = 'TODAY';
        String strQuery = 'select id, ContactId, OpportunityId, Role FROM OpportunityContactRole where CreatedDate='+strDateTime;
        return Database.getQueryLocator(strQuery);
    }
    
    global void execute(Database.BatchableContext BC, List<OpportunityContactRole> scope){
        List<Id> lstContactIds = new List<Id>();
        for(OpportunityContactRole objRole: scope){
            lstContactIds.add(objRole.ContactId);
        }  
        List<Contact> lstContacts = new List<Contact>();
        lstContacts = [SELECT Id,name, Last_Customer_Engagement_Date__c
                        FROM Contact 
                        WHERE Id IN: lstContactIds 
                        LIMIT 50000]; 
        for(Contact objCon: lstContacts){
            objCon.Last_Customer_Engagement_Date__c = system.today();
        } 
        if(!lstContacts.isEmpty()){
            try{
                update lstContacts;
            }
            catch(Exception e){
                system.debug('Exception while updating Last Oppty Date '+e.getMessage());
            }
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}