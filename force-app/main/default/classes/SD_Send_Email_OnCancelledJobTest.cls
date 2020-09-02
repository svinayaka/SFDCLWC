@isTest
public class SD_Send_Email_OnCancelledJobTest {
  


    @isTest static void testsendEmailForCancelledJob(){
     
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs(thisUser ){
        
        String orgId = userInfo.getOrganizationId();
       String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
       Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
       String uniqueName = orgId + dateString + randomInt;
       Profile p = [SELECT Id FROM Profile WHERE Name='Service Delivery Coordinator'];
       
        
          Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
       Id accOfficeRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Office').getRecordTypeId();
    
        
  //2. Prepare Test Account Record
        Account testAcc = new Account();
            testAcc.Name = 'VMTestAccount';
            //testAcc.OwnerId = u.Id;
            testAcc.RecordTypeId = accRecordTypeId;
            testAcc.Classification__c = 'Platinum'; 
            testacc.Type = 'Direct Customer';
        Insert testAcc;
        //2.1 Prepare Test Office Account Record
        Account testAccOfc = new Account();
            testAccOfc.Name = 'VMTestoffAccount';
           // testAccOfc.OwnerId = u.Id;
            testAccOfc.RecordTypeId = accOfficeRecordTypeId;
            testAccOfc.Classification__c = 'Platinum'; 
            testAccOfc.Type = 'Direct Customer';
        Insert testAccOfc;
        
         // Create Price Book 
        FX5__Price_Book__c priceBook = new FX5__Price_Book__c();
            priceBook.Name = 'VM Test PB';
            priceBook.FX5__Effective_Date__c = System.today();
        Insert  priceBook;
        
        
         User u = new User();
            u.firstname = 'NewTest';
            u.lastName = 'MTest';
            u.email = 'test5678@gmail.com';
            u.Username = uniqueName + '@test' + orgId + '.org';
            u.EmailEncodingKey = 'ISO-8859-1';
            u.Alias = uniqueName.substring(18, 23);
            u.TimeZoneSidKey = 'America/Los_Angeles';
            u.LocaleSidKey = 'en_US';
            u.LanguageLocaleKey = 'en_US';
            u.ProfileId = p.id;
            Insert u;
       
       
            
        FX5__Job__c job1 = new FX5__Job__c();
        job1.Name = 'TestJob';
        job1.SD_Job_Summary__c = 'Job Record For Test Class';
        job1.SD_Stage__c = 'Define Requirements';
        job1.SD_Product_Line__c = 'DS';
         job1.SD_Duration__c = 2;
        job1.SD_No_of_Field_Personnel_Required__c = 1;
        job1.FX5__Projected_Start_Date__c = DateTime.now();
        //job1.FX5__Projected_End_Date__c = DateTime.now().addDays(1) ;
        job1.FX5__CustomerAccount__c = testAcc.id;
        job1.FX5__Price_Book__c = priceBook.id;
        //job1.SD_Pending__c = true;
        job1.FX5__Office__c = testAccOfc.id;
        //Job2.RecordTypeId = Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByName().get('SD_Job_Phase');
        if(u != null){
           job1.SD_Job_Coordinator__c=u.id;
           job1.SD_Account_Manager__c=u.id; 
        }
        //insert job1;
        List<Id> IdsList = new List<Id>();
        List<FX5__Job__c> JobsList = new List<FX5__Job__c>();
        
        JobsList.add(job1);
       
        insert JobsList;
    
        
        
        
        IdsList.add(job1.id);
       
        
        List<SD_JobTeam__c> jobTeamList = new List<SD_JobTeam__c>();
        
        SD_JobTeam__c jobTeam = new SD_JobTeam__c();
        if(u != null)
         jobTeam.SD_JobTeam_Member__c = u.id;
        jobTeam.SD_Job__c = job1.id;
        jobTeamList.add(jobTeam);
        
        
        SD_JobTeam__c jobTeam1 = new SD_JobTeam__c();
        if(u != null)
         jobTeam1.SD_JobTeam_Member__c = u.id;
        jobTeam1.SD_Job__c = job1.id;
        jobTeamList.add(jobTeam1);
        
        
        insert jobTeamList;
        
        List<FX5__Crew_Planning__c> crewPlanningList = new List<FX5__Crew_Planning__c>();
        
        FX5__Crew_Planning__c crewMember = new FX5__Crew_Planning__c();
        crewMember.FX5__Planned_Start_Date__c=DateTime.now();
        crewMember.FX5__Planned_End_Date__c=DateTime.now().addDays(1);
        crewMember.FX5__Job__c=job1.id;
        crewPlanningList.add(crewMember);
        
       
        insert crewPlanningList;
        
        
        SD_Send_Email_OnCancelledJob.sendEmailForCancelledJob(IdsList); 
    }
   } 
}