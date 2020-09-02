global class BatchProcessRelatedRecordsController implements Database.Batchable<sObject>,Database.Stateful{
    global Id masterHQId = null;
    global Id masterRecordId = null;
    global Id masterMergeId = null;
    global Map<Id, Id> mapChildParent = new Map<Id, Id>();
    global Map<Id, String> errorMap = new Map<Id, String>();
    global Map<Id, SObject> IdToSObjectMap = new Map<Id, SObject>();
    global Map<Id,Related_Modules_Merge_History__c> mapSobjectDetail = new Map<Id,Related_Modules_Merge_History__c>();
    global List<Related_Modules_Merge_History__c> finalDetailToUpdate  = new List<Related_Modules_Merge_History__c>();
    global Set<Id> setRelatedHistoryId = new Set<Id>();
    global Map<Id,String> mapRelatedHistoryId = new Map<Id,String>();
    global List<Account> lstComplianceReady = new List<Account>();
    global Set<Id> setComplianceIds = new Set<Id>();
    global BatchProcessRelatedRecordsController(Id masterMergeId, Id masterHQId, Id masterRecordId, Map<Id, Id> mapChildParent){
        this.masterHQId = masterHQId;
        this.masterRecordId = masterRecordId;
        this.mapChildParent = mapChildParent;
        this.masterMergeId = masterMergeId;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        String strQuery = 'select id, Merge_ID_GE_OG__c, Error_Details_GE_OG__c, Object_ID_GE_OG__c, Object_Type__c,Transaction_Status_GE_OG__c FROM Related_Modules_Merge_History__c where Merge_ID_GE_OG__c=: masterMergeId LIMIT 50000';
        return Database.getQueryLocator(strQuery);
    }

    global void execute(Database.BatchableContext BC, List<Related_Modules_Merge_History__c> scope){
        List<Id> lstAccountIds = new List<Id>();
        List<Id> lstOppIds = new List<Id>();
        List<Id> lstCaseIds = new List<Id>();
        List<Id> lstContractIds = new List<Id>();
        List<Account> lstAccountRecords = new List<Account>();
        List<Case> lstCaseRecords = new List<Case>();
        List<Opportunity> lstOpptyRecords = new List<Opportunity>();
        List<Contract> lstContractRecords = new List<Contract>();
        List<Sobject> finalListToUpdate = new List<SObject>();
   
        for(Related_Modules_Merge_History__c objHistory: scope){
            mapSobjectDetail.put(objHistory.Object_ID_GE_OG__c,objHistory);
            if(objHistory.Object_Type__c == 'Account'){
                lstAccountIds.add(objHistory.Object_ID_GE_OG__c);
            }
            else if(objHistory.Object_Type__c == 'Opportunity'){
                lstOppIds.add(objHistory.Object_ID_GE_OG__c);
            }
            else if(objHistory.Object_Type__c == 'Case'){
                lstCaseIds.add(objHistory.Object_ID_GE_OG__c);
            }
            
            else if(objHistory.Object_Type__c == 'Contract'){                lstContractIds.add(objHistory.Object_ID_GE_OG__c);
            }
        }
        
        if(!lstAccountIds.isEmpty()){
            lstAccountRecords = [select id, name,Member_of_GE_OG__c, Account_Status__c,ParentId, Oil_Gas_Parent_Account__c,Oil_Gas_Parent_Account__r.parentId,
                                    Account_Tier_GEOG__c,Oil_Gas_Parent_Account__r.Account_Tier_GEOG__c,Oil_Gas_Parent_Account__r.Classification__c,Classification__c,
                                    type,Oil_Gas_Parent_Account__r.type
                                    FROM Account
                                    WHERE Id IN:lstAccountIds 
                                    LIMIT 50000];
            //system.debug('acc records '+lstAccountRecords.size());
            for(Account objAcc: lstAccountRecords){
                if(masterHQId != null){
                    objAcc.Member_of_GE_OG__c = masterHQId;
                }
                else{
                    objAcc.Member_of_GE_OG__c = null;
                }
                if(mapChildParent.containsKey(objAcc.id)){
                    system.debug('Contains....');
                    objAcc.ParentId = masterRecordId;    
                }
                if(objAcc.Account_Status__c == 'CC Approved'){
                    objAcc.Oil_Gas_Parent_Account__c = objAcc.Oil_Gas_Parent_Account__c;
                    setComplianceIds.add(objAcc.Oil_Gas_Parent_Account__c);
                    if(objAcc.Oil_Gas_Parent_Account__r.parentId != null){                        setComplianceIds.add(objAcc.Oil_Gas_Parent_Account__r.parentId);
                    }
                    if(masterHQId != null){                        setComplianceIds.add(masterHQId);
                    }
                }
                if(objAcc.Account_Tier_GEOG__c == 'LE'){
                    objAcc.Type= objAcc.Oil_Gas_Parent_Account__r.Type;
                    objAcc.Classification__c = objAcc.Oil_Gas_Parent_Account__r.Classification__c;
                }
                finalListToUpdate.add(objAcc);
            }
        }
        if(!lstOppIds.isEmpty()){
             lstOpptyRecords = [select id, name, Account_member_of_ge_og__c,account_type_ge_og__c
                                FROM Opportunity
                                WHERE Id IN: lstOppIds
                                LIMIT 50000];
            //system.debug('Opp records '+lstOpptyRecords.size());      
            for(Opportunity objOppty: lstOpptyRecords){
                //Added by Megha-R-33373
                if(objOppty.account_type_ge_og__c == 'Internal'){ 
                    {
                        objOppty.Type='Internal to Company';
                    }
                if(masterHQId != null){
                    objOppty.Account_member_of_ge_og__c = masterHQId;
                }
                else{
                    objOppty.Account_member_of_ge_og__c = null;
                }
                
                finalListToUpdate.add(objOppty);
            }
            
        }
        if(!lstCaseIds.isEmpty()){
            lstCaseRecords = [select id,AccountId, Key_Account_Name__c FROM Case LIMIT 50000];
            //system.debug('Case records '+lstCaseRecords.size());
            for(Case objCase: lstCaseRecords){
                objCase.AccountId = masterRecordId;                finalListToUpdate.add(objCase);
            }
        }
        if(!lstContractIds.isEmpty()){
            List<Id> lstRecordTypes = new List<Id>();
            lstRecordTypes.add(Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId());
            lstRecordTypes.add(Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId());
            lstRecordTypes.add(Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Addendum Frame Agreement').getRecordTypeId());
            lstRecordTypes.add(Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Master Frame Agreement').getRecordTypeId());
            
            lstContractRecords = [select id, name, GE_Commercial_Member_Of_GE_OG__c
                                FROM Contract
                                WHERE Id IN:lstContractIds AND RecordTypeId IN: lstRecordTypes
                                LIMIT 50000];
            for(Contract objContract: lstContractRecords){
                if(masterHQId != null){
                    objContract.GE_Commercial_Member_Of_GE_OG__c = masterHQId;
                }
                else{
                    objContract.GE_Commercial_Member_Of_GE_OG__c = null;
                }
                finalListToUpdate.add(objContract);
            }
        }
        system.debug('final list size '+finalListToUpdate.size());
        if(!finalListToUpdate.isEmpty()){
            try{
                GEOG_SkipTriggerFromClass.Var_GEESPopulateSICDesc = True;  
                GEOG_SkipTriggerFromClass.Var_GE_OG_Update_FinanceUpdateStatus  = True;   
                GEOG_SkipTriggerFromClass.Var_GE_OG_AccountTrigger = True; 
                GEOG_SkipTriggerFromClass.Var_GE_OG_InsertTeamMember  = true;
                
                Database.SaveResult[] srList = Database.update(finalListToUpdate, false);
                
                GEOG_SkipTriggerFromClass.Var_GEESPopulateSICDesc = false;  
                GEOG_SkipTriggerFromClass.Var_GE_OG_Update_FinanceUpdateStatus  = false;   
                GEOG_SkipTriggerFromClass.Var_GE_OG_AccountTrigger = false; 
                GEOG_SkipTriggerFromClass.Var_GE_OG_InsertTeamMember  = false;
                Integer index = 0;
                for(Database.SaveResult dsr : srList){
                    // when update is success polpultae transaction_status = success in related modules merege history object                
                if(dsr.isSuccess()){
                    Related_Modules_Merge_History__c objCustomDetail = mapSobjectDetail.get(finalListToUpdate[index].Id);
                    system.debug('detail is '+objCustomDetail.id);
                    objCustomDetail.Transaction_Status_GE_OG__c = 'Success';
                    finalDetailToUpdate.add(objCustomDetail);
                    mapRelatedHistoryId.put(objCustomDetail.id,objCustomDetail.Transaction_Status_GE_OG__c);
                    IdToSObjectMap.put(finalListToUpdate[index].Id, finalListToUpdate[index]);
                }
                else{
                    String errMsg = dsr.getErrors()[0].getMessage();
                    errorMap.put(finalListToUpdate[index].Id, errMsg);
                    system.debug('from execute... '+errorMap.get(finalListToUpdate[index].Id));
                    Related_Modules_Merge_History__c objCustomDetail = mapSobjectDetail.get(finalListToUpdate[index].Id);
                    objCustomDetail.Transaction_Status_GE_OG__c = 'Error';
                    objCustomDetail.Error_Details_GE_OG__c = errMsg;
                    finalDetailToUpdate.add(objCustomDetail);
                    mapRelatedHistoryId.put(objCustomDetail.id,objCustomDetail.Transaction_Status_GE_OG__c);
                    IdToSObjectMap.put(finalListToUpdate[index].Id, finalListToUpdate[index]);
                }
    
     // transaction status=success is done here               
                    index++;
                }
                
            }
                
            catch(Exception e){
                system.debug('Error in updating the related records.... ');
            }
        }
    }
	}
    
    global void finish(Database.BatchableContext BC){
        system.debug('Finish batch');
        //Send an email to the User after your batch completes 
        String Recordlink = URL.getSalesforceBaseUrl().toExternalForm()+'/'+masterMergeId;
        system.debug('map contents size '+mapRelatedHistoryId.size());
        List<Related_Modules_Merge_History__c> lstRelatedUpdate = [select id,Transaction_Status_GE_OG__c,Object_ID_GE_OG__c,Error_Details_GE_OG__c FROM Related_Modules_Merge_History__c
                                                                    WHERE id IN: mapRelatedHistoryId.keySet() LIMIT 50000];
        for(Related_Modules_Merge_History__c objRel: lstRelatedUpdate){
            objRel.Transaction_Status_GE_OG__c = mapRelatedHistoryId.get(objRel.id);
            if(objRel.Transaction_Status_GE_OG__c == 'Error' ){
                system.debug('related obj in finish '+objRel.Object_ID_GE_OG__c);
                system.debug('from map '+errorMap.get(objRel.Object_ID_GE_OG__c));
                objRel.Error_Details_GE_OG__c = errorMap.get(objRel.Object_ID_GE_OG__c);
            }
        }
        
        if(!lstRelatedUpdate.isEmpty()){
            if(lstRelatedUpdate.size() < 10000){
                try{
                    update lstRelatedUpdate;
                }
                catch(Exception e){
                    system.debug('Error in updating Related Merge History.');
                }
            }
            else{
                List<List<SObject>> listOfList = UtilityListSplit.spliceListBySize(lstRelatedUpdate,9000);
                List<Id> lstJobIds = new List<Id>();
                try{
                    for(List<SObject> lstSlice: listOfList){
                        Id queueJobId = System.enqueueJob(new AsyncInsertRelatedRecords(lstSlice,'Update'));
                        lstJobIds.add(queueJobId);
                   }
                }
                catch(Exception e){
                    system.debug('Exception while updating related records');
                }
                
            }
        }
        if(!setComplianceIds.isEmpty()){
            lstComplianceReady = [SELECT id,Compliance_Ready__c,name
                                    FROM Account
                                    WHERE id IN: setComplianceIds
                                    LIMIT 50000];
            if(!lstComplianceReady.isEmpty()){
                for(Account obj: lstComplianceReady){
                    if(!obj.Compliance_Ready__c){
                        obj.Compliance_Ready__c = TRUE;
                    }
                }
                try{
                    update lstComplianceReady;
                }
                catch(Exception e){
                    system.debug('Exception while updating Compliance Ready');
                }
            }
        }
       AsyncApexJob a = [SELECT id, ApexClassId,
                       JobItemsProcessed, TotalJobItems,
                       NumberOfErrors, CreatedBy.Email
                       FROM AsyncApexJob
                       WHERE id = :BC.getJobId()];
            String body = 'Your batch job to update related records '
             + 'has finished. \n' 
             + 'There were '
             + errorMap.size()
             + ' errors. Please find the error list attached to the email.\n'
             +'Link to Master Merge History: '+Recordlink;
 
            // Creating the CSV file
            String finalstr = 'Id, Error \n';
            String subject =  'Account Merge - Batch Error List';
            String attName = 'Update Errors.csv';
            for(Id id  : errorMap.keySet()){
                string err = errorMap.get(id);
                string recordString = '"'+id+'","'+err+'"\n';
                finalstr = finalstr +recordString;
            } 
 
            // Define the email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
 
            // Create the email attachment  
            if(!errorMap.isEmpty()){  
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(attName);
                efa.setBody(Blob.valueOf(finalstr));
                email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            }
            // Sets the paramaters of the email
            email.setSubject( subject );
            List<String> idList = new List<String>();
            List<String> mailToAddresses = new List<String>();
            
            Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE DeveloperName = 'Merge_Commercial_Account_Users'];
            for (GroupMember gm : g.groupMembers) {
                idList.add(gm.userOrGroupId);
            }
            List<User> usr = [SELECT id,email FROM user WHERE id IN :idList LIMIT 50000];
            for(User u : usr) {
                mailToAddresses.add(u.email);
            }
            mailToAddresses.add(a.CreatedBy.Email);
            system.debug('email addresses'+mailToAddresses);
            email.setToAddresses(mailToAddresses);
            //email.setToAddresses( new String[] {a.CreatedBy.Email} );
            email.setPlainTextBody( body );
            
 
            // Sends the email
            Messaging.SendEmailResult [] r = 
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
            
    }

}