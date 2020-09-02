@isTest
public class GE_OG_Finance_Details_TEST{
    static Testmethod void GE_OG_FinanceDetails(){
     GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account Acc= new Account();
        Acc.Name='Test Acc1';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
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
            
            GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
            findet.GE_OG_Actual__c='actualtest';
            findet.GE_OG_Cust_accepted__c=true;
            findet.GE_OG_Comment__c='nrnrn test test test';
            findet.GE_OG_Credit_Line_Request__c='test new test new';
            findet.GE_OG_Currnt_Yr_Sales__c='salestest';
            findet.GE_OG_Approx_of_Employees__c='approxemp';
            findet.GE_OG_Pre_Yr_Sales__c='yearsaltest';
            findet.GE_OG_Approx_yrs_in_Business__c='bussinyrstest';
            findet.GE_OG_level1_met__c='yes';
            findet.GE_OG_Fast_Lane_Criteria__c=true;
            findet.GE_OG_Account__c=acc.id;
            findet.GE_OG_KYC__c =  kyc.id;
            insert findet;
            findet.GE_OG_Finance_Status__c='Completed';
            findet.GE_OG_Resubmitted__c = False;
            findet.GE_OG_Cust_accepted__c = False;
            findet.GE_OG_Escalation_Comments__c = '';
            update findet;
            
           
            ApexPages.StandardController controler =  new ApexPages.StandardController(Acc);    
            GE_OG_Finance_Details finDetail = new GE_OG_Finance_Details(controler);
            
            finDetail.Completed();
            finDetail.saveesc();
            finDetail.savereq();
            finDetail.saveData();
            finDetail.display();
            finDetail.EscalateToFinance();
           
           
    }
    static Testmethod void GE_OG_FinanceDetails2(){
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account AccObj2= new Account();
        AccObj2.Name='Test Acc1';  
        AccObj2.GE_HQ_Request_Status__c='CMF Approved';
        AccObj2.GE_HQ_KYC_Complete__c=TRUE;
        AccObj2.GE_PRM_KYC_Completed__c=TRUE;
        AccObj2.GE_HQ_DUNS_Number__c='555123459';  
        AccObj2.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        AccObj2.GE_OG_Buss_Tier2__c='Lufkin';
        AccObj2.GE_OG_Buss_Tier3__c='Oilfield';
        AccObj2.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        AccObj2.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        AccObj2.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        AccObj2.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        AccObj2.GE_PW_Country_Bill_To__c='UNITED STATES';
        AccObj2.GE_PW_City_Bill_To__c='United States';
        AccObj2.GE_PW_State_Province_Bill_To__c='state';
        AccObj2.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        AccObj2.GE_PW_Country_Ship_To__c='UNITED STATES';
        AccObj2.GE_PW_City_Ship_To__c='city';
        AccObj2.GE_PW_State_Province_Ship_To__c='state';
        AccObj2.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        AccObj2.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        AccObj2.GE_HQ_Nts_Comments__c='Test';
        insert AccObj2;
        
        Account_Request__c accReq2 = new  Account_Request__c();
        accReq2.GE_HQ_Account__c=AccObj2.Id;
        accReq2.GE_HQ_Nts_Comments__c='Test 1';
        accReq2.GE_HQ_Country__c='AFGHANISTAN';     
        accReq2.GE_HQ_Street__c='test';     
        accReq2.GE_HQ_City__c='Test';     
        accReq2.GE_HQ_State_Province__c='Test';     
        accReq2.GE_HQ_Postal_Code__c='560067';   
        insert accReq2;
        
         GE_PRM_Recommendation__c recom = new  GE_PRM_Recommendation__c(GE_PRM_KYC_Page__c='Completed');
         insert recom;
            
            GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
            ky.GE_HQ_Account__c=AccObj2.Id;
            ky.GE_PRM_Recommendation__c=recom.id;
            String rt1 = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Edit Record Type').getRecordTypeId();
            ky.RecordTypeId=rt1;
            ky.GE_OG_Fin_Status__c='In Progress';
            ky.GE_HQ_Status__c='Manual Due Diligence Submitted';
            ky.GE_PW_KYC_Type__c='Modify Account';       
            ky.GE_PW_Risk_Type__c = 'High';
            ky.GE_HQ_Sold_To_Country__c = 'Tajikistan';   
            ky.GE_PW_Acc_Mod_Req__c = accReq2.id;       
            insert ky;              
            System.assertEquals(ky.GE_OG_Fin_Status__c, 'In Progress');
            
            GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
            findet.GE_OG_Actual__c='actualtest';
            findet.GE_OG_Cust_accepted__c=true;
            findet.GE_OG_Comment__c='nrnrn test test test';
            findet.GE_OG_Credit_Line_Request__c='test new test new';
            findet.GE_OG_Currnt_Yr_Sales__c='salestest';
            findet.GE_OG_Approx_of_Employees__c='approxemp';
            findet.GE_OG_Pre_Yr_Sales__c='yearsaltest';
            findet.GE_OG_Approx_yrs_in_Business__c='bussinyrstest';
            findet.GE_OG_level1_met__c='yes';
            findet.GE_OG_Fast_Lane_Criteria__c=true;
            findet.GE_OG_Account__c=AccObj2.id;
            findet.GE_OG_KYC__c =  ky.id;
            insert findet;
            findet.GE_OG_Finance_Status__c='Pending User Review - On Hold';
            findet.GE_OG_Resubmitted__c = False;
            findet.GE_OG_Cust_accepted__c = False;
            findet.GE_OG_Escalation_Comments__c = 'Test';
            update findet;
            
                 
            
            ApexPages.StandardController controler =  new ApexPages.StandardController(AccObj2);    
            GE_OG_Finance_Details finDetail1 = new GE_OG_Finance_Details(controler);
            
            finDetail1.Rejected();
            finDetail1.saveesc();
            finDetail1.savereq();
            finDetail1.saveData();
            finDetail1.display();
            finDetail1.EscalateToFinance();
    }
    static Testmethod void GE_OG_FinanceDetails1(){
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account AccObj= new Account();
        AccObj.Name='Test Acc1';  
        AccObj.GE_HQ_Request_Status__c='CMF Approved';
        AccObj.GE_HQ_KYC_Complete__c=TRUE;
        AccObj.GE_PRM_KYC_Completed__c=TRUE;
        AccObj.GE_HQ_DUNS_Number__c='555123459';  
        AccObj.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        AccObj.GE_OG_Buss_Tier2__c='Lufkin';
        AccObj.GE_OG_Buss_Tier3__c='Oilfield';
        AccObj.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        AccObj.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        AccObj.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        AccObj.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        AccObj.GE_PW_Country_Bill_To__c='UNITED STATES';
        AccObj.GE_PW_City_Bill_To__c='United States';
        AccObj.GE_PW_State_Province_Bill_To__c='state';
        AccObj.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        AccObj.GE_PW_Country_Ship_To__c='UNITED STATES';
        AccObj.GE_PW_City_Ship_To__c='city';
        AccObj.GE_PW_State_Province_Ship_To__c='state';
        AccObj.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        AccObj.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        AccObj.GE_HQ_Nts_Comments__c='Test';
        insert AccObj;
        
        Account_Request__c accReq1 = new  Account_Request__c();
        accReq1.GE_HQ_Account__c=AccObj.Id;
        accReq1.GE_HQ_Nts_Comments__c='Test 1';
        accReq1.GE_HQ_Country__c='AFGHANISTAN';     
        accReq1.GE_HQ_Street__c='test';     
        accReq1.GE_HQ_City__c='Test';     
        accReq1.GE_HQ_State_Province__c='Test';     
        accReq1.GE_HQ_Postal_Code__c='560067';   
        insert accReq1;
        
         GE_PRM_Recommendation__c recom = new  GE_PRM_Recommendation__c(GE_PRM_KYC_Page__c='Completed');
         insert recom;
            
            GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
            ky.GE_HQ_Account__c=AccObj.Id;
            ky.GE_PRM_Recommendation__c=recom.id;
            String rt1 = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Edit Record Type').getRecordTypeId();
            ky.RecordTypeId=rt1;
            ky.GE_OG_Fin_Status__c='In Progress';
            ky.GE_HQ_Status__c='Manual Due Diligence Submitted';
            ky.GE_PW_KYC_Type__c='Modify Account';       
            ky.GE_PW_Risk_Type__c = 'High';
            ky.GE_HQ_Sold_To_Country__c = 'Tajikistan';   
            ky.GE_PW_Acc_Mod_Req__c = accReq1.id;       
            insert ky;              
            System.assertEquals(ky.GE_OG_Fin_Status__c, 'In Progress');
            
            GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
            findet.GE_OG_Actual__c='actualtest';
            findet.GE_OG_Cust_accepted__c=true;
            findet.GE_OG_Comment__c='nrnrn test test test';
            findet.GE_OG_Credit_Line_Request__c='test new test new';
            findet.GE_OG_Currnt_Yr_Sales__c='salestest';
            findet.GE_OG_Approx_of_Employees__c='approxemp';
            findet.GE_OG_Pre_Yr_Sales__c='yearsaltest';
            findet.GE_OG_Approx_yrs_in_Business__c='bussinyrstest';
            findet.GE_OG_level1_met__c='yes';
            findet.GE_OG_Fast_Lane_Criteria__c=true;
            findet.GE_OG_Account__c=AccObj.id;
            findet.GE_OG_KYC__c =  ky.id;
            insert findet;
            findet.GE_OG_Finance_Status__c='Submitted';
            findet.GE_HQ_Finance_Risk_Score__c=Null;
            findet.GE_OG_Finance_Credit_Limit__c=Null;
            findet.GE_OG_Actual__c=NUll;
            findet.GE_OG_Finan_TC__c=NUll;
            findet.GE_OG_Resubmitted__c = TRUE;
            update findet;
            
                 
            
            ApexPages.StandardController controler =  new ApexPages.StandardController(AccObj);    
            GE_OG_Finance_Details finDetail1 = new GE_OG_Finance_Details(controler);
            
            finDetail1.Resubmitted();
            finDetail1.saveesc();
            finDetail1.savereq();
            finDetail1.saveData();
            finDetail1.display();
            finDetail1.EscalateToFinance();
    }
}