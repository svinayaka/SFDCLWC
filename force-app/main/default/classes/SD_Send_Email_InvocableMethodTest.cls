@isTest
public class SD_Send_Email_InvocableMethodTest {
    @isTest static void testsendEmailForDesignPlanJob() {
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
        //3.Prepare Test Contact Record
       /* Contact testContact = new Contact();
            testContact.firstname='VMTestCont';
            testContact.lastname='VMTest';
            testContact.FX5__Office__c=testAccOfc.ID;           
            testContact.Email = 'VMTest@test.Com';
        Insert testContact;*/
        // Create Price Book 
        FX5__Price_Book__c priceBook = new FX5__Price_Book__c();
            priceBook.Name = 'VM Test PB';
            priceBook.FX5__Effective_Date__c = System.today();
        Insert  priceBook;
        System.runAs(tuser) {  
        FX5__Job__c job1 = new FX5__Job__c();
        job1.Name = 'TestJob';
        job1.SD_Job_Summary__c = 'Job Record For Test Class';
        job1.SD_Stage__c = 'Define Requirements';
        job1.SD_Product_Line__c = 'DS';
        //job1.SD_Region__c = 'APAC';
        job1.SD_No_of_Field_Personnel_Required__c = 1;
        job1.FX5__Projected_Start_Date__c = DateTime.now();
        job1.FX5__Projected_End_Date__c = DateTime.now().addDays(1) ;
        job1.FX5__CustomerAccount__c = testacc.id;
        //job1.FX5__CustomerAccount__c = '0011200001Gviwr';
        job1.FX5__Price_Book__c = priceBook.id;
        //job1.SD_Pending__c = true;
        job1.FX5__Office__c = testAccOfc.id;
        //job1.FX5__Office__c = '0011200001Gviwr';
        if(tuser != null){
           job1.SD_Job_Coordinator__c=tuser.id;
           job1.SD_Account_Manager__c=tuser.id; 
        }
        insert job1;
        
        FX5__Job__c job2 = new FX5__Job__c();
        job2.Name = 'Test2Job';
        job2.SD_Job_Summary__c = 'Job Record For Test Class';
        job2.SD_Stage__c = 'Define Requirements';
        job2.SD_Product_Line__c = 'DS';
        //job2.SD_Region__c = 'APAC';
        job2.SD_No_of_Field_Personnel_Required__c = 1;
        job2.FX5__Projected_Start_Date__c = DateTime.now();
        job2.FX5__Projected_End_Date__c = DateTime.now().addDays(1) ;
        job2.FX5__CustomerAccount__c = testacc.id;
        job2.FX5__Price_Book__c = priceBook.id;
        //job2.SD_Pending__c = true;
        job2.FX5__Office__c = testAccOfc.id;
        if(tuser != null){
           job2.SD_Job_Coordinator__c=tuser.id;
           job2.SD_Account_Manager__c=tuser.id; 
        }
        insert job2;
        
        SD_JobTeam__c jobTeam = new SD_JobTeam__c();
        if(tuser != null)
         jobTeam.SD_JobTeam_Member__c = tuser.id;
        jobTeam.SD_Job__c = job1.id;
        insert jobTeam;
        
        List<Id> IdsList = new List<Id>();
        IdsList.add(job1.id);
        IdsList.add(job2.id);
        SD_Send_Email_InvocableMethod.sendEmailForDesignPlanJob(IdsList);      
    }
  } 
}