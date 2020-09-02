/*
Test Class Name: GE_OG_AutoCreateFinanceTest
Use: Trigger to insert Finance and ERP record whenever a KYC record is created.
Trigger Name: GE_OG_AutoCreateFinance
*/

@isTest
private class GE_OG_AutoCreateFinanceTest{
    static testMethod void AutoCreateFinanceTest() {  
    
        Account acc=new Account();          
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'UNITED STATES';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'UNITED STATES'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc.GE_PW_Street_Bill_To__c = 'test';
        acc.GE_PW_City_Bill_To__c = 'test';
        acc.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc.GE_PW_Street_Ship_To__c = 'test';
        acc.GE_PW_City_Ship_To__c = 'test';
        acc.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'UNITED STATES';
        acc.GE_PW_Country_Bill_To__c = 'UNITED STATES';
        acc.GE_PW_Country_Ship_To__c = 'UNITED STATES';
        acc.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc.GE_PW_Phone_Bill_To__c = '0212142121';
        acc.GE_PW_Phone_Ship_To__c = '020124512';
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc.GE_HQ_DB_DUNS__c = '254123452';
        acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'UNITED STATES'; 
        acc.GE_HQ_Nts_Comments__c = 'test';
        acc.GE_OG_Buss_Tier1__c='Oil & Gas';
        acc.GE_OG_Buss_Tier2__c='Digital Solutions';
        acc.GE_OG_Buss_Tier3__c='Flow & Process Technologies (Dresser)';
        insert acc;
        string accid=acc.id;
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        
        GE_PRM_KYC_Termination_Checklist__c kynew =new GE_PRM_KYC_Termination_Checklist__c();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        kynew.GE_HQ_Account__c=acc.Id;
        kynew.GE_PRM_Recommendation__c=RecomId;
        kynew.GE_OG_Fin_Status__c='Completed';
        kynew.GE_PW_KYC_Type__c = 'In Progress';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kynew.RecordTypeId=kyc1;
        
        insert kynew;
        
        GEMDM__GEMDMCountryList__c con =  new GEMDM__GEMDMCountryList__c();
        con.GEMDM__Country_Code__c = 'US';
        con.Name='test';
        con.GEMDM__Country_Name__c = 'UNITED STATES';
        insert con;
        
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Comment__c=Null;
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c=Null;
        findet.GE_OG_Approx_of_Employees__c=Null;
        findet.GE_OG_Pre_Yr_Sales__c= null;
        findet.GE_OG_Approx_yrs_in_Business__c=null;
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;

        System.assertEquals(acc.Name,'Test');          
        /*End sample code from handler */
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = kynew.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
             
    }
    
    
     static testMethod void AutoCreateFinanceTest2() {  
    
        Account acc=new Account();          
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'UNITED STATES';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'UNITED STATES'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc.GE_PW_Street_Bill_To__c = 'test';
        acc.GE_PW_City_Bill_To__c = 'test';
        acc.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc.GE_PW_Street_Ship_To__c = 'test';
        acc.GE_PW_City_Ship_To__c = 'test';
        acc.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'UNITED STATES';
        acc.GE_PW_Country_Bill_To__c = 'UNITED STATES';
        acc.GE_PW_Country_Ship_To__c = 'UNITED STATES';
        acc.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc.GE_PW_Phone_Bill_To__c = '0212142121';
        acc.GE_PW_Phone_Ship_To__c = '020124512';
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc.GE_HQ_DB_DUNS__c = '254123452';
        acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'UNITED STATES'; 
        acc.GE_HQ_Nts_Comments__c = 'test';
        acc.GE_OG_Buss_Tier1__c='Oil & Gas';
        acc.GE_OG_Buss_Tier2__c='Digital Solutions';
        acc.GE_OG_Buss_Tier3__c='Control Solutions';
        insert acc;
        string accid=acc.id;
        
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        
        GE_PRM_KYC_Termination_Checklist__c kynew =new GE_PRM_KYC_Termination_Checklist__c();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        kynew.GE_HQ_Account__c=acc.Id;
        kynew.GE_PRM_Recommendation__c=RecomId;
        kynew.GE_OG_Fin_Status__c='Completed';
        kynew.GE_PW_KYC_Type__c = 'Modify Account';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kynew.RecordTypeId=kyc1;
        
        insert kynew;
        
        GEMDM__GEMDMCountryList__c con =  new GEMDM__GEMDMCountryList__c();
        con.GEMDM__Country_Code__c = 'US';
        con.Name='test';
        con.GEMDM__Country_Name__c = 'UNITED STATES';
        insert con;
        
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Comment__c=Null;
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c=Null;
        findet.GE_OG_Approx_of_Employees__c=Null;
        findet.GE_OG_Pre_Yr_Sales__c= null;
        findet.GE_OG_Approx_yrs_in_Business__c=null;
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = kynew.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
             
    }
    
