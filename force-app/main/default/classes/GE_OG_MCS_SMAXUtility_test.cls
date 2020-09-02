/**
 * This class is written to improve the code coverage of SMAXUtility
 * as a part of MCS business.
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts
Author:Sathyanarayana B.
See the Apex Language Reference for more information about Testing and Code Coverage.
*/

@isTest(SeeAllData=True)
public class GE_OG_MCS_SMAXUtility_test 
{

    static testMethod void myUnitTest() 
    {
        Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
        
        
        SVMXC__Skill__c sk = new SVMXC__Skill__c(name='test');
        insert sk;        
        
        
        List<EmailTemplate> etList= new List<EmailTemplate>([select id from EmailTemplate where name='GE_OG_MC_WorkOrderTechAssignedForMCS']);
        EmailTemplate et = new EmailTemplate(Name='GE_OG_MC_WorkOrderTechAssignedForMCS',Subject='hi',Body='Body content of Email');        
        
        //Account 
        Account acc = new Account();
        ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        acc.RecordTypeId = accrecid;
        acc.name = 'testaccount';
        acc.Classification__c = 'Strategic';        
        insert acc;

        SVMXC__Site__c loc = new SVMXC__Site__c ();
        loc.name = 'Test Location';
        loc.GE_AL_Well_Type__c = 'Sour Service';
        loc.SVMXC__Country__c = 'United States';
        insert loc;
        
        GE_SS_Project__c fsp = new GE_SS_Project__c();
        fsp.Name = 'Test';
        fsp.GE_SS_Account__c = acc.id;
        fsp.GE_SS_Status__c = 'Open';        
        fsp.GE_SS_Type_of_Customer_Project__c = 'Greenfield';
        fsp.GE_SS_Country__c = 'INDIA';
        //OFS Commented
        //fsp.BHGE_OFS_Driving_Directions__c = 'Test BHGE OFS Driving Directions';
        insert fsp;     
            
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Order_Status__c = 'Open';
        wo.SVMXC__Priority__c ='Medium';
        wo.SVMXC__Skill__c=sk.id;
        wo.RecordTypeId = rtId;
        wo.GE_SM_HQ_Task_Description__c = 'Test Task Desciption';
        wo.GE_PC_Driving_Directions__c = 'Test Driving Directions';        
        wo.GE_SM_HQ_Scheduled_Start_Date_Time__c = System.now();
        wo.GE_SM_HQ_Scheduled_End_Date_Time__c = System.now();
        wo.GE_PC_RIG__c = 'Test Rig';
        wo.SVMXC__Latitude__c = 1234.78;
        wo.SVMXC__Longitude__c = 2345.89;
        /*OFS Commented
        wo.BHGE_OFS_Field_Name__c = 'Test BHGE OFS Field';
        wo.BHGE_OFS_Block_Number__c = 'Test Block Number';*/
        wo.SVMXC__Company__c = acc.id;
        wo.SVMXC__Site__c   = loc.id;
        wo.GE_SS_Project__c = fsp.id;
        wo.Region__c='MENAT';
        insert wo;
        
        //OFS Commented
        //Id workRecId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('BHGE_OFS').getRecordTypeId();
        //OFS Added
        Id workRecId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId(); 
        Test.StartTest();
        SVMXC__Service_Order__c wo_MENAT = new SVMXC__Service_Order__c();
        wo_MENAT.SVMXC__Order_Status__c = 'Open';
        wo_MENAT.SVMXC__Priority__c ='Medium';
        wo_MENAT.SVMXC__Skill__c=sk.id;
        wo_MENAT.RecordTypeId = workRecId;
        wo_MENAT.GE_SM_HQ_Task_Description__c = 'Test Task Desciption';
        wo_MENAT.GE_PC_Driving_Directions__c = 'Test Driving Directions';
        wo_MENAT.GE_SM_HQ_Scheduled_Start_Date_Time__c = System.now();
        wo_MENAT.GE_SM_HQ_Scheduled_End_Date_Time__c = System.now();        
        wo_MENAT.Region__c='MENAT';
        wo_MENAT.GE_PC_RIG__c = 'Test Rig';
        wo_MENAT.SVMXC__Latitude__c = 1234.78;
        wo_MENAT.SVMXC__Longitude__c = 2345.89;     
        /*OFS Commented
        wo_MENAT.BHGE_OFS_Field_Name__c = 'Test BHGE OFS Field';
        wo_MENAT.BHGE_OFS_Block_Number__c   = 'Test Block Number';*/
        wo_MENAT.SVMXC__Company__c = acc.id;
        wo_MENAT.SVMXC__Site__c = loc.id;
        wo_MENAT.GE_SS_Project__c = fsp.id;
        insert wo_MENAT;
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'      
        );
        insert sg;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = sg.Id,
        Name = 'SVMX Tech',
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '51234567',
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        
        
        SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        DateTime t = system.now();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
        evtOb.SVMXC__StartDateTime__c = t;
        evtOb.SVMXC__EndDateTime__c = t.addDays(15);
        evtOb.SVMXC__ActivityDate__c  = Date.today();
        evtOb.SVMXC__ActivityDateTime__c  = t;       
        insert evtOb;
        
        SVMXC__SVMX_Event__c evtOb_MENAT = new SVMXC__SVMX_Event__c();
        evtOb_MENAT.SVMXC__Service_Order__c = wo_MENAT.id;
        evtOb_MENAT.SVMXC__Technician__c=tech.id;
        evtOb_MENAT.SVMXC__WhatId__c= wo_MENAT.id;
        evtOb_MENAT.SVMXC__StartDateTime__c = t;
        evtOb_MENAT.SVMXC__EndDateTime__c = t.addDays(15);
        evtOb_MENAT.SVMXC__ActivityDate__c  = Date.today();
        evtOb_MENAT.SVMXC__ActivityDateTime__c  = t;
        insert evtOb_MENAT;
        Test.StopTest();
               
        String mailadd = 'test@ge.com';
        String  []mailaddress = new String[]{mailadd};
        
        Id Userid = UserInfo.getUserId(); 
        ID templateId;
        for (EmailTemplate etid:etList)
             templateId= etid.id;

        ID WOId = wo.id;
        SVMX_Utility.sendEmail(WOId, templateId, Userid, mailadd);
        //SVMX_Utility.sendApprovalEmail(WOId);
        
        SVMXC__Service_Group_Members__c tech1 = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = sg.Id,
        Name = 'SVMX Tech',
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '512345672',
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech1;
        
        delete tech1;
        
        undelete tech1;
        
        SVMX_Utility.sendEmailstoMCS(evtOb.id, templateId, Userid, mailadd);
        //SVMX_Utility.sendEmailsToPC(new List<SVMXC__SVMX_Event__c> {evtOb_MENAT},new List<SVMXC__Service_Order__c> {wo_MENAT});
        SVMX_Utility.sendEmailsToPC(new List<SVMXC__SVMX_Event__c> {evtOb},new List<SVMXC__Service_Order__c> {wo}) ;
        //OFS Commented
        //SVMX_Utility.sendEmailToOFSTech(new List<SVMXC__Service_Order__c> {wo_MENAT}, new List<SVMXC__SVMX_Event__c> {evtOb});
    }
}