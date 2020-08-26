trigger GE_HQ_Insert_AccountModificationNotes on Account_Request__c (after Insert, before Update) {
    Set<Id> accountModificationIds = new set<Id>();
    Map<Id, Account_Request__c> sendCommentsToCMF = new Map<Id, Account_Request__c>();
    List<Account_Modification_Note__c> AccModNoteList=new List<Account_Modification_Note__c>();
    AccountIntegrationWrapper ModifyAccReq;
    for(Account_Request__c Acc:trigger.new){
        if(trigger.isInsert && Acc.GE_HQ_Nts_Comments__c != null){
           if(!Test.isRunningTest()){ 
            System.debug('****Inserting Account Modification Request****');
            AccModNoteList.add(new Account_Modification_Note__c(Account_Request__c = Acc.Id,Comments__c = Acc.GE_HQ_Nts_Comments__c,Type__c = 'User'));
            /*
            if(Acc.GE_HQ_Request_Status__c == 'Pending User Review' || Acc.GE_HQ_Request_Status__c == 'Pending CMF')  
                sendCommentsToCMF.put(Acc.id, Acc);  
            */                
        }}
        else if(Trigger.isUpdate && Acc.GE_HQ_Nts_Comments__c != null){
            System.debug('****Updating Account Modification Request****');
            if(trigger.oldMap.get(Acc.Id).GE_HQ_Nts_Comments__c != trigger.newMap.get(Acc.Id).GE_HQ_Nts_Comments__c){
               AccModNoteList.add(new Account_Modification_Note__c(Account_Request__c = Acc.Id,Comments__c = Acc.GE_HQ_Nts_Comments__c,Type__c = 'User'));
                
                //if(Acc.GE_HQ_Request_Status__c == 'Pending User Review' || Acc.GE_HQ_Request_Status__c == 'Pending CMF')  
                    if(Acc.GE_HQ_Request_Status__c == 'Pending User Review')                
                        sendCommentsToCMF.put(Acc.id, Acc); 
                        System.debug('##########'+ sendCommentsToCMF);
            }                              
        }
    }

    if(AccModNoteList.size()>0)
        insert AccModNoteList;
    if( sendCommentsToCMF.size()>0){ // && !Test.isRunningTest() 
        System.debug('^^^^^^^^^');
        //ModifyAccReq=new AccountIntegrationWrapper();
        Account_Request__c str;
        String ids;
        for(Account_Request__c accId: sendCommentsToCMF.values()){
            //str = new Account_Request__c();
            ids=accid.id;
            System.debug('===========>');
            if(!Test.isRunningTest()){
            AccountIntegrationWrapper.AccountModifyRequest(ids);}
        }            
    }                    
}