    static testMethod void AutoCreateFinanceTest3() {  
    
        Account acc=new Account();          
        acc.name = 'Testabcd';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'UNITED STATES';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'UNITED STATES'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc.GE_PW_Street_Bill_To__c = 'test';
        acc.GE_PW_City_Bill_To__c = 'test';
        acc.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc.GE_PW_Street_Ship_To__c = 'test';
        acc.GE_PW_City_Ship_To__c = 'test';
        acc.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'UNITED STATES';
        acc.GE_PW_Country_Bill_To__c = 'UNITED STATES';
        acc.GE_PW_Country_Ship_To__c = 'UNITED STATES';
        acc.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc.GE_PW_Phone_Bill_To__c = '0212142121';
        acc.GE_PW_Phone_Ship_To__c = '020124512';
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc.GE_HQ_DB_DUNS__c = '254123452';
        acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'UNITED STATES'; 
        acc.GE_HQ_Nts_Comments__c = 'test';
        acc.GE_OG_Buss_Tier1__c='Oil & Gas';
        acc.GE_OG_Buss_Tier2__c='Subsea & Drilling';
        acc.GE_OG_Buss_Tier3__c='Drilling';
        insert acc;
        string accid=acc.id;
        
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        
        GE_PRM_KYC_Termination_Checklist__c kynew =new GE_PRM_KYC_Termination_Checklist__c();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        kynew.GE_HQ_Account__c=acc.Id;
        kynew.GE_PRM_Recommendation__c=RecomId;
        kynew.GE_OG_Fin_Status__c='Completed';
        //kynew.GE_PW_KYC_Type__c = 'Modify Account';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kynew.RecordTypeId=kyc1;
        
        insert kynew;
        
        GEMDM__GEMDMCountryList__c con =  new GEMDM__GEMDMCountryList__c();
        con.GEMDM__Country_Code__c = 'US';
        con.Name='test';
        con.GEMDM__Country_Name__c = 'UNITED STATES';
        insert con;
        
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Comment__c=Null;
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c=Null;
        findet.GE_OG_Approx_of_Employees__c=Null;
        findet.GE_OG_Pre_Yr_Sales__c= null;
        findet.GE_OG_Approx_yrs_in_Business__c=null;
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = kynew.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
             
    }
    
    static testMethod void AutoCreateFinanceTest4() {  
    
        Account acc=new Account();          
        acc.name = 'Testabcd';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'UNITED STATES';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'UNITED STATES'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc.GE_PW_Street_Bill_To__c = 'test';
        acc.GE_PW_City_Bill_To__c = 'test';
        acc.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc.GE_PW_Street_Ship_To__c = 'test';
        acc.GE_PW_City_Ship_To__c = 'test';
        acc.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'UNITED STATES';
        acc.GE_PW_Country_Bill_To__c = 'UNITED STATES';
        acc.GE_PW_Country_Ship_To__c = 'UNITED STATES';
        acc.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc.GE_PW_Phone_Bill_To__c = '0212142121';
        acc.GE_PW_Phone_Ship_To__c = '020124512';
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc.GE_HQ_DB_DUNS__c = '254123452';
        acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'UNITED STATES'; 
        acc.GE_HQ_Nts_Comments__c = 'test';
        acc.GE_OG_Buss_Tier1__c='Oil & Gas';
        acc.GE_OG_Buss_Tier2__c='Downstream Technology Solutions';
        acc.GE_OG_Buss_Tier3__c='Flow & Process Technologies';
        insert acc;
        string accid=acc.id;
        
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        
        GE_PRM_KYC_Termination_Checklist__c kynew =new GE_PRM_KYC_Termination_Checklist__c();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        kynew.GE_HQ_Account__c=acc.Id;
        kynew.GE_PRM_Recommendation__c=RecomId;
        kynew.GE_OG_Fin_Status__c='Completed';
        //kynew.GE_PW_KYC_Type__c = 'Modify Account';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kynew.RecordTypeId=kyc1;
        
        insert kynew;
        
        GEMDM__GEMDMCountryList__c con =  new GEMDM__GEMDMCountryList__c();
        con.GEMDM__Country_Code__c = 'US';
        con.Name='test';
        con.GEMDM__Country_Name__c = 'UNITED STATES';
        insert con;
        
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Comment__c=Null;
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c=Null;
        findet.GE_OG_Approx_of_Employees__c=Null;
        findet.GE_OG_Pre_Yr_Sales__c= null;
        findet.GE_OG_Approx_yrs_in_Business__c=null;
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = kynew.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
             
    }
    
