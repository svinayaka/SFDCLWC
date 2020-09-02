@isTest
Private class GEHQAccountSearchPage_Test
{
    static testMethod void GEHQAccountSearchPage_Test()
    {
        // Creating a new Account Plan
        GE_HQ_Account_Plan__c AccPlan = new GE_HQ_Account_Plan__c();
        AccPlan.GE_HQ_Business_Tier1__c = 'ES';
        // R-24261  GE_HQ_P_L__c  Deleted 
        //AccPlan.GE_HQ_P_L__c = 'ES > MCS';
        Insert AccPlan;
    
        // Creating new Accounts
        Account Acc1 = new Account(Name = 'Test account111',BillingCountry = 'USA',ShippingCountry = 'USA',ShippingState = 'AT',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010',Phone='123456');
        Account Acc2 = new Account(Name = 'Test account112',BillingCountry = 'USA',ShippingCountry = 'USA',ShippingState = 'AT',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010',Phone='123456');
        Account Acc3 = new Account(Name = 'Test account113',BillingCountry = 'USA',ShippingCountry = 'USA',ShippingState = 'AT',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010',Phone='123456');
        List<Account> ListAcc = new List<Account>();
        ListAcc.add(Acc1); ListAcc.add(Acc2); ListAcc.add(Acc3);
        Insert ListAcc;

        // Creating the junction object record to connect the Account and Account Plan
        GE_HQ_Acc_AccPlan_Rel__c AccPlanRel = new GE_HQ_Acc_AccPlan_Rel__c();
        AccPlanRel.GE_HQ_Account__c = Acc1.Id;
        AccPlanRel.GE_HQ_Account_Plan__c = AccPlan.Id;
        Insert AccPlanRel;
                
        PageReference pageRef = Page.GEHQAccountSearchPage;
        Test.setCurrentPageReference(pageRef);
        //Setting the page's Id to the id of Account plan.
        ApexPages.currentPage().getParameters().put('retURL', '/'+AccPlan.Id);
        ApexPages.StandardController con = new ApexPages.StandardController(AccPlanRel);
        GEHQAccountSearchPageController ASP = new GEHQAccountSearchPageController(con);

        ASP.TotalNoOfAccounts=0;
        ASP.getNext();
        ASP.getPrev();
        ASP.getFirst();
        ASP.getLast();
        
        List<SelectOption> accSalesRegions = ASP.accSalesRegions;
        ASP.searchText='%';
        ASP.NoOfRows=1;
        ASP.city='Test%';
        ASP.country='%';
        ASP.state='%';
//        ASP.salesRegion='%';
        ASP.phone='123456';

//Name = 'Test account1',BillingCountry = 'USA',ShippingCountry = 'USA',ShippingState = 'AT',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010',Phone='123456');

        ASP.getAccountResults();
        PageReference pr = ASP.search();
        System.debug('+_+_'+[Select id,name,ShippingStreet from Account where ShippingStreet Like '%Test Sh%']);
        System.debug('TotalNoOfAccounts +++'+ASP.TotalNoOfAccounts );
        ASP.getAccountResults();
        ASP.getNext();
        ASP.getAccountResults();
        ASP.getPrev();
                      
        ASP.chkAllBox();        
        ASP.chkFlag=True;
        ASP.chkAllBox(); 
        ASP.NextCount=0;        
        ASP.getAccountResults();
        
        Account Acc4 = new Account(Name = 'Test account111',BillingCountry = 'USA',ShippingCountry = 'USA',ShippingState = 'AT',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010',Phone='123456');
        List<Account> ListAcc1 = new List<Account>();
        ListAcc1.add(Acc4);
        
        GE_HQ_Acc_AccPlan_Rel__c AccPlanRel1 = new GE_HQ_Acc_AccPlan_Rel__c();
        AccPlanRel1.GE_HQ_Account__c = Acc1.Id;
        AccPlanRel1.GE_HQ_Account_Plan__c = AccPlan.Id;
        Insert AccPlanRel1;
        ASP.NextCount=1;        
        ASP.getAccountResults();
        
        Id[] Selected = ASP.getSelected();
        ASP.setSelected(Selected);
        ASP.ProcessSelected();           
        ASP.Cancel();
        ASP.NextCount=2;        
        ASP.getAccountResults();
        
        ApexPages.currentPage().getParameters().put('accPlanId',AccPlan.Id);
        ASP.chkFlag1=True;        
        ASP.MyGEAccts();        
        ASP.chkAllBox1();  
        ASP.getAccountResults1();          
        ASP.getNext();    
        ASP.getAccountResults1();   
        ASP.getPrev(); 
                                     
        Id[] Selected1 = ASP.getSelected1();
        ASP.setSelected1(Selected1);
        ASP.DeleteSelected();
        ASP.Cancel();           
        
        ASP.NextCount=2;        
        ASP.getAccountResults1();
             
        ASP.AccountType ='My GE Accounts';
        ASP.myGEAccount();

        ASP.AccountType ='All Accounts';
        ASP.myGEAccount();   
        
        List<SelectOption> sOpt = ASP.accountsType;
        
        ApexPages.currentPage().getParameters().put('accPlanId',AccPlan.Id);
        PageReference pgRef= ASP.ProcessSelected();
        PageReference pgRef1= ASP.DeleteSelected();
        pgRef=ASP.Cancel();
    
    }
  
     static testMethod void GEHQAccountSearchPage_Test1()
     {
        Test.startTest();
        //Getting Developer Profile
        Profile developerProfile = [select id from Profile where name = 'GE_ES Developer'];
        
        //Inserting currentUser
        
        User currentUser = new User(firstname = 'Xyz', lastname = 'user', email = 'Xyzuser@ge.com', alias = 'XyzUsr', profileId = developerProfile.Id, 
        Username = 'Xyzuser@ge.com', title = 'Developer User', CommunityNickname = 'Xyzuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert currentUser;
        
        User userObj = new User(firstname = 'Mno', lastname = 'user', email = 'Mnouser@ge.com', alias = 'MnoUsr', profileId = developerProfile.Id, 
        Username = 'Mnouser@ge.com', title = 'Developer User', CommunityNickname = 'Mnouse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert UserObj;
        //User currentUser = [Select Id,GE_HQ_Tier_1_P_L__c,GE_HQ_SSO_ID__c from User where isActive = true and ProfileId =:developerProfile.id limit 1][0];
                
        System.runAs(currentUser){
        
        
        //Inserting otheruser
        User otherUser = new User(firstname = 'Abc', lastname = 'user', email = 'Abcuser@ge.com', alias = 'AbcUsr', profileId = developerProfile.Id, 
        Username = 'Abcuser@ge.com', title = 'Developer User', CommunityNickname = 'Abcuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert otherUser;
        
        
        List<Account> accList =new List<Account>();
        accList = [select id,name from Account where name = 'TestClassAccount-EndUser' or name = 'TestClassAccount-LegalEntity' or name = 'TestClassAccount' or name ='TestClassAccount-ShipTo'];
        String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('Private Plan').getRecordTypeId();
        
        GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = 'PrivatePlan(111111)', OwnerId =otherUser.id, GE_HQ_Business_Tier1__c = 'PW', RecordTypeId = recordTypeName);
        Insert newAccPlan;
        
        List<GE_HQ_Acc_AccPlan_Rel__c> lstAPA = new List<GE_HQ_Acc_AccPlan_Rel__c>();
        for(Account acc: accList){
          
              GE_HQ_Acc_AccPlan_Rel__c newAPA = new GE_HQ_Acc_AccPlan_Rel__c();
              newAPA.GE_HQ_Account__c = acc.Id;
              newAPA.GE_HQ_Account_Plan__c = newaccPlan.Id;
              newAPA.GE_HQ_Acc_Type__c = 'Private Plan';
              lstAPA.add(newAPA);
        }
        
        if(lstAPA.size()>0) insert lstAPA;
        
            // Creating the junction object record to connect the Account and Account Plan
            GE_HQ_Acc_AccPlan_Rel__c AccPlanRel = new GE_HQ_Acc_AccPlan_Rel__c();
            AccPlanRel.GE_HQ_Account__c = accList[0].Id;
            AccPlanRel.GE_HQ_Account_Plan__c = newAccPlan.Id;
            Insert AccPlanRel;
            
            ApexPages.StandardController con = new ApexPages.StandardController(AccPlanRel);
            GEHQAccountSearchPageController ASP = new GEHQAccountSearchPageController(con);
            PageReference pg;
            
            ASP.AccPlanObj.GE_HQ_Select_User__c = otherUser.id;
            //insert ASP.ACCPlanObj;
            
            ASP.chkFlag=false;
            
            ASP.goButton();
            ASP.chkFlag =true;
            ASP.chkAllBox();
            pg=ASP.processSelectButton();
            pg=ASP.CancelClone();
          
            ASP.AccPlanObj.GE_HQ_Select_User__c = userObj.id;
            ASP.goButton();           
        }
        
        Test.stopTest();

     }
    
}