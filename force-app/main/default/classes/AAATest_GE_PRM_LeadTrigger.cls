/*
Type Name [Class/Trigger/Page Name] : Test Class
Used Where ?                        : 
Purpose/Overview                    : To incrase the code coverage 
Functional Area                     : PRM
Author                              : Venkat Reddy
Created Date                        : 01/14/2015           
Change History -
Date Modified   : Developer Name    : Method/Section Modified/Added  : Purpose/Overview of Change
*/

/*
Trigger : LeadTrigger ---- 93%
*/



@isTest(seeAllData=true)
Public class AAATest_GE_PRM_LeadTrigger {
    static testMethod void Test_GE_PRM_LeadTriggerMethod() {
        Test.startTest();
        //Inserting new Lead with different Tier2.
        List<Lead> lstLd=new List<Lead>();
        Lead leadObj = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='Measurement & Control (M&C)',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_MC_Marketo_Stage__c='Known');
        //Insert leadObj;
        lstLd.add(leadObj);
        System.assertEquals(leadObj.GE_HQ_Business_Tier2__c,'Measurement & Control (M&C)'); 
        // GE_HQ_Business_Tier2__c='Drilling & Surface (D&S)';
        /*Lead leadObj1 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='Drilling & Surface (D&S)',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_DS_Marketo_Stage__c='Known');
        lstLd.add(leadObj1);
        
        Lead leadObj2 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='DTS',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_DTS_Marketo_Stage__c='Known');
        lstLd.add(leadObj2);
        Lead leadObj3 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='Subsea (SS)',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_SS_Marketo_Stage__c='Known');
        lstLd.add(leadObj3);
        Lead leadObj4 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='TMS',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_TMS_Marketo_Stage__c='Known');
        lstLd.add(leadObj4);*/
        
        insert lstLd;
        //System.assertEquals(leadObj.GE_HQ_Business_Tier2__c ,'Drilling & Surface (D&S)');
        Test.stopTest();
        /*
leadObj .IsConverted=true;
leadObj .converteddate=system.today();
update leadObj ;
*/
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(leadObj .id);
        /*Database.LeadConvert lc1 = new database.LeadConvert();
        lc1.setLeadId(leadObj1 .id);
        Database.LeadConvert lc2 = new database.LeadConvert();
        lc2.setLeadId(leadObj2.id);
        Database.LeadConvert lc3 = new database.LeadConvert();
        lc3.setLeadId(leadObj3 .id);
        Database.LeadConvert lc4 = new database.LeadConvert();
        lc4.setLeadId(leadObj4.id);*/
        //lc.status='opportunity';
        lc.setDoNotCreateOpportunity(true);
        /*lc1.setDoNotCreateOpportunity(true);
        lc2.setDoNotCreateOpportunity(true);
        lc3.setDoNotCreateOpportunity(true);
        lc4.setDoNotCreateOpportunity(true);*/
        //lc.setConvertedStatus('opportunity');
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        /*lc1.setConvertedStatus(convertStatus.MasterLabel);
        lc2.setConvertedStatus(convertStatus.MasterLabel);
        lc3.setConvertedStatus(convertStatus.MasterLabel);
        lc4.setConvertedStatus(convertStatus.MasterLabel);*/
        
        
        /*Database.LeadConvertResult lcr1 = Database.convertLead(lc);
        Database.LeadConvertResult lcr2 = Database.convertLead(lc1);
        Database.LeadConvertResult lcr3 = Database.convertLead(lc2);
        Database.LeadConvertResult lcr4 = Database.convertLead(lc3);*/
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
        /*System.assert(lcr1.isSuccess());
        System.assert(lcr2.isSuccess());
        System.assert(lcr3.isSuccess());
        System.assert(lcr4.isSuccess());*/
    }
    
    static testMethod void Test_GE_PRM_LeadTriggerMethod2() {
        Test.startTest();
        //Inserting new Lead with different Tier2.
        List<Lead> lstLd=new List<Lead>();
        
        Lead leadObj1 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='Drilling & Surface (D&S)',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_DS_Marketo_Stage__c='Known');
        lstLd.add(leadObj1);                
        insert lstLd;
        System.assertEquals(leadObj1.GE_HQ_Business_Tier2__c ,'Drilling & Surface (D&S)');
        Test.stopTest();

        Database.LeadConvert lc1 = new database.LeadConvert();
        lc1.setLeadId(leadObj1 .id);
                
        lc1.setDoNotCreateOpportunity(true);
       
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];        
        lc1.setConvertedStatus(convertStatus.MasterLabel);              
        Database.LeadConvertResult lcr1 = Database.convertLead(lc1);
               
        System.assert(lcr1.isSuccess());
       
    }
    
    static testMethod void Test_GE_PRM_LeadTriggerMethod3() {
        Test.startTest();
        //Inserting new Lead with different Tier2.
        List<Lead> lstLd=new List<Lead>();
        
        Lead leadObj1 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='DTS',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_DS_Marketo_Stage__c='Known');
        lstLd.add(leadObj1);                
        insert lstLd;
        System.assertEquals(leadObj1.GE_HQ_Business_Tier2__c ,'DTS');
        Test.stopTest();

        Database.LeadConvert lc1 = new database.LeadConvert();
        lc1.setLeadId(leadObj1 .id);
                
        lc1.setDoNotCreateOpportunity(true);
       
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];        
        lc1.setConvertedStatus(convertStatus.MasterLabel);               
        Database.LeadConvertResult lcr1 = Database.convertLead(lc1);
               
        System.assert(lcr1.isSuccess());
       
    }
    
    static testMethod void Test_GE_PRM_LeadTriggerMethod4() {
        Test.startTest();
        //Inserting new Lead with different Tier2.
        List<Lead> lstLd=new List<Lead>();
        
        Lead leadObj1 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='Subsea (SS)',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_DS_Marketo_Stage__c='Known');
        lstLd.add(leadObj1);                
        insert lstLd;
        System.assertEquals(leadObj1.GE_HQ_Business_Tier2__c ,'Subsea (SS)');
        Test.stopTest();

        Database.LeadConvert lc1 = new database.LeadConvert();
        lc1.setLeadId(leadObj1 .id);
                
        lc1.setDoNotCreateOpportunity(true);
       
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];        
        lc1.setConvertedStatus(convertStatus.MasterLabel);               
        Database.LeadConvertResult lcr1 = Database.convertLead(lc1);
               
        System.assert(lcr1.isSuccess());
       
    }
    
    static testMethod void Test_GE_PRM_LeadTriggerMethod5() {
        Test.startTest();
        //Inserting new Lead with different Tier2.
        List<Lead> lstLd=new List<Lead>();
        
        Lead leadObj1 = new Lead(GE_HQ_Business_Tier1__c ='Oil & Gas (O&G)',firstname='test ',GE_HQ_Business_Tier2__c ='TMS',lastname='TestingLead',Company='Testingaccount',Email='testingemail@ge.com',phone='123457845',GE_OG_DS_Marketo_Stage__c='Known');
        lstLd.add(leadObj1);                
        insert lstLd;
        System.assertEquals(leadObj1.GE_HQ_Business_Tier2__c ,'TMS');
        Test.stopTest();

        Database.LeadConvert lc1 = new database.LeadConvert();
        lc1.setLeadId(leadObj1 .id);
                
        lc1.setDoNotCreateOpportunity(true);
       
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];        
        lc1.setConvertedStatus(convertStatus.MasterLabel);               
        Database.LeadConvertResult lcr1 = Database.convertLead(lc1);
               
        System.assert(lcr1.isSuccess());
       
    }
}