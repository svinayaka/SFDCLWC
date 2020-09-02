@isTest
private class GEESGalaxyContactTest {

   
    static testMethod void testContact(){
     
        Account a = New Account(Name = 'TestAccount');
        
         a.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         a.Account_Tier_GEOG__c = 'Country';
         a.Type = 'Direct Customer';
         a.Classification__c = 'Strategic';
         insert a;
        
        Contact objContact = new Contact();
        objContact.GE_OG_Contact_Audience__c='Customer Care';
        objContact.FirstName='CJTest01';
        objContact.LastName='Test 1';
        objContact.Salutation='Mr.';
        objContact.Email='blabla@ge.com';
        objContact.Phone='111111111';
        objContact.Fax='1212121212';
        objContact.GE_ES_I_Agree_flag__c = TRUE;
        objContact.AccountId= a.id;
        
        insert objContact;

        List<Contact> lstContact = [select ID,FirstName from Contact limit 2];
        for(Contact con :lstContact) {
            con.FirstName = 'MyCon-J';
        }
        update lstContact;
        
        
        
        //obj1.IntegrationExecutionObj.IsOrgName=FALSE;
 

        //delete lstContact;
        //objContact = [SELECT ID,firstname,lastname,salutation,email,phone,fax from Contact limit 1];
    }
    
    static testMethod void testContact2(){
     
        Account a = New Account(Name = 'TestAccount2');
         a.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         a.Account_Tier_GEOG__c = 'Country';
         a.Type = 'Direct Customer';
         a.Classification__c = 'Strategic';
        insert a;
        
        Contact objContact = new Contact();
        objContact.GE_OG_Contact_Audience__c='Customer Care';
        objContact.FirstName='CJTest01';
        objContact.LastName='Test 1';
        objContact.Salutation='Mr.';
        objContact.Email='blabla@ge.com';
        objContact.Phone='111111111';
        objContact.Fax='1212121212';
        objContact.GE_ES_I_Agree_flag__c = TRUE;
        objContact.AccountId = a.id;
        insert objContact;

       // List<Contact> lstContact = [select ID,FirstName from Contact limit 2];
       // for(Contact con :lstContact) {
       //     con.FirstName = 'MyCon-J';
       // }
       // update lstContact;
        
        
        
      GE_ES_ContactGalaxyIntegrationWrapper.isTest = false ;
      GE_ES_ContactGalaxyIntegrationWrapper.newContactRequest(New Set<ID>{objContact.ID}, New Set<ID>{UserInfo.getUserID()},New Set<ID>{a.ID});
    }
    
}