@isTest 
private class AccountRollupSchedule_Test{
   static testMethod void AccountRollupScheduleTest() {
      
    /*Account glbAccnt = new Account();
    glbAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    glbAccnt.name = 'Slave Account Global';
    glbAccnt.Account_Tier_GEOG__c = 'Global';
    glbAccnt.Classification__c= 'Strategic';
    glbAccnt.Type = 'Customer';
    glbAccnt.ShippingCountry = 'India';
    insert glbAccnt;*/
    
    Account glbAccnt=AccountTestDataFactory.createRelationshipAccountGlobal('Slave Account Global','Customer');   
    
    //Creating Regional Account
    /*Account reginlAccnt = new Account();
    reginlAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    reginlAccnt.name = 'Slave Account Regional';
    reginlAccnt.Account_Tier_GEOG__c = 'Regional';
    reginlAccnt.Country_GEOG__c = 'INDIA';
    reginlAccnt.Classification__c= 'Strategic';
    reginlAccnt.Type = 'Customer';
    reginlAccnt.ShippingCountry = 'India';
    reginlAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    reginlAccnt.ParentId = glbAccnt.Id;
    insert reginlAccnt;*/
    
    Account reginlAccnt=AccountTestDataFactory.createRegionalAccount(glbAccnt.Id,'Slave Account Regional','Customer');
    
    
    
      
    //Creating Country Account
 /* Account cuntryAccnt = new Account();
    cuntryAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    cuntryAccnt.name = 'Slave Account Country';
    cuntryAccnt.Account_Tier_GEOG__c = 'Country';
    cuntryAccnt.Country_GEOG__c = 'INDIA';
    cuntryAccnt.Classification__c= 'Strategic';
    cuntryAccnt.Type = 'Customer';
    cuntryAccnt.ShippingCountry = 'India';
    cuntryAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    cuntryAccnt.ParentId = reginlAccnt.Id;
    insert cuntryAccnt; */
    
    
     account cuntryAccnt = AccountTestDataFactory.createCountryaccount(glbAccnt.Id,reginlAccnt.id,'Slave Account Country',false,false,'Customer');
    
    
    //Creating LE Account
      Account leAccnt = new Account();
    leAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    leAccnt.name = 'Slave LE';
    leAccnt.Account_Tier_GEOG__c = 'LE';
    leAccnt.Type = 'Customer';
    leAccnt.Account_Status__c = 'CC Approved';
    leAccnt.Country_GEOG__c = 'INDIA';
    leAccnt.Classification__c= 'Strategic';
    leAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    leAccnt.Oil_Gas_Parent_Account__c = cuntryAccnt.Id;
    leAccnt.Finance_Lock_GEOG__c = True ;
    leAccnt.Compliance_Lock_GEOG__c = True;
    insert leAccnt;   
    
       // Account leAccnt = AccountTestDataFactory.createLegalEntityAccount('Slave LE', glbAccnt.Id,SlaveaccCountry.id,True,True,'Customer'); 
    
    Test.StartTest();
    opportunity opp = AccountTestDataFactory.createOppty('TestOppty', leAccnt.id);
    Test.stopTest();
   // opportunity opp1 = CommonTestDataFactory_GE_OG.createOppty('TestOppty', cuntryAccnt.id);
    // opportunity opp2 = CommonTestDataFactory_GE_OG.createOppty('TestOppty', reginlAccnt.id);

     
    AccountRollupSchedule schCls = new AccountRollupSchedule();   
    String chron = '0 0 23 * * ?';        
    system.schedule('Test RollupSchedule', chron , schCls);
    
    }
    
