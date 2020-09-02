/*
Class Name        : GE_HQ_User_WS_test
Purpose/Overview  : Test class for GE_HQ_User_WS
Author            : Lakshman Bugude
Modified          : Ashish Yadav
*/

@isTest(seeAlldata=true)
Private Class GE_HQ_User_WS_Test {
    
     Static TestMethod void GE_HQ_User_WS_Test_DeactivateUser() {
        list<User> Dusr = [Select UserName, GE_HQ_SSO_ID__c from User where IsActive = true limit 1];
        System.debug('----Active User SSO----'+Dusr[0].GE_HQ_SSO_ID__c);
        GE_HQ_User_WS.Usr Us = new GE_HQ_User_WS.Usr();
        Us.IsActive = 'FALSE';
        GE_HQ_User_WS.Result Res = new GE_HQ_User_WS.Result();
        Res = GE_HQ_User_WS.DeactivateUser(Us);
        Us.SSOId = Dusr[0].GE_HQ_SSO_ID__c;
        Us.UserName = Dusr[0].Username;
        Res = GE_HQ_User_WS.DeactivateUser(Us);
        Dusr = [Select UserName, GE_HQ_SSO_ID__c from User where IsActive = false limit 1];
        System.debug('----InActive User SSO----'+Dusr[0].GE_HQ_SSO_ID__c);
        Us.SSOId = Dusr[0].GE_HQ_SSO_ID__c;
        Us.UserName = Dusr[0].Username;
        Res = GE_HQ_User_WS.DeactivateUser(Us);
        

      
      
      
     }

     Static TestMethod void GE_HQ_User_WS_Test_InsertUser() {
        Id UsrRole = [Select Id from UserRole where Name = 'GE Energy Svc Adminstrators' limit 1][0].Id;
        Id ChatterProfile = [Select Id from Profile where Name = 'Chatter Free User' limit 1][0].Id;
        Id SalesforceProfile = [Select Id from Profile where Name = 'System Administrator' limit 1][0].Id;
        User use=[Select Id,Name,GE_HQ_SSO_ID__c,Profile.Name from User where Profile.Name != '%Chatter%' and IsActive = True Limit 1];
        GE_HQ_User_WS.Usr Us = New GE_HQ_User_WS.Usr();
        Us.SSOId = '10000001';
        //Us.SSOId = use.GE_HQ_SSO_ID__c;

        Us.FirstName = 'Test';
        Us.LastName = 'Class';
        Us.Email = 'Test.Class@Ge.com';
        Us.UserName = 'Test.Class@ge.com';
        Us.UserRoleId = UsrRole;
        Us.ProfileId = SalesforceProfile;
        Us.FederationIdentifier = '10000001';
        //Us.FederationIdentifier = use.GE_HQ_SSO_ID__c;



        Us.Alias = 'TUsr';
        Us.CurrencyIsoCode = 'USD';
        Us.DefaultCurrencyIsoCode = 'USD';
        Us.EmailEncodingKey = 'UTF-8';
        Us.ForecastEnabled = 'TRUE';
        Us.IDMCountry = 'United States';
        Us.IDMCreation = 'TRUE';
        Us.IDMDepartment = 'TEST';
        Us.IDMState = 'Georgia';
        Us.IsActive = 'TRUE';
        Us.LanguageLocaleKey = 'en_US';
        Us.LocaleSidKey = 'en_US';
        Us.Tier1 = 'HQ';
        Us.Tier2 = '';
        Us.TimeZoneSidKey = 'America/New_York';
        Us.UserPermissionsMobileUser = 'TRUE';
        Us.UserPermissionsSFContentUser = 'TRUE';
        Us.UsrLocation = 'HQ';
        GE_HQ_User_WS.Result Res = New GE_HQ_User_WS.Result();
        Res = GE_HQ_User_WS.InsertUser(Us);
        Us.ProfileId =ChatterProfile;
        Res = GE_HQ_User_WS.InsertUser(Us);
       
        Us.ProfileId =SalesforceProfile; 
        Res = GE_HQ_User_WS.InsertUser(Us);
        Us.Tier2 = 'Compass Users Only';
        Us.UserName = 'Test.Class.1@ge.com';
        Res = GE_HQ_User_WS.InsertUser(Us);
        Res = GE_HQ_User_WS.DeactivateUser(Us);
        //Res = GE_HQ_User_WS.DeactivateUser(Us);
        
        //Us.SSOId = '10000002';
        Us.SSOId = use.GE_HQ_SSO_ID__c;

        //Us.FederationIdentifier = '10000002';
        Us.FederationIdentifier = use.GE_HQ_SSO_ID__c;

        Res = GE_HQ_User_WS.InsertUser(Us);

        //Us.SSOId = '10000003';
        Us.SSOId = use.GE_HQ_SSO_ID__c;


        //Us.FederationIdentifier = '10000002';
        Us.FederationIdentifier = use.GE_HQ_SSO_ID__c;

        Res = GE_HQ_User_WS.InsertUser(Us);
        
        List<User> Usr = [Select UserName, GE_HQ_SSO_ID__c from User where IsActive = false limit 1];
        //Us.SSOId = '10000004';
        Us.SSOId = use.GE_HQ_SSO_ID__c;


        //Us.FederationIdentifier = '10000004';
        Us.FederationIdentifier = use.GE_HQ_SSO_ID__c;


        Us.UserName = Usr[0].Username;
        Res = GE_HQ_User_WS.InsertUser(Us);
     }

     Static TestMethod void GE_HQ_User_WS_Test_Negative() {
        Id UsrRole = [Select Id from UserRole where Name = 'GE Energy Svc Adminstrators' limit 1][0].Id;
        Id UsrProfile = [Select Id from Profile where Name = 'System Administrator' limit 1][0].Id;
         Id ChatterProfile = [Select Id from Profile where Name = 'Chatter Free User' limit 1][0].Id;
        GE_HQ_User_WS.Usr Us = New GE_HQ_User_WS.Usr();
        // Us.UserRoleId = UsrRole;
        GE_HQ_User_WS.Result Res = New GE_HQ_User_WS.Result();
        Res = GE_HQ_User_WS.InsertUser(Us);
		Res = GE_HQ_User_WS.DeactivateUser(Us);
        Us.SSOId = '10000001';
        Us.FirstName = 'Test';
        Us.LastName = 'Class';
        Us.Email = 'Test.Class@Ge.com';
        Us.UserName = 'Test.Class@ge.com';
        Us.UserRoleId = UsrRole;
        Us.ProfileId = UsrProfile;
        Us.FederationIdentifier = '10000001';

        Res = GE_HQ_User_WS.DeactivateUser(Us);
     }
    

}