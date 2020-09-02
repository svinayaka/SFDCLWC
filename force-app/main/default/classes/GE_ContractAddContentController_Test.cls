@isTest
public class GE_ContractAddContentController_Test{


 testMethod static void AddContentTest1(){        
        Test.StartTest();
    try{
  

       
        profile chnlMagrId  =  [select id from profile where name ='System Administrator' limit 1];
        User chnlManr = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = chnlMagrId.id, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        /*
          list<PermissionSetAssignment> psaName = new   list<PermissionSetAssignment>();
        List<PermissionSet> PSName ;
        PermissionSetAssignment objPSa ;
         PSName=[Select Id,Name, IsOwnedByProfile, Profile.Name, Label from PermissionSet where Name IN ('GE_OG_FA_Manager','PRM_Contractual_Team','GE_Super_PRM_Contractual_Team')];
        
        for (PermissionSet objPS : PSName )
         {
         objPSa= new PermissionSetAssignment();
         objPSa.PermissionSetid = objPS.id;
         objPSa.Assigneeid=chnlManr.id;
         psaName.add(objPSa);
         
         }
        // insert psaName;*/
         
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc12=rtByName_acc1.getRecordTypeId();
        
        GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account Acc= new Account();
        Acc.Name='Test Acc';  
        Acc.GE_HQ_KYC_Complete__c=False;
        Acc.GE_PRM_KYC_Completed__c=False;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='D&S - DT';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        Acc.GE_HQ_Nts_Comments__c='Test'; 
        Acc.GE_OG_MDM_Shipping_Country_ISO_Code__c = 'US';     
        acc.GE_OG_MDM_Billing_Country_ISO_Code__c ='IN';       
        acc.RecordTypeId=acc12;
        acc.GE_OG_AccFin_Status__c='In Progress';
        acc.GE_HQ_Request_Status__c ='CMF Approved';
        acc.ShippingCountry ='ARGENTINA';
        acc.GE_PW_Phone_New_Request__c='(111)111-1111';
        Acc.GE_HQ_Site_Use_Code__c ='BILL_TO';
        
        insert acc;
 // Contract with Address Info.
 String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        contract Cntrct = new contract(); 
        Cntrct.GE_ES_User_Lead_Sales_Person__c = chnlManr.id; 
        Cntrct.Accountid = acc.id; 
        Cntrct.GE_PRM_Region__c ='US South';
        Cntrct.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)'; 
        Cntrct.Status = 'Awaiting Review before to be sent to channel'; 
        Cntrct.recordtypeid = contractRecordTypeMasterId;
        Cntrct.ContractTerm = 12;
        Cntrct.GE_PRM_Tier_2__c = 'Drilling & Surface (D&S)';
        Cntrct.GE_PRM_Tier_3__c = 'Artificial Lift (AL)';
        Cntrct.GE_PRM_Tier_4__c = 'Artificial Lift (AL)';     
        Cntrct.GE_OG_Evergreen__c = true;
        Cntrct.BillingStreet =  'Test';
        Cntrct.BillingCity =  'Test';
        Cntrct.BillingState =  'Test';
        Cntrct.BillingPostalCode =  'Test';
        Cntrct.BillingCountry =  'Test';
        Cntrct.ShippingStreet =  'Test';
        Cntrct.ShippingCity =  'Test';
        Cntrct.ShippingState =  'Test';
        Cntrct.ShippingPostalCode =  'Test';
        Cntrct.ShippingCountry =  'Test';
        insert Cntrct;

  /*System.runAs(chnlManr)
    {*/
    
     GE_ContractAddContentController  controller = new GE_ContractAddContentController (new ApexPages.StandardController(Cntrct));
    GE_ContractAddContentController.Originalpage(Cntrct.id);
    }
    //}
     catch(Exception e1)
        {
            
            system.debug(e1);
            
        }
    Test.stopTest();
    }
    }