    static testMethod void AccountRollupScheduleTest1() {
      
   /*  Account glbAccnt = new Account();
    glbAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    glbAccnt.name = 'Slave Account Global';
    glbAccnt.Account_Tier_GEOG__c = 'Global';
    glbAccnt.Classification__c= 'Strategic';
    glbAccnt.Type = 'Customer';
    glbAccnt.ShippingCountry = 'India';
    insert glbAccnt; */
    
     Account glbAccnt=AccountTestDataFactory.createRelationshipAccountGlobal('Slave Account Global','Customer'); 
    
    //Creating Regional Account
    /* Account reginlAccnt = new Account();
    reginlAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    reginlAccnt.name = 'Slave Account Regional';
    reginlAccnt.Account_Tier_GEOG__c = 'Regional';
    reginlAccnt.Country_GEOG__c = 'INDIA';
    reginlAccnt.Classification__c= 'Strategic';
    reginlAccnt.Type = 'Customer';
    reginlAccnt.ShippingCountry = 'India';
    reginlAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    reginlAccnt.ParentId = glbAccnt.Id;
    insert reginlAccnt; */
    
    Account reginlAccnt=AccountTestDataFactory.createRegionalAccount(glbAccnt.Id,'Slave Account Regional','Customer');
      
      
    //Creating Country Account
   /*  Account cuntryAccnt = new Account();
    cuntryAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    cuntryAccnt.name = 'Slave Account Country';
    cuntryAccnt.Account_Tier_GEOG__c = 'Country';
    cuntryAccnt.Country_GEOG__c = 'INDIA';
    cuntryAccnt.Classification__c= 'Strategic';
    cuntryAccnt.Type = 'Customer';
    cuntryAccnt.ShippingCountry = 'India';
    cuntryAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    cuntryAccnt.ParentId = reginlAccnt.Id;
    insert cuntryAccnt; */
    
    account cuntryAccnt = AccountTestDataFactory.createCountryaccount(glbAccnt.Id,reginlAccnt.id,'Slave Account Country',false,false,'Customer');

    
    
    
    //Creating LE Account
    Account leAccnt = new Account();
    leAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    leAccnt.name = 'Slave LE';
    leAccnt.Account_Tier_GEOG__c = 'LE';
    leAccnt.Type = 'Customer';
    leAccnt.Account_Status__c = 'CC Approved';
    leAccnt.Classification__c= 'Strategic';
    leAccnt.Country_GEOG__c = 'INDIA';
    leAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    leAccnt.Oil_Gas_Parent_Account__c = cuntryAccnt.Id;
    leAccnt.Finance_Lock_GEOG__c = True ;
    leAccnt.Compliance_Lock_GEOG__c = True;
    insert leAccnt;
     
    //account SlaveaccCountry = AccountTestDataFactory.createCountryaccount(glbAccnt.Id,cuntryAccnt.id,'Slave Account Country',true,true,'Customer');

    
    Test.StartTest();
    opportunity opp = AccountTestDataFactory.createOppty('TestOppty1', cuntryAccnt.id);
    Test.stopTest();
     
    AccountRollupSchedule schCls = new AccountRollupSchedule();   
    String chron = '0 0 23 * * ?';        
    system.schedule('Test RollupSchedule', chron , schCls);
    
    } 
    
