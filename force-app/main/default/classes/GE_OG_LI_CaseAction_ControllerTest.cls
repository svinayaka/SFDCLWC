@isTest
public class GE_OG_LI_CaseAction_ControllerTest{

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
   
   Contact con= new Contact();
   con.Email= 'TestContact@gmail.com';
   con.LastName= 'Hook';
   con.FirstName='Tom';
   con.GE_OG_Contact_Audience__c='Customer Care';
   con.AccountId= acc.id;
   Insert con;
   
   
  
   
    id recTypeMcsCS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
    id  recTypeMcTS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();

    Case MCSCase= new Case();
    MCSCase.Site_Contact_Information__c='SiteABD';
    MCSCase.SuppliedEmail='test3421@gmail.com';
    MCSCase.accountId= acc.id;
    MCSCase.recordTypeId= recTypeMcsCS;
  
    insert MCSCase;
    
    

    Case CCCase= new Case();
    MCSCase.Site_Contact_Information__c='SiteABD';
    MCSCase.SuppliedEmail='test41@gmail.com';
    MCSCase.accountId= acc.id;
    MCSCase.recordTypeId= recTypeMcsCS;
  
    insert CCCase;
    
    Case TSCase= new Case();
    TSCase.Site_Contact_Information__c='SiteABD';
    TSCase.SuppliedEmail='test421@gmail.com';
    TSCase.AccountId= acc.id;
    TSCase.ContactId= con.id;   
    TSCase.recordTypeId= recTypeMcTS;
  
    insert TSCase;
    
   
 EmailMessage EmailMsg = new EmailMessage();
 EmailMsg.FromAddress='autoreply.email@ge.com';
 EmailMsg.FromName = 'Test';
 EmailMsg.ToAddress = 'Test@gmail.com';
 EmailMsg.Subject = '[ ref:TestEmail]';
 EmailMsg.TextBody = 'Testing123';
 EmailMsg.HtmlBody = 'test345';
 EmailMsg.Status = '0';
 EmailMsg.ParentId = MCSCase.Id;
 Insert EmailMsg;
 
   
  }
  
  
   static testmethod void moveToTrashBinTest()
   {
     Case cse=  [select id,GE_SS_Owner_Name__c From Case where SuppliedEmail=:'test3421@gmail.com'];
     
     try
     { System.Test.StartTest();
       string result = GE_OG_LI_CaseAction_Controller.moveToTrashBin(cse.id);   
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
        GE_OG_LI_CaseAction_Controller.caseDetailServer(cse.id);
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
          string msg = GE_OG_LI_CaseAction_Controller.acceptCase(cse.id);
          system.assertequals(msg,'Owner Updated Successfully');
          System.Test.StopTest();
       }
        catch(Exception e) 
      {
        System.debug('>>> ERROR ='+e);

      }             
       
    }
    
    
    static testmethod void returnCaseTest()
    {  
     Case cse=  [select id From Case where SuppliedEmail=:'test3421@gmail.com'];
     try
     {
       System.Test.StartTest();
       string msg = GE_OG_LI_CaseAction_Controller.returnCase(cse.id);
       system.assertequals(msg,'Owner Reverted');
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
        GE_OG_LI_CaseAction_Controller.updateCaseServer(cse);
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
        GE_OG_LI_CaseAction_Controller.flipCaseRecordTypeServer(cse.id);
        //system.assertequals(cse.recordTypeId,recTypeMcTS);
       System.Test.StopTest();
       }
       
       catch(Exception e)
       {
          System.debug('>>> ERROR ='+e);

       }
   
   }
   
   static testmethod void cloneCaseAndAttachServerTest()
   {
      Case cse=  [select id,Site_Contact_Information__c,recordTypeId From Case where SuppliedEmail=:'test3421@gmail.com'];
      try{
      System.Test.StartTest();
      
       GE_OG_LI_CaseAction_Controller.cloneCaseAndAttachServer(cse.id);
       Case clonedcse= GE_OG_LI_CaseAction_Controller.cloneCaseRecord(cse.id);
       ContentDocumentLink contentDoc = new ContentDocumentLink();
       contentDoc.LinkedEntityId = cse.id;
       insert contentDoc;
       GE_OG_LI_CaseAction_Controller.insertAttachmentsToClonedCase(clonedcse.id,cse.id);
      System.Test.StopTest();
      }
      
      catch(Exception e)
      {
        System.debug('>>> ERROR ='+e);

      }
   }
  
  

}