    static testMethod void AutoCreateFinanceTest5() {  
    
        Account acc=new Account();          
        acc.name = 'Testabcd';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'UNITED STATES';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'UNITED STATES'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc.GE_PW_Street_Bill_To__c = 'test';
        acc.GE_PW_City_Bill_To__c = 'test';
        acc.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc.GE_PW_Street_Ship_To__c = 'test';
        acc.GE_PW_City_Ship_To__c = 'test';
        acc.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'UNITED STATES';
        acc.GE_PW_Country_Bill_To__c = 'UNITED STATES';
        acc.GE_PW_Country_Ship_To__c = 'UNITED STATES';
        acc.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc.GE_PW_Phone_Bill_To__c = '0212142121';
        acc.GE_PW_Phone_Ship_To__c = '020124512';
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc.GE_HQ_DB_DUNS__c = '254123452';
        acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'UNITED STATES'; 
        acc.GE_HQ_Nts_Comments__c = 'test';
        acc.GE_OG_Buss_Tier1__c='Oil & Gas';
        acc.GE_OG_Buss_Tier2__c='Surface';
        acc.GE_OG_Buss_Tier3__c='DT/LS/Zenith';
        acc.GE_OG_Buss_Tier4__c='Downhole Technology';
        insert acc;
        string accid=acc.id;
        
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        
        GE_PRM_KYC_Termination_Checklist__c kynew =new GE_PRM_KYC_Termination_Checklist__c();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        kynew.GE_HQ_Account__c=acc.Id;
        kynew.GE_PRM_Recommendation__c=RecomId;
        kynew.GE_OG_Fin_Status__c='Completed';
        //kynew.GE_PW_KYC_Type__c = 'Modify Account';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kynew.RecordTypeId=kyc1;
        
        insert kynew;
        
        GEMDM__GEMDMCountryList__c con =  new GEMDM__GEMDMCountryList__c();
        con.GEMDM__Country_Code__c = 'US';
        con.Name='test';
        con.GEMDM__Country_Name__c = 'UNITED STATES';
        insert con;
        
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Comment__c=Null;
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c=Null;
        findet.GE_OG_Approx_of_Employees__c=Null;
        findet.GE_OG_Pre_Yr_Sales__c= null;
        findet.GE_OG_Approx_yrs_in_Business__c=null;
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = kynew.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
             
    }
    
    static testMethod void AutoCreateFinanceTest6() {  
    
        Account acc=new Account();          
        acc.name = 'Testabcd';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'UNITED STATES';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'UNITED STATES'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc.GE_PW_Street_Bill_To__c = 'test';
        acc.GE_PW_City_Bill_To__c = 'test';
        acc.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc.GE_PW_Street_Ship_To__c = 'test';
        acc.GE_PW_City_Ship_To__c = 'test';
        acc.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'UNITED STATES';
        acc.GE_PW_Country_Bill_To__c = 'UNITED STATES';
        acc.GE_PW_Country_Ship_To__c = 'UNITED STATES';
        acc.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc.GE_PW_Phone_Bill_To__c = '0212142121';
        acc.GE_PW_Phone_Ship_To__c = '020124512';
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc.GE_HQ_DB_DUNS__c = '254123452';
        acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'UNITED STATES'; 
        acc.GE_HQ_Nts_Comments__c = 'test';
        acc.GE_OG_Buss_Tier1__c='Oil & Gas';
        acc.GE_OG_Buss_Tier2__c='Turbomachinery Solutions';
        acc.GE_OG_Buss_Tier3__c='Power Transmission';
        insert acc;
        string accid=acc.id;
        
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        
        GE_PRM_KYC_Termination_Checklist__c kynew =new GE_PRM_KYC_Termination_Checklist__c();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        kynew.GE_HQ_Account__c=acc.Id;
        kynew.GE_PRM_Recommendation__c=RecomId;
        kynew.GE_OG_Fin_Status__c='Completed';
        //kynew.GE_PW_KYC_Type__c = 'Modify Account';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kynew.RecordTypeId=kyc1;
        
        insert kynew;
        
        GEMDM__GEMDMCountryList__c con =  new GEMDM__GEMDMCountryList__c();
        con.GEMDM__Country_Code__c = 'US';
        con.Name='test';
        con.GEMDM__Country_Name__c = 'UNITED STATES';
        insert con;
        
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Comment__c=Null;
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c=Null;
        findet.GE_OG_Approx_of_Employees__c=Null;
        findet.GE_OG_Pre_Yr_Sales__c= null;
        findet.GE_OG_Approx_yrs_in_Business__c=null;
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = kynew.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
             
    }
}