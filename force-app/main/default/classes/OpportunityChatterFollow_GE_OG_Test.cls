/*
    Class/Trigger Name     : OpportunityChatterFollow_GE_OG_Test
    Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityFollowUnFollow_GE_OG Class 
    Scrum Team             : Transformation - OPPTY MGMT
    Author                 : Gourav Anand
    Created Date           : 13-April-2016
    Used For               : OpportunityChatterFollow_GE_OG - 100%
                             OpportunityTeamMemberTrigger_GE_OG - 65%
                                
*/ 

@isTest
public class OpportunityChatterFollow_GE_OG_Test {

    @testsetup
    static void createTestData(){
        
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
    
    static testMethod void followOpportunityChatterOnInsert(){
        
        Test.startTest();
            //Creating an Opportunity
            Account acc2 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
            //Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc2.ID);
            Opportunity  custoppty = new Opportunity();
            custOppty.Name = 'Test Opportunity';
            custOppty.amount_ge_og__c = 685;
            custOppty.CloseDate = date.today();
            custOppty.CurrencyIsoCode = 'USD';
            custOppty.StageName='Prospecting';
            custOppty.tier_1_ge_og__c='Oil & Gas';
        //Changing from Surface to Digital Solutions
            custOppty.tier_2_ge_og__c = 'Digital Solutions';
        //Changing from Pressure Control to Bently Nevada
            custOppty.tier_3_ge_og__c = 'Bently Nevada';
            custOppty.AccountId = acc2.ID;
        
            insert custoppty;
            system.assertEquals('Test Opportunity',custoppty.Name);
            
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
            lstID.add(custoppty.ID);
            system.assertEquals(1,lstID.size());
            
            OpportunityTeamMember otm = CommonTestDataFactory_GE_OG.createOpportunityTeamMember(custoppty.ID, lstUser[1].ID, 'Following') ;
            insert otm;
            
            otm.TeamMemberRole='Legal';
            update otm;
            
            otm.TeamMemberRole='Following';
            update otm;
        
            delete otm;
                
        Test.stopTest();
                
            
        }
}