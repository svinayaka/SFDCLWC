@isTest
public class SendMailToTresholdUserTest 
{
    
    static testMethod void testMethod1() 
    { 
    
       // Oppty_Threshold__c OpptyThreshold = new Oppty_Threshold__c();
        List<Opportunity> lstopty= new List<Opportunity>();
        List<Opportunity> lstoptyupdate= new List<Opportunity>();
        ID ProfileID = [ Select id,UserType from Profile where name = 'System Administrator' and UserType='standard'].id;
        
         account acc = new account();
        acc.name = 'Test Acc';
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.ShippingCountry = 'India';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Region_GEOG__c = 'India';
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        insert acc;
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
       CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        for(Integer i=0 ;i <5;i++)
        {
           opportunity opp = new opportunity();
        opp.name= 'Test Oppty'+i;
        opp.stageName = 'Prospecting';
        //opp.has_opportunitycontactrole_ge_og__c = false;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = acc.Id;
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        opp.amount_ge_og__c =1000000.00;
        opp.amount = 1000000.00;
        opp.install_country_ge_og__c= 'India'; 
        lstopty.add(opp);
        
        }
        
        insert lstopty;
        
        User record5=new User();
  
  record5.firstname='pavan';
  record5.lastname='gada5';
  //record1.Days_Since_Login__c=30;
  record5.Email='ashish.vashisht@ge.com';
 // record1.Is_DND__c='No';
 // record1.Is_Risk_Approver__c='No';
  record5.Username='ashish.vashisht@ge.com.geclone';
  record5.Alias='pgada5';
  record5.CommunityNickname='testname5';
  record5.TimeZoneSidKey='America/New_York';
  record5.LocaleSidKey='en_US';
  record5.EmailEncodingKey='ISO-8859-1';
  record5.ProfileId=ProfileID;
  record5.LanguageLocaleKey='en_US';
  record5.BigDeal_Threshold__c=1.00;
  
  insert record5;
  
  for(opportunity op:lstopty)
  {
  //Test.setCreatedDate(recordId, createdDatetime) 
      Datetime testingday = Datetime.now().addDays(-1);
      Test.setCreatedDate(op.Id, testingday);
      lstoptyupdate.add(op);
  }
  update lstoptyupdate;
  //listusers.add(record5);
 
   
         
             Test.startTest();
            SendMailToTresholdUser obj = new SendMailToTresholdUser();
            DataBase.executeBatch(obj); 
            
         Test.stopTest();
    
    }
}