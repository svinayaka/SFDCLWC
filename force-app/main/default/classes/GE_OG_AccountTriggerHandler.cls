/*
Class Name                   - GE_OG_AccountTriggerHandler 
Object Name                  - Account
Created Date                 - 7/22/2014
Description                  -  Handler Clas GE_OG_AccountTriggerHandler would process all the Trigger requests coming from GE_OG_AccountTrigger
                               All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
public without sharing class GE_OG_AccountTriggerHandler {
    GE_OG_AccountTriggerHandlerMethods handlerMethods = new GE_OG_AccountTriggerHandlerMethods();
    
    public void OnBeforeInsert(List<Account> newAccnts){
        // EXECUTE BEFORE INSERT LOGIC
        Map<id,Account> mapDummyAccounts = new Map<Id,Account>();
         //handlerMethods.preventCompetitorTypeRecordEdit(Trigger.oldMap, Trigger.newMap, 'Type', 'Competitor');
         handlerMethods.AccountStrengthAndNameChangeCompliaceReady(mapDummyAccounts,newAccnts);
    }

    public void OnAfterInsert(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
    
        // EXECUTE AFTER INSERT LOGIC
        
    }
    
    public void beforeCheckOppty(List<Account> newAccnts, Map<Id, Account> AccountOldMap){
        handlerMethods.checkForOpportunitiesBeforeUnlink(newAccnts,AccountOldMap);
    }

    public void OnBeforeUpdate(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
        // BEFORE UPDATE LOGIC
        //handlerMethods.preventCompetitorTypeRecordEdit(Trigger.oldMap, Trigger.newMap, 'Type', 'Competitor');
        handlerMethods.AccountStrengthAndNameChangeCompliaceReady(AccountOldMap,newAccnts);
        
    }

    public void OnAfterUpdate(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
        // AFTER UPDATE LOGIC
        //handlerMethods.NameAndTypeChnage(oldAccnts,newAccnts,AccountOldMap);
        handlerMethods.UpdateTeamMemberRole(oldAccnts,newAccnts,AccountOldMap);
        handlerMethods.CheckComplianceReadyFlag(oldAccnts,newAccnts,AccountOldMap);
        handlerMethods.uncheckComplianceReady(newAccnts, AccountOldMap);
        handlerMethods.CheckGovernmentEntityFlag(oldAccnts,newAccnts,AccountOldMap);
        LeMemberOffChange(oldAccnts,newAccnts,AccountOldMap);
        
    }
    
    public void LeMemberOffChange(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
    
    Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
   
    List<Account> updActLst = new List<Account>();
    
    Set<Id> leAccountMemberOffChanged = new set<Id>();
    
    for(Account act : newAccnts)
    {
        Id OldMemberOff = AccountOldMap.get(act.id).Member_of_GE_OG__c;
        
        if('Country' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && OldMemberOff != act.Member_of_GE_OG__c){
            
            leAccountMemberOffChanged.add(act.Id);
        }
       
    }
    
    if(!leAccountMemberOffChanged.isEmpty()){
        for(Account childAcc : [SELECT Id, Oil_Gas_Parent_Account__r.Member_of_GE_OG__c
                                FROM Account 
                                WHERE Oil_Gas_Parent_Account__c in: leAccountMemberOffChanged 
                                AND Account_Tier_GEOG__c = 'LE' ])
        {
            childAcc.Member_of_GE_OG__c = childAcc.Oil_Gas_Parent_Account__r.Member_of_GE_OG__c;
            updActLst.add(childAcc);
        }
    }
    
    If(!updActLst.isEmpty()){
        update updActLst;
        }
 }
    
}