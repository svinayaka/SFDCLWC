/*
Class/Trigger Name     : GE_OG_AccountContactRelationTrigger
Used Where ?           : GE_OG_AccountContactRelationHandler
Purpose/Overview       : To set only one primary contact on RelatedContact Module and also to check Accounts Data Quality
Scrum Team             : Accounts & Contacts Scrum
Requirement Number     : 
Author                 : Niranjana
Created Date           : 14/NOV/2016
Test Class Name        : GE_OG_AccountContactRelationHandler_Test
Code Coverage          : 100%
*/


trigger GE_OG_AccountContactRelationTrigger on AccountContactRelation(after delete, after insert, after undelete, after update, before delete, before insert, before update) {
GE_OG_AccountContactRelationHandler handler=new GE_OG_AccountContactRelationHandler();
    //Before Insert 
    if(Trigger.isInsert && Trigger.isBefore){
        
    }
    //After Insert
    else if(Trigger.isInsert && Trigger.isAfter){
        handler.SetPrimaryFlag(Trigger.old, Trigger.new, trigger.oldMap);
        handler.CheckPrimaryContactOnAccounts(Trigger.old, Trigger.new, trigger.oldMap);
                
    }
    //Before Update
    else if(Trigger.isUpdate && Trigger.isBefore){
        //handler.SetPrimaryFlag(Trigger.old, Trigger.new, trigger.oldMap);

    }
    //After Update
    else if(Trigger.isUpdate && Trigger.isAfter){
        handler.SetPrimaryFlag(Trigger.old, Trigger.new, trigger.oldMap);
        handler.CheckPrimaryContactOnAccounts(Trigger.old, Trigger.new, trigger.oldMap);
    }
    
    //Before Delete
    else if(Trigger.isDelete && Trigger.isBefore){ 
        handler.SetAccountDataQuality(Trigger.old, Trigger.oldMap);       
    }
    //After Delete
    else if(Trigger.isDelete && Trigger.isAfter){
        
    }

}