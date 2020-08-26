/*R-18947
As a part of creating WellHistory data when well status is changed to the given profiles.
The trigger is modified as a part of creating the Handler class : GE_AL_CreateWellHistoryTriggerHandler

Modified by :Sathyanarayana Borugula.


*/

trigger CreateWellDataHistory on SVMXC__Site__c (after update) {

    List<GE_AL_Well_History_Data__c> wellHistDataList = new List<GE_AL_Well_History_Data__c>();
    
    Schema.DescribeSObjectResult des = Schema.SObjectType.GE_AL_Well_History_Data__c; 
    Map<String,Schema.RecordTypeInfo> rtMapByName = des.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName =  rtMapByName.get('Well Data History');
    Id wellHistdataRT = rtByName.getRecordTypeId(); 
    List<SVMXC__Site__c> locationList = new List<SVMXC__Site__c>();
    List<SVMXC__Site__c> oldlocationList = new List<SVMXC__Site__c>();
       
    for(SVMXC__Site__c newWellRec : Trigger.new)
    {           
        locationList.add(newWellRec);       
        SVMXC__Site__c oldWellRec = System.Trigger.oldMap.get(newWellRec.id);
        oldlocationList.add(oldWellRec);        
     
    }   
    GE_AL_CreateWellHistoryTriggerHandler Handler =new GE_AL_CreateWellHistoryTriggerHandler();
    Handler.OnAfterUpdate(locationList,oldlocationList);
}