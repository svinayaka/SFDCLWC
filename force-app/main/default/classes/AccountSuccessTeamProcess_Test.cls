/*
    Class/Trigger Name     : AccountSuccessTeamProcess_AddEditDelete
    Purpose/Overview       : Test Class to calculate the code coverage for the AccountSuccessTeamProcess_AddEditDelete Class 
    Scrum Team             : Accounts & Contacts
    Author                 : Geetha Karmarkar
*/ 
@isTest
public class AccountSuccessTeamProcess_Test{
    @testsetup
    static void createTestData(){
        
        // Create Member Account
        Account acc1 = AccountTestDataFactory.createCommercialParentAccount('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        system.debug('TestAccount Member'+acc1.Name);
        
    }
    
    static testMethod void accountTeamProcess_1(){
        
        Test.startTest();
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'TestAccount Member1234djdjddjdj';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        insert acc;
            
        ID userID = UserInfo.getUserID();
        // Create String to add Deal Team Member
        String jsonString = '{"1":{"AccountId":"' + acc.ID + '","UserId":"' + userID + '","TeamMemberRole":"Sales - Primaray"}}';
        // Add Deal Team Member
        AccountSuccessTeamProcess_AddEditDelete.AddEditDeleteSuccessTeamMember(jsonString);
            
        Test.stopTest();
    }
    
    static testMethod void accountTeamProcess_2(){
        
        Test.startTest();
        
            account acc = new account();
            acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
            acc.name = 'TestAccount Member1234djdjddjdj';
            acc.Account_Tier_GEOG__c = 'Country';
            acc.Country_GEOG__c = 'INDIA';
            acc.Classification__c= 'Strategic';
            acc.Type = 'Direct Customer';
            acc.ShippingCountry = 'India';
            insert acc;
            
            ID userID = UserInfo.getUserID();
            List<User> lstUser = new List<User>();
            
            AccountTeamMember objTeamMember = new AccountTeamMember();
            objTeamMember.UserID = userID ;
            objTeamMember.AccountId= acc.ID;
            objTeamMember.TeamMemberRole = 'Primary - Sales';
            try{
                insert objTeamMember;
            }
            catch(Exception ex){
                
                system.debug('Error while inserting Account Team Mamber');
            }
            
            //objTeamMember.TeamMemberRole = 'Commercial Primary Resource';
            objTeamMember.TeamMemberRole = 'Primary Resource';
            Update objTeamMember;
            
            objTeamMember = new AccountTeamMember();
            objTeamMember = [Select ID, TeamMemberRole from AccountTeamMember where AccountId=: acc.ID];
            
            // Create String to Delete Deal Team Member
            String jsonString = '{"' + objTeamMember.ID + '":{"__deleted":"true"}}';
            // Delete Deal Team Member
            AccountSuccessTeamProcess_AddEditDelete.AddEditDeleteSuccessTeamMember(jsonString);
            
        Test.stopTest();
    }  
    
    static testMethod void accountTeamProcess_3(){
        
        Test.startTest();
            
            account acc = new account();
            acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
            acc.name = 'TestAccount Member1234djdjddjdj';
            acc.Account_Tier_GEOG__c = 'Country';
            acc.Country_GEOG__c = 'INDIA';
            acc.Classification__c= 'Strategic';
            acc.Type = 'Direct Customer';
            acc.ShippingCountry = 'India';
            insert acc;
        
            ID userID = UserInfo.getUserID();
            List<User> lstUser = new List<User>();
            
            AccountTeamMember objTeamMember = new AccountTeamMember();
            objTeamMember.UserID = userID ;
            objTeamMember.AccountID = acc.ID;
            objTeamMember.TeamMemberRole = 'Primary - Sales';
            insert objTeamMember;
            
            objTeamMember = new AccountTeamMember();
            objTeamMember = [Select ID, TeamMemberRole from AccountTeamMember where AccountID =: acc.ID];
                 
            // Create String to Delete Deal Team Member
            String jsonString = '{"' + objTeamMember.ID + '":{"TeamMemberRole":"Marketing"}}';
            // Delete Deal Team Member
            AccountSuccessTeamProcess_AddEditDelete.AddEditDeleteSuccessTeamMember(jsonString);
        
          //*****************//
           // To cover Parser Class
           AccountSuccessTeamParser_GE_OG parserObj = new AccountSuccessTeamParser_GE_OG(acc.id,userId,'Sales'); 
          
            
        Test.stopTest();
    }
}