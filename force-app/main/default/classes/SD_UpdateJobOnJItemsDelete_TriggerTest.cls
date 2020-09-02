/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 15/OCT/2019
Purpose     : Test Class for the functionlaity / business logic related to Job and Job Items(Before delete action) Related functionality.

Modified By : Vijaya Lakshmi Murukutla
Modified On : 14/Nov/2019 to 18/Nov/2019
Purpose     : Refactring of the Test Class as part of the Requirement # R-33315 ,
			  Requirement Name (Technical - Update Test Classes - Remove hard coded IDs)
========================================================
*/ 
@isTest
public class SD_UpdateJobOnJItemsDelete_TriggerTest {
    static TestMethod void deleteJobItemsPositiveTest(){
    	   		Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Id accOfficeRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Office').getRecordTypeId();
        String orgId = userInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
         //User u1 = [SELECT Id,GE_HQ_SSO_ID__c FROM User WHERE GE_HQ_SSO_ID__c='502811773'];
        Profile p = [SELECT Id FROM Profile WHERE Name='Service Delivery Coordinator'];
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
        // Create Price Book 
    // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
            testPB.Name = 'VM Test PB';
            testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB; 
        System.runAs(tuser) {  
        FX5__Job__c testJob = new FX5__Job__c();
        testJob.Name = 'TestJob';
        testJob.SD_Job_Summary__c = 'Job Record For Test Class';
        testJob.SD_Stage__c = 'Define Requirements';
        testJob.SD_Product_Line__c = 'DS';
        //testJob.SD_Region__c = 'APAC';
        testJob.SD_No_of_Field_Personnel_Required__c = 1;
        testJob.FX5__Projected_Start_Date__c = DateTime.now();
        testJob.FX5__Projected_End_Date__c = DateTime.now().addDays(1) ;
        testJob.FX5__CustomerAccount__c = testacc.id;
        //testJob.FX5__CustomerAccount__c = '0011200001Gviwr';
        testJob.FX5__Price_Book__c = testPB.id;
        //testJob.SD_Pending__c = true;
        testJob.FX5__Office__c = testAccOfc.id;
        //testJob.FX5__Office__c = '0011200001Gviwr';
        if(tuser != null){
           testJob.SD_Job_Coordinator__c=tuser.id;
           testJob.SD_Account_Manager__c=tuser.id; 
        }       
        Insert testJob;      
        
        // Create Catlog Item
               FX5__Catalog_Item__c testCI = new FX5__Catalog_Item__c();
                    testCI.Name = 'VMTestCI';
                    testCI.FX5__Ticket_Item_Record_Type__c = 'Labor';
                    testCI.FX5__Sequence_Number__c = 577808;
                    testCI.SD_Tier_3__c ='VM Test Tier3';
                    testCI.SD_Tier_4__c ='VM Test Tier4';
                    testCI.SD_Tier_5__c ='VM Test Tier5';
               Insert testCI; 
            // Create Price book Item 
            FX5__Price_Book_Item__c testPBI = new FX5__Price_Book_Item__c();
                testPBI.FX5__Catalog_Item__c = testCI.ID;
                testPBI.FX5__Discount_Percent__c = 30;
                testPBI.FX5__Default_Quantity__c = 2;
                testPBI.FX5__Sequence_Number__c  =123.4;
                testPBI.FX5__Price_Book__c = testPB.ID;
             Insert testPBI; 
            // Create Job Item 1 
            SDJob_Items__c testJobItems1 = new SDJob_Items__c();                
                testJobItems1.SD_Job__c = testJob.ID;
                testJobItems1.SDPrice_Book_Item__c = testPBI.ID;
            Insert testJobItems1;
            // Create Job Item 2 
            SDJob_Items__c testJobItems2 = new SDJob_Items__c();               
                testJobItems2.SD_Job__c = testJob.ID;
                testJobItems2.SDPrice_Book_Item__c = testPBI.ID;
            Insert testJobItems2;
            // Create Job Item 3    
            SDJob_Items__c testJobItems3 = new SDJob_Items__c();                
                testJobItems3.SD_Job__c = testJob.ID;
                testJobItems3.SDPrice_Book_Item__c = testPBI.ID;
            Insert testJobItems3; 
        
            // Delete Job Item 3 
            SDJob_Items__c testJobItemsToDelete = new SDJob_Items__c();                
                testJobItemsToDelete.ID = testJobItems3.ID;                
            Delete testJobItemsToDelete;   
            }    
        
    }
    static TestMethod void deleteJobItemsNegativeTest(){
    Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Id accOfficeRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Office').getRecordTypeId();
        String orgId = userInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
         //User u1 = [SELECT Id,GE_HQ_SSO_ID__c FROM User WHERE GE_HQ_SSO_ID__c='502811773'];
        Profile p = [SELECT Id FROM Profile WHERE Name='Service Delivery Coordinator'];
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
        Insert tuser;
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
       // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
            testPB.Name = 'VM Test PB';
            testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB; 
        System.runAs(tuser) {  
        FX5__Job__c testJob = new FX5__Job__c();
        testJob.Name = 'TestJob';
        testJob.SD_Job_Summary__c = 'Job Record For Test Class';
        testJob.SD_Stage__c = 'Define Requirements';
        testJob.SD_Product_Line__c = 'DS';
        //testJob.SD_Region__c = 'APAC';
        testJob.SD_No_of_Field_Personnel_Required__c = 1;
        testJob.FX5__Projected_Start_Date__c = DateTime.now();
        testJob.FX5__Projected_End_Date__c = DateTime.now().addDays(1) ;
        testJob.FX5__CustomerAccount__c = testacc.id;
        //testJob.FX5__CustomerAccount__c = '0011200001Gviwr';
        testJob.FX5__Price_Book__c = testPB.id;
        //testJob.SD_Pending__c = true;
        testJob.FX5__Office__c = testAccOfc.id;
        //testJob.FX5__Office__c = '0011200001Gviwr';
        if(tuser != null){
           testJob.SD_Job_Coordinator__c=tuser.id;
           testJob.SD_Account_Manager__c=tuser.id; 
        }       
        Insert testJob;     
        // Create Catlog Item
        
               FX5__Catalog_Item__c testCI = new FX5__Catalog_Item__c();
                    testCI.Name = 'VMTestCI';
                    testCI.FX5__Ticket_Item_Record_Type__c = 'Labor';
                    testCI.FX5__Sequence_Number__c = 577808;
                    testCI.SD_Tier_3__c ='VM Test Tier3';
                    testCI.SD_Tier_4__c ='VM Test Tier4';
                    testCI.SD_Tier_5__c ='VM Test Tier5';
               Insert testCI; 
               
            // Create Price book Item 
            FX5__Price_Book_Item__c testPBI = new FX5__Price_Book_Item__c();
                testPBI.FX5__Catalog_Item__c = testCI.ID;
                testPBI.FX5__Discount_Percent__c = 30;
                testPBI.FX5__Default_Quantity__c = 2;
                testPBI.FX5__Sequence_Number__c  =123.4;
                testPBI.FX5__Price_Book__c = testPB.ID;
             Insert testPBI; 
            // Create Job Item 1 
            SDJob_Items__c testJobItems1 = new SDJob_Items__c();                
                testJobItems1.SD_Job__c = testJob.ID;
                testJobItems1.SDPrice_Book_Item__c = testPBI.ID;
            Insert testJobItems1;
         
            // Delete Job Item 3 
            SDJob_Items__c testJobItemsToDelete = new SDJob_Items__c();                
                testJobItemsToDelete.ID = testJobItems1.ID;                
            Delete testJobItemsToDelete;         
        
        }
    }
}