@isTest()
public class New_Channel_Partner_Access_Test{
    
    public static testMethod void test1() {
        test.startTest();
        PageReference pageRef = Page.New_Channel_Partner_Access_Page;
        Test.setCurrentPage(pageRef);
        String TestAccountName = system.Label.Test_Account_Name;
        Account testRRAccount = new Account(name=TestAccountName);
        testRRAccount.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        testRRAccount.Type = 'Direct Customer';
        testRRAccount.Classification__c = 'Strategic';
        insert testRRAccount;
        Account acc = createBaseData();
        String accid = acc.id;
        
        ApexPAges.StandardController sc = new ApexPages.StandardController(acc);
        New_Channel_Partner_Access cont = new New_Channel_Partner_Access(sc);
        New_Channel_Partner_Access.ContactWrap cnt = new New_Channel_Partner_Access.ContactWrap();
        List<New_Channel_Partner_Access.ContactWrap> LstWrp = New_Channel_Partner_Access.getcontactList(accid);
        system.assertEquals(1, New_Channel_Partner_Access.getcontactList(accid).size());
        system.assertEquals(true,acc.ispartner);
        String mtd1 = New_Channel_Partner_Access.activate(LstWrp[0]);
        //String mtd2 = New_Channel_Partner_Access.activate(LstWrp[1]);
        //LstWrp[1].ssoid = 'a.b';
        //LstWrp[1].RWprimary = false;
        //LstWrp[1].RWaccess = 'Active';
        //String mtd3 = New_Channel_Partner_Access.activate(LstWrp[1]);
        //LstWrp[1].RWaccess = 'De-Activated';
        //String mtd4 = New_Channel_Partner_Access.activate(LstWrp[1]);
        String mtd5 = New_Channel_Partner_Access.changeEmail(LstWrp[0],'ramprasad@ge.com');
        String mtd6 = New_Channel_Partner_Access.changeSSO(LstWrp[0],'ramprasad.prasad');
        //String mtd4 = New_Channel_Partner_Access.makePrimary(LstWrp[0]);
        //New_Channel_Partner_Access.activateRWUser(LstWrp[0]);
        //String mtd5 = New_Channel_Partner_Access.deactivate(LstWrp[0]);
        test.stopTest();
        
 }
    
    public static Account createBaseData(){
    
        User thisUser = [Select Id from User where Id = :UserInfo.getUserId()];
        
        Account acc;
      
        System.runAs ( thisUser ) { 
            RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Relationship Account' Limit 1]; 
            acc = new Account(Name='Test', REcordTypeId=rt.Id, GE_HQ_New_Account_Street__c='Test',GE_HQ_New_Account_City__c='Test',
                                GE_HQ_New_Account_State_Province__c='Test',GE_HQ_New_Account_Zip_Postal_Code__c='Test',
                                Type = 'Direct Customer', Classification__c = 'Strategic',
                                GE_HQ_New_Account_Country__c='BAHRAIN',GE_PW_Phone_New_Request__c='1234567890');
            insert acc;
            
            acc.isPartner = true;
            update acc;
            
            Contact conc1 = new Contact(GE_OG_Contact_Audience__c='Customer Care',FirstName='Test', LastName='Test1', Tier_1_P_L__c='Oil & Gas (O&G)',Tier_2_P_L__c='PII Pipeline Solutions',
                                Email='abc1.xyz@ge.com',accountId=acc.Id,GE_PRM_SSO_ID__c='test.test1');
            insert conc1;
            //Contact conc2 = new Contact(FirstName='Test', LastName='Test2', Tier_1_P_L__c='Oil & Gas (O&G)',Tier_2_P_L__c='PII Pipeline Solutions',
                            //    Email='abc2.xyz@ge.com',accountId=acc.Id,GE_PRM_SSO_ID__c='', RW_isPrimary__c=false, RW_Access__c='', RW_Profile__c='', RW_Change__c=false);
           // insert conc2;
            
            Profile cusPartId = [select id from Profile where UserType = 'PowerPartner' Limit 1];
            
            User partUsrSR = new User(firstname = 'partner', lastname = 'user', email = 'partneruser@ge.com', alias = 'pUsr', profileid = cusPartId.id , contactid = conc1.id, isactive = true,
            GE_HQ_Tier_1_P_L__c = 'Oil & Gas (O&G)', GE_HQ_Tier_2_P_L__c = 'Measurement & Control (M&C)', GE_HQ_Tier_3_P_L__c = 'Inspection Technologies',
        Username = 'partuser@ge.com', title = 'Partner User', CommunityNickname = 'puse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert partUsrSR;
            
        }
        return acc;
    }
}