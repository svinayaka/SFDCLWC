/**
* 
* Class/Trigger Name--:GE_MCS_Tier_2_Account_Region 
* Used Where ?--------:Contract
* Purpose/Overview----:This trigger is written for the R-19143. It will update the Tier_2_Account_Region field with correct Region. 
* Functional Area-----:MCS SFDC
* Author--------------:Raju Manche 
* Created Date--------:06/10/2014 
* Test Class Name-----: GE_HQ_Get_Region_Test (Method :GE_HQ_Get_Region_Contract_Test)

* Change History -

* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

**/

/**
* Sanjay Comments:
* Fill the above Class/Trigger Header Info.
* Comments.
* Indent.
* This Trigger would call the class every single time, add some kind of check so we stop them for firing more than once,
* Why a new Trigger  ? This object already has triggers, why not create a trigger shell and Handler Class 
**/

trigger GE_MCS_Tier_2_Account_Region on Contract (before insert,before update) {
String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
String contractRecordTypeAddedumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
String contractRecordTypeAmmendmentId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();        
if(!OpptyTriggerhelperClass.casequoteflag==true)
{
    for(Contract objCon:Trigger.New){
        if(objCon.RecordTypeId != contractRecordTypeMasterId && objCon.RecordTypeId != contractRecordTypeAddedumId && objCon.RecordTypeId != contractRecordTypeAmmendmentId ){
        String[] region=GE_HQ_Get_Region.getRegion(objCon.GE_PRM_Tier_2__c,objCon.GE_ES_Account_Country__c,null,'Sales');
        objCon.GE_MCS_Tier_2_Account_Region__c=region[0];         
    }
    }
    OpptyTriggerhelperClass.casequoteflag=true;
    }
}