@isTest(seeAllData = true)
private class GE_OG_DealRTest_Trigger
{
   
    static testmethod Deal_Reviewer_Criteria_ge_og__c testDRC()
    {
        Deal_Reviewer_Criteria_ge_og__c drc = new Deal_Reviewer_Criteria_ge_og__c();
        drc.type_ge_og__c = 'Deal Reviewer';
        //drc.deal_reviewer_criteria_category_ge_og__c = 'Finance' ;
        drc.RecordTypeId = '01212000000VolH';
        //drc.deal_reviewer_criteria_region_ge_og__c = 'Asia Pacific' ;
        insert drc;
        return drc;
    }
    
    static testmethod User testuser()
    {
         ID ProfileID = [ Select id,UserType from Profile where name = 'System Administrator' and UserType='standard'].id;
        User record1=new User();
          record1.firstname='pavan';
          record1.lastname='gada';
          record1.Days_Since_Login__c=35;
          record1.Email='ashish.vashisht@ge.com';
          record1.Username='ashish.vashisht@ge.com.geclone';
          record1.Alias='pgada';
          record1.CommunityNickname='testname';
          record1.TimeZoneSidKey='America/New_York';
          record1.LocaleSidKey='en_US';
          record1.EmailEncodingKey='ISO-8859-1';
          record1.ProfileId=ProfileID;
          record1.LanguageLocaleKey='en_US';
          record1.IDM_Business__c ='GE Oil & Gas';
        insert record1;
        
        
        
        return record1;
        
    }
   
    static testmethod User testuser2()
    {
         ID ProfileID = [ Select id,UserType from Profile where name = 'System Administrator' and UserType='standard'].id;
        User record1=new User();
          record1.firstname='Ashish1';
          record1.lastname='vas1';
          record1.Days_Since_Login__c=40;
          record1.Email='ashish.vashisht11@ge.com';
          record1.Username='ashish.vashisht11@ge.com.geclone';
          record1.Alias='ash';
          record1.CommunityNickname='testname1';
          record1.TimeZoneSidKey='America/New_York';
          record1.LocaleSidKey='en_US';
          record1.EmailEncodingKey='ISO-8859-1';
          record1.ProfileId=ProfileID;
          record1.LanguageLocaleKey='en_US';
          record1.IDM_Business__c ='GE Oil & Gas';
        insert record1;
        
        
        
        return record1;
        
    }
    
    static testMethod void testInsertDR() 
    {
        Deal_Reviewer_Criteria_ge_og__c drc = testDRC();
        User u = testuser();
        Deal_Reviewer_ge_og__c d = new Deal_Reviewer_ge_og__c();
        //d.deal_reviewer_criteria_num_ge_og__c =  drc.id;
        d.user_ge_og__c = u.Id;
        
        Test.startTest();
        insert d;
         
        User u1 = testuser2();
        d.user_ge_og__c = u1.Id ;
        update d;
        
        delete d;
        
        Test.stopTest();
    
    }
    
    
}