@isTest
private class GE_OG_AccountTriggerHandler_Test{
    static testMethod void AccountStrengthTest() {
        test.startTest();
         List<Account> newAccnts = new List<Account>();
         
         Account acnt = new Account();
         acnt.Name='Customer value perception';
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         acnt.Strength__c = 'Low';
         newAccnts.add(acnt);
         insert newAccnts;
         test.stopTest();
     }
    
     static testMethod void AccountStrengthTest1() {
         test.startTest();
         List<Account> newAccnts = new List<Account>();
                 
         Account acnt = new Account();
         acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         acnt.Account_Tier_GEOG__c = 'Country';
         acnt.Name='Customer value perception';
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         //acnt.Compliance_Ready__c = True;
         //acnt.GE_Account_Success_Team_X_GEOG__c = 3;
         acnt.GE_ES_Primary_Industry__c = 'FOUNDRY';
         acnt.Strength__c = 'Medium';
         newAccnts.add(acnt);
         insert newAccnts;
         
         Contact cont = new Contact();
         cont.LastName = 'Test';
         cont.FirstName = 'Test';
         cont.Phone = '98745632145';
         cont.Email = 'test@test1298.com';
         cont.GE_PRM_Primary_Contact__c = True;
         cont.AccountId = acnt.Id;
         cont.GE_OG_Contact_Audience__c = 'Sales / ITO';
         insert cont;
         
         ContactAccountSharing__c conshar = new ContactAccountSharing__c ();
         conshar.Primary_Contact_GE_OG__c = True;
         conshar.Account_GEOG__c = acnt.Id;
         conshar.Contact_GEOG__c = cont.Id;
         insert conshar;
        
        acnt.Strength__c = 'Medium';
        update acnt;
        test.stopTest();
    }
    
    static testMethod void AccountStrengthTest2() {
    test.startTest();    
    List<Account> newAccnts = new List<Account>();

    Account acnt = new Account();
        
         acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         acnt.Account_Tier_GEOG__c = 'Country';
        
    acnt.Name='Customer value perception';
    acnt.Type = 'EPC';
    acnt.Classification__c = 'Strategic';
    acnt.Compliance_Ready__c = True;
    //acnt.GE_Account_Success_Team_X_GEOG__c = 3;
    acnt.GE_ES_Primary_Industry__c = 'FOUNDRY';
    acnt.Strength__c = 'High';
    //insert acnt;

    newAccnts.add(acnt);
    insert newAccnts;

    AccountTeamMember atm = new AccountTeamMember();
    atm.AccountId = acnt.id;
    atm.userid = UserInfo.getUserId();
    atm.teammemberrole = 'Following';
    insert atm;

    Contact cont = new Contact();
    cont.LastName = 'Test';
    cont.FirstName = 'Test';
    cont.Phone = '98745632145';
    cont.Email = 'test@tes124537t.com';
    cont.GE_PRM_Primary_Contact__c = True;
    cont.AccountId = acnt.Id;
    cont.GE_OG_Contact_Audience__c = 'Sales / ITO';
    insert cont;

    ContactAccountSharing__c conshar = new ContactAccountSharing__c ();
    conshar.Primary_Contact_GE_OG__c = True;
    conshar.Account_GEOG__c = acnt.Id;
    conshar.Contact_GEOG__c = cont.Id;
    insert conshar;
     test.stopTest();   
     }
     