    static testMethod void AccountRollupScheduleTest2() {
      
    Account glbAccnt = new Account();
    glbAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    glbAccnt.name = 'Slave Account Global';
    glbAccnt.Account_Tier_GEOG__c = 'Global';
    glbAccnt.Classification__c= 'Strategic';
    glbAccnt.Type = 'Hedge';
    glbAccnt.ShippingCountry = 'India';
    glbAccnt.Compliance_Ready__c = True;
    //glbAccnt.Commercial_Ready__c = True;
    insert glbAccnt;
    
     
    
    
    //Creating Regional Account
   /*  Account reginlAccnt = new Account();
    reginlAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    reginlAccnt.name = 'Slave Account Regional';
    reginlAccnt.Account_Tier_GEOG__c = 'Regional';
    reginlAccnt.Country_GEOG__c = 'INDIA';
    reginlAccnt.Classification__c= 'Strategic';
    reginlAccnt.Type = 'Hedge';
    reginlAccnt.Compliance_Ready__c = True;
    //reginlAccnt.Commercial_Ready__c = True;
    reginlAccnt.ShippingCountry = 'India';
    reginlAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    reginlAccnt.ParentId = glbAccnt.Id;
    insert reginlAccnt; */
    
    
    Account reginlAccnt=AccountTestDataFactory.createRegionalAccount(glbAccnt.Id,'Slave Account Regional','Hedge');
      
    //Creating Country Account
    Account cuntryAccnt = new Account();
    cuntryAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    cuntryAccnt.name = 'Slave Account Country';
    cuntryAccnt.Account_Tier_GEOG__c = 'Country';
    cuntryAccnt.Country_GEOG__c = 'INDIA';
    cuntryAccnt.Classification__c= 'Strategic';
    cuntryAccnt.Type = 'Hedge';
    cuntryAccnt.Compliance_Ready__c = True;
    //cuntryAccnt.Commercial_Ready__c = True;
    cuntryAccnt.ShippingCountry = 'India';
    cuntryAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    cuntryAccnt.ParentId = reginlAccnt.Id;
    insert cuntryAccnt;
    
    
    
    //Creating LE Account
   /*  Account leAccnt = new Account();
    leAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    leAccnt.name = 'Slave LE';
    leAccnt.Account_Tier_GEOG__c = 'LE';
    leAccnt.Type = 'Hedge';
    leAccnt.Compliance_Ready__c = True;
    //leAccnt.Commercial_Ready__c = True;
    leAccnt.Account_Status__c = 'CC Approved';
    leAccnt.Country_GEOG__c = 'INDIA';
    leAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    leAccnt.Oil_Gas_Parent_Account__c = cuntryAccnt.Id;
    leAccnt.Classification__c= 'Strategic';
    leAccnt.Finance_Lock_GEOG__c = True ;
    leAccnt.Compliance_Lock_GEOG__c = True;
    insert leAccnt; */
    
     Account leAccnt = AccountTestDataFactory.createLegalEntityAccount('Slave LE', glbAccnt.Id,cuntryAccnt.id,True,True,'Hedge'); 
   
    Test.StartTest(); 
    AccountRollupSchedule schCls = new AccountRollupSchedule();   
    String chron = '0 0 23 * * ?';        
    system.schedule('Test RollupSchedule', chron , schCls);
    Test.stopTest();
    }
    
    static testMethod void AccountRollupScheduleTest3() {
      
    //Creating Country Account
    Account cuntryAccnt = new Account();
    cuntryAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    cuntryAccnt.name = 'Slave Account Country';
    cuntryAccnt.Account_Tier_GEOG__c = 'Country';
    cuntryAccnt.Country_GEOG__c = 'INDIA';
    cuntryAccnt.Classification__c= 'Strategic';
    cuntryAccnt.Type = 'Hedge';
    cuntryAccnt.Compliance_Ready__c = True;
    //cuntryAccnt.Commercial_Ready__c = True;
    cuntryAccnt.ShippingCountry = 'India';
    //cuntryAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    //cuntryAccnt.ParentId = reginlAccnt.Id;
    insert cuntryAccnt;
    
    
    
    //Creating LE Account
    Account leAccnt = new Account();
    leAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    leAccnt.name = 'Slave LE';
    leAccnt.Account_Tier_GEOG__c = 'LE';
    leAccnt.Type = 'Hedge';
    leAccnt.Compliance_Ready__c = True;
    //leAccnt.Commercial_Ready__c = True;
    leAccnt.Account_Status__c = 'CC Approved';
    leAccnt.Country_GEOG__c = 'INDIA';
    //leAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    leAccnt.Oil_Gas_Parent_Account__c = cuntryAccnt.Id;
    leAccnt.Classification__c= 'Strategic';
    leAccnt.Finance_Lock_GEOG__c = True ;
    leAccnt.Compliance_Lock_GEOG__c = True;
    insert leAccnt;
    
    
   
    Test.StartTest(); 
    AccountRollupSchedule schCls = new AccountRollupSchedule();   
    String chron = '0 0 23 * * ?';        
    system.schedule('Test RollupSchedule', chron , schCls);
    Test.stopTest();
    }
    
