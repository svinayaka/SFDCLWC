@istest
Public Class TestUserInsertUpdate
{
       public static boolean callOut = true;
public static boolean invokeTrigger = false;
String errorMessage = '';


@Testsetup
    static void testUserInsertUpdate(){

        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Account acc=new Account();          
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc.Phone = '03332342345';
        acc.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        acc.RecordtypeId = CommAccrecType ;
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'TOGO';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'TOGO'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.BMPartnerCompanyName__c='GEOR';
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        insert acc;

        contact c= new contact(FirstName='GE', AccountId=acc.Id,lastname='test',email='test@ge.com');
        insert c;
  

//Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
Profile p = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
 
/*GE_Profile__c myStandardUsr = new GE_Profile__c();
       myStandardUsr.name='Standard User';
       myStandardUsr.Profile_Name__c='Standard User';
       myStandardUsr.Profile_SFDC_ID__c='00eA0000000n90x';
       //myStandardUsr.Id='a3rA00000009Bz1';
       insert myStandardUsr;*/

BMUserSecurity__c bmu= new BMUserSecurity__c ();
       // bmu.id='a0nA00000029qog';
        bmu.AdminEmail__c= 'kiranyerneni@ge.com';
        bmu.APIUserName__c='Integration User';
        bmu.APIUserPassword__c='abcd';
        bmu.APISubDomain__c='dev';
        bmu.isActive__c =true;
        bmu.BMSSLRequired__c=true;
        insert bmu;
  
        User u = new User();
        u.FirstName = 'test';
        u.LastName = 'tester';
        u.Email = 'test@example.com';
        u.Username = 'testing@ge.com';
        u.Alias = 'tsf2';
        u.emailencodingkey='UTF-8'; 
        u.languagelocalekey='en_US';
        u.localesidkey='en_US';
        //u.profileid = '00eA0000000n90x';
        u.profileid='00eA0000000b6mR';
        u.timezonesidkey='America/New_York';
        u.Department = BMGlobal.TEST_USER;
        u.IsActive = true;
        u.BMUserType__c = BMGlobal.BM_PARTNER_USER;
        u.BMUserAccessType__c = 'SalesAgent';
        u.isBMEnabled__c = true;
        u.BMMassProvisioning__c = false;
        u.BMUnit__c='English';
        u.ContactId=c.id;
        u.profileId = p.id;
        u.GE_HQ_Tier_3_P_L__c='WPS';
       
      insert u;
     // Test.StartTest();
    /*  try {  insert u; 
        u.isActive=false; u.isBMEnabled__c=false; if (u.ContactId != null && u.BMUserType__c == BMGlobal.BM_INTERNAL_USER){
         Database.update(u,false); } 
      }
                            // Test.StopTest();
/*u.isBMEnabled__c=false;   
           u.BMMassProvisioning__c=false;
           //invokeTrigger = false;
      u.IsActive =true;
        u.isBMEnabled__c =true; */
     
    
       // system.assertequals('u.username','testing@ge.com');
       //u.BMMassProvisioning__c=true;
        // invokeTrigger = false;
  invokeTrigger = true;
  System.RunAs(u) {
            u.isActive=false;
            u.isBMEnabled__c = false;
            u.BMUserAccessType__c='';
            Test.StartTest();  
            try{Database.update(u); }catch(DMLException e){}
            Test.StopTest();
}
   /*    u.IsActive =false;
         u.isBMEnabled__c =false;*/
                
}

   
  static testMethod void testUserInsertUpdate1(){
    /*BMUserSecurity__c[] bmu= [SELECT AdminEmail__c FROM BMUserSecurity__c limit 1];
  
  bmu[0].AdminEmail__c='';
   update bmu[0];*/

  BMUserSecurity__c[] bmu= [SELECT AdminEmail__c FROM BMUserSecurity__c where AdminEmail__c='kiranyerneni@ge.com'];
   update bmu[0];
   
   User user= [Select u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                                    u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                                    u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                                    u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                                    u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c     ,u.BMUserType__c                            
                                 from User u where u.isActive=false and u.isBMEnabled__c=false LIMIT 1];
   update user;
   }
   
    static testMethod void testUserInsertUpdate2()
    {      
    
    User user= [Select u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                                    u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                                    u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                                    u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                                    u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c     ,u.BMUserType__c                            
                                 from User u where u.isActive=true and u.isBMEnabled__c=true LIMIT 1];
   update user;
   
  // user.isActive=false;
  // user.isBMEnabled__c=false;

}
  

}