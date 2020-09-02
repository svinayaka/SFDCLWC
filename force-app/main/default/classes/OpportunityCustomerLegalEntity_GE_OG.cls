/*
Class/Trigger Name     : OpportunityCustomerLegalEntity_GE_OG
Used Where ?           : OpportunityTriggerHandler_GE_OG
Purpose/Overview       : If there is only 1 legal entity associated with the commercial 
account(Opportunity standard account field) 
then this class  defaults  the legal entity into the opportunity 
customer legal entity field
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23662
Author                 : Sanath Kumar Dheram
Created Date           : 23/NOV/2015
Test Class Name        : OpportunityCustomerLE_GE_OG_Test
Code Coverage          : 93%
*/
public without sharing class OpportunityCustomerLegalEntity_GE_OG 
{ 
    id userId = userInfo.getUserId();
    User u = UserUtil.getUser(userId);
    // Method to filter Opportunities
    public void insertCustomerLegalEntityOnOpportunity(List<Opportunity> lstOpportunity)
    {
        Set<Id> setAccountId = new Set<Id>();
        Id ogRecordtypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','O&G').getRecordTypeId();
        
        for(Opportunity objOpportunity:lstOpportunity)
        {
            if(objOpportunity.AccountId!=null && objOpportunity.RecordtypeId == ogRecordtypeId)  
                setAccountId.add(objOpportunity.AccountId);
        }
        
        
        updateAccountMemberOfOnOppty(setAccountId, lstOpportunity);
    }
    
    
    
    public void updateCustomerLegalEntityOnOpportunity(List<Opportunity> lstOpportunity, Map<Id, Opportunity> mapOldOpportunity)
    {
        Set<Id> setAccountId = new Set<Id>();
        List<Opportunity> lstOppty = new List<Opportunity>();    
        Id ogRecordtypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','O&G').getRecordTypeId();
        
        for(Opportunity objOpportunity:lstOpportunity)
        {
            if(objOpportunity.AccountId != mapOldOpportunity.get(objOpportunity.Id).AccountId  && objOpportunity.RecordtypeId == ogRecordtypeId)
            {
                if(objOpportunity.AccountId!=null)  
                    setAccountId.add(objOpportunity.AccountId);
                lstOppty.add(objOpportunity);
            }
        }
        
        updateAccountMemberOfOnOppty(setAccountId, lstOppty);
    }
    
    
    // Method to update the account member of on oppty
    private void updateAccountMemberOfOnOppty(Set<Id> setAccId, List<Opportunity> lstOpportunity)
    {
        Map<Id,Id> mapOpptyIdToAccountId = new Map<Id,Id>();
        List<Opportunity> lstOpportunityToUpdate = new List<Opportunity>();
        
        
        for(Opportunity objOpportunity:[SELECT Id,AccountId
                                        FROM Opportunity 
                                        WHERE AccountId IN:setAccId AND ID IN:lstOpportunity
                                        AND Account.Account_Tier_GEOG__c = 'Global'])
        {
            mapOpptyIdToAccountId.put(objOpportunity.Id,objOpportunity.AccountId);
        }
        
        
        for(Opportunity objOpportunity:[SELECT Id,AccountId,Account.Member_of_GE_OG__c
                                        FROM Opportunity 
                                        WHERE AccountId IN:setAccId AND ID IN:lstOpportunity
                                        AND (Account.Account_Tier_GEOG__c = 'Regional' OR Account.Account_Tier_GEOG__c = 'Country') ])
        {
            mapOpptyIdToAccountId.put(objOpportunity.Id,objOpportunity.Account.Member_of_GE_OG__c);
        }
        
        for(Opportunity objOppty:lstOpportunity)
        {
            if(mapOpptyIdToAccountId.containskey(objOppty.Id))
            {
                Opportunity objOpportunity = new Opportunity
                    (
                        Id = objOppty.Id, 
                        Account_member_of_ge_og__c = mapOpptyIdToAccountId.get(objOppty.Id),
                        AccountId = objOppty.AccountId
                    );
                
                lstOpportunityToUpdate.add(objOpportunity);
            }
        }
        
        
        findNumberOfLegalEntitiesForAccount(setAccId, lstOpportunityToUpdate);
    }
    
    
    
    
    // Method to find the number of LE of account
    private void findNumberOfLegalEntitiesForAccount(Set<Id> setAccId, List<Opportunity> lstOpportunity)
    {
        Set<Id> setGlobalAccountIds = new Set<Id>();
        Map<Id,Integer> mapAccountId_CountLegalEntity = new Map<Id,Integer>();
        Set<Id> setSingleLEAccounts = new Set<Id>();
        List<Opportunity> lstFilteredOpportunity = new List<Opportunity>();
        system.debug('=== SetAccID Size '+ setAccId.size());
        
        if(setAccId!=null && setAccId.size()>0){
            for(Account objAccount:[SELECT Id,Oil_Gas_Parent_Account__r.Parent.ParentId,Account_Tier_GEOG__c,Oil_Gas_Parent_Account__c,
                                    Oil_Gas_Parent_Account__r.ParentId
                                    FROM Account
                                    WHERE (Oil_Gas_Parent_Account__r.Parent.ParentId IN:setAccId OR 
                                           Oil_Gas_Parent_Account__r.ParentId IN:setAccId   OR
                                           Oil_Gas_Parent_Account__c IN:setAccId)
                                    AND Account_Tier_GEOG__c = 'LE'])
            {
                if(objAccount.Oil_Gas_Parent_Account__c != null && objAccount.Oil_Gas_Parent_Account__r.ParentId != null
                   && objAccount.Oil_Gas_Parent_Account__r.Parent.ParentId != null)
                {
                    setGlobalAccountIds.add(objAccount.Oil_Gas_Parent_Account__r.Parent.ParentId);
                }
            }
        }
        
        
        // Rollup at Global level from LE level
        for(AggregateResult aggresult:[SELECT Oil_Gas_Parent_Account__r.Parent.ParentId parentAccount, COUNT(Id) cnt
                                       FROM Account
                                       WHERE Oil_Gas_Parent_Account__r.Parent.ParentId  IN:setGlobalAccountIds AND Account_Tier_GEOG__c = 'LE'
                                       GROUP BY Oil_Gas_Parent_Account__r.Parent.ParentId])
        {
            mapAccountId_CountLegalEntity.put((Id)aggresult.get('parentAccount'),(Integer)aggresult.get('cnt'));
        }
        
        
        // Create a set of accounts with single LE
        if(!mapAccountId_CountLegalEntity.isEmpty())
        {
            for(Id accId:mapAccountId_CountLegalEntity.keyset())
            {
                if(mapAccountId_CountLegalEntity.get(accId) == 1)
                {
                    setSingleLEAccounts.add(accId);
                }
            }
        }
        
        filterAndPopulateLegalEntityOnOpportunity(lstOpportunity,setSingleLEAccounts);
    }
    
    
    
    
    // Method to update customer legal entity into the opportunity
    private void filterAndPopulateLegalEntityOnOpportunity(List<Opportunity> lstOpportunity,set<Id> setSingleLEAccounts)
    {
        Set<Id> setAccountId = new Set<Id>();
        Map<Id,Id> mapCommercialAccountId_LegalEntityId = new Map<Id,Id>();
        Map<Id,Id> mapOpptyId_AccountMemberOfId = new Map<Id,Id>();
        List<Opportunity> lstOpportunityToUpdate = new List<Opportunity>();
        Database.Saveresult[] saveResult;
        
        // Create a set of parent account id of oppty
        for(Opportunity objOpportunity:lstOpportunity)
        {
            setAccountId.add(objOpportunity.AccountId);
        }
        
        // Create a map of Commercial account to LE account id
        for(Account objAccount:[SELECT Id, Oil_Gas_Parent_Account__c,Oil_Gas_Parent_Account__r.ParentId,
                                Oil_Gas_Parent_Account__r.Parent.ParentId,Account_Tier_GEOG__c
                                FROM Account
                                WHERE Account_Tier_GEOG__c = 'LE' AND Account_Status__c = 'CC Approved' AND
                                (Oil_Gas_Parent_Account__c IN : setAccountId OR 
                                 Oil_Gas_Parent_Account__r.ParentId IN : setAccountId OR
                                 Oil_Gas_Parent_Account__r.Parent.ParentId IN: setAccountId)])
        {
            if(setAccountId.contains(objAccount.Oil_Gas_Parent_Account__c))
                mapCommercialAccountId_LegalEntityId.put(objAccount.Oil_Gas_Parent_Account__c,objAccount.Id);
            
            else if(setAccountId.contains(objAccount.Oil_Gas_Parent_Account__r.ParentId))
                mapCommercialAccountId_LegalEntityId.put(objAccount.Oil_Gas_Parent_Account__r.ParentId,objAccount.Id);
            
            else if(setAccountId.contains(objAccount.Oil_Gas_Parent_Account__r.Parent.ParentId))
                mapCommercialAccountId_LegalEntityId.put(objAccount.Oil_Gas_Parent_Account__r.Parent.ParentId,objAccount.Id);
        }
        
        // Create data for Oppty Customer legal entity
        for(Opportunity objOpportunity:lstOpportunity)
        {
            mapOpptyId_AccountMemberOfId.put(objOpportunity.Id,objOpportunity.Account_member_of_ge_og__c);
        }
        
        
        for(Opportunity objOppty:[SELECT Id,Account_member_of_ge_og__c,AccountId,
                                  Account.ParentId,Account.Parent.ParentId,legal_entity_ge_og__c
                                  FROM Opportunity
                                  WHERE ID IN:lstOpportunity])
        {
            objOppty.Account_member_of_ge_og__c = mapOpptyId_AccountMemberOfId.get(objOppty.Id);
            
            if(mapCommercialAccountId_LegalEntityId.containskey(objOppty.AccountId) && 
               mapCommercialAccountId_LegalEntityId.get(objOppty.AccountId) != null && 
               (setSingleLEAccounts.contains(objOppty.AccountId) || 
                setSingleLEAccounts.contains(objOppty.Account.ParentId) ||
                setSingleLEAccounts.contains(objOppty.Account.Parent.ParentId))   
              )
            {
                objOppty.legal_entity_ge_og__c = mapCommercialAccountId_LegalEntityId.get(objOppty.AccountId);
                system.debug('---objOppty.legal_entity_ge_og__c------>>>>>>>>>>'+objOppty.legal_entity_ge_og__c);
            }
            else
            {
                if(!u.Disable_validations_for_MERGE__c){
                    objOppty.legal_entity_ge_og__c = null; 
                }
                //Commented by Harsha   objOppty.legal_entity_ge_og__c = null;
            }
            
            lstOpportunityToUpdate.add(objOppty);
        }
        
        if(!lstOpportunityToUpdate.isEmpty())
            saveResult  = database.update(lstOpportunityToUpdate,false);
        
        
        if(saveResult != null)
        {
            for(Database.Saveresult objSaveResult:saveResult)
            {
                if(objSaveResult.isSuccess())
                {
                    system.debug('-----Opportunity Updated Successfully--->>>'+objSaveResult.getId());
                }
                else
                {
                    system.debug('-----Opportunity Updation Failed--->>>'+objSaveResult.getId());
                    for(Database.Error objError:objSaveResult.getErrors())
                    {
                        system.debug('----Following fields caused the issue-->>>>'+objError.getFields());
                        system.debug('----Message----->>>>>>>>>'+objError.getMessage());
                        system.debug('----Status Code----->>>>>>>>>'+objError.getStatusCode());
                    }
                }
            }
        }
    }
}