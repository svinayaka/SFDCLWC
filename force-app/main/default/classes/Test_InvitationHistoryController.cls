@istest
Public class Test_InvitationHistoryController{
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
        insert objCon;
        
        Campaign theme    = CommonTestDataFactory_GE_OG.createThemeCampaign('Test GrvTheme1');
        Campaign program  = CommonTestDataFactory_GE_OG.createProgramCampaign('Test GrvProgram1', theme.Id);
        
        
    }
    
    public static testMethod void testSchduleKeyDates(){
        test.startTest();
        
            Campaign themeRec = [Select Id,name from Campaign where name='Test GrvTheme1'];
            Campaign programRec = [Select Id,name from Campaign where name='Test GrvProgram1'];
            Campaign campaignRec = CommonTestDataFactory_GE_OG.createCampaign('Test GrvCampaign1', programRec.Id);
            Contact objC = [select id,email from contact limit 1];
            
            Task objTask = new Task();
            objTask.RecordTypeId= Schema.SObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeId();
            objTask.subject = 'INVHISTFRMMARKT^'+campaignRec.id+'^Annual Meeting 2020.VIP Track - Initial Invite^Email Sent^2019-10-01 13:58:22';
            objTask.type='Call';
            objTask.WhoId = objC.id;
            objTask.status = 'In Progress';
            objTask.ownerId = UserInfo.getUserId();
            objTask.ActivityDate= system.today();
            objTask.whatId =campaignRec.id;
            insert objTask;
            
            CampaignMember cmr = new CampaignMember();
            cmr.CampaignID =campaignRec.Id;
            cmr.ContactId = objC.Id;
            cmr.Status='Lead Prospecting';
            cmr.Invitation_Status__c = 'Sent';
            insert cmr;
            
            List<String> lst  = new List<String>();
            lst.add(String.valueOf(objTask.id));
            InvitationHistoryController.parseInvitationHistory(lst);
            
            objTask.subject = 'TestSub';
            update objTask;
            InvitationHistoryController.parseInvitationHistory(lst);
        test.stopTest();
    }
}