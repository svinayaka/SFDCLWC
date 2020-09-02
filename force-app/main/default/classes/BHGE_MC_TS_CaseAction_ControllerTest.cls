@isTest
public class BHGE_MC_TS_CaseAction_ControllerTest{

 @testSetup
 public static void DataSetup()
  {
   id RelationAccountid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
   Account acc= new Account();
   acc.RecordTypeId= RelationAccountid;
   acc.Name= 'TestAccount';
   acc.Account_Tier_GEOG__c = 'Country';
   acc.Classification__c= 'Strategic';
   acc.Type = 'Partner';
   acc.ShippingCountry = 'India';
   acc.GE_ES_Primary_Industry__c = 'Marine';
   acc.Country_GEOG__c = 'India';
   Insert acc;
   
  /* Contact con= new Contact();
   con.Email= 'TestContact@gmail.com';
   con.LastName= 'Hook';
   con.FirstName='Tom';
   
   con.AccountId= acc.id;
   Insert con;*/
   
   
  
   
    //id recTypeMcsCS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
    id  recTypeMcTS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();

    Case MCTSCase= new Case();
    MCTSCase.Site_Contact_Information__c='SiteABD';
    MCTSCase.SuppliedEmail='test3421@gmail.com';
    MCTSCase.accountId= acc.id;
    MCTSCase.recordTypeId= recTypeMcTS ;
  
    insert MCTSCase;
    
    
/*
    Case CCCase= new Case();
    MCSCase.Site_Contact_Information__c='SiteABD';
    MCSCase.SuppliedEmail='test41@gmail.com';
    MCSCase.accountId= acc.id;
    MCSCase.recordTypeId= recTypeMcsCS;
  
    insert CCCase;*/
    
    Case TSCase= new Case();
    TSCase.Site_Contact_Information__c='SiteABD';
    TSCase.SuppliedEmail='test421@gmail.com';
    TSCase.AccountId= acc.id;
    //TSCase.ContactId= con.id;   
    TSCase.recordTypeId= recTypeMcTS;
  
    insert TSCase;
    
   BHGE_MC_TS_CaseAction_Controller.fetchProfile();
   BHGE_MC_TS_CaseAction_Controller.fetchRecordTypeId();
 
   
  }
  
  
   static testmethod void moveToTrashBinTest()
   {
     Case cse=  [select id,GE_SS_Owner_Name__c From Case where SuppliedEmail=:'test3421@gmail.com'];
     
     try
     { System.Test.StartTest();
       string result = BHGE_MC_TS_CaseAction_Controller.moveToTrashBin(cse.id);   
       system.assertequals(result,'updated successfully');
       System.Test.StopTest();
       
       }
       
       catch(Exception e)
      {
        System.debug('>>> ERROR ='+e);

      }
   }
   
    static testmethod void caseDetailServerTest()
    { 
     
     Case cse=  [select id,Site_Contact_Information__c From Case where SuppliedEmail=:'test3421@gmail.com'];
     try
     {
       System.Test.StartTest();
        BHGE_MC_TS_CaseAction_Controller.caseDetailServer(cse.id);
        BHGE_MC_TS_CaseAction_Controller.getTaskInfo(cse.id);
       System.Test.StopTest();
      }
      catch(Exception e)
      {
        System.debug('>>> ERROR ='+e);

      }
    
    }
    
     static testmethod void acceptCaseTest()
    {  
     Case cse= [select id,OwnerID From Case where SuppliedEmail=:'test3421@gmail.com'];
     id currentUserId = UserInfo.getUserId();
       
          try
       {
          System.Test.StartTest();
          string msg = BHGE_MC_TS_CaseAction_Controller.acceptCase(cse.id);
          system.assertequals(msg,'Owner Updated Successfully');
          System.Test.StopTest();
       }
        catch(Exception e) 
      {
        System.debug('>>> ERROR ='+e);

      }             
       
    }
    
    
    
    
    static testmethod void updateCaseServerTest()
   
   {
      Case cse=  [select id,Site_Contact_Information__c From Case where SuppliedEmail=:'test3421@gmail.com'];
      try
      {
      System.Test.StartTest();
        BHGE_MC_TS_CaseAction_Controller.updateCaseServer(cse);
         system.assertequals(cse.Status,'Closed');
       System.Test.StopTest();
       }
       
       catch(Exception e)
       {
          System.debug('>>> ERROR ='+e);

       }
   
   }
   
   
   
    static testmethod void flipCaseRecordTypeServerTest()
   
   {
        id recTypeMcsCS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        id  recTypeMcTS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
      Case cse=  [select id,Site_Contact_Information__c,recordTypeId From Case where SuppliedEmail=:'test421@gmail.com'];
      try
      {
      System.Test.StartTest();
        BHGE_MC_TS_CaseAction_Controller.flipCaseRecordTypeServer(cse.id);
        //system.assertequals(cse.recordTypeId,recTypeMcTS);
       System.Test.StopTest();
       }
       
       catch(Exception e)
       {
          System.debug('>>> ERROR ='+e);

       }
   
   }
   
   
  

}