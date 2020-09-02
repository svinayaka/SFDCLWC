@isTest(seeAllData=true)
public class FAAccountTriggerHandler_Test
{
  static testMethod void FAAccountHandler()
  {
         Account acc = new Account();
        acc.Name = 'TestAccount6345';
        //acc.GE_HQ_Request_Status__c = 'CMF Approved';
        insert acc;
        
         //Account acc1 = [select id from Account where name = 'TestClassAccount' limit 1];
       
       Recordtype rectype = [select id, name from Recordtype where name ='Master Frame Agreement' and SobjectType = 'Contract' limit 1];
        
        Contract ct = new Contract();
        ct.RecordTypeId = rectype.id;
        ct.Name = 'ssr';
        //ct.Account=acc.Name;
        ct.AccountId=acc.id;
        //ct.GE_PRM_Recommendation_Link__c=apptmtObj.id;
        ct.GE_OG_Evergreen__c=true;
        insert ct;
        List<Contract> newRecords= new List<Contract>();
        Set<Id> FARecIds= new Set<Id>();
        Map<ID,Contract> oldMap = new Map<ID,Contract>();
        Map<ID,Contract> newMap = new Map<ID,Contract>();
        List<Contract> updatedRecords = new List<Contract>();
        
        Contract updateContract = [select id,name,GE_MCS_Contract_Amount__c from Contract where Name = 'ssr' and AccountId=: acc.id limit 1 ];
        updateContract.GE_MCS_Contract_Amount__c = 1000.00;
        update updateContract;
        updatedRecords.add(updateContract);
        oldMap.put(ct.id,ct);   
        newMap.put(updateContract.id,updateContract);   
   FAAccountTriggerHandler fat = new FAAccountTriggerHandler();
    Account_Frame_Agreement__c afa = new Account_Frame_Agreement__c();
  afa.Contract_Name__c=ct.id;
  afa.Account_Name__c=acc.id;
  try{
  insert afa; 
   }
  catch(exception emsg){
  system.assert(emsg.getmessage().contains('Duplicate record on Junction Object, Selected Account is already associated to this Frame Agreement'));
  }
  
  newRecords.add(ct);
        FARecIds.add(afa.id);
  fat.OnAfterInsert(newRecords,FArecIds);
  fat.OnAfterUpdate(newRecords,updatedRecords,oldMap,newMap,FArecIds);
  }
  
  
}