    Static testMethod void ComplianceReady_Test() {
   
    List<Account> newAccnts = new List<Account>();
    
    account acc = new account();
    acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    acc.name = 'Account Global';
    acc.Account_Tier_GEOG__c = 'Global';
    acc.Classification__c= 'Unclassified';
    acc.Type = 'Direct Customer';
    acc.ShippingCountry = 'India';
    insert acc;
    
    //newAccnts.add(acc);
    
    //Creating Regional account
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = 'Test Account Regional';
    accRegional.Account_Tier_GEOG__c = 'Regional';
    accRegional.Country_GEOG__c = 'INDIA';
    accRegional.Classification__c= 'Unclassified';
    accRegional.Type = 'Direct Customer';
    accRegional.ShippingCountry = 'India';
    accRegional.Member_of_GE_OG__c = acc.Id;
    accRegional.ParentId = acc.Id;
    insert accRegional;
    //newAccnts.add(accRegional);
      
    //Creating Country account
    account accCountry = new account();
    accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accCountry.name = 'Test Account Country';
    accCountry.Account_Tier_GEOG__c = 'Country';
    accCountry.Country_GEOG__c = 'INDIA';
    accCountry.Classification__c= 'Unclassified';
    accCountry.Type = 'Direct Customer';
    accCountry.ShippingCountry = 'India';
    accCountry.Member_of_GE_OG__c = acc.Id;
    accCountry.ParentId = accRegional.Id;
    accCountry.Finance_Lock_GEOG__c = True;
    accCountry.Compliance_Ready__c  =  False;
    //insert accCountry;
    newAccnts.add(accCountry);
    
    insert newAccnts;
   
    Contact con = new Contact();
    con.FirstName='test';
    con.LastName='test';
    con.Email='terst@test.com';
    con.AccountId = accCountry.Id;
    con.GE_OG_Contact_Audience__c = 'Sales / ITO';
    insert con;
    
    Contact con2 = new Contact();
    con2.FirstName='test';
    con2.LastName='test';
    con2.Email='terst1@test.com';
    con2.AccountId = accCountry.Id;
    con2.GE_OG_Contact_Audience__c = 'Sales / ITO';
    insert con2;
      
    //Creating LE account    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Type = 'Direct Customer';
    accLE.Classification__c = 'Do Not Contact';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'New';
    accLE.Member_of_GE_OG__c = acc.Id;
    insert accLE;
    Account LEResult=[Select id,name,Oil_Gas_Parent_Account__c,Account_Status__c,RecordTypeId from Account where id=:accLE.id];
    LEResult.Account_Status__c = 'CC Approved';  
    update LEResult;
    //newAccnts.add(accLE);
    //insert newAccnts;
    
    test.starttest();
    acc.name ='test1test12';
    acc.type = 'Direct Customer';
    update acc;
    
    test.stoptest();
   }
    
    Static testMethod void testMethodClassification() {
   
    List<Account> newAccnts = new List<Account>();
    test.starttest();
    account acc = new account();
    acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    acc.name = 'Account Global';
    acc.Account_Tier_GEOG__c = 'Global';
    acc.Classification__c= 'Strategic';
    acc.Type = 'Direct Customer';
    acc.ShippingCountry = 'India';
    insert acc;
   
    //Creating Regional account
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = 'Test Account Regional';
    accRegional.Account_Tier_GEOG__c = 'Regional';
    accRegional.Country_GEOG__c = 'INDIA';
    accRegional.Classification__c= 'Strategic';
    accRegional.Type = 'Direct Customer';
    accRegional.ShippingCountry = 'India';
    accRegional.Member_of_GE_OG__c = acc.Id;
    accRegional.ParentId = acc.Id;
    insert accRegional;
     
    //Creating Country account
    account accCountry = new account();
    accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accCountry.name = 'Test Account Country';
    accCountry.Account_Tier_GEOG__c = 'Country';
    accCountry.Country_GEOG__c = 'INDIA';
    accCountry.Classification__c= 'Strategic';
    accCountry.Type = 'Direct Customer';
    accCountry.ShippingCountry = 'India';
    accCountry.Member_of_GE_OG__c = acc.Id;
    accCountry.ParentId = accRegional.Id;
    accCountry.Finance_Lock_GEOG__c = True;
    accCountry.Compliance_Ready__c  =  False;
    insert accCountry;
      
    //Creating LE account    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Type = 'Direct Customer';
    accLE.Classification__c = 'Do Not Contact';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'CC Approved';
    accLE.Member_of_GE_OG__c = acc.Id;
    insert accLE;

    test.stoptest();
    //acc.Classification__c = 'Do Not Contact';
    //update acc;
    
    
   }
   
