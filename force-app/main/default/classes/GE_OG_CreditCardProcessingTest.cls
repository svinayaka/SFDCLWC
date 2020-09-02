@IsTest(SeeAllData=false)
// using see all data true because ConnectApi methods are not supported in data siloed tests
public class GE_OG_CreditCardProcessingTest {
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    // This test method covers class GE_OG_CreditCardCaseScanBatch
    static testMethod void GE_OG_CreditCardCaseScanBatch_Test() {        
        
        String jobId = System.schedule('GE_OG_CreditCardCaseScanBatch_Test', CRON_EXP, new GE_OG_CreditCardCaseScanBatch());
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));
        
        // create custom setting record
        OG_HQ_CC_Scan_Date__c ProcessDate = new OG_HQ_CC_Scan_Date__c();
        List<OG_HQ_CC_Scan_Date__c> testList = new List<OG_HQ_CC_Scan_Date__c>();
        testList = [select Id from OG_HQ_CC_Scan_Date__c where name='CCScanDate'];
        if(testList.size()==0){
            ProcessDate = new OG_HQ_CC_Scan_Date__c(Name='CCScanDate', Scan_Date__c=System.now().addDays(-1));
            insert ProcessDate;
        }
        else
            ProcessDate = testList.get(0);
        
        // Create a Case with CC Data
        Case c = new Case();
        c.Subject='CC Testing Scenario 1';
        c.Description='Hi this is a test and I have a dummy visa number Visa CC 4775-0701-0009-0000 I would now like to buy something worth a lot of money!';
        
        insert c;        
        
        Test.startTest();        
        
        GE_OG_CreditCardCaseScanBatch batch = new GE_OG_CreditCardCaseScanBatch();        
        String queryString = 'Select Id, CaseNumber, Description, CreatedDate from Case where Id=\'' + c.Id +'\'';
        batch.query=queryString;
        Database.executeBatch(batch);
        
        // validate that the compliance record was created since the process should have flagged the case as having CC data in it
        datetime recent = System.now().addMinutes(-1);
        List<Compliance_Object_Batch__c> compObj = [Select Id from Compliance_Object_Batch__c where createdDate > :recent];
        System.assert(compObj.size()>0);
        
        Test.stopTest();
        
    }
    
    // This test method covers classes GE_OG_CreditCardEmailScanBatch  &  GE_OG_EmailCreditCardCheck   & GE_OG_CaseCreditCardProcessor  & GE_OG_CaseCreditCardBean
    static testMethod void GE_OG_CreditCardEmailScanBatch_Test() {
        
        String jobId = System.schedule('GE_OG_CreditCardEmailScanBatch_Test', CRON_EXP, new GE_OG_CreditCardEmailScanBatch());
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));
        
        // create custom setting record
        OG_HQ_CC_Scan_Date__c ProcessDate = new OG_HQ_CC_Scan_Date__c();
        List<OG_HQ_CC_Scan_Date__c> testList = new List<OG_HQ_CC_Scan_Date__c>();
        testList = [select Id from OG_HQ_CC_Scan_Date__c where name='CCScanDate'];
        if(testList.size()==0){
            ProcessDate = new OG_HQ_CC_Scan_Date__c(Name='CCScanDate', Scan_Date__c=System.now().addDays(-1));
            insert ProcessDate;
        }
        else
            ProcessDate = testList.get(0);
        
        //Create Case Record and then attach the Email record to the case that is created
        Case c = new Case();
        c.Subject='CC Testing Scenario 2';
        c.Description='Hi this is a test case with an inbound email with CC info.';        
        insert c;
        
        //Create Inbound Email Message Record
        EmailMessage em = new EmailMessage();
        em.subject='Testing subject';
        em.textBody = 'Hi this is a test and I have a dummy visa number Visa CC 4775-0701-0009-0000 I would now like to buy something worth a lot of money!.';
        em.parentId=c.Id;
        insert em;
        
        Test.startTest();
        
        GE_OG_CreditCardEmailScanBatch batch = new GE_OG_CreditCardEmailScanBatch();
        String queryString = 'Select Id, TextBody, ParentId, CreatedDate from EmailMessage where Id =\'' + em.Id + '\'';
        batch.query=queryString;
        Database.executeBatch(batch);
        
        // validate that the compliance record was created since the process should have flagged the case as having CC data in it
        datetime recent = System.now().addMinutes(-1);
        List<Compliance_Object_Batch__c> compObj = [Select Id from Compliance_Object_Batch__c where createdDate > :recent];
        System.assert(compObj.size()>0);   
        
        Test.stopTest();		
        
    }
    
    // This method covers class GE_OG_CaseCreditCardProcessor
    static testMethod void GE_OG_CaseCreditCardProcessor_Test(){
        
        String OriginText = 'Happy Chicken!';
        GE_OG_NA_Case_Origin_Values__c newOrigin = new GE_OG_NA_Case_Origin_Values__c(Name = OriginText, Origin_Name__c= OriginText);
        insert newOrigin;
        Id originalOwner;
        
        List<CaseCreditCardQueue__c> queueName = new List<CaseCreditCardQueue__c>();
        queueName = [select Id from CaseCreditCardQueue__c where Name ='North America'];
        if(queueName.size()==0){
            CaseCreditCardQueue__c newQueue = new CaseCreditCardQueue__c(Name='North America', Queue_Name__c='GE OG North America CC Cases');
            insert newQueue;
        }
        
        String ChatterGroupName;
        CollaborationGroup theChatterGroup;
        ChatterGroupName = Label.Case_Credit_Card_Chatter_Group;
        List<CollaborationGroup> CG = new List<CollaborationGroup>();
        CG = [select Id from CollaborationGroup where name = :ChatterGroupName and isArchived=false];
        if(CG.size()==0){
            CollaborationGroup newCG = new CollaborationGroup(Name='Credit Card Chatter Group Test', CollaborationType='Private');
            insert newCG;
            theChatterGroup = newCg;            
        }
        else
            theChatterGroup = CG.get(0);
        
        // Create a Case with CC Data
        Case c = new Case();
        c.Subject='CC Testing Scenario 1';
        c.Description='Hi this is a test and I have a dummy visa number Visa CC 4775-0701-0009-0000 I would now like to buy something worth a lot of money!';
        c.Origin=OriginText;
        c.GE_ES_Sub_Type__c='My Sub Type';
        
        insert c; 
        originalOwner = c.Id;
        
        List<String> casestoProcessSerialize = new List<String>();
        GE_OG_CaseCreditCardBean CCBean = new GE_OG_CaseCreditCardBean(c.Id,'Pre Text','PostText');
        casestoProcessSerialize.add(JSON.serialize(CCBean));       
        
        Test.startTest();    
        
        GE_OG_CaseCreditCardProcessor.futureUpdateCaseOwner(casestoProcessSerialize,'',false);
        
        Case updatedCase = [Select Id, OwnerId from Case where Id=:c.Id];
        
		GE_OG_CaseCreditCardProcessor.isTestRunning = true;
        GE_OG_CaseCreditCardProcessor.postToChatterGroup('PreText','PostText',c, false, theChatterGroup.Id);
        GE_OG_CaseCreditCardProcessor.postToChatterGroup('PreText','PostText',c, true, theChatterGroup.Id);
        
        Test.stopTest();
        
    } 
    // Coverage for trigger GE_OG_EmailMessage_Trigger
    static testMethod void TestEmailMessageTrigger(){
    
        Test.startTest();
        //Create Case Record and then attach the Email record to the case that is created
        Case c = new Case();
        c.Subject='CC Testing Scenario 2';
        c.Description='Hi this is a test case with an inbound email with CC info.';        
        insert c;
        
        //Create Inbound Email Message Record
        EmailMessage em = new EmailMessage();
        em.subject='Testing subject';
        em.textBody = 'Hi this is a test.';
        em.parentId=c.Id;
        insert em;
        
        delete em;
        
        undelete em;
        
        Test.stopTest();
    
    }
}