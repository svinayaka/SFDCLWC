public class GEOG_Mearge_Commerical_AccountController{
@InvocableMethod (label='Merge Accounts')
    public static List<String> mergeAct(List<String> lstMasterSlaveIds){
        system.debug('master & slave accounts are ---->>'+lstMasterSlaveIds);
        List<String> lstIds = lstMasterSlaveIds[0].split(',');
        Map<id, Id> mapChildParent = new Map<Id,Id>();
        String masterAcctId = lstIds[0];
        String slvAcctId = lstIds[1];
        Id masterHQId = null;
        Savepoint sp = Database.setSavepoint();
        String errorMessage = '';
        List<String> lstErrors = new List<String>();
        List<Related_Modules_Merge_History__c> lstRelatedHistory = new List<Related_Modules_Merge_History__c>();
        Account masterRecord = [select id, name, Member_of_GE_OG__c, Account_Tier_GEOG__c,Region_GEOG__c,Country_GEOG__c from Account where id=: masterAcctId LIMIT 1];
        List<Account> slaveLst = [select id, name, Member_of_GE_OG__c, Account_Tier_GEOG__c,Classification__c,Country_GEOG__c,Region_GEOG__c,Type
                                    from Account where id=: slvAcctId LIMIT 1];
        List<Account> lstParentChild = [select id, name, Member_of_GE_OG__c, Account_Tier_GEOG__c, parentId from Account 
                                        where parentId=: slvAcctId LIMIT 50000];
                                        
        User loggedInUser=new User();
        loggedInUser =[Select Id,Name,Email,Disable_validations_for_MERGE__c,GE_OG_Commercial_Excellence_User__c 
                        from User where Id=:userinfo.getuserId()];
                        
        if(loggedInUser.Disable_validations_for_MERGE__c != true && !(Test.isRunningTest())){
            errorMessage = 'Please log in as Merge User to proceed with the merge.';
            lstErrors.add(errorMessage);
            system.debug('Error returned '+lstErrors);
            return lstErrors;
        }
        
        if(masterRecord.Account_Tier_GEOG__c != slaveLst[0].Account_Tier_GEOG__c){
            errorMessage = 'Both master and slave should have same account tier values.';
            lstErrors.add(errorMessage);
            return lstErrors;
        }
        if(masterRecord.Account_Tier_GEOG__c == 'LE' || slaveLst[0].Account_Tier_GEOG__c == 'LE'){
            errorMessage = 'Commercial Account merge can not performed for Legal Entities.';
            lstErrors.add(errorMessage);
            return lstErrors;
        }
        if(masterRecord.Country_GEOG__c != slaveLst[0].Country_GEOG__c){
            errorMessage = 'Both master and slave should have same country account to perform merge request.';
            lstErrors.add(errorMessage);
            return lstErrors;
        }
        
        String batchClassName = 'BatchProcessRelatedRecordsController';
        List<AsyncApexJob> batchJob = new List<AsyncApexJob>();
        batchJob = [SELECT Id, MethodName, Status, CreatedDate FROM AsyncApexJob where ApexClassId in (SELECT Id FROM ApexClass where name= :batchClassName) 
                    and jobtype = 'BatchApex' and status ='Processing'];
        if(batchJob.isEmpty()){
        
            Commercial_Account_Merge_History__c objMasterHistory = new Commercial_Account_Merge_History__c();
            objMasterHistory.Master_Account_Id__c= masterRecord.id;
            objMasterHistory.Master_Account_Name__c= masterRecord.Name;
            objMasterHistory.Slave_Account_Name__c = slaveLst[0].Name;
            objMasterHistory.Slave_Account_Name__c = slaveLst[0].Name;
            objMasterHistory.Slave_Account_ID_GE_OG__c = slaveLst[0].id;
            objMasterHistory.Merge_Performed_By__c = UserInfo.getUserId();
            objMasterHistory.Slave_Account_Classification__c = slaveLst[0].Classification__c;
            objMasterHistory.Slave_Account_Country__c = slaveLst[0].Country_GEOG__c;
            objMasterHistory.Slave_Account_Member_of__c = slaveLst[0].Member_of_GE_OG__c;
            objMasterHistory.Slave_Account_Region__c = slaveLst[0].Region_GEOG__c;
            objMasterHistory.Slave_Account_Type__c = slaveLst[0].Type;
            //added by megha-R-33150
            objMasterHistory.Master_Account_Region__c= masterRecord.Region_GEOG__c;
            
            
            try{
                insert objMasterHistory;
            }
            catch(Exception e){
                //errorMessage = e.getMessage();
                lstErrors.add(e.getMessage());
                return lstErrors;
            }
            
            /**************Check for duplicate shared contacts from master and slave ***********/
            List<AccountContactRelation> lstDeleteDuplicates = new List<AccountContactRelation>();
            List<AccountContactRelation> lstAccConRel = [Select id, AccountId, ContactId, isDirect  
                                                            From AccountContactRelation
                                                            WHERE AccountId =: masterAcctId LIMIT 50000
                                                        ];
                                            
            List<AccountContactRelation> lstAccConRelSlave = [Select id, AccountId, ContactId,isDirect  
                                                            From AccountContactRelation
                                                            WHERE AccountId =: slaveLst[0].Id LIMIT 50000
                                                            ];                                      
            Map<Id, AccountContactRelation> masterRelationMap = new Map<Id, AccountContactRelation>();
            for(AccountContactRelation masterRel: lstAccConRel){
                masterRelationMap.put(masterRel.ContactId,masterRel);
            }
            for(AccountContactRelation ACShas: lstAccConRelSlave){
                    if(masterRelationMap.get(ACShas.ContactId) != null){
                        if(ACShas.isDirect == true){
                            lstDeleteDuplicates.add(masterRelationMap.get(ACShas.ContactId));
                        }
                        else{
                            lstDeleteDuplicates.add(ACShas);
                        }
                    }
                
            }
            if(!lstDeleteDuplicates.isEmpty()){
                try{
                    delete lstDeleteDuplicates;
                }
                catch(Exception e){
                    objMasterHistory.Merge_Status__c = 'Failed';
                    objMasterHistory.Merge_Error__c = e.getMessage();
                    update objMasterHistory;
                    
                }
            }
            /**************End of Check for duplicate shared contacts from master and slave ***********/
            
            
            if(masterRecord.Account_Tier_GEOG__c == 'Global'){
                masterHQId = masterRecord.id;
            }
            else if(masterRecord.Member_of_GE_OG__c != null){
                masterHQId = masterRecord.Member_of_GE_OG__c;
            }
            
            if(!lstParentChild.isEmpty()){
                for(Account obj: lstParentChild){
                    if(obj.parentId== slvAcctId){
                        mapChildParent.put(obj.id,masterAcctId);
                    }
                }
            }
            
            system.debug('map contents..... '+mapChildParent);
            Integer i = 0;
            while(i < 10){
            Database.MergeResult[] results = Database.merge(masterRecord, slaveLst, false);
                for(Database.MergeResult res : results) {
                    if (res.isSuccess()) {
                        i= 10;
                        system.debug('merge successful !!!!!!');
                        objMasterHistory.Merge_Status__c = 'Success';
                        update objMasterHistory;
                        List<Id> mergedIds = res.getMergedRecordIds();
                        List<Id> lstRelatedIds = res.getUpdatedRelatedIds();
                        for(Id recId: lstRelatedIds){
                            Related_Modules_Merge_History__c objChildMergeHistory = new Related_Modules_Merge_History__c();
                            objChildMergeHistory.Merge_ID_GE_OG__c = objMasterHistory.id;
                            objChildMergeHistory.Object_Type__c = recId.getsobjecttype().getDescribe().getName();
                            objChildMergeHistory.Object_ID_GE_OG__c = recId;
                            lstRelatedHistory.add(objChildMergeHistory);
                        }
                        if(!lstRelatedHistory.isEmpty()){
                            system.debug('total list size... '+lstRelatedHistory.size());
                            if(lstRelatedHistory.size() < 10000){
                                try{
                                    insert lstRelatedHistory;
                                    if(objMasterHistory.id != null){
                                        BatchProcessRelatedRecordsController bc = new BatchProcessRelatedRecordsController(objMasterHistory.id,masterHQId,masterAcctId,mapChildParent); 
                                        Database.executeBatch(bc,50);
                                    }
                                }
                                catch(Exception e){
                                    //errorMessage = e.getMessage();
                                    lstErrors.add(e.getMessage());
                                    return lstErrors;
                                }
                            }
                            if(lstRelatedHistory.size() >= 10000 || Test.isRunningTest()){
                                List<List<SObject>> listOfList = UtilityListSplit.spliceListBySize(lstRelatedHistory,9000);
                                List<Id> lstJobIds = new List<Id>();
                                try{
                                    for(List<SObject> lstSlice: listOfList){
                                        Id queueJobId = System.enqueueJob(new AsyncInsertRelatedRecords(lstSlice,'Insert'));
                                        lstJobIds.add(queueJobId);
                                    }
                                    DateTime nowPlusFive = system.now().addMinutes(5);
                                    String day = string.valueOf(nowPlusFive.day());
                                    String month = string.valueOf(nowPlusFive.month());
                                    String hour = string.valueOf(nowPlusFive.hour());
                                    String minute = string.valueOf(nowPlusFive.minute() );
                                    String second = string.valueOf(nowPlusFive.second());
                                    String year = string.valueOf(nowPlusFive.year());
                                    String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
                                    System.schedule('Merge Job '+system.now(), strSchedule, new MergeBatchScheduler(objMasterHistory.id,masterHQId,masterAcctId,mapChildParent));
                                       
                                }
                                catch(Exception e){
                                        system.debug('Exception while invoking Queueable/ Scheduler');
                                        //errorMessage = e.getMessage();
                                        lstErrors.add(e.getMessage());
                                        return lstErrors;
                                }
                                
                            }
                        }
                        
                        
                    }
                
                    if (!res.isSuccess() || Test.isRunningTest()){
                        if(!Test.isRunningTest() && res.getErrors()[0].getMessage().contains('unable to obtain exclusive access')){
                            i++;
                        }
                        else{
                            i = 10;
                            objMasterHistory.Merge_Status__c = 'Failed';
                            if(!Test.isRunningTest()){
                                objMasterHistory.Merge_Error__c = res.getErrors()[0].getMessage();
                            }
                            try{
                                update objMasterHistory;
                            }
                            catch(Exception e){
                               // errorMessage = e.getMessage();
                                lstErrors.add(e.getMessage());
                                return lstErrors;
                            }
                            if(!Test.isRunningTest()){
                                for(Database.Error err : res.getErrors()) {
                                    System.debug(err.getMessage());
                                    errorMessage = errorMessage+' '+err.getMessage();
                                }
                            }
                            lstErrors.add(errorMessage);
                            return lstErrors;
                        }
                    }
                }
            }
        }
        else{
            errorMessage = 'There is already a merge in progress. Please use the merge tool after sometime.';
            lstErrors.add(errorMessage);
            return lstErrors;
        }
        
        return lstErrors;
    }
    
}