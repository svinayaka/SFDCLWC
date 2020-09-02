@isTest 
private class GEOG_DuplicateContactAccountSharingTest{
    static testMethod void TastStartTest() {
       
        Account acnt = new Account();
        acnt.Name='Test';
         acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         acnt.Account_Tier_GEOG__c = 'Country';
         acnt.Type = 'Direct Customer';
         acnt.Classification__c = 'Strategic';
        insert acnt;
        
        Contact con = new Contact();
        con.GE_OG_Contact_Audience__c='Customer Care';
        con.FirstName= 'Test';
        con.LastName = 'test';
        con.AccountId = acnt.id;
        con.Email = 'test@abc.com';
        //con.GE_HQ_CONTACT_STATUS__c='Inactive';
        insert con;
        
        ContactAccountSharing__c ConAcc = new ContactAccountSharing__c();
        ConAcc.Account_GEOG__c = acnt.id;
        ConAcc.Contact_GEOG__c = con.id;
        ConAcc.Primary_Contact_GE_OG__c = True;
        insert ConAcc;
 
        ContactAccountSharing__c ConAcc1 = new ContactAccountSharing__c();
        ConAcc1.Account_GEOG__c = acnt.id;
        ConAcc1.Contact_GEOG__c = con.id;
        ConAcc1.Primary_Contact_GE_OG__c=True;
        insert ConAcc1;
        ConAcc1.Primary_Contact_GE_OG__c=False;
        Update ConAcc1;
        
    }
}