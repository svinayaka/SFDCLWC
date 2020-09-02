//sendRequestBorrowCtrl


@IsTest 
public class sendRequestBorrowCtrlTest {
   
    static testmethod void callTestData() {
         // SD_getCrewDetails objTest = new SD_getCrewDetails();
        String orgId = userInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Id accOfficeRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Office').getRecordTypeId();
        Id conOfficeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Field Personnel').getRecordTypeId();
        Profile p = [SELECT Id FROM Profile WHERE Name='Service Delivery Coordinator']; 
        
        // insert User
        //1.Prepare Test User Record
        User tuser = new User();
        tuser.firstname = 'abTest';
        tuser.lastName = 'MTest';
        tuser.email = uniqueName + '@test' + orgId + '.org';
        tuser.Username = uniqueName + '@test' + orgId + '.org';
        tuser.EmailEncodingKey = 'ISO-8859-1';
        tuser.Alias = uniqueName.substring(18, 23);
        tuser.TimeZoneSidKey = 'America/Los_Angeles';
        tuser.LocaleSidKey = 'en_US';
        tuser.LanguageLocaleKey = 'en_US';
        //tuser.ProfileId = '00eA0000000n90vIAA';
        tuser.ProfileId = p.id;
        // Insert tuser;
        
        
        
        //
        //2. Prepare Test Account Record
        Account testAcc = new Account();
        testAcc.Name = 'ABTestAccount';
        // testAcc.OwnerId = tuser.Id;
        testAcc.RecordTypeId = accRecordTypeId;
        testAcc.Classification__c = 'Platinum'; 
        testacc.Type = 'Direct Customer';
        Insert testAcc;
        
        
        //2.1 Prepare Test Office Account Record
        Account testAccOfc = new Account();
        testAccOfc.Name = 'ABTestAccount';
        // testAccOfc.OwnerId = tuser.Id;
        testAccOfc.RecordTypeId = accOfficeRecordTypeId;
        testAccOfc.SD_Product_Line__c = 'DS';
        testAccOfc.SD_Service_Delivery_Region__c = 'Europe';
        // testAccOfc.SD_Job_Coordinator__c = tuser.Id;
        testAccOfc.Classification__c = 'Platinum'; 
        testAccOfc.Type = 'Direct Customer';
        Insert testAccOfc;
        
        
        //3.Prepare Test Contact Record
        Contact testContact = new Contact();
        testContact.firstname='ABTestCont';
        testContact.lastname='abTest';
        testContact.FX5__Office__c=testAccOfc.ID;           
        testContact.Email = 'abTest@test.Com';
        testContact.RecordTypeId =conOfficeRecordTypeId;
        testContact.GE_PRM_SSO_ID__c = '123456789';
        testContact.AccountId = testAcc.ID;
        testContact.GE_OG_Contact_Audience__c = 'Customer Care';
        Insert testContact;
        
        
        // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
        testPB.Name = 'AB Test PB';
        testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB; 
        
        // 4. Create Job Record    : JOB-1019  
        // System.runAs(tuser){
        FX5__Job__c testJob = new FX5__Job__c();
        testJob.SD_Job_Record_Type__c = 'Single Phase Job';
        testJob.SD_Job_Summary__c = 'ab Test through Test Class';
        testJob.SD_Stage__c  = 'Design and Plan';
        testJob.SD_Product_Line__c = 'DS';        
        testJob.FX5__Projected_Start_Date__c = DateTime.now();
        testJob.SD_Duration__c = 2;
        testJob.SD_No_of_Field_Personnel_Required__c = 2;        
        testJob.SD_Job_Coordinator__c = tuser.ID;
        testJob.SD_Account_Manager__c=tuser.ID; 
        testJob.FX5__Price_Book__c = testPB.id;
        testJob.FX5__CustomerAccount__c = testacc.id;
        //testJob.FX5__CustomerAccount__c = '0011200001Gviwr';                 
        testJob.FX5__Office__c = testAccOfc.id;
        
        //testJob.FX5__Office__c = '0011200001Gviwr';
        Insert testJob;
        
        FX5__Crew_Planning__c testCP = new FX5__Crew_Planning__c();
        
        testCP.FX5__Crew_Member__c =testContact.id;
        testCP.FX5__Job__c = testJob.ID;
        testCP.FX5__Planned_Start_Date__c= DateTime.now();
        testCP.FX5__Planned_End_Date__c=DateTime.now().addDays(1);
        testCP.SD_Confirmed_by_FSE__c = true;
        testCP.SD_Reason_of_Rejection__c='test';
        Insert testCP; 
        
        Test.StartTest();
            ApexPages.currentPage().getParameters().put('jobid',testCP.id);
            ApexPages.StandardController sc = new ApexPages.StandardController(testCP);
            sendRequestBorrowCtrl ctrl1 = new sendRequestBorrowCtrl(sc);
            ctrl1.radioValue = '0';
            ctrl1.doSubmit();
            ctrl1.radioValue = '1';
            ctrl1.doSubmit();
        Test.Stoptest();
    }

}