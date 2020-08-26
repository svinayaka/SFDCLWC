/*
Class Name:-      GE_ES_GIBIntegration
Overview:-        This Class is used for synchronising the SFDC data with GIB
Author:-          Jullain
Created Date:-    4th April 2011
Test Class Name:- GE_ES_GIBIntegration_Test
Change History:-  Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  31st Apr 2011 : Durgaprasad        : Added ws calling
                  03rd Jul 2011 : Raja Kuamr Malla   : Made Bulk Trigger: Updated for handling bulk dataload
                  04th Jul 2011 : Jayadev Rath       : Made Bulk Trigger: Updated for handling bulk dataload
                  18th Jul 2011 : Raja Kumar Malla   : Include “Aero Gas” record type to follow Sales Manager and Sales Channel changes from SFDC to GIB 
                  12th Mar 2012  :Rekha N            : To Include Global Services(GS) Record Types  
                  08th Sep 2014 : Rekha N            : Removed Wind,Aero Gas Record Type related code (R-18237)          
*/

Trigger GE_ES_GIBIntegration on GE_Installed_Base__c (After Update) {

    // Checking for User name is 'System Interation' to avoid loopy updations (All Changes from GIB to SFDC are done using this user name).
    If(UserInfo.getName().contains('System Integration'))
        Return;    // Send back the control without making any progress/Changes to GIB.
    set<ID> IBIDs = new set<ID>();
    
    // Fetching all record type names for GE_Installed_Base__c
    List<RecordType> IBRT= [Select Name, Id From RecordType where sObjectType='GE_Installed_Base__c'];      
    // Create a map of record type names and IDs.
    Map<String,String> IBRecTypes = new Map<String,String>{};
   
      
 
    for(RecordType rt: IBRT)    
        IBRecTypes.put(rt.Name,rt.Id);
    // Check through all the records to find if the GE_ES_Sales_Channel__c or GE_ES_Account_Manager__c has been updated or not
     /*testing*/
         List<GE_Installed_Base__c> newIB= [Select Id,GE_ES_Sales_Channel__c,GE_ES_Account_Manager__c,RecordTypeId, GE_ES_Account_Manager__r.Name,GE_HQ_lntrv_BIs__c,GE_HQ_lntrv_CIs__c, GE_HQ_lntrv_HGPMIs__c, GE_HQ_lntrv_Major__c, GE_HQ_lntrv_Minor__c, GE_HQ_lntrv_SMI__c from GE_Installed_Base__c  where id=: Trigger.NewMap.keyset()];
          /*testing*/
   // for(GE_Installed_Base__c IB: Trigger.new){
   for(GE_Installed_Base__c IB: newIB){
          system.debug('IB.GE_ES_Account_Manager__c--->' + IB.GE_ES_Account_Manager__c);
          system.debug('IB.GE_ES_Account_Manager__r.Name--->' + IB.GE_ES_Account_Manager__r.Name);
        
          if(IB.RecordTypeId==IBRecTypes.get('Generator')||IB.RecordTypeId==IBRecTypes.get('HD Gas')||IB.RecordTypeId==IBRecTypes.get('Motors')||IB.RecordTypeId==IBRecTypes.get('Steam')||IB.RecordTypeId==IBRecTypes.get('Installed Base Generic')||IB.RecordTypeId==IBRecTypes.get('Cooler')||IB.RecordTypeId==IBRecTypes.get('Compressor')||IB.RecordTypeId==IBRecTypes.get('Hydro Units')||IB.RecordTypeId==IBRecTypes.get('Plant')||IB.RecordTypeId==IBRecTypes.get('Pump')||IB.RecordTypeId==IBRecTypes.get('Turboexpander')||IB.RecordTypeId==IBRecTypes.get('Valve')||IB.RecordTypeId==IBRecTypes.get('Gasification')){
            if((Trigger.oldmap.get(IB.Id).GE_ES_Sales_Channel__c != IB.GE_ES_Sales_Channel__c) || ((Trigger.oldmap.get(IB.Id).GE_ES_Account_Manager__c != IB.GE_ES_Account_Manager__c) && (IB.GE_ES_Account_Manager__r.Name!='See GIB')) || (Trigger.oldmap.get(IB.Id).GE_HQ_lntrv_BIs__c != IB.GE_HQ_lntrv_BIs__c) || (Trigger.oldmap.get(IB.Id).GE_HQ_lntrv_CIs__c != IB.GE_HQ_lntrv_CIs__c) || (Trigger.oldmap.get(IB.Id).GE_HQ_lntrv_HGPMIs__c != IB.GE_HQ_lntrv_HGPMIs__c) || (Trigger.oldmap.get(IB.Id).GE_HQ_lntrv_Major__c != IB.GE_HQ_lntrv_Major__c) || (Trigger.oldmap.get(IB.Id).GE_HQ_lntrv_Minor__c != IB.GE_HQ_lntrv_Minor__c) || (Trigger.oldmap.get(IB.Id).GE_HQ_lntrv_SMI__c != IB.GE_HQ_lntrv_SMI__c))
              { IBIDs.add(IB.id);   // If any records with modification exists add its details to send to GIB WS
                system.debug('old trigger sales channel--->' + Trigger.oldmap.get(IB.Id).GE_ES_Sales_Channel__c);
                system.debug('new sales channel--->' + IB.GE_ES_Sales_Channel__c); 
                system.debug('old trigger Acc mgr--->' + Trigger.oldmap.get(IB.Id).GE_ES_Account_Manager__c);
                system.debug('new Acc mgr--->' + IB.GE_ES_Account_Manager__c); 
                system.debug('new Acc mgr name--->' + IB.GE_ES_Account_Manager__r.Name);  
              }
        }
    }

    // only if there are records  to send to WS, then only WS will be called      
    if(!IBIDs.isempty()) GE_ES_GIBWrapper.IBReq(IBIDs);      
}