    Static testMethod void testMethodLeMemberOffChange() {
   
    List<Account> newAccnts = new List<Account>();
    
    account acc = new account();
    acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    acc.name = 'Account Global';
    acc.Account_Tier_GEOG__c = 'Global';
    acc.Classification__c= 'Strategic';
    acc.Type = 'Direct Customer';
    acc.ShippingCountry = 'India';
    insert acc;
    
    account acc2 = new account();
    acc2.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    acc2.name = 'Account Global';
    acc2.Account_Tier_GEOG__c = 'Global';
    acc2.Classification__c= 'Strategic';
    acc2.Type = 'Direct Customer';
    acc2.ShippingCountry = 'India';
    insert acc2;
   
    //Creating Regional account
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = 'Test Account Regional';
    accRegional.Account_Tier_GEOG__c = 'Regional';
    accRegional.Country_GEOG__c = 'INDIA';
    accRegional.Classification__c= 'Strategic';
    accRegional.Type = 'Direct Customer';
    accRegional.ShippingCountry = 'India';
    accRegional.Member_of_GE_OG__c = acc.Id;
    accRegional.ParentId = acc.Id;
    insert accRegional;
     
    //Creating Country account
    account accCountry = new account();
    accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accCountry.name = 'Test Account Country';
    accCountry.Account_Tier_GEOG__c = 'Country';
    accCountry.Country_GEOG__c = 'INDIA';
    accCountry.Classification__c= 'Strategic';
    accCountry.Type = 'Direct Customer';
    accCountry.ShippingCountry = 'India';
    accCountry.Member_of_GE_OG__c = acc.Id;
    accCountry.ParentId = accRegional.Id;
    accCountry.Finance_Lock_GEOG__c = True;
    accCountry.Compliance_Ready__c  =  False;
    insert accCountry;
      
    //Creating LE account    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Type = 'Direct Customer';
    accLE.Classification__c = 'Do Not Contact';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'CC Approved';
    accLE.Member_of_GE_OG__c = acc.Id;
    insert accLE;

    test.starttest();
    accCountry.Member_of_GE_OG__c = acc2.Id;
    update accCountry;
    
    test.stoptest();
   }
   
  /* The below test method is to cover code coverage for method 'UpdateTeamMemberRole' under class 'GE_OG_AccountTriggerHandlerMethods'.
     Created By: Niranjana Venkatesh
     Requirement Number: R-24714 */
     
