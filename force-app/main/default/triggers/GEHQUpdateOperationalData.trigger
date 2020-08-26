/*    
Trigger Name      : GE_HQ_Operational_Data__c 
Purpose/Overview  :  To update the values from Operational data to Installed Base
Author            : Rekha.N and Raj
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 
Test Class        : GEHQUpdateOperationalData_Test
                  
*/
trigger GEHQUpdateOperationalData on GE_HQ_Operational_Data__c (after insert) { 
    
   List<GE_Installed_Base__c> allIBs =new List<GE_Installed_Base__c>();
   Set<Id> IbIds = new Set<Id>();

   for(GE_HQ_Operational_Data__c opRec: Trigger.new){
       IbIds.add(opRec.GE_S_N_Equip_Name__c);
   }

 
   allIBs = [Select ID, Name, GE_HQ_IB_LCVHrs__c, GE_HQ_IB_LCVStrts__c, GE_HQ_IB_LCV_Trps__c, 
                  (Select ID, GE_HQ_SnpSht_dt__c, GE_HQ_LCV_Hrs__c, GE_HQ_LCV_Strts__c, GE_HQ_LCV_Trps__c 
                   From Operational_Data__r Where GE_HQ_LCV_Hrs__c <> null Order by GE_HQ_SnpSht_dt__c desc, CreatedDate desc Limit 1)
                   From GE_Installed_Base__c Where ID IN :IbIds ]; 
                   
   if(allIBs != null && allIBs.size()>0){
       for (GE_Installed_Base__c IBRec : allIBs ) {    
          for (GE_HQ_Operational_Data__c OpRec : IBRec.Operational_Data__r) {
                IBRec.GE_HQ_IB_LCVHrs__c  =  OpRec.GE_HQ_LCV_Hrs__c; 
                IBRec.GE_HQ_IB_LCVStrts__c = OpRec.GE_HQ_LCV_Strts__c;
                IBRec.GE_HQ_IB_LCV_Trps__c = OpRec.GE_HQ_LCV_Trps__c;
          }
        }
       update allIBs;
   }                
 
}