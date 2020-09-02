/*Class Name:   GE_OG_HQ_WO_SetEndDateTime
* Purpose:  Due to the all day event process for ServiceMax we need to help set a more accurate end date time on the work order
*               This process will trim 1 minute off the duration when calculating the end date time field IF the work order has a related SMax event that has all day event = true
*               If the work order does not have an event, which is set to all day event = true, then the end date time will be calculated from the duration value without any adjustment
* Create Date:  April 8th release 2016  -  R-24352
* Author:       Matt Koshay
*/

public class GE_OG_HQ_WO_SetEndDateTime {
   
    public static void setEndDateTimeInsertUpdate(List<SVMXC__SVMX_Event__c> p_eventList){         
        // will hold the list SOQL results of all WOs tied to the passed events
        List<SVMXC__Service_Order__c> WOList = new List<SVMXC__Service_Order__c>();
        // will hold the list of WOs that will be updated
        Map<Id,SVMXC__Service_Order__c> WOUpdateMap = new Map<Id,SVMXC__Service_Order__c>();
        // holds Ids of WOs that have a related all day event
        Set<Id> WOsWithADEventsSet = new Set<Id>();
        // holds Ids of the WOs related to the passed events
        Set<Id> allWOsSet = new Set<Id>();
        
        Datetime tempEndTime = Datetime.newInstanceGmt(2011,6,1,12,1,5);
        Date tempEndDate = Date.newInstance(2011, 6, 1);
        
        for(SVMXC__SVMX_Event__c e : p_eventList){
            // if the event is an all day event, add the related WO to the set
            if(e.SVMXC__IsAllDayEvent__c == true && e.SVMXC__Service_Order__c != null)
                WOsWithADEventsSet.add(e.SVMXC__Service_Order__c);
            // if the event has a related work order add it to the set
            if(e.SVMXC__Service_Order__c != null)
                allWOsSet.add(e.SVMXC__Service_Order__c);
        }
        
        WOList = [select id, name, recordtype.name, SVMXC__Scheduled_Date_Time__c ,SVMXC__Service_Duration__c, GE_SM_HQ_Scheduled_End_Date_Time__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c where Id in : allWOsSet ];
        
        // loop over the WOs and if the end date would be different by adding the duration to the start date time, then add it to the updated WO list
        for(SVMXC__Service_Order__c wo : WOList){
            // if the work order is an all day event related work order add the duration to the start date time minus 1 minute
            if(WOsWithADEventsSet.contains(wo.Id) && wo.SVMXC__Scheduled_Date_Time__c  != null && wo.SVMXC__Service_Duration__c != null && !WOUpdateMap.containsKey(wo.Id)){                
                tempEndTime = DateTime.valueof(wo.SVMXC__Scheduled_Date_Time__c).addseconds(Integer.valueof(wo.SVMXC__Service_Duration__c) - 1);            System.debug('&&tempEndTime&&'+tempEndTime);
                if(wo.GE_SM_HQ_Scheduled_End_Date_Time__c != tempEndTime){
                    System.debug('Changing WO EndDateTime (ADWO): ' + wo.Name + ' Cur EndDateT: '+ wo.GE_SM_HQ_Scheduled_End_Date_Time__c + ' New EndDateT: ' + tempEndTime);
                    wo.GE_SM_HQ_Scheduled_End_Date_Time__c=tempEndTime;
                    // Set the schedule end date field
                    tempEndDate = Date.newInstance(tempEndTime.yearGmt(),tempEndTime.monthGmt(), tempEndTime.dayGmt());
                   //Bug # 0000024349: Below line is commented and changed as above.
                    //tempEndDate = Date.valueof(tempEndTime);
                    system.debug('$$Schedule End date'+wo.GE_SM_HQ_Schedule_End_Date2__c);
                    System.debug('Changing WO EndDate (ADWO): ' + wo.Name + ' Cur EndDate: ' + wo.GE_SM_HQ_Schedule_End_Date2__c + ' New EndDate: ' + tempEndDate);
                    wo.GE_SM_HQ_Schedule_End_Date2__c = tempEndDate;
                    WOUpdateMap.put(wo.Id,wo);
                }                                
            }
            else if (wo.SVMXC__Scheduled_Date_Time__c  != null && wo.SVMXC__Service_Duration__c != null && !WOUpdateMap.containsKey(wo.Id)){
                tempEndTime = DateTime.valueof(wo.SVMXC__Scheduled_Date_Time__c).addseconds(Integer.valueof(wo.SVMXC__Service_Duration__c));
                // if the work order is NOT an all day event related work order, just add the duration to the start date time
                if(wo.GE_SM_HQ_Scheduled_End_Date_Time__c != tempEndTime){
                    System.debug('Changing WO EndDateTime (Non ADWO): ' + wo.Name + ' Cur EndDateT: '+ wo.GE_SM_HQ_Scheduled_End_Date_Time__c + ' New EndDateT: ' + tempEndTime);
                    wo.GE_SM_HQ_Scheduled_End_Date_Time__c=tempEndTime;
                    // Set the schedule end date field
                    tempEndDate = Date.newInstance(tempEndTime.year(),tempEndTime.month(), tempEndTime.day());
                    System.debug('Changing WO EndDate (Non ADWO): ' + wo.Name + ' Cur EndDate: ' + wo.GE_SM_HQ_Schedule_End_Date2__c + ' New EndDate: ' + tempEndDate);
                    wo.GE_SM_HQ_Schedule_End_Date2__c = tempEndDate;
                    WOUpdateMap.put(wo.Id,wo);
                }
            }                            
        }// end for loop
        
        try{
            if(WOUpdateMap.size() > 0)
                update WOUpdateMap.values();
        }
        catch (Exception e){
            System.debug('Could not update Work order Map values :' + e.getMessage());
        }
          
    } // end method
    
