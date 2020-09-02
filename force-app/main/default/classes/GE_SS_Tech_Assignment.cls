public class GE_SS_Tech_Assignment {
    //Commenting the code as part of R-26370 as not used by Subsea
    //variable to use in whole class
    Public void dummyMethod(){
     integer i = 0;
    }
   /* public static Set<Id> setWORTIds = new Set<Id>();
    
    public static void manageTechAssignments(List<SVMXC__SVMX_Event__c> triggerNew, Map<Id, SVMXC__SVMX_Event__c> triggerOld, Boolean isInsert, Boolean isUpdate, Boolean isDelete) 
    { 
        // SubSea RecordTypes used to restrict what WO RecordTypes are used in this process  
        setWORTIds.add(Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId());
        setWORTIds.add(Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId());
        setWORTIds.add(Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId());
        System.debug('in method manageTechAssignments');
        
        if(isInsert)
        {
            onInsertSMAXEvent(triggerNew);
        }
        else if(isUpdate)
        {
            onUpdateSMAXEvent(triggerNew);
        }
        else if(isDelete)
        {
            onDeleteSMAXEvent(triggerOld);
        }
    }
    
    /*
        This method execute when SVMXC__SVMX_Event__c is created with what Id is work order id and work order record type is (Daily, Trip, Mobilize)
    */
    /*public static void onInsertSMAXEvent(List<SVMXC__SVMX_Event__c> triggerNew1)
    {
        System.debug('in method onInsertSMAXEvent');
        Map<Id, SVMXC__Service_Order__c> mapWorkOrder = new Map<Id, SVMXC__Service_Order__c>();
        Set<Id> setWOId = new Set<Id>();
        List<Work_Activity__c> lstTechAssignment = new List<Work_Activity__c>();
        List<SVMXC__SVMX_Event__c> lstSMAXEvents = new List<SVMXC__SVMX_Event__c>();
        
        for(SVMXC__SVMX_Event__c objEvent : triggerNew1)
        {
                if(objEvent.SVMXC__WhatId__c != null)
                {
                    if(((Id)objEvent.SVMXC__WhatId__c).getSObjectType().getDescribe().getName() == 'SVMXC__Service_Order__c')
                    {
                        setWOId.add(objEvent.SVMXC__WhatId__c);
                        lstSMAXEvents.add(objEvent);
                    }
                }
        }
        System.debug('setWOId: '+setWOId);

        System.debug('lstSMAXEvents: '+lstSMAXEvents);
        //Deleted the fields as part of R-26138
        //mapWorkOrder.putAll([SELECT Id, RecordTypeId, SVMXC__Company__c, GE_SS_Air_Tickets_Booked__c, GE_SS_Collect_Where__c, GE_SS_Contact_Offshore_Fax__c, GE_SS_Contact_Onshore_Fax__c, GE_SS_Contact_Person_Offshore__c, GE_SS_Contact_Person_Offshore_Tel__c, GE_SS_Contact_Person_Onshore__c, GE_SS_Contact_Person_Onshore_Tel__c, GE_SS_Co_Worker__c, GE_SS_External_Timesheets_to_be_written__c,GE_SS_Heliport__c, GE_SS_Job_Description__c, GE_SS_Mobilization_Date_Time__c, GE_SS_Report_Responsible__c,GE_SS_Shift__c, GE_SS_Technical_info_needed_offshore__c FROM SVMXC__Service_Order__c WHERE Id IN : setWOId and RecordTypeId IN : setWORTIds ]);
         //Removed GE_SS_Co_Worker__c,GE_SS_Shift__c,GE_SS_External_Timesheets_to_be_written__c,GE_SS_Report_Responsible__c, GE_SS_Technical_info_needed_offshore__c,GE_SS_Mobilization_Date_Time__c fields from the below Query as per R-26370
        mapWorkOrder.putAll([SELECT Id, RecordTypeId, SVMXC__Company__c, GE_SS_Job_Description__c FROM SVMXC__Service_Order__c WHERE Id IN : setWOId and RecordTypeId IN : setWORTIds ]);
        System.debug('mapWorkOrder: '+mapWorkOrder);
        
        for(SVMXC__SVMX_Event__c objEvent1 : lstSMAXEvents)
        {
            System.debug('mapWorkOrder.containsKey((Id)objEvent1.SVMXC__WhatId__c): '+mapWorkOrder.containsKey((Id)objEvent1.SVMXC__WhatId__c));
            if( mapWorkOrder != null && mapWorkOrder.containsKey((Id)objEvent1.SVMXC__WhatId__c) && objEvent1.SVMXC__Technician__c != null)
            {
                Work_Activity__c ObjTechAssignemnt = new Work_Activity__c();
                ObjTechAssignemnt.Work_Order__c = (Id)objEvent1.SVMXC__WhatId__c;
                ObjTechAssignemnt.Technician_Equipment__c = objEvent1.SVMXC__Technician__c;
                ObjTechAssignemnt.StartTime__c = objEvent1.SVMXC__StartDateTime__c;
                ObjTechAssignemnt.EndTime__c = objEvent1.SVMXC__EndDateTime__c;
             //Deleted the fields as part of R-26138
              //  ObjTechAssignemnt.GE_SS_Air_Tickets_Booked__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Air_Tickets_Booked__c;
                ObjTechAssignemnt.GE_SS_Account__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).SVMXC__Company__c;
              //  ObjTechAssignemnt.GE_SS_Collect_Where__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Collect_Where__c;
              //  ObjTechAssignemnt.GE_SS_Contact_Offshore_Fax__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Contact_Offshore_Fax__c;
              //  ObjTechAssignemnt.GE_SS_Contact_Onshore_Fax__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Contact_Onshore_Fax__c ;
              //  ObjTechAssignemnt.GE_SS_Contact_Person_Offshore__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Contact_Person_Offshore__c ;
             //   ObjTechAssignemnt.GE_SS_Contact_Person_Offshore_Tel__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Contact_Person_Offshore_Tel__c ; 
              //  ObjTechAssignemnt.GE_SS_Contact_Person_Onshore__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Contact_Person_Onshore__c ;
            //    ObjTechAssignemnt.GE_SS_Contact_Person_Onshore_Tel__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Contact_Person_Onshore_Tel__c ;
                //ObjTechAssignemnt.GE_SS_Co_Worker__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Co_Worker__c ;
                //ObjTechAssignemnt.GE_SS_External_Timesheets_to_be_written__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_External_Timesheets_to_be_written__c ;
           //     ObjTechAssignemnt.GE_SS_Heliport__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Heliport__c;
                ObjTechAssignemnt.GE_SS_Job_Description__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Job_Description__c ; 
                //ObjTechAssignemnt.GE_SS_Mobilization_Date_Time__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Mobilization_Date_Time__c ;
                //ObjTechAssignemnt.GE_SS_Report_Responsible__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Report_Responsible__c ;
                //ObjTechAssignemnt.GE_SS_Shift__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Shift__c ;
                //ObjTechAssignemnt.GE_SS_Technical_info_needed_offshore__c = mapWorkOrder.get((Id)objEvent1.SVMXC__WhatId__c).GE_SS_Technical_info_needed_offshore__c ;
                
                ObjTechAssignemnt.GE_SS_Event_Id__c = objEvent1.Id ;
                
                lstTechAssignment.add(ObjTechAssignemnt);
            }
        }
        if(lstTechAssignment != null && lstTechAssignment.size() > 0)
            insert lstTechAssignment;
    }*/
    
    /*
        This method execute when SVMXC__SVMX_Event__c is updated with what Id is work order id and work order record type is (Daily, Trip, Mobilize)
    */
   /* public static void onUpdateSMAXEvent(List<SVMXC__SVMX_Event__c> triggerNew1)
    {
        System.debug('in method onUpdateSMAXEvent');
        Map<Id, SVMXC__Service_Order__c> mapWorkOrder = new Map<Id, SVMXC__Service_Order__c>();
        Map<Id, Id> mapUserIdToTechId = new Map<Id, Id>();
        Set<Id> setWOId = new Set<Id>();
        List<Work_Activity__c> lstTechAssignmentToUpdate = new List<Work_Activity__c>();
        Map<Id, SVMXC__SVMX_Event__c> mapSMAXEvents = new Map<Id, SVMXC__SVMX_Event__c>();
        
        
        for(SVMXC__SVMX_Event__c objEvent : triggerNew1)
        {
                if(objEvent.SVMXC__WhatId__c != null)
                {
                    if(((Id)objEvent.SVMXC__WhatId__c).getSObjectType().getDescribe().getName() == 'SVMXC__Service_Order__c')
                    {
                        setWOId.add(objEvent.SVMXC__WhatId__c);
                        mapSMAXEvents.put(objEvent.Id, objEvent);
                    }
                }
        }
        
        System.debug('setWOId2: '+setWOId);
        System.debug('mapSMAXEvents2: '+mapSMAXEvents);
        
        lstTechAssignmentToUpdate = [Select Id, GE_SS_Account__c, Work_Order__c, Technician_Equipment__c, StartTime__c, EndTime__c, GE_SS_Air_Tickets_Booked__c, GE_SS_Collect_Where__c, GE_SS_Contact_Offshore_Fax__c, GE_SS_Contact_Onshore_Fax__c, GE_SS_Contact_Person_Offshore__c, GE_SS_Contact_Person_Offshore_Tel__c, GE_SS_Contact_Person_Onshore__c, GE_SS_Contact_Person_Onshore_Tel__c, GE_SS_Co_Worker__c, GE_SS_External_Timesheets_to_be_written__c, GE_SS_Heliport__c, GE_SS_Job_Description__c, GE_SS_Mobilization_Date_Time__c, GE_SS_Report_Responsible__c, GE_SS_Shift__c, GE_SS_Technical_info_needed_offshore__c, GE_SS_Event_Id__c from Work_Activity__c where GE_SS_Event_Id__c IN: mapSMAXEvents.keySet()];
        
        System.debug('lstTechAssignmentToUpdate2: '+lstTechAssignmentToUpdate);
        
        //Delete the fields as part of R-26138
       // mapWorkOrder.putAll([SELECT Id, RecordTypeId, SVMXC__Company__c, GE_SS_Air_Tickets_Booked__c, GE_SS_Collect_Where__c, GE_SS_Contact_Offshore_Fax__c, GE_SS_Contact_Onshore_Fax__c, GE_SS_Contact_Person_Offshore__c, GE_SS_Contact_Person_Offshore_Tel__c, GE_SS_Contact_Person_Onshore__c, GE_SS_Contact_Person_Onshore_Tel__c, GE_SS_Co_Worker__c, GE_SS_External_Timesheets_to_be_written__c,GE_SS_Heliport__c, GE_SS_Job_Description__c, GE_SS_Mobilization_Date_Time__c, GE_SS_Report_Responsible__c,GE_SS_Shift__c, GE_SS_Technical_info_needed_offshore__c FROM SVMXC__Service_Order__c WHERE Id IN : setWOId and RecordTypeId IN : setWORTIds ]);
         //Removed GE_SS_Co_Worker__c,GE_SS_Shift__c,GE_SS_External_Timesheets_to_be_written__c,GE_SS_Report_Responsible__c, GE_SS_Technical_info_needed_offshore__c,GE_SS_Mobilization_Date_Time__c fields from the below Query as per R-26370
         mapWorkOrder.putAll([SELECT Id, RecordTypeId, SVMXC__Company__c, GE_SS_Job_Description__c FROM SVMXC__Service_Order__c WHERE Id IN : setWOId and RecordTypeId IN : setWORTIds ]);
        
        System.debug('mapWorkOrder2: '+mapWorkOrder);
        
        
        
        for(Work_Activity__c ObjTechAssignemnt : lstTechAssignmentToUpdate)
        {
            System.debug('mapSMAXEvents.containsKey(ObjTechAssignemnt.GE_SS_Event_Id__c)2: '+mapSMAXEvents.containsKey(ObjTechAssignemnt.GE_SS_Event_Id__c));
            System.debug('mapWorkOrder.containsKey(ObjTechAssignemnt.Work_Order__c)2: '+mapWorkOrder.containsKey(ObjTechAssignemnt.Work_Order__c) );
            

            if(mapSMAXEvents.containsKey(ObjTechAssignemnt.GE_SS_Event_Id__c) && mapWorkOrder.containsKey(ObjTechAssignemnt.Work_Order__c) && mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__Technician__c != null)
            {
                ObjTechAssignemnt.Work_Order__c = (Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c;
                ObjTechAssignemnt.Technician_Equipment__c = (Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__Technician__c;
                ObjTechAssignemnt.StartTime__c = mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__StartDateTime__c;
                ObjTechAssignemnt.EndTime__c = mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__EndDateTime__c;
              //Delete the field Well as part of R-26138
               //ObjTechAssignemnt.GE_SS_Air_Tickets_Booked__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Air_Tickets_Booked__c;
               // ObjTechAssignemnt.GE_SS_Collect_Where__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Collect_Where__c;
                ObjTechAssignemnt.GE_SS_Account__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).SVMXC__Company__c;
               // ObjTechAssignemnt.GE_SS_Contact_Offshore_Fax__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Contact_Offshore_Fax__c;
              //  ObjTechAssignemnt.GE_SS_Contact_Onshore_Fax__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Contact_Onshore_Fax__c ;
               // ObjTechAssignemnt.GE_SS_Contact_Person_Offshore__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Contact_Person_Offshore__c ;
               // ObjTechAssignemnt.GE_SS_Contact_Person_Offshore_Tel__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Contact_Person_Offshore_Tel__c ; 
               // ObjTechAssignemnt.GE_SS_Contact_Person_Onshore__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Contact_Person_Onshore__c ;
              //  ObjTechAssignemnt.GE_SS_Contact_Person_Onshore_Tel__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Contact_Person_Onshore_Tel__c ;
               // ObjTechAssignemnt.GE_SS_Co_Worker__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Co_Worker__c ;
                //ObjTechAssignemnt.GE_SS_External_Timesheets_to_be_written__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_External_Timesheets_to_be_written__c ;
               // ObjTechAssignemnt.GE_SS_Heliport__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Heliport__c;
                ObjTechAssignemnt.GE_SS_Job_Description__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Job_Description__c ; 
               // ObjTechAssignemnt.GE_SS_Mobilization_Date_Time__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Mobilization_Date_Time__c ;
               // ObjTechAssignemnt.GE_SS_Report_Responsible__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Report_Responsible__c ;
               // ObjTechAssignemnt.GE_SS_Shift__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Shift__c ;
               // ObjTechAssignemnt.GE_SS_Technical_info_needed_offshore__c = mapWorkOrder.get((Id)mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).SVMXC__WhatId__c).GE_SS_Technical_info_needed_offshore__c ;
                ObjTechAssignemnt.GE_SS_Event_Id__c = mapSMAXEvents.get(ObjTechAssignemnt.GE_SS_Event_Id__c).Id ;
                
            }
        }
        if(lstTechAssignmentToUpdate != null && lstTechAssignmentToUpdate.size() > 0)
            Update lstTechAssignmentToUpdate;
        
    }*/
    
    /*
        This method execute when event is deleted with what Id is work order id and work order record type is (Daily, Trip, Mobilize)
    */
    
    /*public static void onDeleteSMAXEvent(Map<Id, SVMXC__SVMX_Event__c> triggerOld)
    {
        Set<Id> setEventId = new Set<Id>();
        List<Work_Activity__c> lstTechAssignmentToDelete = new List<Work_Activity__c>();
        
        for(Id eventId : triggerOld.keySeT())
            setEventId.add(eventId);
        
        lstTechAssignmentToDelete = [Select Id from Work_Activity__c where GE_SS_Event_Id__c IN: setEventId and Work_Order__r.RecordTypeId IN: setWORTIds];
        
        if(lstTechAssignmentToDelete != null && lstTechAssignmentToDelete.size() > 0)
            delete lstTechAssignmentToDelete;
        
    }*/
}