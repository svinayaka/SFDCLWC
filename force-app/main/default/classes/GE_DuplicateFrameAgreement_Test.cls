@isTest(seeAlldata=true)
public class GE_DuplicateFrameAgreement_Test
{
  static testmethod Void DuplicateFrameAgreement()
  {
        
  
        Account acc = new Account();
        acc.Name = 'TestAccount6345';
        //acc.GE_HQ_Request_Status__c = 'CMF Approved';
        insert acc;
        
         //Account acc1 = [select id from Account where name = 'TestClassAccount' limit 1];
       
       
        
        Contract ct = new Contract();
        ct.Name = 'ssr';
        //ct.Account=acc.Name;
        ct.AccountId=acc.id;
        //ct.GE_PRM_Recommendation_Link__c=apptmtObj.id;
        ct.GE_OG_Evergreen__c=true;
        insert ct; 
        
        
        
  
  Account_Frame_Agreement__c afa = new Account_Frame_Agreement__c();
  afa.Contract_Name__c=ct.id;
  afa.Account_Name__c=acc.id;
  try{
  insert afa; 
  }
  catch(exception emsg){
  system.assert(emsg.getmessage().contains('Duplicate record on Junction Object, Selected Account is already associated to this Frame Agreement'));
  }
  }

}