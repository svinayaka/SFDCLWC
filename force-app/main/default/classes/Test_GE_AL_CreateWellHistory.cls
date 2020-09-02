@IsTest
public class Test_GE_AL_CreateWellHistory {
  
    Static testMethod void WellAfterUpdate(){
        
        GE_AL_CreateWellHistoryTriggerHandler Wh = new GE_AL_CreateWellHistoryTriggerHandler();
        List<SVMXC__Site__c> locationList = new List<SVMXC__Site__c>();
        List<SVMXC__Site__c> oldlocationList = new List<SVMXC__Site__c>();
        
        Wh.OnAfterUpdate(locationList,oldlocationList);
    }

}