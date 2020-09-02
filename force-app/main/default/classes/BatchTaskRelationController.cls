global class BatchTaskRelationController implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        String strDateTime = 'TODAY';
        String strQuery = 'select id, RelationId, TaskId FROM TaskRelation where CreatedDate='+strDateTime;
        return Database.getQueryLocator(strQuery);
    }
    
    global void execute(Database.BatchableContext BC, List<TaskRelation> scope){
        List<Id> lstContactIds = new List<Id>();
        for(TaskRelation objRel: scope){
            String strRelId = String.valueOf(objRel.RelationId);
            if(strRelId.startsWith('003')){
                lstContactIds.add(objRel.RelationId);
            }
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
                system.debug('Exception while updating Last ENGAGEMENT Date '+e.getMessage());
            }
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}