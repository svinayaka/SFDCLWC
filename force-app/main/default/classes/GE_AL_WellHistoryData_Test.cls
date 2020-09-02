/**
* 
* Trigger Name        : CreateWellDataHistory
* Handler Class       : GE_AL_CreateWellHistoryTriggerHandler
* Used Where ?        : On Location Object,well data History is created 
* Purpose/Overview    :This test class is used to track the changes done to the Well history,
                        when the intialization date,Status of the well history is changed.  
* Functional Area     : GE Oil&Gas Artificial Lift.
* Author              : Sathyanarayana B.
* Created Date        : 23/09/2014
* Test Class Name     : GE_AL_WellHistoryData_Test
* Change History      : Created to the Trigger(CreateWellDataHistory) with the Handler class and updated comments.
* Date Modified       : 04/11/2014
* Developer Name      : Sathyanarayana B.
* Method/Section Modified/Added : Added the method checkWellDataHistorywithLocation() which executed when the intialization date is modified.
**/

@isTest
private class GE_AL_WellHistoryData_Test {
    
    public static testMethod void wellDataHistory() {
        List<SVMXC__Site__c> locationList = new List<SVMXC__Site__c>();
        List<SVMXC__Site__c> oldlocationList = new List<SVMXC__Site__c>(); 
        Test.startTest(); 
        ID Rtid=Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Well').getRecordTypeId();
        SVMXC__Site__c locationObj = new SVMXC__Site__c(Name = 'testloc1',RecordTypeId=Rtid);
        locationObj.GE_AL_Well_Status__c='Pull';
        insert locationObj;
        System.assertEquals(locationObj.Name,'testloc1');
        locationObj.GE_AL_Well_Status__c='Intialization';
        update locationObj; 
        
        GE_AL_CreateWellHistoryTriggerHandler handler = new GE_AL_CreateWellHistoryTriggerHandler();
        handler.OnAfterUpdate(locationList,oldlocationList);
        Test.stopTest();
        
    }
    //This method is executed when the Location intialization date is modified
     public static testMethod void checkWellDataHistorywithLocation() {
        List<SVMXC__Site__c> locationList = new List<SVMXC__Site__c>();
        List<SVMXC__Site__c> oldlocationList = new List<SVMXC__Site__c>(); 
        ID Rtid=Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Well').getRecordTypeId();
        Test.startTest(); 
        SVMXC__Site__c locationObj = new SVMXC__Site__c(Name = 'testloc1',RecordTypeId=Rtid);
        locationObj.GE_AL_Well_Status__c='Pull';
        locationObj.GE_AL_Well_Initialization_Date__c= Date.newInstance(2014, 10, 01) ;     
        insert locationObj;
        oldlocationList.add(locationObj);
        System.assertEquals(locationObj.Name,'testloc1');
        locationObj.GE_AL_Well_Initialization_Date__c= Date.newInstance(2014, 10, 04) ;
        update locationObj; 
        locationList.add(locationObj);
        GE_AL_CreateWellHistoryTriggerHandler handler = new GE_AL_CreateWellHistoryTriggerHandler();
        handler.OnAfterUpdate(locationList,oldlocationList);
        Test.stopTest();
        
    }
    
    
}