   Static testMethod void testPrimarySalesOwner() {
    test.startTest();
    List<User> usrList = new List<User>();
        Profile p = [SELECT Id FROM Profile WHERE Name='OG_Sales/Comm Ops'];
        User testUser1 = new User(alias = 'TstUsr1',Firstname='tst1', email='newuserDP@ge.com', 
                                  emailencodingkey='UTF-8', lastname='Tst11', languagelocalekey='en_US', 
                                  localesidkey='en_US',ProfileId = p.Id,timezonesidkey='America/Los_Angeles', 
                                  username='newuser11@ge.com');
        
        User testUser2 = new User(alias = 'TstUsr2',Firstname='tst2', email='newuserDP2@ge.com', 
                                  emailencodingkey='UTF-8', lastname='Tst112', languagelocalekey='en_US', 
                                  localesidkey='en_US', ProfileId = p.Id, timezonesidkey='America/Los_Angeles', 
                                  username='newuser112@ge.com');
        //insert testUser1;
        usrList.add(testUser1);
        usrList.add(testUser2);
        insert usrList;
       
        System.runAs(testUser1){
            
        Account acc = new Account(Name = 'Test Shell', 
                                  OwnerId = testUser1.Id);
            insert acc;
        
        AccountTeamMember accteam = new AccountTeamMember(UserId=testUser1.Id, AccountId=acc.id, TeamMemberRole='Sales - Primary');
            insert accteam;
  
       acc.OwnerId = testUser2.Id;
           
       update acc;
       test.stopTest();
   }
   }
   public static testMethod void testCheckForOppty(){
       test.startTest();
       
        String strRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        String strRecordTypeParentId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        
        Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
        insert hqAccount;
        
        Account regionalAccount = new Account(name='regionalParent', type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Regional',RecordTypeId=strRecordTypeParentId,parentId=hqAccount.id,Compliance_Ready__c=true);
        insert regionalAccount;
        
        Account parentAccount = new Account(name='parentTestunlink123',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,parentId=regionalAccount.id,Compliance_Ready__c=true);
        insert parentAccount;
        
        Account parentAccount2 = new Account(name='parentTestunlink456',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,parentId=regionalAccount.id,Compliance_Ready__c=true);
        insert parentAccount2;

        Account objTestAccount = new Account(name='unlinkTestAccount',type='Direct Customer', Classification__c = 'Strategic',Account_Status__c='CC Approved',Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId);
        insert objTestAccount;
        
        Account LEResult=[Select id,name,Oil_Gas_Parent_Account__c,Account_Status__c,RecordTypeId from Account where id=:objTestAccount.id];
        LEResult.Oil_Gas_Parent_Account__c=parentAccount2.id;
        
        system.assertEquals(parentAccount2.id, LEResult.Oil_Gas_Parent_Account__c);   
        
        UnlinkLEController.uncheckCommercialReady(LEResult.id);
        
        LEResult.Oil_Gas_Parent_Account__c = null;
        update LEResult;
        
        /*objTestAccount.Oil_Gas_Parent_Account__c = parentAccount.id;
        update objTestAccount;
        */
        //Account regionalAccount2 = new Account(name='regionalParent2',Account_Tier_GEOG__c='Regional',RecordTypeId=strRecordTypeParentId,parentId=hqAccount.id,Compliance_Ready__c=true);
        //insert regionalAccount2;
        
        /*Account parentAccount2 = new Account(name='parentTestunlink12322',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,parentId=regionalAccount.id,Compliance_Ready__c=true);
        insert parentAccount2;
        
        objTestAccount.Oil_Gas_Parent_Account__c = null;
        update objTestAccount;*/
        
        test.stopTest();
   }
   
  public static testMethod void testGovernamentFlag(){
       
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'CMF Approved' LIMIT 1].Id;
        String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
        
        Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
        insert hqAccount;
        
        Account regionalAccount = new Account(name='regionalParent', type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Regional',RecordTypeId=strRecordTypeParentId,parentId=hqAccount.id,Compliance_Ready__c=true);
        insert regionalAccount;
        
        Account parentAccount = new Account(name='parentTestunlink123',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,parentId=regionalAccount.id,Compliance_Ready__c=true);
        insert parentAccount;
        Account objTestAccount = new Account(name='unlinkTestAccount',type='Direct Customer', Classification__c = 'Strategic',Account_Status__c='CC Approved',GE_HQ_GOVT_FLG2__c=false,Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId);
        insert objTestAccount;
        
        test.startTest();
        objTestAccount.GE_HQ_GOVT_FLG2__c = true;
        update objTestAccount;
        objTestAccount.GE_HQ_GOVT_FLG2__c = False;
        update objTestAccount;
        test.stopTest();
   }
   
   public static testMethod void testActiveInacitve(){
       test.startTest();
       String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'CMF Approved' LIMIT 1].Id;
       String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
       Account parentAccount = new Account(name='parentTestunlink123',type='Direct Customer', Classification__c = 'Unclassified',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId, Compliance_Ready__c=true);
       insert parentAccount;
       Account objTestAccount = new Account(name='unlinkTestAccount',type='Direct Customer', Classification__c = 'Strategic',Account_Status__c='CC Approved',GE_HQ_GOVT_FLG2__c=false,Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId);
       insert objTestAccount;
       parentAccount.type='Channel Partner';
       update parentAccount;
       test.stopTest();
   }
   
   public static testMethod void testActiveInacitveGlobal(){
       test.startTest();
       String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
       Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
       insert hqAccount;
       
       Account parentAccount = new Account(name='parentTestunlink123',type='Direct Customer', Classification__c = 'Unclassified',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId, Compliance_Ready__c=true, Member_of_GE_OG__c=hqAccount.id);
       insert parentAccount;
       
       parentAccount.type='Channel Partner';
       update parentAccount;
       test.stopTest();
   }
   
