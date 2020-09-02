/*
Req: R-23916

Class Name              :        GE_OG_MC_EventDateChanges
Class called in         :        GE_OG_SVMX_Event_TriggerHandler
Purpose:When multi technician assignment is done, to capture actual start and end dates among all the technicians assigned to a particular work order.This class also handles when technicians are modified(added/removed).
When a technician is unassigned from the group of technicians the dates are sorted for the remaining technicians and shown.
For the final technician when unassigned from the work order/during the unassignment of workorder to all the technicians, the field dates are made empty.

Operations handled      :         For Insertion / Updation , Deletion
Insertion/Updation      :         Method : eventDatesExtraction()
Deletion                :         Method : eventDatesDeletion()

*/

public class GE_OG_MC_EventDateChanges{
  
    Set<Id> woIdset = new Set<Id>();
    List<SVMXC__SVMX_Event__c> evtsList1 = new List<SVMXC__SVMX_Event__c>();
   
    Map<Id, List<SVMXC__SVMX_Event__c>> wosMap = new Map<Id,List<SVMXC__SVMX_Event__c>>();
    Set<Id> woSet = new Set<Id>();
    List<DateTime> startDates;
    List<DateTime> endDates;
    List<SVMXC__Service_Order__c> woList;
     List<SVMXC__Service_Order__c> finalWOList;
    public void eventDatesExtraction(List<SVMXC__SVMX_Event__c> events){
    //Id woId;  
    DateTime finalStartDate;   
    DateTime finalEndDate;
    Integer evtDateSize;
    List<SVMXC__SVMX_Event__c> smaxEvtList = new List<SVMXC__SVMX_Event__c>();
    try{
           for (SVMXC__SVMX_Event__c evt :events){            
                woIdset.add(evt.SVMXC__Service_Order__c);           
           }
           
           System.debug('The work order values are :' +woIdset);
          // Map<id,SVMXC__SVMX_Event__c> woEvtMap = new Map<id, SVMXC__SVMX_Event__c>([
           //SVMXC__Service_Order__c,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c
          // from SVMXC__SVMX_Event__c where SVMXC__Service_Order__c in : woIdset]);    
           //System.debug('The map contains ----------------------->'+woEvtMap);         
           
           for(ID woId1:woIdset){
                List<SVMXC__SVMX_Event__c> eventlist = new List<SVMXC__SVMX_Event__c>();
                for(SVMXC__SVMX_Event__c event : events)
                {
                    if(woId1 == event.SVMXC__Service_Order__c)
                        eventlist.add(event);
                }
                wosMap.put(woId1,eventlist);
            }
            System.debug('Map:'+wosMap);
        
            if(wosMap.size()>0){
            
                        woList=[select id,GE_OG_Min_Event_Start_Date__c,GE_OG_Max_Event_End_Date__c from SVMXC__Service_Order__c where id in : woIdset and RecordType.Name = 'MCS'];
                        for(SVMXC__Service_Order__c wId : woList){ 
                            
                            startDates = new List<DateTime>();
                            endDates = new List<DateTime>();
                                smaxEvtList = wosMap.get(wId.id);
                                System.debug('Work order'+wId.id+'events related to :'+smaxEvtList);
                                
                                for (SVMXC__SVMX_Event__c  evt:smaxEvtList){
                                        startDates.add(evt.SVMXC_Start_Date_Time_UI__c);
                                        endDates.add(evt.SVMXC_End_Date_Time_UI__c);                    
                                }           
                                startDates.sort();
                                endDates.sort();                    
                                System.debug('Start dates in sorted order are : ' +startDates);
                                System.debug('End dates in sorted order are : ' +endDates);
                                evtDateSize = endDates.size()-1;
                                finalStartDate = startDates.get(0);
                                finalEndDate = endDates.get(evtDateSize);
                                System.debug('after insertion Start dates :--------->'+finalStartDate+'-------'+'End dates-->'+finalEndDate);   
                                
                                wId.GE_OG_Min_Event_Start_Date__c = finalStartDate;
                                wId.GE_OG_Max_Event_End_Date__c = finalEndDate;  
                                
                                System.debug('The final WO lilst is :'+ wId);
                                
                        }   
                        
            }
            if(woList.size()>0){
                update woList;
            }
            
    }
        Catch(Exception e){
            System.debug('The execption is --->'+e);
        }     
    }
    
    public void eventDatesDeletion(List<SVMXC__SVMX_Event__c> events){
    
    
            evtsList1 = [select id,SVMXC__Service_Order__c from SVMXC__SVMX_Event__c where id in : events];
            Set<ID> deleteIds = new Set<ID>();
            
            for(SVMXC__SVMX_Event__c evt :evtsList1){
                    deleteIds.add(evt.SVMXC__Service_Order__c);         
            }
            
            List <SVMXC__Service_Order__c> wodeleteList=[select id,GE_OG_Min_Event_Start_Date__c,GE_OG_Max_Event_End_Date__c from SVMXC__Service_Order__c where id in : deleteIds and RecordType.Name = 'MCS'];
            
            for (SVMXC__Service_Order__c wo:wodeleteList){
                wo.GE_OG_Min_Event_Start_Date__c = null;
                wo.GE_OG_Max_Event_End_Date__c =null;           
            
            }
            if(wodeleteList.size()>0){
                update wodeleteList;
            
            
            }
        
    
    
    }
}