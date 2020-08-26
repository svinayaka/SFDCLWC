trigger GEHQInsertRequestNotes on Account (after insert,before update) {
//Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GEHQInsertRequestNotes');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
       
        return;  
    }
    else{
    Set<Id> sendCommentsToCMF = new Set<Id>();
    Set <Id> AccIds = new Set<Id>();
    List<Account_Request_Note__c> AccList=new List<Account_Request_Note__c>();
    
    Schema.DescribeSObjectResult r = Account.sObjectType.getDescribe();
    Map<String,Schema.RecordTypeInfo> rtMapByName = r.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName =  rtMapByName.get('New Customer Request');
    Schema.RecordTypeInfo rtByName1 =  rtMapByName.get('New Request - Read Only');
    Schema.RecordTypeInfo rtByName2 =  rtMapByName.get('New Customer Request - Step 2');
    Schema.RecordTypeInfo rtByName3 =  rtMapByName.get('New Customer Request - Step 3');
    Schema.RecordTypeInfo rtByName4 =  rtMapByName.get('New Customer Request - Step 3 Read Only');
    Schema.RecordTypeInfo rtByName5 =  rtMapByName.get('New Customer Request with KYC');           
    Id rt=rtByName.getRecordTypeId();
    Id rt1=rtByName1.getRecordTypeId();
    Id rt2=rtByName2.getRecordTypeId();
    Id rt3=rtByName3.getRecordTypeId();
    Id rt4=rtByName4.getRecordTypeId();   
    Id rt5=rtByName5.getRecordTypeId();          
    

    for(Account Acc:trigger.new){
        if(trigger.isInsert && (Acc.RecordTypeId == rt || Acc.RecordTypeId == rt1 || Acc.RecordTypeId == rt2 || Acc.RecordTypeId == rt3 || Acc.RecordTypeId == rt4 || Acc.RecordTypeId == rt5) && Acc.GE_HQ_Nts_Comments__c != null){
            System.debug('****Insert****');
            AccList.add(new Account_Request_Note__c(Account__c=Acc.Id,Comments__c=Acc.GE_HQ_Nts_Comments__c,Type__c='User'));
            /*
            if(Acc.GE_HQ_Request_Status__c == 'Pending User Review' || Acc.GE_HQ_Request_Status__c == 'Pending CMF')  
                sendCommentsToCMF.add(Acc.id);
            */                  
        }
        else if(Trigger.isUpdate && (Acc.RecordTypeId == rt || Acc.RecordTypeId == rt1 || Acc.RecordTypeId == rt2 || Acc.RecordTypeId == rt3 || Acc.RecordTypeId == rt4 || Acc.RecordTypeId == rt5)  && Acc.GE_HQ_Nts_Comments__c != null){
            System.debug('****Update****');
            if(trigger.oldMap.get(Acc.Id).GE_HQ_Nts_Comments__c != trigger.newMap.get(Acc.Id).GE_HQ_Nts_Comments__c){
               AccList.add(new Account_Request_Note__c(Account__c=Acc.Id,Comments__c=Acc.GE_HQ_Nts_Comments__c,Type__c='User'));
                
                //if(Acc.GE_HQ_Request_Status__c == 'Pending User Review' || Acc.GE_HQ_Request_Status__c == 'Pending CMF')  
                if(Acc.GE_HQ_Request_Status__c == 'Pending User Review')
                    sendCommentsToCMF.add(Acc.id); 
            }                              
        }
    }

    if(AccList.size()>0)
        insert AccList;
    if( sendCommentsToCMF.size()>0 && !Test.isRunningTest() ){ 
        for(Id accId: sendCommentsToCMF)
            GE_HQ_ESKYC_CMF_Acc_Int_Wrapper.NewAccountRequest(accId);
    }
}                           
}