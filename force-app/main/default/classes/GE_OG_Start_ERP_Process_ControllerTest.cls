@isTest
public class GE_OG_Start_ERP_Process_ControllerTest
{
    static testMethod void StartERPProcess() 
    { 
            /*Start sample code from handler */
            GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
            Account Acc= new Account();
            Acc.Name='Test Acc1';  
            Acc.GE_HQ_Request_Status__c='CMF Approved';
            Acc.GE_HQ_KYC_Complete__c=TRUE;
            Acc.GE_PRM_KYC_Completed__c=TRUE;
            Acc.GE_HQ_DUNS_Number__c='555123429';  
            Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
            Acc.GE_OG_Buss_Tier2__c='Lufkin';
            Acc.GE_OG_Buss_Tier3__c='Oilfield';
            Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
            Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
            Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
            Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
            Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
            Acc.GE_PW_City_Bill_To__c='United States';
            Acc.GE_PW_State_Province_Bill_To__c='state';
            Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
            Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
            Acc.GE_PW_City_Ship_To__c='city';
            Acc.GE_PW_State_Province_Ship_To__c='state';
            Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
            Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
            Acc.GE_HQ_Nts_Comments__c='Test';
            insert Acc;
            
            Account_Request__c accReq = new  Account_Request__c();
            accReq.GE_HQ_Account__c=acc.Id;
            accReq.GE_HQ_Nts_Comments__c='Test 1';
            accReq.GE_HQ_Country__c='AFGHANISTAN';     
            accReq.GE_HQ_Street__c='test';     
            accReq.GE_HQ_City__c='Test';     
            accReq.GE_HQ_State_Province__c='Test';     
            accReq.GE_HQ_Postal_Code__c='560067';   
            insert accReq;
            
            GE_PRM_Recommendation__c recom1 = new  GE_PRM_Recommendation__c(GE_PRM_KYC_Page__c='Completed');
            insert recom1;
            
            GE_PRM_KYC_Termination_Checklist__c kyc=new GE_PRM_KYC_Termination_Checklist__c();
            kyc.GE_HQ_Account__c=acc.Id;
            kyc.GE_PRM_Recommendation__c=recom1.id;
            String rt1 = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Edit Record Type').getRecordTypeId();
            kyc.RecordTypeId=rt1;
            kyc.GE_OG_Fin_Status__c='In Progress';
            kyc.GE_HQ_Status__c='Manual Due Diligence Submitted';
            kyc.GE_PW_KYC_Type__c='Modify Account';       
            kyc.GE_PW_Risk_Type__c = 'High';
            kyc.GE_HQ_Sold_To_Country__c = 'Tajikistan';   
            kyc.GE_PW_Acc_Mod_Req__c = accReq.id;       
            insert kyc;              
            System.assertEquals(kyc.GE_OG_Fin_Status__c, 'In Progress');

            GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c (); 
            erp.GE_OG_Advance_User__c = 'test1';
            erp.GE_OG_ERP_Is_this_Customer_Tax_Exempt__c= 'No';
            erp.GE_OG_ERP_Account__c=Acc.id;
            erp.GE_OG_Tier_3_PL__c = acc.GE_OG_Buss_Tier3__c;
            insert erp;
                 
            GE_OG_ERP_Advance_User__c advance=new GE_OG_ERP_Advance_User__c();
            advance.GE_OG_ERP_Tier_3__c=acc.GE_OG_Buss_Tier3__c;
            advance.GE_OG_ERP_Advance_User__c='Test';
            insert advance;
            
            System.assertEquals(advance.GE_OG_ERP_Advance_User__c,'Test');
            
            Attachment a=new Attachment();
            a.name='Test';
            a.parentid=acc.Id;
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            a.body=bodyBlob;
            insert a;
            

            Test.startTest();
            
            ApexPages.StandardController sc = new ApexPages.StandardController(erp);
            GE_OG_Start_ERP_Process_Controller finance=new GE_OG_Start_ERP_Process_Controller(sc);
            
            finance.LoadERP();

            
            erp.GE_OG_KYC__c = kyc.id;
            erp.GE_OG_ERP_Is_this_Customer_Tax_Exempt__c= 'Yes';
            erp.GE_OG_ERP_CSR_Person__c = userinfo.getuserid();
            erp.GE_OG_ERP_Sales_Person__c = userinfo.getuserid();
            update erp;
            finance.LoadERP();
            finance.startERP();
            finance.checkERPAttachment();
            finance.addAttachment();
            
            finance.erpDocs = new list<Attachment>();
            finance.erpDocs.add(a);
            finance.saveAttachment();

            finance.saveERPDetails();
            finance.sdelAttachments =a.id;
            finance.deleteAttachments();  
            
            
            finance.populateSAP();
            finance.populateCSR();
            
            finance.erp.GE_OG_ERP_Sales_Person_First_Name__c ='test';
            finance.erp.GE_OG_ERP_Sales_Person_Last_Name__c = 'test';
            finance.erp.GE_OG_ERP_Sales_Person_ID__c ='test';
            finance.erp.GE_OG_ERP_Sales_Person_Email__c='test';
            finance.saveERPDetails();
            
            finance.OracleERP = false;
            finance.saveERPDetails();
            Test.stopTest();  
    }
}