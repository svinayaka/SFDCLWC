@isTest
public class PRMDueDiligenceHandler_Test {
    static testMethod void dueDilgRecTest(){
        List<PRM_Due_Diligence__c> prm_dd = new List<PRM_Due_Diligence__c>();
        
        Profile  chnlMgrId =  [select id from profile where name ='System Administrator' limit 1];
        User chnlMgnr = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = chnlMgrId.id, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlMgnr;
        
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'PRM_KYC_DD_Permission_Set'];
        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.AssigneeId = chnlMgnr.Id;
        psa.PermissionSetId = ps.Id;
        insert psa;
        
        system.runAs(chnlMgnr){
            Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
            Id acc12=rtByName_acc1.getRecordTypeId();
            
            Account Acc= new Account();
            Acc.Name='Test Acc';   
            Acc.RecordTypeId=acc12;
            Acc.Account_Status__c ='CC Approved';
            insert Acc;
            
            PRM_Channel_Appointment_GE_OG__c prm_chApp = new PRM_Channel_Appointment_GE_OG__c();
            prm_chApp.PRM_Account_Name__c = Acc.id;
            prm_chApp.PRM_Primary_Tier_2__c = 'Digital Solutions';
            prm_chApp.PRM_Commercial_Manager__c = chnlMgnr.id;
            prm_chApp.PRM_Primary_Sales_Channel_Manager__c = chnlMgnr.id;
            insert prm_chApp;
            
            PRM_Share_Holder__c sh = new PRM_Share_Holder__c();
            sh.name = 'Test ShareHolder';
            sh.PRM_Channel_Appointment__c = prm_chApp.id;
            sh.PRM_Active__c = true;
            sh.CurrencyIsoCode = 'USD';
            sh.PRM_Ownership__c = 12;
            sh.PRM_Red_Flag__c = 'No';
            insert sh;
            
            PRM_Officer__c offc = new PRM_Officer__c();
            offc.Name = 'Test Officer';
            offc.PRM_Channel_Appointment__c = prm_chApp.id;
            offc.PRM_Active__c = true;
            offc.PRM_Position__c = 'Executive';
            offc.PRM_Red_Flag__c = 'No';
            insert offc;
            
            PRM_Sub_Affiliate__c prm_subAff = new PRM_Sub_Affiliate__c();
            prm_subAff.PRM_Affiliate_Dependent_Type__c = 'Branch';
            prm_subAff.PRM_Legal_Name__c = 'Test';
            prm_subAff.PRM_Authorized_Commercial_Lines__c = 'Auth Test';
            prm_subAff.PRM_Prinicipal_Contact__c = 'Test Contact';
            prm_subAff.PRM_Active__c = true;
            prm_subAff.PRM_Channel_Appointment__c = prm_chApp.id;
            prm_subAff.CurrencyIsoCode = 'USD';
            prm_subAff.PRM_Red_Flag__c = 'No';
            prm_subAff.PRM_KYC_Reviewer_Comments__c = 'Test';
            insert prm_subAff;
            
            PRM_Due_Diligence__c dd = new PRM_Due_Diligence__c();
            dd.PRM_Active__c = true;
            dd.PRM_KYC_DD_Completed_Date__c = system.today();
            dd.PRM_Channel_Appointment__c = prm_chApp.id;
            dd.PRM_Due_Diligence_Status__c = 'Yellow Flag';
            dd.PRM_3rd_Party_Report_Received_Date__c = system.today();
            dd.PRM_3rd_Party_Report_Request_Date__c = system.today();
            dd.PRM_3rd_Party_Search_Comments__c = 'test';
            dd.PRM_3rd_Party_Searches__c = 'Yes';
            dd.PRM_Adverse_flags_in_Legal_Proceedings__c = 'Yes';
            dd.PRM_Branch_issue_identified__c = 'Yes';
            dd.PRM_Branch_Validation__c = 'Yes';
            dd.PRM_Due_Diligence_Comments__c = 'test';
            dd.PRM_Government_link_Comments__c = 'test';
            dd.PRM_Government_Links__c = 'Yes';
            dd.PRM_Internet_Search__c = 'Yes';
            dd.PRM_Internet_Search_Comments__c = 'test';
            dd.PRM_Is_Government_Certification_uploaded__c = 'Yes';
            dd.PRM_Legal_Entity_Address_Validation__c = 'Yes';
            dd.PRM_Legal_Entity_Name_Validation__c = 'Yes';
            dd.PRM_Legal_Proceedings_Check__c = 'Yes';
            dd.PRM_Negative_News_Status__c = 'PASS - NO FLAG';
            dd.PRM_Positive_WatchList_Alerts__c = 'Yes';
            dd.PRM_Positive_Watchlist_Comments__c = 'test';
            dd.PRM_Sub_agent_Sub_dealer_Validation__c = 'Yes';
            dd.PRM_Sub_Agent_issue_identified__c = 'Yes';
            dd.PRM_Subsidiaries_Validation__c = 'Yes';
            dd.PRM_Subsidiary_issue_identified__c = 'Yes';
            dd.CA_Commercial_Manager__c = chnlMgnr.id;
            insert dd;
            
            Test.startTest();
            dd.PRM_Due_Diligence_Status__c = 'None';
            update dd;
            
            dd.PRM_Due_Diligence_Status__c = 'Not Started';
            update dd;
            
            //Test.startTest();
            PRM_Due_Diligence__c obj = new PRM_Due_Diligence__c();
            Test.stopTest();
        }
    }
    
}