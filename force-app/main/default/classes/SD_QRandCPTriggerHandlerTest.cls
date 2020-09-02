/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 11/Sept/2019
Purpose     : Test Class for SD_QualificationReqTriggerHandler
Ref #R-32464
Modified By : VijayaLakshmi Murukutla
Modified On : 30/Sept/2019

========================================================
*/ 
@isTest(SeeAllData=false)  
public class SD_QRandCPTriggerHandlerTest {
    
    static testmethod void SD_QualificationReqTriggerHandler_Met(){
        Test.startTest();
        Profile p = [SELECT Id FROM Profile WHERE Name='Service Delivery Coordinator'];
        String orgId = userInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Id accOfficeRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Office').getRecordTypeId();
        
        //1.Prepare Test User Record
        User tuser = new User();
        tuser.firstname = 'VijayaTest';
        tuser.lastName = 'MTest';
        tuser.email = uniqueName + '@test' + orgId + '.org';
        tuser.Username = uniqueName + '@test' + orgId + '.org';
        tuser.EmailEncodingKey = 'ISO-8859-1';
        tuser.Alias = uniqueName.substring(18, 23);
        tuser.TimeZoneSidKey = 'America/Los_Angeles';
        tuser.LocaleSidKey = 'en_US';
        tuser.LanguageLocaleKey = 'en_US';
        tuser.ProfileId = p.id;
        tuser.ProfileId = '00eA0000000n90vIAA';
        Insert tuser;
        //2. Prepare Test Account Record
        Account testAcc = new Account();
        testAcc.Name = 'VMTestAccount';
        testAcc.OwnerId = tuser.Id;
        testAcc.RecordTypeId = accRecordTypeId;
        testAcc.Classification__c = 'Platinum'; 
        testacc.Type = 'Direct Customer';
        Insert testAcc;
        //2.1 Prepare Test Office Account Record
        Account testAccOfc = new Account();
        testAccOfc.Name = 'VMTestAccount';
        testAccOfc.OwnerId = tuser.Id;
        testAccOfc.RecordTypeId = accOfficeRecordTypeId;
        testAccOfc.Classification__c = 'Platinum'; 
        testAccOfc.Type = 'Direct Customer';
        Insert testAccOfc;
        Id conOfficeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Field Personnel').getRecordTypeId();
        
        //3.Prepare Test Contact Record
        Contact testContact = new Contact();
        testContact.firstname='VMTestCont';
        testContact.RecordTypeId =conOfficeRecordTypeId;
        testContact.GE_PRM_SSO_ID__c = '123456789';
        testContact.AccountId = testAcc.ID;
        testContact.GE_OG_Contact_Audience__c = 'Customer Care';
        testContact.lastname='VMTest';
        testContact.firstname='VMTest';
        testContact.FX5__Office__c=testAccOfc.ID;           
        testContact.Email = 'VMTest@test.Com';
        Insert testContact;
        // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
        testPB.Name = 'VM Test PB';
        testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB;         
        // 4. Create Job Record    : JOB-1019     
        FX5__Job__c testJob = new FX5__Job__c();
        testJob.SD_Job_Record_Type__c = 'Single Phase Job';
        //testJob.SD_Job_Summary_New__c = 'VM Test through Test Class';
        testJob.SD_Stage__c  = 'Design and Plan';
        //testJob.SD_Product_Line__c = 'DS';        
        testJob.FX5__Projected_Start_Date__c = DateTime.now();
        testJob.SD_Duration__c = 2;
        //testJob.FX5__Projected_End_Date__c = DateTime.now().addDays(1);
        testJob.SD_No_of_Field_Personnel_Required__c = 2;        
        testJob.SD_Job_Coordinator__c = tuser.ID;
        testJob.FX5__CustomerAccount__c=testAcc.ID;
        testJob.SD_Account_Manager__c=tuser.ID;
        testJob.FX5__Price_Book__c= testPB.ID;
        testJob.FX5__Office__c = testAccOfc.ID;
        Insert testJob;
        
        FX5__Crew_Planning__c creplanrec = new FX5__Crew_Planning__c(
        FX5__Job__c = testJob.id,
        FX5__Crew_Member__c = testContact.id
        );
        insert creplanrec;
        
        //Create Qualification :  Fundamental  
        FX5__Qualification__c testQ = new FX5__Qualification__c();
        testQ.SD_Qualification_Type__c = 'Fundamental';
        testQ.Name = 'VM Test Qualification Fundamental';
        //testQ.SD_Product_Line__c = 'VM Test';
        testQ.FX5__Abbreviation__c = 'TestFundamental';
        testQ.SD_Qualification_Id__c = 'TestFundamental';
        Insert testQ;
        
        //Create Qualification :  Type 1  
        FX5__Qualification__c testQ1 = new FX5__Qualification__c();
        testQ1.SD_Qualification_Type__c = 'Type 1';
        testQ1.Name = 'VM Test Qualification Type 1';
        
        //testQ1.SD_Product_Line__c = 'VM Test';
        testQ1.FX5__Abbreviation__c = 'Test Abrv Type 1';
        testQ1.SD_Qualification_Id__c = 'Test Abrv Type 1';
        Insert testQ1;
        //Create Contact Qualification 1
        FX5__Contact_Qualification__c testCQ1 = new FX5__Contact_Qualification__c();
        testCQ1.Name ='VM Test CQ1';
        testCQ1.FX5__Contact__c = testContact.Id;
        testCQ1.FX5__Effective_Date__c = System.today();
        testCQ1.FX5__Expiration_Date__c = System.today().adddays(3);
        testCQ1.FX5__Qualification__c = testQ1.ID;
        Insert testCQ1;
        
        //Create Contact Qualification 2
        FX5__Contact_Qualification__c testCQ = new FX5__Contact_Qualification__c();
        testCQ.Name ='VM Test CQ2';
        testCQ.FX5__Contact__c = testContact.Id;
        testCQ.FX5__Effective_Date__c = System.today();
        testCQ.FX5__Expiration_Date__c = System.today().adddays(4);
        testCQ.FX5__Qualification__c = testQ.ID;
        Insert testCQ;
        
        List<FX5__Qualification_Requirement__c> lstOldQR = new List<FX5__Qualification_Requirement__c>();  
        
        // Qualification Requirement Type 1        
        FX5__Qualification_Requirement__c testQR1 = new FX5__Qualification_Requirement__c();
        testQR1.SD_Type__c='Type 1';
        testQR1.FX5__Job__c=testJob.ID;
        testQR1.FX5__Qualification__c=testQ1.ID;
        Insert testQR1;         
        
        // Qualification Requirement Fundamental        
        FX5__Qualification_Requirement__c testQR2 = new FX5__Qualification_Requirement__c();
        testQR2.SD_Type__c='Fundamental';
        testQR2.FX5__Job__c=testJob.ID;
        testQR2.FX5__Qualification__c=testQ.ID;
        Insert testQR2;
        
        lstOldQR.add(testQR1);
        lstOldQR.add(testQR2);
        delete testQR2;
        
        testQR1.FX5__Qualification__c = testQ1.id;
        try{
            update testQR1;
        }catch(exception ex){}
        
        Set<id> setjobids = new Set<id>();
        setjobids .add(testJob.id);
        
        SD_QualificationReqTriggerHandler handler = new SD_QualificationReqTriggerHandler();
        handler.updateJobOnCPchanges(setjobids);
        
        Test.stopTest();
    }  
    
}