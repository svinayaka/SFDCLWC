/*
---------------------------------------------------------*************************************************************------------------------------------------------------------------------------------------------
Requirement Number: R-18900
Build Card Number: S-14391
Created By: Abhijeet Virgaonkar
Business: OG D&S > Artificial Lift. (Servicemax D&S) 
Purpose:  If User is modifying Status, Location, Shipped to or Shipped From field on Installed Product Object a new Record should be created in Equipment Data Object 
                 with Record Type Equipment Data History. It should contain old and new values of the Fields mentioned earlier.
Modified By: Mounika Nellutla Purpose: To use handler class in trigger

Requirement Number :- R-31298
Description :- The new source of truth for Installed base is now located in Installed Products object in ServiceMax.The Business requires an automated data dump from 
installed Products to Installed Base on a weekly basis.And that if a new Installed Products is created,they can automatically allow its creation in Installed Base.
Development date :- 24/01/2019
Business :- SubSea
Author :- Shiv Pratap Singh Bhadauria 

---------------------------------------------------------*************************************************************------------------------------------------------------------------------------------------------
*/
trigger CreateEquipDataHistory on SVMXC__Installed_Product__c ( before insert , after insert , before update ,after Update) {    
    List<SVMXC__Installed_Product__c> installprodList = new List<SVMXC__Installed_Product__c>();
    List<SVMXC__Installed_Product__c> oldInstallProdList = new List<SVMXC__Installed_Product__c>();
    Id ALRecordTypeId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('GE OG D&S Artificial Lift').getRecordTypeId();
    Boolean sFlag = false;
    set<Id> AccountIdsSet = new Set<Id>();

     if(trigger.isBefore){
          GE_AL_CreateEquipHitoryTriggerHandler.onbeforeInsertUpdate(Trigger.new) ;
     } 
     
     if(trigger.isAfter){    
             List<Id> lstJobIds = new List<Id>();
             try{    
                if(GE_AL_CreateEquipHitoryTriggerHandler.isFirstTime){
                    GE_AL_CreateEquipHitoryTriggerHandler.isFirstTime = false;
                    Id queueJobId = System.enqueueJob(new GE_SS_Auto_InstalledBase_Creation(Trigger.new));
                    lstJobIds.add(queueJobId);
                }
           }
            catch(Exception e){
                system.debug('Issue with IP & IB sync');
            }
         
         if(trigger.isUpdate){
              for(SVMXC__Installed_Product__c installprod : Trigger.new) {
                  if(installprod.RecordTypeId == ALRecordTypeId){
                       sFlag = true;
                  }
              }
              if(sFlag){
                  GE_AL_CreateEquipHitoryTriggerHandler.OnAfterUpdate(Trigger.new,Trigger.old);
              }
              
         }  
    } 
}