/*    
Class Name        : Test_AccountSearchController
Purpose/Overview  : Test Class for AccountSearchController
Author            : Chetan Vaidya
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : Old release   : Chetan Vaidya      : Test Class Created : Created the Test class
                  : 08th Sep 2011 : Jayadev Rath       : Test Class Updated : To Increase the Coverage of the class without any change of the functionality
*/
@isTest
private class Test_AccountSearchController {
    public static testMethod void TestAccSrchCnt() {
        
        AccountSearchController accsrchcon = new AccountSearchController();
       /*
        List<Account> Al = new List<Account>();
        Account Acc= new Account(name='TestAcc');        Al.add(Acc);
        Account AccDel= new Account(name='TestAccDel');  Al.add(AccDel);
        Insert Al; 
        
        account Acc1 = new account();
        Acc1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        Acc1.Name = 'accname';
        Acc1.Account_Tier_GEOG__c = 'Country';
        Acc1.Country_GEOG__c = 'USA';
        Acc1.Classification__c= 'Strategic';
        Acc1.BillingCountry = 'USA';
        Acc1.ShippingCountry = 'USA';
        Acc1.GE_HQ_DUNS_Number__c='555126948';
        Acc1.GE_ES_Primary_Industry__c = 'ABC';
        Acc1.ShippingState = 'AT';
        Acc1.ShippingCity = 'TestShipping City';
        Acc1.ShippingStreet = 'Test Shipping Street';
        Acc1.ShippingPostalCode = '101010';
        insert Acc1 ;
        
        Opportunity oppObj =new Opportunity();
        //Recordtype oppRecordType = [select id from Recordtype where  SobjectType = 'Opportunity' and name = 'O&G'];
        oppObj.name='Test Opp';
        //oppObj.recordtypeid=oppRecordType.id;
        oppObj.AccountId=Acc1.Id;
        oppObj.StageName='Prospecting';
        oppObj.amount_ge_og__c = 568956;
        oppObj.bid_due_date_ge_og__c=Date.today();
        oppObj.CloseDate=oppObj.bid_due_date_ge_og__c+3;
        //oppObj.tier_1_ge_og__c='Oil & Gas (O&G)';
        oppobj.tier_1_ge_og__c='Power & Water (P&W)';
        oppobj.tier_3_ge_og__c= 'Wind Services';
        oppObj.tier_2_ge_og__c='SubSea (SS)';
        oppObj.region_ge_og__c= 'Europe';
        //oppobj.commercial_primary_resource_ge_og__c=Userinfo.getUserId();
        insert oppObj; 
        
        PageReference pageRef = Page.AccountSearch;
        pageRef.getParameters().put('id',Acc1.id); 
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con= new ApexPages.standardController(Al[0]);
        AccountSearchController AccSrchCon = new AccountSearchController(con);
        // Set the variables of the controller
        AccSrchCon.FromTest=True;
        AccSrchCon.str =Acc;
        AccSrchCon.Cancel();
        AccSrchCon.Submit();
        AccountIntegrationWrapper.wsdlstatus='SUCCESS';
        AccSrchCon.Submit();
        AccSrchCon.DeleteRec();
        // Invoking the else part of the deleteRec() method
        pageRef.getParameters().put('id',Acc1.id); 
        Test.setCurrentPage(pageRef);
        con= new ApexPages.standardController(Acc1);
        AccSrchCon = new AccountSearchController(con);
        AccSrchCon.DeleteRec(); 
        */
    }
}