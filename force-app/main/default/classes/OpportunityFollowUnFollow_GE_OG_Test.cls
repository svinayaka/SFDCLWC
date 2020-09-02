/*
    Class/Trigger Name     : OpportunityFollowUnFollow_GE_OG_Test
    Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityFollowUnFollow_GE_OG Class 
    Scrum Team             : Transformation - OPPTY MGMT
    Author                 : Mohit Maheshwari
    Created Date           : 13-Feb-2016
    Used For               : OpportunityFollowUnFollow_GE_OG - 90%
*/ 

@isTest
public class OpportunityFollowUnFollow_GE_OG_Test{
    
    @testsetup
    static void createTestData(){
    
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        insert objcustom;
        
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
        
        
    }
    
    static testMethod void updateOpportunityAsFollowUnFollow(){
        
        Test.startTest();
        
            Opportunity opp = [Select ID, Name from Opportunity where Name = 'Testopportunity'];
            system.assertEquals('Testopportunity',opp.Name);
            
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
            User objUser = new User(Alias = 'standt1', Email='standarduser1@testbsoft.com', 
            EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@testbsoft.com');
        
            insert objUser;
        
            objUser = new User(Alias = 'standt2', Email='standarduser2@testbsoft.com', 
            EmailEncodingKey='UTF-8', LastName='Testing2', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser2@testbsoft.com');
            
            insert objuser;    
            
            ID userID = UserInfo.getUserID();
            List<User> lstUser = new List<User>();
            
            lstUser = [Select ID from User where Profile.Name = 'System Administrator' and IsActive = True and ID !=: userID limit 2];
            system.assertEquals(2,lstUser.size());
    
            List<ID> lstID = new List<ID>();
            lstID.add(opp.ID);
            system.assertEquals(1,lstID.size());
             
            system.runAs(lstUser[0]){
                OpportunityFollowUnFollow_GE_OG.updateOpportunityAsFollow_UnFollow(lstID);
                OpportunityFollowUnFollow_GE_OG.updateOpportunityAsFollow_UnFollow(lstID);
            }
            
            OpportunityTeamMember objTeamMember = new OpportunityTeamMember();
            objTeamMember.UserID = lstUser[1].ID;
            objTeamMember.OpportunityID = opp.ID;
            objTeamMember.TeamMemberRole = 'Application Engineer';
            insert objTeamMember;
            
            system.runAs(lstUser[1]){
                try{
                    OpportunityFollowUnFollow_GE_OG.updateOpportunityAsFollow_UnFollow(lstID);
                }catch(Exception ex){}    
            }
        
        Test.stopTest();
    }
    
}