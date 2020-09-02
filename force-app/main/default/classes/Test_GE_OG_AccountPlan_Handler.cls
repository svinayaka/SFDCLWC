/*
Type Name [Class/Trigger/Page Name] : Account Plan Class Handler
Used Where ?                        : 
Purpose/Overview                    :
Functional Area                     : Accounts
Author                              : Satyanarayana Pusuluri
Created Date                        : 05/27/2014           
Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/
public class Test_GE_OG_AccountPlan_Handler
{
    /* this method is used for creating 'Account' record, that is using in all Accounts test classes */
    public static Account createAccount(String name)
    {

        Account Acc = new Account();
        Acc.Name = name;
        Acc.BillingCountry = 'USA';
        Acc.ShippingCountry = 'USA';
        Acc.ShippingState = 'AT';
        Acc.ShippingCity = 'TestShipping City';
        Acc.ShippingStreet = 'Test Shipping Street';
        Acc.ShippingPostalCode = '101010';
        
        insert Acc;
        return Acc;
    }   
    
    /* this method is used for creating 'Account Plan' record, that is using in all Accounts/Account Plan */
    public static GE_HQ_Account_Plan__c createAccountPlan()
    {
        GE_HQ_Account_Plan__c AccPlan = new GE_HQ_Account_Plan__c();
        AccPlan.name = 'TestMeth';
        AccPlan.GE_HQ_Buss_Tier__c = 'Oil & Gas (O&G)';
        AccPlan.GE_HQ_Buss_Tier1__c = 'Subsea (SS)';
        AccPlan.GE_HQ_Risk_Indicator__c = 'Green';
        AccPlan.GE_OG_Tier_3_P_L__c='SS - Offshore';
        //AccPlan.GE_HQ_DDUNS_Number__c = Acc.Id;
        
        Insert AccPlan;
        return AccPlan;
    }
    
    /* this method is used for creating 'Account Plan Relation' record, that is using in all Accounts/Account Plan */
    public static GE_HQ_Acc_AccPlan_Rel__c createAccountPlanRel(Account Acc,GE_HQ_Account_Plan__c AccPlan)
    {
        GE_HQ_Acc_AccPlan_Rel__c AccPlanRel=new GE_HQ_Acc_AccPlan_Rel__c();
        AccPlanRel.GE_HQ_Account_Plan__c=AccPlan.id;
        AccPlanRel.GE_HQ_Account__c=Acc.id;

        Insert AccPlanRel;
        return AccPlanRel;
    } 

    /* this method is used for creating 'User' record, that is using in all Accounts/Account Plan */
    public static User createUser(String Usrname)
    {
        //Id ProfId = [select id from Profile where name = 'GE_ES Developer' limit 1][0].Id;
        List<GE_Profile__c> profile = GE_Profile__c.getall().values();
        Id ProfId = UserInfo.getProfileId();   
        for (GE_Profile__c profilename: profile ) {
            if(profilename.Profile_Name__c == 'GE_ES Developer')
                ProfId = profilename.Profile_SFDC_ID__c;
        }
        
        User usr = new User();
        usr.LastName=Usrname;
        usr.Alias='tuser';
        usr.DefaultGroupNotificationFrequency='N';
        usr.DigestFrequency='N';
        usr.Email='testuser@ge.com';
        usr.Username='testuserr2@ge.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LanguageLocaleKey='en_US';
        usr.LocaleSidKey='IN';
        usr.ProfileId= ProfId;
        usr.TimeZoneSidKey='Asia/Kolkata';
        usr.UserPermissionsCallCenterAutoLogin=false;
        usr.UserPermissionsMarketingUser=false;
        usr.UserPermissionsOfflineUser=false;
      
        Insert usr;
        return usr;
    }   

    /* this method is used for creating 'Installed Base' record, that is using in all Accounts/Account Plan */
    public static GE_Installed_Base__c createInstalledBase(Account Acc)
    {       
        GE_Installed_Base__c InstBase=new GE_Installed_Base__c();
        InstBase.Name='New Test1';
        InstBase.Account__c=Acc.id;

        Insert InstBase;
        return InstBase;
    } 

    /* this method is used for creating 'SubScribe System' record, that is using in all Accounts/Account Plan */
    public static GE_HQ_SUBSCR_SYSTEMS__c createSubScribeSystem(Account Acc)
    {       
        GE_HQ_SUBSCR_SYSTEMS__c SubScrSys=new GE_HQ_SUBSCR_SYSTEMS__c();
        SubScrSys.GE_HQ_Account__c=Acc.id;

        Insert SubScrSys;
        return SubScrSys;
    }       
}