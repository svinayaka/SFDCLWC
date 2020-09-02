/*
Class Name        : GE_MCS_Add_Partner_To_GroupTest
Purpose/Overview  : Test class for GE_MCS_Add_Partner_To_Group class
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-10-01    : Htut Zaw           : Inital creation
*/
@isTest(SeeAllData = true)
private class GE_MCS_Add_Partner_To_GroupTest
{
  @isTest static void testAddUserToGroup()
  {
    
    ///////////////////////
    // create test Account  //
    ///////////////////////
    String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
    Account testAccount = new Account();
    testAccount.Name = 'Test Account';
    testAccount.GE_HQ_DUNS_Number__c = 'GEGUL9999';
    testAccount.RecordTypeId=recordTypeName;
    testAccount.Classification__c = 'Silver';
    testAccount.type ='EPC';
    insert testAccount;
    
    ///////////////////////
    // create test Contact  //
    ///////////////////////    
    Contact testContact = new Contact();
    testContact.GE_OG_Contact_Audience__c='Customer Care';
    testContact.FirstName = 'Test';
    testContact.LastName = 'Contact';
    testContact.AccountId = testAccount.Id;
    testContact.Email = 'ChPartUser@testorg.com';
    testContact.GE_OG_Contact_Audience__c = 'Sales / ITO';
    insert testContact;

    ///////////////////////
    // create test User  //
    ///////////////////////
    Profile p = [select id from profile where name='GE Channel Partner Community Member'];
    User u = new User(alias = 'partnr', email='ChPartUser@testorg.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US', profileid = p.Id,
            timezonesidkey='America/Los_Angeles', username='ChPartUser@testorg.com',
            GE_HQ_Tier_1_P_L__c='Oil & Gas (O&G)',
            GE_HQ_Tier_2_P_L__c='Measurement & Control (M&C)',
            GE_HQ_Tier_3_P_L__c='Bently Nevada',
            GE_HQ_SSO_ID__c='NA232323T',
            ContactId=testContact.Id,
            IsActive =true);
    Test.startTest();
    System.runAs ( new User(Id = UserInfo.getUserId()) ) {
     insert u;
    }
     
    Test.stopTest();
    
    GE_MCS_COMMUNITY_GROUPS__c commGrp = GE_MCS_COMMUNITY_GROUPS__c.getInstance(u.GE_HQ_Tier_3_P_L__c);
    System.debug('****publi group***'+commGrp.Public_Group_Id__c+'***userid***'+u.id);
    //GroupMember grpMem = [Select Id, GroupId, UserOrGroupId from GroupMember where GroupId=:commGrp.Public_Group_Id__c and UserOrGroupId=:u.Id limit 1];
    //System.assertNotEquals(grpMem.Id,null);   
  }
}