/*
Class/Trigger Name     : SetContactPrimaryFlagTrigger
Used Where ?           : GE_OG_AccountContactRelationHandler
Purpose/Overview       : To set only one primary contact on a Contact Module and also to check Accounts Data Quality
Scrum Team             : Accounts & Contacts Scrum
Requirement Number     : 
Author                 : Niranjana
Created Date           : 14/NOV/2016
Test Class Name        : GE_OG_AccountContactRelationHandler_Test & AccountStrength_GEOG_Test
Code Coverage          : 100%
*/


trigger SetContactPrimaryFlagTrigger on Contact (after insert, after update,before insert, before update) {
set<id> getNewContactIds = new Set<Id>();
set<id> getContactId= new Set<Id>();
String PrimaryContactId;
List<AccountContactRelation> UpdateRelatedContactList = new List<AccountContactRelation>();

for(Contact con:Trigger.New){

    //Region calculation begins
    if(trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        con.GE_OG_Region__c = Util_GE_OG.regionPopulateByCountry(con.GE_OG_Country__c);
    }
    //Region calcualtion ends here
    if(trigger.oldMap!=null){
     Contact oldCon= trigger.oldMap.get(con.id);
    if(oldCon.GE_PRM_Primary_Contact__c != con.GE_PRM_Primary_Contact__c){
        getNewContactIds.add(con.id);  
    }
    }
    else
        getNewContactIds.add(con.id);    
    
    system.debug('====getNewContactIds===='+getNewContactIds);
}

if(getNewContactIds.isEmpty()==false){
List<Contact> NewContactList= [Select id,GE_PRM_Primary_Contact__c,AccountID from Contact where Id IN: getNewContactIds limit 50000];

system.debug('====NewContactList===='+NewContactList);

List<AccountContactRelation> getRelatedContactList = [Select id, GE_OG_Primary_Contact__c,IsDirect,ContactID,AccountID,Contact.GE_PRM_Primary_Contact__c from AccountContactRelation where ContactID IN: NewContactList and IsDirect=true limit 50000];
system.debug('====getRelatedContactList ==='+getRelatedContactList);

Map<Id, Contact> PrimarycontactMap = new Map<Id, Contact>();
        for(Contact conMap: NewContactList){
            PrimarycontactMap.put(conMap.id, conMap);
        }

for(AccountContactRelation con:getRelatedContactList){
     if(PrimarycontactMap.get(con.ContactId).GE_PRM_Primary_Contact__c== True){
         con.GE_OG_Primary_Contact__c=true;
     }   
     else if(PrimarycontactMap.get(con.ContactId).GE_PRM_Primary_Contact__c== False){
         con.GE_OG_Primary_Contact__c=false;    
     }
     UpdateRelatedContactList.add(con);
     system.debug('====con.GE_OG_Primary_Contact__c ==='+con.GE_OG_Primary_Contact__c);
     system.debug('====con.==='+con);
}
if(UpdateRelatedContactList.size()>0){
Update UpdateRelatedContactList;}
}

}