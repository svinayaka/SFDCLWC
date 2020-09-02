/*
Class/Trigger Name     : OpportunityDealTeamProcess_GE_OG_Test
Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityFollowUnFollow_GE_OG Class 
Scrum Team             : Transformation - OPPTY MGMT
Author                 : Mohit Maheshwari
Created Date           : 13-Feb-2016
Used For               : OpportunityDealTeamProcess_GE_OG - 90%
AddOpportunityTeamMemberAutomation_GE_OG - 80%   
*/ 

@isTest
public class OpportunityDealTeamProcess_GE_OG_Test{
    
    @testsetup
    static void createTestData(){
        
        List<Profile> lstProfile = new List<Profile>();
        lstProfile = [Select ID, Name from profile where Name in ('System Administrator', 'GE_ES Developer')];
        
        List<profile_permission_ge_og__c> lstcustomSet = new List<profile_permission_ge_og__c>();
        
        for(Profile objprofile : lstProfile){
            profile_permission_ge_og__c objprofileset = new profile_permission_ge_og__c();
            objprofileset.profile_id_ge_og__c = objprofile.ID;
            if(objprofile.name == 'System Administrator')
                objprofileset.Name = 'System Administrator';
            else
                objprofileset.Name = 'GE_ES Developer';
            lstcustomSet.add(objprofileset);
        }
        
        if(lstcustomSet.size()>0)
            insert lstcustomSet;
        
        
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
    
    static testMethod void methodOpportunityDealTeamProcess_1(){
        
        Test.startTest();
        
        Opportunity opp = [Select ID, Name from Opportunity where Name = 'Testopportunity'];
        system.assertEquals('Testopportunity',opp.Name);
        
        ID userID = UserInfo.getUserID();
        
        // Create String to add Deal Team Member
        String jsonString = '{"1":{"OpportunityId":"' + opp.ID + '","UserId":"' + userID + '","TeamMemberRole":"Sales - Primaray"}}';
        // Add Deal Team Member
        OpportunityDealTeamProcess_GE_OG.AddEditDeleteDealTeamMember(jsonString);
        
        Test.stopTest();
    }
    
    static testMethod void methodOpportunityDealTeamProcess_2(){
        
        Test.startTest();
        
        Opportunity opp = [Select ID, Name, ownerid from Opportunity where Name = 'Testopportunity'];
        system.assertEquals('Testopportunity',opp.Name);
        
        ID userID = UserInfo.getUserID();
        List<User> lstUser = new List<User>();
        
        OpportunityTeamMember objTeamMember = new OpportunityTeamMember();
        objTeamMember.UserID = userID ;
        objTeamMember.OpportunityID = opp.ID;
        objTeamMember.TeamMemberRole = 'Primary - Sales';
        try{
            insert objTeamMember;
        }
        catch(Exception ex){
            
            system.assertequals(true,ex.getMessage().contains('Sales - Primary can only be changed when Opportunity Owner changed.'));
        }
        
        //objTeamMember.TeamMemberRole = 'Commercial Primary Resource';
        objTeamMember.TeamMemberRole = 'Primary Resource';
        Update objTeamMember;
        
        objTeamMember = new OpportunityTeamMember();
        objTeamMember = [Select ID, TeamMemberRole from OpportunityTeamMember where OpportunityID =: opp.ID];
        
        // Create String to Delete Deal Team Member
        String jsonString = '{"' + objTeamMember.ID + '":{"__deleted":"true"}}';
        // Delete Deal Team Member
        OpportunityDealTeamProcess_GE_OG.AddEditDeleteDealTeamMember(jsonString);
        
        Test.stopTest();
    }  
    
    static testMethod void methodOpportunityDealTeamProcess_3(){
        
        Test.startTest();
        
        Opportunity opp = [Select ID, Name from Opportunity where Name = 'Testopportunity'];
        system.assertEquals('Testopportunity',opp.Name);
        
        ID userID = UserInfo.getUserID();
        List<User> lstUser = new List<User>();
        
        OpportunityTeamMember objTeamMember = new OpportunityTeamMember();
        objTeamMember.UserID = userID ;
        objTeamMember.OpportunityID = opp.ID;
        objTeamMember.TeamMemberRole = 'Primary - Sales';
        insert objTeamMember;
        
        objTeamMember = new OpportunityTeamMember();
        objTeamMember = [Select ID, TeamMemberRole from OpportunityTeamMember where OpportunityID =: opp.ID];
        
        // Create String to Delete Deal Team Member
        String jsonString = '{"' + objTeamMember.ID + '":{"TeamMemberRole":"Marketing"}}';
        // Delete Deal Team Member
        OpportunityDealTeamProcess_GE_OG.AddEditDeleteDealTeamMember(jsonString);
        
        //*****************//
        
        
        
        Test.stopTest();
    }
    
    static testMethod void methodOpportunityDealTeamProcess_4(){
        
        Test.startTest();
        
        // Let's create a new test user
        Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
        
        List<User> lstUser = new List<User>();
        
        User testUser = new User(LastName = 'test user 1', Username = 'test.user.bs1@example.com', Email = 'test.bs1@example.com', Alias = 'testu1',                TimeZoneSidKey = 'GMT', LocaleSidKey = 'en_GB', EmailEncodingKey = 'ISO-8859-1', ProfileId = testProfile.Id, LanguageLocaleKey = 'en_US', IsActive = True); 
        
        lstUser.add(testUser);
        
        testUser = new User(LastName = 'test user 2', Username = 'test.user.bs2@example.com', Email = 'test.bs2@example.com', Alias = 'testu2',                 TimeZoneSidKey = 'GMT', LocaleSidKey = 'en_GB', EmailEncodingKey = 'ISO-8859-1', ProfileId = testProfile.Id, LanguageLocaleKey = 'en_US', IsActive = True); 
        
        lstUser.add(testUser);
        
        testUser = new User(LastName = 'test user 3', Username = 'test.user.bs3@example.com', Email = 'test.bs3@example.com', Alias = 'testu2',                 TimeZoneSidKey = 'GMT', LocaleSidKey = 'en_GB', EmailEncodingKey = 'ISO-8859-1', ProfileId = testProfile.Id, LanguageLocaleKey = 'en_US', IsActive = True); 
        
        lstUser.add(testUser);
        
        insert lstUser;
        
        ID userID = UserInfo.getUserID();
        
        lstUser = [Select ID from User where profileID =: testProfile.ID and IsActive = True and ID !=: userID limit 3];
        
        Opportunity opp = [Select ID, Name, OwnerID from Opportunity where Name = 'Testopportunity'];
        system.assertEquals('Testopportunity',opp.Name);
        
        
        //List<User> lstUser = new List<User>();
        
        List<OpportunityTeamMember> lstOTM = new List<OpportunityTeamMember>();
        
        OpportunityTeamMember objTeamMember = new OpportunityTeamMember();
        objTeamMember.UserID = lstUser[0].ID;
        objTeamMember.OpportunityID = opp.ID;
        //objTeamMember.TeamMemberRole = 'Commercial Primary Resource';
        objTeamMember.TeamMemberRole = 'Commercial Resource';
        lstOTM.add(objTeamMember);
        
        objTeamMember = new OpportunityTeamMember();
        objTeamMember.UserID = lstUser[1].ID;
        objTeamMember.OpportunityID = opp.ID;
        objTeamMember.TeamMemberRole = 'Application Engineer';
        lstOTM.add(objTeamMember);
        
        objTeamMember = new OpportunityTeamMember();
        objTeamMember.UserID = userID ;
        objTeamMember.OpportunityID = opp.ID;
        objTeamMember.TeamMemberRole = 'Reviewer';
        lstOTM.add(objTeamMember);
        
        if(lstOTM.size()>0)
            insert lstOTM;
        
        
        lstOTM = [Select ID, OpportunityID, TeamMemberRole from OpportunityTeamMember where TeamMemberRole in ('Commercial Primary Resource','Application Engineer','Reviewer') order by TeamMemberRole];
        
        List<OpportunityTeamMember> lstupdateOTM = new List<OpportunityTeamMember>();
        
        for(OpportunityTeamMember objOTM : lstOTM){
            if(objOTM.TeamMemberRole == 'Commercial Primary Resource'){
                objOTM.TeamMemberRole = 'Reviewer';
                lstupdateOTM.add(objOTM);
            }
            else if(objOTM.TeamMemberRole == 'Application Engineer'){
                objOTM.TeamMemberRole = 'Commercial Primary Resource';
                lstupdateOTM.add(objOTM);
            }
        }   
        Test.stopTest();
    }
    
    static testMethod void methodOpportunityDealTeamProcess_5(){
        
        Test.startTest();
        
        // Let's create a new test user
        Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
        
        List<User> lstUser = new List<User>();
        
        User testUser = new User(LastName = 'test user 1', Username = 'test.user.bs1@example.com', Email = 'test.bs1@example.com', Alias = 'testu1',                TimeZoneSidKey = 'GMT', LocaleSidKey = 'en_GB', EmailEncodingKey = 'ISO-8859-1', ProfileId = testProfile.Id, LanguageLocaleKey = 'en_US', IsActive = True); 
        
        lstUser.add(testUser);
        
        insert lstUser;
        
        ID userID = UserInfo.getUserID();
        
        lstUser = [Select ID from User where profileID =: testProfile.ID and IsActive = True and ID !=: userID limit 1];
        
        Opportunity opp = [Select ID, Name, OwnerID from Opportunity where Name = 'Testopportunity'];
        system.assertEquals('Testopportunity',opp.Name);
        
        Util_GE_OG.isFromOppTriggerInsert = true;
        
        opp.OwnerID = lstUser[0].ID;
        update opp;
        
        
        Test.stopTest();
    }   
    
    static testMethod void methodOpportunityDealTeamProcess_6(){
        
        Test.startTest();
        
        // Let's create a new test user
        Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
        
        List<User> lstUser = new List<User>();
        
        User testUser = new User(LastName = 'test user 1', Username = 'test.user.bs1@example.com', Email = 'test.bs1@example.com', Alias = 'testu1',                TimeZoneSidKey = 'GMT', LocaleSidKey = 'en_GB', EmailEncodingKey = 'ISO-8859-1', ProfileId = testProfile.Id, LanguageLocaleKey = 'en_US', IsActive = True); 
        
        lstUser.add(testUser);
        
        insert lstUser;
        
        Opportunity opp = [Select ID, Name, OwnerID from Opportunity where Name = 'Testopportunity'];
        system.assertEquals('Testopportunity',opp.Name);
        
        ID userID = UserInfo.getUserID();
        
        lstUser = [Select ID from User where profileID =: testProfile.ID and IsActive = True and ID !=: userID limit 1];
        
        List<OpportunityTeamMember> lstOTM = new List<OpportunityTeamMember>();
        
        OpportunityTeamMember objTeamMember = new OpportunityTeamMember();
        objTeamMember.UserID = lstUser[0].ID;
        objTeamMember.OpportunityID = opp.ID;
        //objTeamMember.TeamMemberRole = 'Commercial Primary Resource';
        objTeamMember.TeamMemberRole =  'Primary Resource';
        lstOTM.add(objTeamMember);
        
        insert  lstOTM;
        
        
        
        lstOTM = new List<OpportunityTeamMember>();
        //lstOTM = [Select ID, OpportunityID, TeamMemberRole from OpportunityTeamMember where TeamMemberRole in ('Commercial Primary Resource') order by TeamMemberRole];
        lstOTM = [Select ID, OpportunityID, TeamMemberRole from OpportunityTeamMember where TeamMemberRole in ('Primary Resource') order by TeamMemberRole];
        delete lstOTM;
        //Added by Rupal
        List<OpportunityTeamMember> lstOTM1 = new List<OpportunityTeamMember>();
        
        OpportunityTeamMember objTeamMember1 = new OpportunityTeamMember();
        objTeamMember1.UserID = lstUser[0].ID;
        objTeamMember1.OpportunityID = opp.ID;
        objTeamMember1.TeamMemberRole = 'Commercial Primary Resource';
        //objTeamMember1.TeamMemberRole =  'Primary Resource';
        
        insert  objTeamMember1;
        //  objTeamMember1.TeamMemberRole='Commercial Primary Resource';
        lstOTM1 = [Select ID, OpportunityID, TeamMemberRole from OpportunityTeamMember where TeamMemberRole in ('Commercial Primary Resource') order by TeamMemberRole];
        delete lstOTM1; 
        //End Added by Rupal
        
        
        
        Test.stopTest();
    }
    static testMethod void methodOpportunityDealTeamProcess_7(){
        
        Test.startTest();
        
        // Let's create a new test user
        Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
        
        List<User> lstUser = new List<User>();
        
        User testUser = new User(LastName = 'test user 1', Username = 'test.user.bs1@example.com', Email = 'test.bs1@example.com', Alias = 'testu1',                TimeZoneSidKey = 'GMT', LocaleSidKey = 'en_GB', EmailEncodingKey = 'ISO-8859-1', ProfileId = testProfile.Id, LanguageLocaleKey = 'en_US', IsActive = True); 
        
        insert testUser;
        
        Opportunity opp = [Select ID, Name, OwnerID from Opportunity where Name = 'Testopportunity'];
        system.assertEquals('Testopportunity',opp.Name);
        
        ID userID = UserInfo.getUserID();
        
        opp.Commercial_Primary_Resource_ge_og__c = testUser.Id;
        update opp;
        
        
        
        Test.stopTest();
    }
}