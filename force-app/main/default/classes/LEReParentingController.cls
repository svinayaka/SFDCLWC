/*
Class/Trigger Name     : LEReParentingController
Purpose/Overview       : To update the parent account of a Legal Entity
Author                 : Geetha Karmarkar
Created Date           : 22/07/2019
*/
global without sharing class LEReParentingController{

    global class LeReparentParser{
        @InvocableVariable(required=true description='LE Account Id' label=' LE Account Id')
        public string legalEntId;
        @InvocableVariable(required=true description='request Id' label='request Id')
        public string requestId;
        @InvocableVariable(required=true description='new parent Id' label='new parent Id')
        public String newParentId;
    }
    
    @InvocableMethod(label='ReparentLE' description='ReparentLE')
    public static void reparent(List<LeReparentParser> lstParser){
        LeReparentParser objInput = lstParser[0];
        Account objNewParent = [SELECT Id, Name, Account_Tier_GEOG__c, Member_of_GE_OG__c, ParentId, Type,Region_GEOG__c,Country_GEOG__c, Classification__c
                                FROM Account 
                                WHERE Id=: objInput.newParentId
                                LIMIT 1];
        List<Account>  lstLE= [SELECT Id, Name, Oil_Gas_Parent_Account__c,Member_of_GE_OG__c
                            FROM Account
                            WHERE Id =:objInput.legalEntId 
                            LIMIT 1];
        lstLE[0].Oil_Gas_Parent_Account__c = objInput.newParentId;
        lstLE[0].Member_of_GE_OG__c = objNewParent.Member_of_GE_OG__c;
        lstLE[0].Type= objNewParent.Type;
        lstLE[0].Region_GEOG__c = objNewParent.Region_GEOG__c;
        lstLE[0].Country_GEOG__c = objNewParent.Country_GEOG__c;
        lstLE[0].Classification__c = objNewParent.Classification__c;
        if(!lstLE.isEmpty()){
            try{
            update lstLE;
            }
            catch(Exception e){
                system.debug('Error in updating the Parent Relationship '+e.getMessage());
            }
        }
        
        List<Opportunity> lstOppties = [SELECT Id, Name,legal_entity_ge_og__c, Type, legal_entity_ge_og__r.Account_Tier_GEOG__c,AccountId,Account.Account_Tier_GEOG__c
                                        FROM Opportunity
                                        WHERE legal_entity_ge_og__c =: objInput.legalEntId 
                                        LIMIT 50000];
        Id channelMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        Id channelAddId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        Id masterFrameId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Master Frame Agreement').getRecordTypeId();
        Id addFrameId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Addendum Frame Agreement').getRecordTypeId();
        List<Id> lstChannelRec = new List<Id>();
        List<Id> lstFrameRec = new List<Id>();
        
        lstChannelRec.add(channelMasterId);
        lstChannelRec.add(channelAddId);
        lstFrameRec.add(masterFrameId);
        lstFrameRec.add(addFrameId);
        List<Contract> lstPRM_FrameContracts = [SELECT Id, Name, AccountId, RecordTypeId, GE_PRM_Commercial_Account__c, GE_Commercial_Member_Of_GE_OG__c, Status
                                            FROM Contract WHERE AccountId=: objInput.legalEntId AND 
                                            (RecordTypeId IN: lstChannelRec OR RecordTypeId IN: lstFrameRec)
                                            LIMIT 50000];
        List<Contract> lstPRMContracts = new List<Contract>();
        List<Contract> lstFrameAgreements = new List<Contract>();
        
        
        for(Contract objContract: lstPRM_FrameContracts){
            if(objContract.RecordTypeId == channelAddId || objContract.RecordTypeId == channelMasterId){
                lstPRMContracts.add(objContract);
            }
            if(objContract.RecordTypeId == masterFrameId || objContract.RecordTypeId == addFrameId){
                lstFrameAgreements.add(objContract);
            }
        }
        
        Id executionId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Contract').getRecordTypeId();
        Id dmId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal Machine Contract').getRecordTypeId();
        List<Contract> lstExecutionContracts = [SELECT Id, Name, AccountId, RecordTypeId, Commercial_Account_Name_GEOG__c,Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c
                                            FROM Contract WHERE AccountId=: objInput.legalEntId AND 
                                            RecordTypeId =: executionId 
                                            LIMIT 50000];                                            
        List<Contract> lstDealMachineContracts =[SELECT Id, Name, AccountId, RecordTypeId, Commercial_Account_Name_GEOG__c, Account_Legal_Entity__c, Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c
                                            FROM Contract WHERE Account_Legal_Entity__c =: objInput.legalEntId AND 
                                            RecordTypeId =: dmId
                                            LIMIT 50000];
                                            
        List<Contact> lstContacts = [SELECT Id, FirstName, LastName,GE_OG_Site_LegalEntity_Account__c, AccountId,Account.Account_Tier_GEOG__c 
                                    FROM Contact 
                                    WHERE GE_OG_Site_LegalEntity_Account__c =: objInput.legalEntId 
                                    LIMIT 50000];
                                    
        List<SObject> lstFinalListToUpdate = new List<SObject>();
        List<SObject> lstTemp = new List<SObject>();
        lstTemp  = Accounts_ContactsReparentHandler.reparentContacts(lstContacts, objNewParent);
        if(!lstTemp.isEmpty()){
            lstFinalListToUpdate.addAll(lstTemp);
        }
        lstTemp  = Accounts_ContactsReparentHandler.reparentDM_Contracts(lstDealMachineContracts, objNewParent);
        if(!lstTemp.isEmpty()){
            lstFinalListToUpdate.addAll(lstTemp);
        }
        lstTemp = Accounts_ContactsReparentHandler.reparentExe_Contracts(lstExecutionContracts, objNewParent);
        if(!lstTemp.isEmpty()){
            lstFinalListToUpdate.addAll(lstTemp);
        }
        lstTemp = Accounts_ContactsReparentHandler.reparentFrameAgr_Contracts(lstFrameAgreements, objNewParent);
        if(!lstTemp.isEmpty()){
            lstFinalListToUpdate.addAll(lstTemp);
        }
        
        lstTemp = LE_Reparenting_Opportunity_GE_OG.reParentLEforoppty(lstOppties, objNewParent);
        if(!lstTemp.isEmpty()){
            lstFinalListToUpdate.addAll(lstTemp);
        }
        if(!lstPRMContracts.isEmpty()){
            lstTemp = ReparentLegalEntity_PRM_GE_OG.reparent_PRM(objNewParent, lstPRMContracts);
            if(!lstTemp.isEmpty()){
                lstFinalListToUpdate.addAll(lstTemp);
            }
        }
        
        if(!lstFinalListToUpdate.isEmpty()){
            BatchLEReparentRecordsController objSch = new BatchLEReparentRecordsController(objInput.requestId,lstFinalListToUpdate); 
            Database.executebatch(objSch);
        }
        else{
            List<Re_Parenting_LE_Request__c> lstReparenting = [SELECT id, name,Request_Status__c
                                                            FROM Re_Parenting_LE_Request__c
                                                            WHERE id=: objInput.requestId
                                                            LIMIT 1];
            if(!lstReparenting.isEmpty()){
                for(Re_Parenting_LE_Request__c objReparenting: lstReparenting){
                    objReparenting.Request_Status__c = 'Completed';
                }
                try{
                    update lstReparenting;
                }
                catch(Exception e){
                    System.debug('Error while updating request...   '+e.getMessage());
                }
            }
        }
    }
}