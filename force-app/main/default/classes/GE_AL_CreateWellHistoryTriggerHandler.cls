/**
 * 
 * Trigger Name     : CreateWellDataHistory  
 * Used Where       : During well data history creation in Installed product Object
 * Purpose/Overview : As a part of creating WellHistory data when well status is changed to the given profiles.
 * Functional Area  : GE Oil& Gas Aritificial Lift.
 * Author           : Sathyanarayana Borugula.
 * Created Date     : 22/09/2014 
 * Test Class Name  : GE_AL_WellHistoryData_Test
 * Change History   : Created as a part of R-18947 for 14 Minor-6 and Updated comments.
 * Date Modified    : 09/10/2014
   Developer Name   : Sathyanarayana Borugula
   Method/Section Modified/Added : Modified the according to the method call from the trigger to Handler.
**/
public without sharing class GE_AL_CreateWellHistoryTriggerHandler {    
    public void OnAfterUpdate(List<SVMXC__Site__c> locationList, List<SVMXC__Site__c> oldlocationList ) {     
        Schema.DescribeSObjectResult des = Schema.SObjectType.GE_AL_Well_History_Data__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = des.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('Well Data History');
        Id wellHistdataRT = rtByName.getRecordTypeId();         
        Schema.DescribeSObjectResult des1 = Schema.SObjectType.SVMXC__Site__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName1 = des1.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName1 =  rtMapByName1.get('Well');
        Id wellRT = rtByName1.getRecordTypeId(); 
        List<GE_AL_Well_History_Data__c> wellHistDataList = new List<GE_AL_Well_History_Data__c>(); 
        List<Profile> alProfList = [Select id, Name from Profile where Name IN ('GE_AL Dispatcher', 'GE_AL_Field Manager','GE_AL_Field Service Office','GE_AL_FS Technician','GE_AL_Invoicing','GE_AL_SM Admin','GE_AL_SM Read Only','GE_ES Developer')];
        Date dt=Date.today();
        Id loggedInUserId = userinfo.getProfileId();
        for(SVMXC__Site__c newWellRec : locationList) {
            for(SVMXC__Site__c oldWellRec :oldlocationList) {
                if(newWellRec.id == oldWellRec.id) {
                   if(newWellRec.RecordTypeId == wellRT && oldWellRec.GE_AL_Well_Initialization_Date__c != newWellRec.GE_AL_Well_Initialization_Date__c ) {
                        GE_AL_Well_History_Data__c wellHistoryData = new GE_AL_Well_History_Data__c();
                        wellHistoryData.Name = 'Well History Data';
                        wellHistoryData.RecordTypeid = wellHistdataRT;
                        wellHistoryData.GE_AL_Event_Date__c = Datetime.now();
                        wellHistoryData.GE_AL_Location__c = newWellRec.Id;
                        wellHistoryData.GE_AL_Old_Value__c = String.valueof(oldWellRec.GE_AL_Well_Initialization_Date__c);
                        wellHistoryData.GE_AL_New_value__c = String.valueof(newWellRec.GE_AL_Well_Initialization_Date__c);
                        wellHistoryData.GE_AL_Event_Type__c = 'Initialization Date Change';
                        wellHistoryData.GE_AL_Total_Well_Run_Days__c = newWellRec.GE_AL_Total_Well_Run_Days__c;
                        wellHistoryData.GE_AL_Start_Date_of_Current_Install__c = newWellRec.GE_AL_Well_Start_Date__c;
                        wellHistoryData.GE_AL_Information__c = 'Initialization Date changed from '+ oldWellRec.GE_AL_Well_Initialization_Date__c + ' to '+                        newWellRec.GE_AL_Well_Initialization_Date__c;  
                        wellHistDataList.add(wellHistoryData);
                    }if(newWellRec.RecordTypeId == wellRT && oldWellRec.GE_AL_Well_Status__c != newWellRec.GE_AL_Well_Status__c ) {
                        GE_AL_Well_History_Data__c wellHistoryData = new GE_AL_Well_History_Data__c();
                        wellHistoryData.Name = 'Well History Data';
                        wellHistoryData.RecordTypeid = wellHistdataRT;
                        wellHistoryData.GE_AL_Event_Date__c = Datetime.now();
                        wellHistoryData.GE_AL_Location__c = newWellRec.Id;
                        wellHistoryData.GE_AL_Old_Value__c = oldWellRec.GE_AL_Well_Status__c;
                        wellHistoryData.GE_AL_New_value__c = newWellRec.GE_AL_Well_Status__c;
                        wellHistoryData.GE_AL_Total_Well_Run_Days__c = newWellRec.GE_AL_Total_Well_Run_Days__c;
                        wellHistoryData.GE_AL_Start_Date_of_Current_Install__c = newWellRec.GE_AL_Well_Start_Date__c;
                        wellHistoryData.GE_AL_Event_Type__c = 'Status Change';
                        wellHistoryData.GE_AL_Information__c = ' Well Status changed from '+ oldWellRec.GE_AL_Well_Status__c + ' to  '+
                        newWellRec.GE_AL_Well_Status__c;   
                        wellHistDataList.add(wellHistoryData);
                    }
                    if(!wellHistDataList.isEmpty()) {
                        insert wellHistDataList;
                    }
                }
            }  
        }
    }
}