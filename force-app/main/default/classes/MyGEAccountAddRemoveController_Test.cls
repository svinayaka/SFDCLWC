/*    
Class Name        : MyGEAccountAddRemoveController_Test
Purpose/Overview  : Test Class for MyGEAccountAddRemoveAccTeamController
Author            : Malemleima Chanu
Created Date      : 15th March 2011
Test Class        :  MyGEAccountAddRemoveController_Test

*/

@isTest
private class MyGEAccountAddRemoveController_Test{

    Public Static TestMethod void MyGEAccountAddRemoveControllerTest() {
        Id ProfId = [select id from Profile where name = 'GE_ES Developer' limit 1][0].Id;
        User usr = new User(LastName='Test User',Alias='Tuser',DefaultGroupNotificationFrequency='N',DigestFrequency='N',Email='testuser@ge.com',Username='testuserr2@ge.com',EmailEncodingKey='UTF-8',LanguageLocaleKey='en_US',LocaleSidKey='IN',ProfileId= ProfId,TimeZoneSidKey='Asia/Kolkata',UserPermissionsCallCenterAutoLogin=false,UserPermissionsMarketingUser=false,UserPermissionsOfflineUser=false);
        Insert usr;
        Account Acc = new Account(Name = 'Test Account',BillingCountry = 'India',ShippingCountry = 'India',ShippingState = 'Delhi',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010');
        Insert Acc;  
        GE_HQ_Account_Plan__c testAccPlan = new GE_HQ_Account_Plan__c();
        testAccPlan.Name = 'TestAccPlan';
        testAccPlan.RecordTypeId = [select id, name from recordtype where name = 'Private Plan'].id;
        insert testAccPlan;
        
        GE_HQ_Acc_AccPlan_Rel__c MyAcc = new  GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account_Plan__c = testAccPlan.Id,GE_HQ_Account__c = Acc.Id,GE_HQ_Acc_Type__c = 'Private Plan');
        Insert MyAcc;     

          PageReference pageRef = Page.GE_OG_MyGEAcc_Add;
            Test.setCurrentPageReference(pageRef);
            ApexPages.currentPage().getParameters().put('AccIds', Acc.Id);
            ApexPages.currentPage().getParameters().put('Action', 'AT');
       
            System.runAs(usr) {
            
            MyGEAccountAddRemoveAccTeamController Con ; // = new  MyGEAccountAddRemoveAccTeamController();
           // Con.reDirect();
         //   Con.reDirect();
            // Covering AddToAccountTeam() method
            ApexPages.currentPage().getParameters().put('Action', 'AT');
            ApexPages.currentPage().getParameters().put('MyGEAccIds',MyAcc.Id);
            Con = new  MyGEAccountAddRemoveAccTeamController();
            Con.getRoles(); con.SelectedRole = 'Approver';
            Con.reDirect();
            Con.AddToAccountTeam();
            Con.AddToAccountTeam();
            // Covering RemoveFromAccountTeam() method
            ApexPages.currentPage().getParameters().put('Action', 'RT');
            Con = new MyGEAccountAddRemoveAccTeamController();
            Con.reDirect();
            Con.Back();
            
           
        }
    }
    }