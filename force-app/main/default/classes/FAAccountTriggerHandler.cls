/**********
Class Name          : FAAccountTriggerHandler 
Used Where ?        : 
Purpose/Overview    :  
Functional Area     : 
Author              : 
Created Date        : 
Test Class Name     :
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
11/26/2014      Pradeep Rao Yadagiri   Added Record type condition to prevent execution for channel master , channel addedum agreement record types
************/

public class FAAccountTriggerHandler {
    String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
    String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();

  // update the primary Account when new records are inserted from trigger
  public void OnAfterInsert(List<Contract> newRecords, Set<Id> FARecIds){
  
      if(newRecords != null & newRecords.size()>0){
          List<Account_Frame_Agreement__c> accFAList = new List<Account_Frame_Agreement__c>();
          
          for(Contract ctRec : newRecords){
          if(ctRec.RecordTypeId != contractRecordTypeMasterId && ctRec.RecordTypeId != contractRecordTypeAddendumId){
              Account_Frame_Agreement__c accFA = new Account_Frame_Agreement__c();
              if(FARecIds.contains(ctRec.RecordTypeId)){
                  accFAList.add(new Account_Frame_Agreement__c(Contract_Name__c=ctRec.Id, Account_Name__c=ctRec.AccountId));
              }
			  }
          }
          if(accFAList.size() > 0){
              insert accFAList;
          }
      }
  }
  
  // update the primary Account when records are updated from trigger  
  public void OnAfterUpdate(List<Contract> oldRecords, 
                            List<Contract> updatedRecords,  Map<ID,Contract> oldMap, 
                            Map<ID,Contract> newMap, Set<Id> FARecIds){
     
     Set<Id> oldContracts = new Set<Id>();
     Set<String> oldContractsWithAccounts = new Set<String>();
     List<Account_Frame_Agreement__c> newFAList = new List<Account_Frame_Agreement__c>();
     
     for(Contract ctRec: updatedRecords){
	     if(ctRec.RecordTypeId != contractRecordTypeMasterId && ctRec.RecordTypeId != contractRecordTypeAddendumId){
         if(FARecIds.contains(ctRec.RecordTypeId))
         
         {
             if(ctRec.AccountId != oldMap.get(ctRec.Id).AccountId){
                 oldContracts.add(ctRec.Id);
                 oldContractsWithAccounts.add('' + ctRec.Id + oldMap.get(ctRec.Id).AccountId);
                 newFAList.add(new Account_Frame_Agreement__c(Contract_Name__c=ctRec.Id, Account_Name__c=ctRec.AccountId));
             }
         }
		 }
     }
     
     if(oldContracts.size() > 0){
         Map<Id, Account_Frame_Agreement__c> AFRecsToDelete = new Map<Id, Account_Frame_Agreement__c>();
         for(Account_Frame_Agreement__c AFRec : [Select Id, Contract_Name__c, Account_Name__c from Account_Frame_Agreement__c where Contract_Name__c IN :oldContracts]){
             if(oldContractsWithAccounts.contains(''+AFRec.Contract_Name__c+AFRec.Account_Name__c)){
                 AFRecsToDelete.put(AFRec.Id, AFRec);
             }
         }
     
         //Delete the existing/old records
         Database.DeleteResult[] deletedAFRecs = Database.delete(AFRecsToDelete.values());

         //Insert the new/updated records
         Database.SaveResult[] newAFRecs = Database.insert(newFAList, false);
     }

     /*if(updatedRecords!= null & updatedRecords.size()>0){
     
         Map<ID, Set<ID>> crMap = new Map<ID, Set<ID>>();
         Set<ID> allconIDs = new Set<ID>();
         for(Contract rec : oldRecords){
                   allconIDs.add(rec.id);
         }
   
             
         List<Account_Frame_Agreement__c> allaccFAList = [Select Id, Account_Name__c, Contract_Name__c From Account_Frame_Agreement__c Where Contract_Name__c =: allconIDs];
         
         if(allaccFAList != null && allaccFAList.size()>0){         
              for(ID conid: allconIDs){
                  Set<ID> accSt = new Set<ID>();
                  for(Account_Frame_Agreement__c accFA :allaccFAList){
                      if(conid==accFA.Contract_Name__c ){
                        accSt.add(accFA.Account_Name__c);
                      }
                  }
                  crMap.put(conid,accSt);
              }
         }
         

         System.debug('crMap:'+crMap);
         List<Account_Frame_Agreement__c> accFAList = new List<Account_Frame_Agreement__c>();
          
          for(Contract c : updatedRecords){          
              Account_Frame_Agreement__c accFA = new Account_Frame_Agreement__c();
              Set<ID> accSet = crMap.get(c.Id);
              System.debug('Acc Set'+accSet);
              System.debug('Acc ID'+c.AccountId);
              System.debug('Check point:'+accSet.contains(c.AccountId));
              
              if(c.RecordTypeId == FARecId && ( accSet==null || (!accSet.contains(c.AccountId)))){
                  accFA.Account_Name__c=c.AccountId;
                  accFA.Contract_Name__c=c.id;             
                  accFAList.add(accFA); 
              }
          }
          
          if(accFAList != null && accFAList.size()>0)
              insert accFAList;
       }*/

      /*if(oldRecords != null && oldRecords.size()>0)
      {
          Set<ID> accIDs = new Set<ID>();
          Set<ID> conIDs = new Set<ID>();
          
          for(Contract rec : oldRecords){
              accIDs.add(rec.AccountId);
              conIDs.add(rec.id);
          }
          
          if(accIDs != null && conIDs !=null ){
              List<Account_Frame_Agreement__c> accFAListDel = [Select Id From Account_Frame_Agreement__c Where Account_Name__c =: accIDs AND Contract_Name__c =: conIDs];
              if(accFAListDel != null && accFAListDel.size() > 0)
              delete accFAListDel;
          }
          
      }*/   
  }
  
}