    static testMethod void AccountRollupScheduleTest4() {
      
    Account glbAccnt = new Account();
    glbAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    glbAccnt.name = 'Slave Account Global';
    glbAccnt.Account_Tier_GEOG__c = 'Global';
    glbAccnt.Classification__c= 'Strategic';
    glbAccnt.Type = 'Customer';
    glbAccnt.ShippingCountry = 'India';
    insert glbAccnt;
    
    //Creating Regional Account
    Account reginlAccnt = new Account();
    reginlAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    reginlAccnt.name = 'Slave Account Regional';
    reginlAccnt.Account_Tier_GEOG__c = 'Regional';
    reginlAccnt.Country_GEOG__c = 'INDIA';
    reginlAccnt.Classification__c= 'Strategic';
    reginlAccnt.Type = 'Customer';
    reginlAccnt.ShippingCountry = 'India';
    reginlAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    reginlAccnt.ParentId = glbAccnt.Id;
    insert reginlAccnt;
      
    //Creating Country Account
    Account cuntryAccnt = new Account();
    cuntryAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    cuntryAccnt.name = 'Slave Account Country';
    cuntryAccnt.Account_Tier_GEOG__c = 'Country';
    cuntryAccnt.Country_GEOG__c = 'INDIA';
    cuntryAccnt.Classification__c= 'Strategic';
    cuntryAccnt.Type = 'Customer';
    cuntryAccnt.ShippingCountry = 'India';
    cuntryAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    cuntryAccnt.ParentId = reginlAccnt.Id;
    insert cuntryAccnt;
    
    //Creating LE Account
    Account leAccnt = new Account();
    leAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    leAccnt.name = 'Slave LE';
    leAccnt.Account_Tier_GEOG__c = 'LE';
    leAccnt.Type = 'Customer';
    leAccnt.Account_Status__c = 'CC Approved';
    leAccnt.Classification__c= 'Strategic';
    leAccnt.Country_GEOG__c = 'INDIA';
    leAccnt.Member_of_GE_OG__c = glbAccnt.Id;
    leAccnt.Oil_Gas_Parent_Account__c = cuntryAccnt.Id;
    leAccnt.Finance_Lock_GEOG__c = True ;
    leAccnt.Compliance_Lock_GEOG__c = True;
    insert leAccnt; 
    
    
    /* Account leAccnt = AccountTestDataFactory.createLegalEntityAccount('Slave LE',glbAccnt.Id,cuntryAccnt.id,True,True,'Customer');  */
    Test.StartTest();
    opportunity opp2 = AccountTestDataFactory.createOppty('TestOppty3', reginlAccnt.id);
    Test.stopTest();
     
    AccountRollupSchedule schCls = new AccountRollupSchedule();   
    String chron = '0 0 23 * * ?';        
    system.schedule('Test RollupSchedule', chron , schCls);
    
    }
    
    static testMethod void AccountRollupScheduleTest5() {
        
    //Creating Country Account
    Account cuntryAccnt = new Account();
    cuntryAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    cuntryAccnt.name = 'Slave Account Country';
    cuntryAccnt.Account_Tier_GEOG__c = 'Country';
    cuntryAccnt.Country_GEOG__c = 'INDIA';
    cuntryAccnt.Classification__c= 'Strategic';
    cuntryAccnt.Type = 'Customer';
    cuntryAccnt.ShippingCountry = 'India';
    cuntryAccnt.Member_of_GE_OG__c = null;
    insert cuntryAccnt;
    
    //Creating LE Account
    Account leAccnt = new Account();
    leAccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    leAccnt.name = 'Slave LE';
    leAccnt.Account_Tier_GEOG__c = 'LE';
    leAccnt.Type = 'Customer';
    leAccnt.Account_Status__c = 'CC Approved';
    leAccnt.Country_GEOG__c = 'INDIA';
    leAccnt.Classification__c= 'Strategic';
    leAccnt.Member_of_GE_OG__c = null;
    leAccnt.Oil_Gas_Parent_Account__c = cuntryAccnt.Id;
    leAccnt.Finance_Lock_GEOG__c = True ;
    leAccnt.Compliance_Lock_GEOG__c = True;
    insert leAccnt; 
    
    /*Account leAccnt = AccountTestDataFactory.createLegalEntityAccount('Slave LE',null,cuntryAccnt.id,True,True,'Customer'); */
   

    opportunity opp = AccountTestDataFactory.createOppty('TestOppty4', leAccnt.id);

    Test.StartTest(); 
    AccountRollupSchedule schCls = new AccountRollupSchedule();   
    String chron = '0 0 23 * * ?';        
    system.schedule('Test RollupSchedule', chron , schCls);
    Test.stopTest();
    }
}