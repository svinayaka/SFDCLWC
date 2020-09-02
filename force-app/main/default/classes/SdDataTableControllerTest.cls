/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 11/OCT/2019
Purpose     : Test Class for the functionlaity / business logic related to Job Related functionality.

Modified By : Vijaya Lakshmi Murukutla
Modified On : 19/Nov/2019 to 20/Nov/2019
Purpose     : Refactring of the Test Class as part of the Requirement # R-33315 ,
              Requirement Name (Technical - Update Test Classes - Remove hard coded IDs)
========================================================
*/ 
@IsTest 
public class SdDataTableControllerTest {
     // Begin : Vijaya Modifications on 11.Oct.2019  
        static testmethod void fetchAndUpdateTest() {   
       // User u1 = [SELECT Id,GE_HQ_SSO_ID__c FROM User WHERE GE_HQ_SSO_ID__c='502811773'];         
            String orgId = userInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Id accOfficeRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Office').getRecordTypeId();
        Id conOfficeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Field Personnel').getRecordTypeId();
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
            //tuser.ProfileId = '00eA0000000n90vIAA';
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
            testAccOfc.SD_Product_Line__c = 'DS';
            testAccOfc.SD_Service_Delivery_Region__c = 'Europe';
            testAccOfc.SD_Job_Coordinator__c = tuser.Id;
            testAccOfc.Classification__c = 'Platinum'; 
            testAccOfc.Type = 'Direct Customer';
       Insert testAccOfc;
        //3.Prepare Test Contact Record
        Contact testContact = new Contact();
            testContact.firstname='VMTestCont';
            testContact.lastname='VMTest';
            testContact.FX5__Office__c=testAccOfc.ID;           
            testContact.Email = 'VMTest@test.Com';
            testContact.RecordTypeId =conOfficeRecordTypeId;
            testContact.GE_PRM_SSO_ID__c = '123456789';
            testContact.AccountId = testAcc.ID;
            testContact.GE_OG_Contact_Audience__c = 'Customer Care';
       Insert testContact;
        // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
            testPB.Name = 'VM Test PB';
            testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB;         
        // 4. Create Job Record    : JOB-1019  
        System.runAs(tuser){
        FX5__Job__c testJob = new FX5__Job__c();
            testJob.SD_Job_Record_Type__c = 'Single Phase Job';
            testJob.SD_Job_Summary__c = 'VM Test through Test Class';
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
            
            FX5__Qualification__c testQ1 = new FX5__Qualification__c();
                testQ1.SD_Qualification_Type__c = 'Fundamental';
                testQ1.Name = 'VM Test Qualification 1';
                //testQ1.SD_Product_Line__c = 'VM Test 1';
                testQ1.FX5__Abbreviation__c = 'Test Abrv 1';
                testQ1.SD_Qualification_Id__c= 'Test Abrv 1';

                
            Insert testQ1; 
            FX5__Qualification_Requirement__c testQR = new FX5__Qualification_Requirement__c();
               testQR.SD_Type__c='Fundamental';
               testQR.FX5__Job__c=testJob.ID;
               testQR.FX5__Qualification__c=testQ1.ID;
           Insert testQR;
          
            SdDataTableController.fetchPriceBookItem(testJob.id);
            SdDataTableController.UpdateBooleans(testJob.id,true);
            SdDataTableController.UpdateBooleans(testJob.id,false);
            SdDataTableController.fetchJobData(testJob.id);        
            }
        }
        static testmethod void updateqReqListTest(){
        //User u1 = [SELECT Id,GE_HQ_SSO_ID__c FROM User WHERE GE_HQ_SSO_ID__c='502811773'];
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
            //tuser.ProfileId = '00eA0000000n90vIAA';
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
            testContact.lastname='VMTest';
            testContact.FX5__Office__c=testAccOfc.ID;           
            testContact.Email = 'VMTest@test.Com';
            testContact.RecordTypeId =conOfficeRecordTypeId;
            testContact.GE_PRM_SSO_ID__c = '123456789';
            //testContact.AccountId = '0011200001Gviwr';
            //testContact.AccountId = testAccOfc.id;
            testContact.GE_OG_Contact_Audience__c = 'Customer Care';
        Insert testContact;
        // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
            testPB.Name = 'VM Test PB';
            testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB; 
            
        // 4. Create Job Record    : JOB-1019   
        System.runAs(tuser){
        FX5__Job__c testJob = new FX5__Job__c();
            testJob.SD_Job_Record_Type__c = 'Single Phase Job';
            testJob.SD_Job_Summary__c = 'VM Test through Test Class';
            testJob.SD_Stage__c  = 'Design and Plan';
            testJob.SD_Product_Line__c = 'DS';        
            testJob.FX5__Projected_Start_Date__c = DateTime.now();
            testJob.SD_Duration__c = 2;
            testJob.SD_No_of_Field_Personnel_Required__c = 2;        
            testJob.SD_Job_Coordinator__c = tuser.ID;            
            testJob.SD_Account_Manager__c=tuser.ID;
            testJob.FX5__Price_Book__c= testPB.ID;  
            testJob.FX5__CustomerAccount__c = testacc.id;
            //testJob.FX5__CustomerAccount__c = '0011200001Gviwr';                 
            testJob.FX5__Office__c = testAccOfc.id;
            //testJob.FX5__Office__c = '0011200001Gviwr';            
        Insert testJob;
            
        //Create Qualification 
        FX5__Qualification__c testQ = new FX5__Qualification__c();
        testQ.SD_Qualification_Type__c = 'Fundamental';
        testQ.Name = 'VM Test Qualification';
        //testQ.SD_Product_Line__c = 'VM Test';
        testQ.FX5__Abbreviation__c = 'Test Abrv';
        testQ.SD_Qualification_Id__c= 'Test Abrv';
        Insert testQ; 

        //Create Contact Qualification 
        FX5__Contact_Qualification__c testCQ = new FX5__Contact_Qualification__c();
            testCQ.Name ='VM Test CQ';
            //testCQ.FX5__Contact__c = '003A0000017ZEmU';
            testCQ.FX5__Contact__c = testContact.id;
            testCQ.FX5__Effective_Date__c = System.today();
            testCQ.FX5__Expiration_Date__c = System.today()+5;
            testCQ.FX5__Qualification__c = testQ.ID;
         Insert testCQ;
        
        // Create Crew Plan    
        FX5__Crew_Planning__c testCP = new FX5__Crew_Planning__c();
           // testCP.FX5__Crew_Member__c = '003A0000017ZEmU';
            testCP.FX5__Crew_Member__c =testContact.id;
            testCP.FX5__Job__c = testJob.ID;
            testCP.FX5__Planned_Start_Date__c= DateTime.now();
            testCP.FX5__Planned_End_Date__c=DateTime.now().addDays(1);
        Insert testCP;        
        // Qualification Requirement Fundamental
       FX5__Qualification_Requirement__c testQR = new FX5__Qualification_Requirement__c();
           testQR.SD_Type__c='Fundamental';
           testQR.FX5__Job__c=testJob.ID;
           testQR.FX5__Qualification__c=testQ.ID;
       Insert testQR;         
        //Create Qualification Type 1
        FX5__Qualification__c testQ1 = new FX5__Qualification__c();
        testQ1.SD_Qualification_Type__c = 'Type 1';
        testQ1.Name = 'VM Test Qualification 1';
        //////testQ1.SD_Product_Line__c = 'VM Test 1';
        testQ1.FX5__Abbreviation__c = 'Test Abrv 1';
        testQ1.SD_Qualification_Id__c= 'Test Abrv 1';
        Insert testQ1; 
         //Create Contact Qualification Type 1 
        FX5__Contact_Qualification__c testCQ1 = new FX5__Contact_Qualification__c();
            testCQ1.Name ='VM Test CQ 1';
            // testCQ1.FX5__Contact__c ='003A0000017ZEmU';
            testCQ1.FX5__Contact__c = testContact.id;
            testCQ1.FX5__Effective_Date__c = System.today();
            testCQ1.FX5__Expiration_Date__c = System.today()+5;
            testCQ1.FX5__Qualification__c = testQ1.ID;
         Insert testCQ1;        
        
        // Qualification Requirement Type 1
        
      FX5__Qualification_Requirement__c testQR1 = new FX5__Qualification_Requirement__c();
           testQR1.SD_Type__c='Type 1';
           testQR1.FX5__Job__c=testJob.ID;
           testQR1.FX5__Qualification__c=testQ1.ID;
       Insert testQR1;        
        
        //Create Qualification 
        FX5__Qualification__c testQ2 = new FX5__Qualification__c();
        testQ2.SD_Qualification_Type__c = 'Fundamental';
        testQ2.Name = 'VM Test Qualification 123';
        //testQ2.SD_Product_Line__c = 'VM Test 123';
        testQ2.FX5__Abbreviation__c = 'Test Abrv123';
          testQ2.SD_Qualification_Id__c= 'Test Abrv123';
        Insert testQ2;  
        list<FX5__Qualification__c> lstQualifications = New list<FX5__Qualification__c>();
        lstQualifications.add(testQ2);
        lstQualifications.add(testQ1);        
                  
            string sQualificationList = System.JSON.serialize(lstQualifications);
            SdDataTableController.updateqReqList(sQualificationList,testJob.ID);
            }
    }   
        static testmethod void addqualificationItemTest(){
        User u1 = [SELECT Id,GE_HQ_SSO_ID__c FROM User WHERE GE_HQ_SSO_ID__c='502811773'];
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
            //tuser.ProfileId = '00eA0000000n90vIAA';
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
        //3.Prepare Test Contact Record
        Id conOfficeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Field Personnel').getRecordTypeId();
       
        Contact testContact = new Contact();
            testContact.firstname='VMTestCont';
            testContact.lastname='VMTest';
            testContact.FX5__Office__c=testAccOfc.ID;           
            testContact.Email = 'VMTest@test.Com';
            testContact.RecordTypeId =conOfficeRecordTypeId;
            testContact.GE_PRM_SSO_ID__c = '123456789';
            //testContact.AccountId = '0011200001Gviwr';
            //testContact.AccountId = testAccOfc.id;
            testContact.GE_OG_Contact_Audience__c = 'Customer Care';
        Insert testContact;
        // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
            testPB.Name = 'VM Test PB';
            testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB;         
        // 4. Create Job Record    : JOB-1019    
        System.runAs(tuser){
        FX5__Job__c testJob = new FX5__Job__c();
            testJob.SD_Job_Record_Type__c = 'Single Phase Job';
            testJob.SD_Job_Summary__c = 'VM Test through Test Class';
            testJob.SD_Stage__c  = 'Design and Plan';
            testJob.SD_Product_Line__c = 'DS';        
            testJob.FX5__Projected_Start_Date__c = DateTime.now();
            testJob.SD_Duration__c = 2;
            //testJob.FX5__Projected_End_Date__c = DateTime.now().addDays(1);
            testJob.SD_No_of_Field_Personnel_Required__c = 2;        
            testJob.SD_Job_Coordinator__c = tuser.ID;
            testJob.SD_Account_Manager__c=tuser.ID;
            testJob.FX5__Price_Book__c= testPB.ID;
            testJob.FX5__CustomerAccount__c = testacc.id;
            //testJob.FX5__CustomerAccount__c = '0011200001Gviwr';        
            testJob.FX5__Office__c = testAccOfc.id;
            //testJob.FX5__Office__c = '0011200001Gviwr';
        Insert testJob;
                //Create Qualification 
                FX5__Qualification__c testQ = new FX5__Qualification__c();
                testQ.SD_Qualification_Type__c = 'Fundamental';
                testQ.Name = 'VM Test Qualification';
              //  testQ.SD_Product_Line__c = 'VM Test';
                testQ.FX5__Abbreviation__c = 'Test Abrv';
                testQ.SD_Qualification_Id__c= 'Test Abrv';
                Insert testQ; 
        
                //Create Contact Qualification 
                FX5__Contact_Qualification__c testCQ = new FX5__Contact_Qualification__c();
                    testCQ.Name ='VM Test CQ';
                    // testCQ.FX5__Contact__c = '003A0000017ZEmU';
                    testCQ.FX5__Contact__c = testContact.id;
                    testCQ.FX5__Effective_Date__c = System.today();
                    testCQ.FX5__Expiration_Date__c = System.today()+5;
                    testCQ.FX5__Qualification__c = testQ.ID;
                 Insert testCQ;
                // Create Catlog Item
               FX5__Catalog_Item__c testCI = new FX5__Catalog_Item__c();
                    testCI.Name = 'VMTestCI';
                    testCI.FX5__Ticket_Item_Record_Type__c = 'Labor';
                    testCI.FX5__Sequence_Number__c = 577808;
               Insert testCI;        
                
            // Create Price book Item 
            FX5__Price_Book_Item__c testPBI = new FX5__Price_Book_Item__c();
                testPBI.FX5__Catalog_Item__c = testCI.ID;
                testPBI.FX5__Discount_Percent__c = 30;
                testPBI.FX5__Default_Quantity__c = 2;
                testPBI.FX5__Sequence_Number__c  =123.4;
                testPBI.FX5__Price_Book__c = testPB.ID;
             Insert testPBI; 
                
                // Create Crew Plan    
                FX5__Crew_Planning__c testCP = new FX5__Crew_Planning__c();
                   // testCP.FX5__Crew_Member__c = ;
                    testCP.FX5__Job__c = testJob.ID;
                    testCP.FX5__Planned_Start_Date__c= DateTime.now();
                    testCP.FX5__Planned_End_Date__c=DateTime.now().addDays(2);
                    testCP.FX5__Role_on_Job__c =testPBI.ID;          
                Insert testCP;        
                
                    // Update Crew Plan    
                FX5__Crew_Planning__c testCPUpdate = new FX5__Crew_Planning__c();
                    testCPUpdate.Id = testCP.ID;
                    // testCPUpdate.FX5__Crew_Member__c = '003A0000017ZEmU';
                    testCPUpdate.FX5__Crew_Member__c = testContact.id;
                    testCPUpdate.FX5__Job__c = testJob.ID;
                    testCPUpdate.FX5__Planned_Start_Date__c= DateTime.now();
                    testCPUpdate.FX5__Planned_End_Date__c=DateTime.now().addDays(3);
                    testCPUpdate.FX5__Role_on_Job__c =testPBI.ID;          
                update testCPUpdate;   
            SdDataTableController.addqualificationItem(testJob.id);
            }
        }      
        static testmethod void fetchQualificationTest(){
        User u1 = [SELECT Id,GE_HQ_SSO_ID__c FROM User WHERE GE_HQ_SSO_ID__c='502811773']; 
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
            //tuser.ProfileId = '00eA0000000n90vIAA';
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
        //3.Prepare Test Contact Record
        Id conOfficeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Field Personnel').getRecordTypeId();
       
        Contact testContact = new Contact();
            testContact.firstname='VMTestCont';
            testContact.lastname='VMTest';
            testContact.FX5__Office__c=testAccOfc.ID;           
            testContact.Email = 'VMTest@test.Com';
            testContact.RecordTypeId =conOfficeRecordTypeId;
            testContact.GE_PRM_SSO_ID__c = '123456789';
            //testContact.AccountId = '0011200001Gviwr';
            //testContact.AccountId = testAccOfc.id;
            testContact.GE_OG_Contact_Audience__c = 'Customer Care';
       Insert testContact;
        // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
            testPB.Name = 'VM Test PB';
            testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB;         
        // 4. Create Job Record    : JOB-1019 
        System.runAs(tuser){ 
        FX5__Job__c testJob = new FX5__Job__c();
            testJob.SD_Job_Record_Type__c = 'Single Phase Job';
            testJob.SD_Job_Summary__c = 'VM Test through Test Class';
            testJob.SD_Stage__c  = 'Design and Plan';
            testJob.SD_Product_Line__c = 'DS';        
            testJob.FX5__Projected_Start_Date__c = DateTime.now();
            testJob.SD_Duration__c = 2;
            //testJob.FX5__Projected_End_Date__c = DateTime.now().addDays(1);
            testJob.SD_No_of_Field_Personnel_Required__c = 2;        
            testJob.SD_Job_Coordinator__c = tuser.ID;
            testJob.SD_Account_Manager__c=tuser.ID;
            testJob.FX5__Price_Book__c= testPB.ID;
            testJob.FX5__CustomerAccount__c = testacc.id;
            //testJob.FX5__CustomerAccount__c = '0011200001Gviwr';        
            testJob.FX5__Office__c = testAccOfc.id;
            //testJob.FX5__Office__c = '0011200001Gviwr';
        Insert testJob;
        //Create Qualification 
        FX5__Qualification__c testQ = new FX5__Qualification__c();
        testQ.SD_Qualification_Type__c = 'Fundamental';
        testQ.Name = 'VM Test Qualification';
        //testQ.SD_Product_Line__c = 'VM Test';
        testQ.FX5__Abbreviation__c = 'Test Abrv';
        testQ.SD_Qualification_Id__c= 'Test Abrv';
        Insert testQ; 
        
        //Create Contact Qualification  1
        FX5__Contact_Qualification__c testCQ = new FX5__Contact_Qualification__c();
            testCQ.Name ='VM Test CQ';
            // testCQ.FX5__Contact__c = '003A0000017ZEmU';
            testCQ.FX5__Contact__c = testContact.id;
            testCQ.FX5__Effective_Date__c = System.today();
            testCQ.FX5__Expiration_Date__c = System.today()+5;
            testCQ.FX5__Qualification__c = testQ.ID; // with Trainee
         Insert testCQ;
        // Create Catlog Item
       FX5__Catalog_Item__c testCI = new FX5__Catalog_Item__c();
            testCI.Name = 'VMTestCI';
            testCI.FX5__Ticket_Item_Record_Type__c = 'Labor';
            testCI.FX5__Sequence_Number__c = 577808;
       Insert testCI;        
        
    // Create Price book Item 
    FX5__Price_Book_Item__c testPBI = new FX5__Price_Book_Item__c();
        testPBI.FX5__Catalog_Item__c = testCI.ID;
        testPBI.FX5__Discount_Percent__c = 30;
        testPBI.FX5__Default_Quantity__c = 2;
        testPBI.FX5__Sequence_Number__c  =123.4;
        testPBI.FX5__Price_Book__c = testPB.ID;
     Insert testPBI; 
        
        // Create Crew Plan    
        FX5__Crew_Planning__c testCP = new FX5__Crew_Planning__c();
            //testCP.FX5__Crew_Member__c = '003A0000017ZEmU';
            testCP.FX5__Crew_Member__c = testContact.id;
            testCP.FX5__Job__c = testJob.ID;
            testCP.FX5__Planned_Start_Date__c= DateTime.now();
            testCP.FX5__Planned_End_Date__c=DateTime.now().addDays(2);
            testCP.FX5__Role_on_Job__c =testPBI.ID;          
        Insert testCP; 
        // Qualification Requirement Trainee        
      FX5__Qualification_Requirement__c testQR = new FX5__Qualification_Requirement__c();
           testQR.SD_Type__c='Fundamental';
           testQR.FX5__Job__c=testJob.ID;
           testQR.FX5__Qualification__c=testQ.ID;
       Insert testQR;   
        
          // Qualification Requirement Trainee        
      FX5__Qualification_Requirement__c testQR1 = new FX5__Qualification_Requirement__c();
           testQR1.SD_Type__c='Fundamental';
           testQR1.FX5__Job__c=testJob.ID;
           testQR1.FX5__Qualification__c=testQ.ID;
       Insert testQR1; 
      FX5__Qualification_Requirement__c testQR2 = new FX5__Qualification_Requirement__c();
        testQR2.SD_Type__c='Fundamental';
        testQR2.FX5__Job__c=testJob.ID;
        testQR2.FX5__Qualification__c=testQ.ID;
      Insert testQR2;  
       SdDataTableController.fetchQualification(testJob.id); 
       }
       
    }
        static testmethod void UpdatepbookitmListTest(){
        //User u1 = [SELECT Id,GE_HQ_SSO_ID__c FROM User WHERE GE_HQ_SSO_ID__c='502811773']; 
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
            //tuser.ProfileId = '00eA0000000n90vIAA';
        Insert tuser;
        //2. Prepare Test Account Record
        Account testAcc = new Account();
            testAcc.Name = 'VMTestAccount';
            testAcc.OwnerId = tuser.Id;
            testAcc.RecordTypeId = accRecordTypeId;
            testAcc.Classification__c = 'Platinum'; 
            testAcc.Type = 'Direct Customer';
       Insert testAcc;
        //2.1 Prepare Test Office Account Record
        Account testAccOfc = new Account();
            testAccOfc.Name = 'VMTestAccount';
            testAccOfc.OwnerId = tuser.Id;
            testAccOfc.RecordTypeId = accOfficeRecordTypeId;
            testAccOfc.Classification__c = 'Platinum'; 
            testAccOfc.Type = 'Direct Customer';
        Insert testAccOfc;
        //3.Prepare Test Contact Record
        Id conOfficeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Field Personnel').getRecordTypeId();
       
        Contact testContact = new Contact();
            testContact.firstname='VMTestCont';
            testContact.lastname='VMTest';
           testContact.FX5__Office__c=testAccOfc.ID;           
            testContact.Email = 'VMTest@test.Com';
            testContact.RecordTypeId =conOfficeRecordTypeId;
            testContact.GE_PRM_SSO_ID__c = '123456789';
            //testContact.AccountId = testAccOfc.id;
            // testContact.AccountId = '0011200001Gviwr'; 
            testContact.GE_OG_Contact_Audience__c = 'Customer Care';
        Insert testContact;
        // Create Price Book 
        FX5__Price_Book__c testPB = new FX5__Price_Book__c();
            testPB.Name = 'VM Test PB';
            testPB.FX5__Effective_Date__c = System.today();
        Insert  testPB;         
        // 4. Create Job Record    : JOB-1019  
        System.runAs(tuser){   
        FX5__Job__c testJob = new FX5__Job__c();
            testJob.SD_Job_Record_Type__c = 'Single Phase Job';
            testJob.SD_Job_Summary__c = 'VM Test through Test Class';
            testJob.SD_Stage__c  = 'Design and Plan';
            testJob.SD_Product_Line__c = 'DS';        
            testJob.FX5__Projected_Start_Date__c = DateTime.now();
            testJob.SD_Duration__c = 2;
            //testJob.FX5__Projected_End_Date__c = DateTime.now().addDays(1);
            testJob.SD_No_of_Field_Personnel_Required__c = 2;        
            testJob.SD_Job_Coordinator__c = tuser.ID;
            testJob.SD_Account_Manager__c=tuser.ID;
            testJob.FX5__Price_Book__c= testPB.ID;
            testJob.FX5__CustomerAccount__c = testacc.id;
            //testJob.FX5__CustomerAccount__c = '0011200001Gviwr';        
            testJob.FX5__Office__c = testAccOfc.id;
            //testJob.FX5__Office__c = '0011200001Gviwr';
        Insert testJob;
        //Create Qualification 
        FX5__Qualification__c testQ = new FX5__Qualification__c();
        testQ.SD_Qualification_Type__c = 'Fundamental';
        testQ.Name = 'VM Test Qualification';
       // testQ.SD_Product_Line__c = 'VM Test';
        testQ.FX5__Abbreviation__c = 'Test Abrv';
        testQ.SD_Qualification_Id__c= 'Test Abrv';
        Insert testQ; 

        //Create Contact Qualification 
        FX5__Contact_Qualification__c testCQ = new FX5__Contact_Qualification__c();
            testCQ.Name ='VM Test CQ';
            // testCQ.FX5__Contact__c = '003A0000017ZEmU';
            testCQ.FX5__Contact__c = testContact.id;
            testCQ.FX5__Effective_Date__c = System.today();
            testCQ.FX5__Expiration_Date__c = System.today()+5;
            testCQ.FX5__Qualification__c = testQ.ID;
         Insert testCQ;
        // Create Catlog Item
       FX5__Catalog_Item__c testCI = new FX5__Catalog_Item__c();
            testCI.Name = 'Trainee';
            testCI.FX5__Ticket_Item_Record_Type__c = 'Labor';
            testCI.FX5__Sequence_Number__c = 577808;
       Insert testCI;
        
        
    // Create Price book Item 
    FX5__Price_Book_Item__c testPBI = new FX5__Price_Book_Item__c();
        testPBI.FX5__Catalog_Item__c = testCI.ID;
        testPBI.FX5__Discount_Percent__c = 30;
        testPBI.FX5__Default_Quantity__c = 2;
        testPBI.FX5__Sequence_Number__c  =123.4;
        testPBI.FX5__Price_Book__c = testPB.ID;
     Insert testPBI;   
        // Create Crew Plan    
        FX5__Crew_Planning__c testCP = new FX5__Crew_Planning__c();
           // testCP.FX5__Crew_Member__c = ;
            testCP.FX5__Job__c = testJob.ID;
            testCP.FX5__Planned_Start_Date__c= DateTime.now();
            testCP.FX5__Planned_End_Date__c=DateTime.now().addDays(1);
            testCP.FX5__Role_on_Job__c =testPBI.ID;          
        Insert testCP;
       // Another Cata Log Item  
        FX5__Catalog_Item__c testCI1 = new FX5__Catalog_Item__c();
            testCI1.Name = 'VM Test CI';
            testCI1.FX5__Ticket_Item_Record_Type__c = 'Labor';
            testCI1.FX5__Sequence_Number__c = 123456;
       Insert testCI1;
      // Create Price Book 1 
        FX5__Price_Book__c testPB1 = new FX5__Price_Book__c();
            testPB1.Name = 'Test Price book';
            testPB1.FX5__Effective_Date__c = System.today();
        Insert  testPB1;      
        // Create Price book Item  1
    FX5__Price_Book_Item__c testPBI1 = new FX5__Price_Book_Item__c();
        testPBI1.FX5__Catalog_Item__c = testCI1.ID;
        testPBI1.FX5__Discount_Percent__c = 30;
        testPBI1.FX5__Default_Quantity__c = 2;
        testPBI1.FX5__Sequence_Number__c  =123.4;
        testPBI1.FX5__Price_Book__c = testPB1.ID;
     Insert testPBI1;  
        // Update Crew Plan    
        FX5__Crew_Planning__c testCPUpdate = new FX5__Crew_Planning__c();
            testCPUpdate.Id = testCP.ID;
            //testCP.FX5__Crew_Member__c = '003A0000017ZEmU';
            testCP.FX5__Crew_Member__c = testContact.id;
            testCPUpdate.FX5__Job__c = testJob.ID;
            testCPUpdate.FX5__Planned_Start_Date__c= DateTime.now();
            testCPUpdate.FX5__Planned_End_Date__c=DateTime.now().addDays(2);
            testCPUpdate.FX5__Role_on_Job__c = testPBI1.ID;          
        update testCPUpdate;  
        
        // Insert CP Again  -- For Delete Action

         // Another Cata Log Item  
        FX5__Catalog_Item__c testCI2 = new FX5__Catalog_Item__c();
            testCI2.Name = 'VM Test CI2';
            testCI2.FX5__Ticket_Item_Record_Type__c = 'Labor';
            testCI2.FX5__Sequence_Number__c = 12345621;
       Insert testCI2;
      // Create Price Book 2
        FX5__Price_Book__c testPB2 = new FX5__Price_Book__c();
            testPB2.Name = 'Test Price book';
            testPB2.FX5__Effective_Date__c = System.today();
        Insert  testPB2;      
        // Create Price book Item  2
    FX5__Price_Book_Item__c testPBI2 = new FX5__Price_Book_Item__c();
        testPBI2.FX5__Catalog_Item__c = testCI2.ID;
        testPBI2.FX5__Discount_Percent__c = 30;
        testPBI2.FX5__Default_Quantity__c = 2;
        testPBI2.FX5__Sequence_Number__c  =123.4;
        testPBI2.FX5__Price_Book__c = testPB2.ID;
     Insert testPBI2; 
     
    // Create Crew Plan    
        FX5__Crew_Planning__c testCP2 = new FX5__Crew_Planning__c();
            //testCP2.FX5__Crew_Member__c = '003A0000017ZEmU';
            testCP2.FX5__Crew_Member__c = testContact.id;
            testCP2.FX5__Job__c = testJob.ID;
            testCP2.FX5__Planned_Start_Date__c= DateTime.now();
            testCP2.FX5__Planned_End_Date__c=DateTime.now().addDays(6);
            testCP2.FX5__Role_on_Job__c =testPBI2.ID;          
        Insert testCP2;
        
        List<FX5__Price_Book_Item__c> pbiList = new List<FX5__Price_Book_Item__c>();
        pbiList.add(testPBI2);
        pbiList.add(testPBI1);
        
        string strPBItemsList = System.JSON.serialize(pbiList);
        SdDataTableController.UpdatepbookitmList(strPBItemsList,testJob.ID);
        }
        
    }   
}