   /*public static testMethod void testCheckforOpptyUnlink()
   {
       test.startTest();
       
       String strRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
       String strRecordTypeParentId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
       List<Account> lstCountrys = new List<Account>();
       Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
       insert hqAccount;
       
       Account parentAccount = new Account(name='parentTestunlink123',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
       lstCountrys.add(parentAccount);
        
        Account parentAccount2 = new Account(name='parentTestunlink456',type='Direct Customer',Member_of_GE_OG__c=hqAccount.id, Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
        lstCountrys.add(parentAccount2);
        insert lstCountrys;
        
        Account objTestAccount = new Account(name='unlinkTestAccount',type='Direct Customer', Classification__c = 'Strategic',Account_Status__c='CC Approved',Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId, Account_Tier_GEOG__c='LE');
        insert objTestAccount;
        
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();

        opportunity opp = new opportunity();
        opp.name= 'Name Test Unlink';
        opp.stageName = 'Prospecting';
        //opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'MENAT';
        //opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = parentAccount.id;
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India'; 
        opp.legal_entity_ge_og__c = objTestAccount.id;    
        opp.end_user_ge_og__c = objTestAccount.id;
        insert opp;
        try{
            objTestAccount.Oil_Gas_Parent_Account__c = parentAccount2.id;
            //objTestAccount.Oil_Gas_Parent_Account__c = null;
            update objTestAccount;
            
        }
        catch(Exception e){
            system.debug('Exception for add error');
        }
        
       test.stopTest();
   }*/
   
   public static testMethod void uncheckComplianceReady()
   {
       test.startTest();
       
       String strRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
       String strRecordTypeParentId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
       
       Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
        insert hqAccount;
        
        Account regionalAccount = new Account(name='regionalParent', type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Regional',RecordTypeId=strRecordTypeParentId,parentId=hqAccount.id,Compliance_Ready__c=true);
        insert regionalAccount;
        
       Account parentAccount = new Account(name='parentTestunlink123',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,parentId=regionalAccount.id);
        insert parentAccount;
        
        Account parentAccount2 = new Account(name='parentTestunlink456',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,parentId=regionalAccount.id);
        insert parentAccount2;

        Account objTestAccountOther = new Account(name='unlinkTestAccountOther',type='Direct Customer', Classification__c = 'Strategic',Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId, Account_Tier_GEOG__c='LE');
        insert objTestAccountOther;
        
        Account objTestAccount = new Account(name='unlinkTestAccount',type='Direct Customer', Classification__c = 'Strategic',Account_Status__c='CC Approved',Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId, Account_Tier_GEOG__c='LE');
        insert objTestAccount;
        
        objTestAccount.Oil_Gas_Parent_Account__c = parentAccount2.id;
        update objTestAccount;
            
        
       test.stopTest();
   }

   public static testMethod void MDMfieldTransformationTest()
   {
       String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'CMF Approved' LIMIT 1].Id;
        String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
        
        Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
        insert hqAccount;
        
        Account regionalAccount = new Account(name='regionalParent', type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Regional',RecordTypeId=strRecordTypeParentId,parentId=hqAccount.id,Compliance_Ready__c=true);
        insert regionalAccount;
        
        Account parentAccount = new Account(name='parentTestunlink123',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId,parentId=regionalAccount.id,Compliance_Ready__c=true);
        insert parentAccount;
        Account objTestAccount = new Account(name='unlinkTestAccount',type='Direct Customer', Classification__c = 'Strategic',Account_Status__c='CC Approved',GE_HQ_GOVT_FLG2__c=false,Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId);
        insert objTestAccount;
        
        test.startTest();
        objTestAccount.Watchlist_Flag_Reason__c  = 'A;B';
        List<Account> accList = new List<Account>();
        accList.add(objTestAccount);
        GE_OG_AccountTriggerHandlerMethods.redFlagReasonTransformationLogic (accList);
        test.stopTest();
        
   }
   
   }