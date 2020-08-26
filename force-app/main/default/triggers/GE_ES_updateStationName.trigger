/*
Trigger Name:-    GE_ES_updateStationName 
Overview:-        This Triger is used for update StationName on account Object  depending upon IB Object Record Type  
Author:-          Rajakumar Malla
Created Date:-    4th April 2011
Test Class Name:- GE_ES_updateStationName_Test
Change History:-  Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  31st Apr 2011 : Durga Prasad       : Added comments and indentation
                  18th Jul 2011 : Raja Kumar Malla   : Included 'Aero Gas' record type in current logic
                  21st Sep 2011 : Jayadev Rath       : Included after delete section : (BC S-03146) -- Included this section to update the Turbine count on Account (even after deletion of an turbine record)
                  08th Sep 2014  : Rekha N           : Removed Wind,Aero Gas Record Type related code (R-18237)
*/

trigger GE_ES_updateStationName on GE_Installed_Base__c (after insert,after update,after delete) {

    set<id> AccID = new set<id>();
    List<Account> AccToUpdate = new List<Account>();
    List<Account> listAccScope = new List<Account>();

    //Query GE_Installed_Base__c Record type 

    List<RecordType> CRecType= [Select Name, Id From RecordType where sObjectType='GE_Installed_Base__c'];  
    Map<String,String> IBRecordTypes = new Map<String,String>{}; 
    for(RecordType rt: CRecType)   
        IBRecordTypes.put(rt.Name,rt.Id);

    If(Trigger.isInsert || Trigger.isUpdate) { // Added this to prevent the execution for 'After delete' event.

        // checking wind record type for eaching record and adding into List .

        for(GE_Installed_Base__c IB:Trigger.New)
        {
            if((IB.GE_ES_Station_Name__c!=null) && (IB.Account__c!=null) &&((IB.RecordTypeId==IBRecordTypes.get('Generator')) || (IB.RecordTypeId==IBRecordTypes.get('HD Gas'))||(IB.RecordTypeId==IBRecordTypes.get('Motors'))||(IB.RecordTypeId==IBRecordTypes.get('Steam'))||(IB.RecordTypeId==IBRecordTypes.get('Installed Base Generic'))))
            {
                AccID.add(IB.Account__c);            
            }
        }
        
        Map<id,Account> listAccScopeId = new Map<id,Account>([Select id, Name, GE_HQ_Station_Name__c, (Select id, Name, GE_ES_Station_Name__c From Installed_Base__r Where GE_ES_Station_Name__c != '') from Account  where id IN : AccID ]);    
        listAccScope = listAccScopeId.values();
        
        for(Account tempAccount : listAccScope )
        {
            for(GE_Installed_Base__c tempIB :  tempAccount.Installed_Base__r)
            { 
               tempAccount.GE_HQ_Station_Name__c = tempIB.GE_ES_Station_Name__c;
               break;
            }    
            AccToUpdate.add(tempAccount);
        }
        // update Account Satation name
        if(AccToUpdate.size() > 0) 
        {
         update AccToUpdate;    
        }
    }
    
    
    
}