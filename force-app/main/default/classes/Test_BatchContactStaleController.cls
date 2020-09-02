@istest
Public class Test_BatchContactStaleController{

    @testsetup
    static void createData(){
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account KP test';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c ='Industrial';
        acc.Country_GEOG__c = 'India';
        insert acc;
        
        Contact objCon = new Contact();
        objCon.FirstName = 'testConKP123';
        objCon.LastName = 'LastnameKP123';
        objCon.email = 'test@kp123.com';
        objCon.AccountId = acc.id;
        objCon.title = 'Test';
        objCon.phone='123456';
        objCon.GE_OG_Country__c ='India';
        objCon.MailingCity ='Test';
        objCon.MailingCountry  ='India';
        objCon.MailingPostalCode  ='123456';
        objCon.MailingStreet  ='Test';
        objCon.GE_ES_Function__c ='Sales';
        insert objCon;
        
        
    }
    
    public static testMethod void testStaleNonStale(){
        test.startTest();
            Contact objCon = [select id, FirstName, LastName,Last_Customer_Engagement_Date__c,Stale_Contact__c,Contact_Stale__c,Contact_Stale_Reason__c,Stale_Reason_Code__c,Contact_Stale_Date__c FROM Contact where FirstName='testConKP123' limit 1];
            objCon.Stale_Contact__c ='';
            update objCon;
            
            List<Contact> lstCon = [SELECT id,firstname,lastname, Contact_Stale__c, Contact_Stale_Date__c, Contact_Stale_Reason__c, Stale_Contact__c, Stale_Reason_Code__c FROM Contact];
            system.debug(lstCon);
            
            List<Contact> lstCon1 = [SELECT id,firstname,lastname, Contact_Stale__c, Contact_Stale_Date__c, Contact_Stale_Reason__c, Stale_Contact__c, Stale_Reason_Code__c FROM Contact where Contact_Stale__c='Stale' and Stale_Contact__c!='Stale'];
            
            ScheduleContactStaleController schedule_apex = new ScheduleContactStaleController();
            String CRON_EXP = '0 0 0 15 3 ? *';
            System.schedule('ScheduleContactStaleController',  CRON_EXP, schedule_apex);
            
                       
        test.stopTest();
    }
}