    // When an event is deleted we need to check if the duration has changed from the dispatch console.  Pass the remaining events in the inserupdate method
   public static void setEndDateTimeDelete(List<SVMXC__SVMX_Event__c> p_eventList){
        List<SVMXC__SVMX_Event__c> relatedEvents = new list<SVMXC__SVMX_Event__c>();
        Set<Id> AllWOSet = new Set<Id>();
        Set<Id> WOWithEvents = new Set<Id>();
        Set<Id> NoEventWOs = new Set<ID>();
        
        for(SVMXC__SVMX_Event__c event : p_eventList){
            if(event.SVMXC__Service_Order__c != null)
                AllWOSet.add(event.SVMXC__Service_Order__c);
        }
        
        // get events that are still in the system (not deleted) related to these work orders        
        relatedEvents = [select id, Name, SVMXC__IsAllDayEvent__c, SVMXC__Service_Order__c from SVMXC__SVMX_Event__c where SVMXC__Service_Order__c in : AllWOSet];
        
        // Get the IDs of work orders that still have events
        for(SVMXC__SVMX_Event__c event : relatedEvents){
            WOWithEvents.add(event.SVMXC__Service_Order__c);
        } 
        
        // figure out the set of IDs of work orders that no longer have any events tied to them
        for(Id i : AllWOSet){
            if(!WOWithEvents.contains(i))
                NoEventWOs.add(i);
        }
        
        // call the end date process for the events related to the WO
        if(relatedEvents.size() > 0)
            GE_OG_HQ_WO_SetEndDateTime.setEndDateTimeInsertUpdate(relatedEvents);   
        
        // set the end date time to null for work orders that no longer have a related event
        List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c>();
        woList = [select id, name, GE_SM_HQ_Scheduled_End_Date_Time__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c where Id in : NoEventWOs];
        for(SVMXC__Service_Order__c wo : woList){
            wo.GE_SM_HQ_Scheduled_End_Date_Time__c = null;
            wo.GE_SM_HQ_Schedule_End_Date2__c = null;
            System.debug('Setting WO ' + wo.name + ' scheduled end date time to null');
        }
        
        try{
            if(woList.size() > 0)
                update woList;     
        }
        catch (exception e){
            System.debug('Exception while trying to update Work order scheduled end date time: ' + e.getMessage());
        }
        
    }
}