@isTest
Public Class populateParentAccount_Test
{
 // public static list<id> acid=new list<id>();
  // public static Set<String> strParentDuns= new Set<String>();
   public Static TestMethod void populateParentAccount_Test11()
   {
   
    Test.startTest(); 
    Account Accct=new Account(); 
     Accct.Name='CUSTOMERLINX OF';
     Accct.GE_HQ_New_Account_City__c='AB7hhS';
     Accct.GE_PW_State_Province_Bill_To__c='Texaslp';
     Accct.GE_HQ_New_Account_Zip_Postal_Code__c='3353687';
     Accct.Parent_Duns__c='535366777';
     Accct.GE_HQ_DUNS_Number__c='535366777';
     Insert Accct;

  
     Accct.Parent_Duns__c='988558098';
     Accct.GE_HQ_DUNS_Number__c='988558098';
     Update Accct;
    
    // Account a1=[select id,GE_HQ_DUNS_Number__c from account where id=:accc.id];
     //acid.add(Accc.id);
     //strParentDuns.add(Accc.Parent_Duns__c);
     Test.stopTest();
     }
     
     public Static TestMethod void populateParentAccount_Test111()
   {
   
    Test.startTest(); 
    Account Accct=new Account(); 
     Accct.Name='CUSTOMERLINX OF';
     Accct.GE_HQ_New_Account_City__c='AB7hhS';
     Accct.GE_PW_State_Province_Bill_To__c='Texaslp';
     Accct.GE_HQ_New_Account_Zip_Postal_Code__c='3353687';
     Accct.Parent_Duns__c='535366777';
     Accct.GE_HQ_DUNS_Number__c='535366787';
     Insert Accct;

  
     Accct.Parent_Duns__c='988558098';
     Accct.GE_HQ_DUNS_Number__c='988558099';
     Update Accct;
    
    // Account a1=[select id,GE_HQ_DUNS_Number__c from account where id=:accc.id];
     //acid.add(Accc.id);
     //strParentDuns.add(Accc.Parent_Duns__c);
     Test.stopTest();
     }
     

 
}