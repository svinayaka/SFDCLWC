@isTest
public class SD_MostRecentJobonCrew_Test {
    @isTest
    public static void callCPTestData(){
        Test.startTest();
       
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Id accOfficeRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Office').getRecordTypeId();
        Id conOfficeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Field Personnel').getRecordTypeId();
        
       //Prepare Test Account Record
        Account testAcc = new Account();
        testAcc.Name = 'VMTestAccount';
        testAcc.RecordTypeId = accRecordTypeId;
        testAcc.Classification__c = 'Platinum'; 
        testacc.Type = 'Direct Customer';
        Insert testAcc;
        
        //Prepare Test Office Account Record
        Account testAccOfc = new Account();
        testAccOfc.Name = 'VMTestAccount';
        testAccOfc.RecordTypeId = accOfficeRecordTypeId;
        testAccOfc.Classification__c = 'Platinum'; 
        testAccOfc.Type = 'Direct Customer';
        Insert testAccOfc;
        
        //Prepare Test Contact Record
        Contact testContact = new Contact();
        testContact.firstname='VMTestCont';
        testContact.lastname='VMTest';
        testContact.firstname='VMTest';
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
        
        // Create Job Record    : JOB-1019     
        FX5__Job__c testJob = new FX5__Job__c();
        testJob.SD_Job_Record_Type__c = 'Single Phase Job';
        testJob.SD_Stage__c  = 'Design and Plan';     
        testJob.FX5__Projected_Start_Date__c = DateTime.now();
        testJob.SD_Duration__c = 2;
        testJob.SD_No_of_Field_Personnel_Required__c = 2;        
        testJob.FX5__CustomerAccount__c=testAcc.ID;
        testJob.FX5__Price_Book__c= testPB.ID;
        testJob.FX5__Office__c = testAccOfc.ID;
        Insert testJob;
        
        //Create Qualification 
        FX5__Qualification__c testQ = new FX5__Qualification__c();
        testQ.SD_Qualification_Type__c = 'Fundamental';
        testQ.Name = 'VM Test Qualification';
        testQ.FX5__Abbreviation__c = 'Test Abrv';
        testQ.SD_Qualification_Id__c = 'Test Abrv';
        Insert testQ; 

        // Create Catlog Item
        FX5__Catalog_Item__c testCI = new FX5__Catalog_Item__c();
        testCI.FX5__Sequence_Number__c = 576878;
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
        LIst<FX5__Crew_Planning__c> CrewPlNNINGlIST = new LIst<FX5__Crew_Planning__c>();
        LIst<FX5__Crew_Planning__c> CrewPlNNINGlIST1 = new LIst<FX5__Crew_Planning__c>();
        Map<Id,FX5__Crew_Planning__c> updCPMap =new Map<Id,FX5__Crew_Planning__c>();
        
        DateTime dt=System.Now();  
        FX5__Crew_Planning__c testCP = new FX5__Crew_Planning__c();
        testCP.FX5__Crew_Member__c = testContact.ID;
        testCP.FX5__Job__c = testJob.ID;
        testCP.FX5__Planned_Start_Date__c= Date.today().adddays(-1);
        testCP.FX5__Planned_End_Date__c=Date.today();
        //testCP.SD_Most_Recent_Job__c  =false;          
        testCP.FX5__Role_on_Job__c =testPBI.ID;          
        CrewPlNNINGlIST.add(testCP);
        
        FX5__Crew_Planning__c testCP2 = new FX5__Crew_Planning__c();
        testCP2.FX5__Crew_Member__c = testContact.ID;
        testCP2.FX5__Job__c = testJob.ID;
        testCP2.FX5__Planned_Start_Date__c= Date.today().adddays(1);
        testCP2.FX5__Planned_End_Date__c=Date.today().adddays(2);
        //testCP2.SD_Most_Recent_Job__c  =false;          
        testCP2.FX5__Role_on_Job__c =testPBI.ID;          
        CrewPlNNINGlIST.add(testCP2);
        
        
        FX5__Crew_Planning__c testCP1 = new FX5__Crew_Planning__c();
        testCP1.FX5__Crew_Member__c = testContact.ID;
        testCP1.FX5__Job__c = testJob.ID;
        testCP1.FX5__Planned_Start_Date__c= Date.today().adddays(-2);
        testCP1.FX5__Planned_End_Date__c=Date.today().adddays(-1);
        //testCP1.SD_Most_Recent_Job__c  =false;          
        testCP1.FX5__Role_on_Job__c =testPBI.ID;          
        CrewPlNNINGlIST.add(testCP1);
        insert CrewPlNNINGlIST;
        
        SD_MostRecentJobonCrew.crewPlanning(CrewPlNNINGlIST,null,true,false);
       
        testCP.FX5__Planned_End_Date__c=Date.today();
        update testCP;
        CrewPlNNINGlIST1.add(testCP);
        updCPMap.put(testCP.id,testCP);
        SD_MostRecentJobonCrew.crewPlanning(CrewPlNNINGlIST1,updCPMap,false,false);
        
        delete CrewPlNNINGlIST[1];
        
        
      Test.stopTest(); 
      
        
    }

}