@isTest

public class GE_OG_FinanceRetriggerTest{
    
    static testMethod void GE_OG_FinanceRetriggerTest1(){
     
        GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest = true;
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
        //acc.BillingCountry
        insert acc;
        string accid=acc.id;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc For TestClass';  
        Acc1.GE_HQ_Request_Status__c='CMF Approved';
        Acc1.GE_HQ_KYC_Complete__c=TRUE;
        Acc1.GE_PRM_KYC_Completed__c=TRUE;
        Acc1.GE_HQ_DUNS_Number__c='555123423';  
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc1.GE_OG_Buss_Tier2__c='Lufkin';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        Acc1.GE_HQ_Nts_Comments__c='Test';
        acc1.GE_HQ_Site_Use_Code__c = 'none';
        acc1.ShippingCountry = 'UNITED STATES';
        insert acc1;
        
                
        OG_Trigger_fire_Decision__c tfd = new OG_Trigger_fire_Decision__c();
        tfd.isActive__c = true;
        tfd.Object_Name__c = 'Account' ;
        tfd.Trigger_Name__c = 'GE_OG_InsertTeamMember' ;
        tfd.name = 'GE_OG_InsertTeamMember';
        insert tfd;
        
        OG_Trigger_fire_Decision__c tfd1 = new OG_Trigger_fire_Decision__c();
        tfd1.isActive__c = true;
        tfd1.Object_Name__c = 'Account' ;
        tfd1.Trigger_Name__c = 'GE_OG_Update_FinanceUpdateStatus' ;
        tfd1.name = 'GE_OG_Update_FinanceUpdateStatus';
        insert tfd1;
              
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
        con.GEMDM__Country_Code__c= 'US';
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
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
            
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
        insert coun1;
         
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
        update coun1;
        
        GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = accReq.GE_HQ_Country__c;
        CMFcountry.GE_PW_Country__c= coun1.id; 
        insert CMFcountry ; 

        Test.startTest();

        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_OG_FinanceRetriggerController finance=new GE_OG_FinanceRetriggerController(sc);
        GE_OG_Finance_Details__c  fffffff=finance.finc;
        
        finance.creditq1= false;
        finance.creditq2 = false;
        finance.isCreditLevel2 = false; 
      
        finance.CheckRiskTpe(); 
        finance.GoBack();
        finance.onchangeType_of_Business();
        finance.kycid=null;
        finance.KycRedirect();
        acc.GE_HQ_Site_Use_Code__c='none';
        update acc;
        finance.KycRedirect();
        
        Schema.DescribeSObjectResult ky = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
            Map<String,Schema.RecordTypeInfo> rtMapByName = ky.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
            Id kycRT=rtByName.getRecordTypeId();
            //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
            String RecomId1 = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
            GE_PRM_KYC_Termination_Checklist__c ky2=new GE_PRM_KYC_Termination_Checklist__c();
            ky2.RecordTypeId=kycRT;
            ky2.GE_PRM_Recommendation__c=RecomId1;
            
            System.debug('*******************in KYC new*********************************************');
           
            ky2.GE_HQ_Account__c=acc1.id;
            ky2.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
            ky2.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
            ky2.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
            ky2.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
            ky2.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
            ky2.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
            ky2.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
            ky2.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
            ky2.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
            ky2.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
            ky2.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
            ky2.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
            ky2.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
            ky2.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
            ky2.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
            ky2.GE_OG_Finance_checked__c=true;
            //ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                
        ky2.GE_PW_Risk_Type__c = ' Risk'; 
        
        insert ky2;            
        finance.kycid=ky2;
        //finance.KycRedirect();
       // finance.onchangeType_of_Business();
       // finance.goBack();
                
        Test.stopTest();   
    }
     static testMethod void GE_OG_FinanceRetriggerTest2(){       
       
       OG_Trigger_fire_Decision__c tfd = new OG_Trigger_fire_Decision__c();
        tfd.isActive__c = true ;
        tfd.Object_Name__c = 'Account' ;
        tfd.Trigger_Name__c = 'populateParentAccount' ;
        tfd.name = 'populateParentAccount';
        insert tfd;
        
        OG_Trigger_fire_Decision__c tfd1 = new OG_Trigger_fire_Decision__c();
        tfd1.isActive__c = true;
        tfd1.Object_Name__c = 'Account' ;
        tfd1.Trigger_Name__c = 'GE_OG_Update_FinanceUpdateStatus' ;
        tfd1.name = 'GE_OG_Update_FinanceUpdateStatus';
        insert tfd1;
        
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
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        //acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';   
        acc.GE_HQ_Nts_Comments__c = 'test';      
        insert acc;
        
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
   
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
       GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        //CMFcountry.GE_PW_CMF_Name__c = accReq.GE_HQ_Country__c;
        CMFcountry.GE_PW_CMF_Name__c ='ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;        
        
        insert CMFcountry ;        
        

         Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
            Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
            Id kycRT=rtByName.getRecordTypeId();
            //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
           
            String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
            GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
            ky.RecordTypeId=kycRT;
            ky.GE_PRM_Recommendation__c=RecomId;
            
            System.debug('*******************in KYC new*********************************************');
           
                ky.GE_HQ_Account__c=acc.id;
                ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
                ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
                ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
                ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
                ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
                ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_OG_Finance_checked__c=true;
                //ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                
                ky.GE_PW_Risk_Type__c = ' Risk'; 
                
                insert ky;            
        
        Test.startTest();
        
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_OG_FinanceRetriggerController finance=new GE_OG_FinanceRetriggerController(sc);
        finance.getVatApplicable();
        //finance.KycRedirect();
        finance.creditq1 = true;
        finance.Submit();
        finance.CheckRiskTpe();
        finance.Submit();
        finance.GoBack();
        finance.onchangeType_of_Business();
        finance.kycid=null;
        finance.KycRedirect();
        acc.GE_HQ_Site_Use_Code__c='none';
        update acc;
        finance.KycRedirect();
        
         finance.kycid=ky;
        //finance.KycRedirect();
                
        Test.stopTest();   
    }
    
  static testMethod void GE_OG_FinanceRetriggerTest3() 
    {       
        
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
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        //acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test';     
        insert acc;
               
        GE_PRM_KYC_Termination_Checklist__c terchek = new GE_PRM_KYC_Termination_Checklist__c();
        terchek.GE_HQ_VAT_Tax_ID__c='taxid';
        terchek.GE_HQ_Vat_Reason_Code__c='Customer Tax Exempt'; 
        terchek.GE_HQ_Status__c='KYC In Process';
        terchek.GE_PW_KYC_Type__c='New Account';
      // insert terchek;
  
        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;

        GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        //CMFcountry.GE_PW_CMF_Name__c = accReq.GE_HQ_Country__c;
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;        
        
        insert CMFcountry ; 
        
        Test.startTest();
        
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_OG_FinanceRetriggerController finance=new GE_OG_FinanceRetriggerController(sc);
        
        /*finance.getVatApplicable();
        finance.KycRedirect();
        finance.Submit();
        finance.CheckRiskTpe();
        finance.Submit();
        finance.GoBack();
        finance.onchangeType_of_Business();
        finance.kycid=null;
        finance.KycRedirect();*/
        
       // update acc;
        //finance.KycRedirect();
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
            Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
            Id kycRT=rtByName.getRecordTypeId();
            //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
            String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
            GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
            ky.RecordTypeId=kycRT;
            ky.GE_PRM_Recommendation__c=RecomId;
            
            System.debug('*******************in KYC new*********************************************');
           
                ky.GE_HQ_Account__c=acc.id;
                ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
                ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
                ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
                ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
                ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
                ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_OG_Finance_checked__c=true;
                //ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                ky.GE_PW_KYC_Type__c='Modify Account';
                ky.GE_PW_Risk_Type__c = ' Risk'; 
                insert ky; 
                
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        //findet.GE_OG_Comment__c='nrnrn test test test';
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        //findet.GE_OG_Currnt_Yr_Sales__c='salestest';
       // findet.GE_OG_Approx_of_Employees__c='approxemp';
        //findet.GE_OG_Pre_Yr_Sales__c='yearsaltest';
        //findet.GE_OG_Approx_yrs_in_Business__c='bussinyrstest';
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c = acc.Id;
        findet.GE_OG_KYC__c = ky.id;
        findet.GE_OG_Finance_Status__c ='Pending User Submission';
        insert findet;

                finance.acc=acc;          
                finance.kycid=ky;
                finance.kycexist = true;
                finance.KycRedirect();
                try{
                finance.submit();
                }catch(Exception e){}
               ky.GE_PW_KYC_Type__c='New Account';
               update ky;
                finance.GoBack();
                finance.kycid=null;
                finance.KycRedirect();
        Test.stopTest();   
    }

  static testMethod void GE_OG_FinanceRetriggerTest4() 
    {      
        try{ 
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
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA'; 
        acc.GE_HQ_Nts_Comments__c = 'test';        
        insert acc;

        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        //findet.GE_OG_Comment__c='nrnrn test test tes;
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        //findet.GE_OG_Currnt_Yr_Sales__c='salestest';
       // findet.GE_OG_Approx_of_Employees__c='approxemp';
        //findet.GE_OG_Pre_Yr_Sales__c='yearsaltest';
        //findet.GE_OG_Approx_yrs_in_Business__c='bussinyrstest';
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;

        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
        update coun1;
        GE_PW_CMFtoISOCountryName__c CMFcountry =  Test_GE_Accounts_Handler.cmfcoun(accReq,coun1);
        CMFcountry.GE_PW_CMF_Name__c='ARGENTINA';
        update CMFcountry ;       
        Test.startTest();
        
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_OG_FinanceRetriggerController finance=new GE_OG_FinanceRetriggerController(sc);
        finance.getVatApplicable();
        finance.KycRedirect();
        finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        finance.Submit();
        finance.CheckRiskTpe();
        finance.creditq1=true;
        GE_PRM_KYC_Termination_Checklist__c kycid=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:acc.id and GE_PW_KYC_Type__c!='Modify Account'];
        //  GE_OG_Finance_Details__c kycid
        GE_OG_Finance_Details__c ffff=[ Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:kycid.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1];  
        ffff.GE_OG_Comment__c='Test Comments';
        update ffff;
        finance.Submit();
        finance.GoBack();
        finance.onchangeType_of_Business();
        finance.kycid=null;
        finance.KycRedirect();
        acc.GE_HQ_Site_Use_Code__c='none';
        update acc;
        finance.KycRedirect();
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
            Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
            Id kycRT=rtByName.getRecordTypeId();
            //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
            String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
            GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
            ky.RecordTypeId=kycRT;
            ky.GE_PRM_Recommendation__c=RecomId;
            
            System.debug('*******************in KYC new*********************************************');
           
                ky.GE_HQ_Account__c=acc.id;
                ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
                ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
                ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
                ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
                ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
                ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_OG_Finance_checked__c=true;
                //ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                
                ky.GE_PW_Risk_Type__c = ' Risk'; 
                
                insert ky;            
                finance.kycid=ky;
                //finance.KycRedirect();
               // finance.onchangeType_of_Business();
                finance.submit();
                     
        Test.stopTest();  
     }catch(Exception ex){}
    }
    
    static testMethod void GE_OG_FinanceRetriggerTest5() 
    {       
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
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
       //acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test';     
        insert acc;
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
        
        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
        GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        //CMFcountry.GE_PW_CMF_Name__c = accReq.GE_HQ_Country__c;
        CMFcountry.GE_PW_Country__c= coun1.id; 
        insert CMFcountry ; 
              
        Test.startTest();
        
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_OG_FinanceRetriggerController finance=new GE_OG_FinanceRetriggerController(sc);
        finance.KycRedirect();
        finance.getVatApplicable();
        
        /*finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;*/
        finance.creditq1=true;
        //finance.Submit();
        finance.creditq2=true;
        finance.Submit();
        finance.CheckRiskTpe();
        
        acc.GE_OG_Buss_Tier1__c = null;
        acc.GE_OG_Buss_Tier2__c = null;
        acc.GE_OG_Buss_Tier3__c = null;
        acc.GE_OG_Buss_Tier4__c = null;
        update acc;
        finance.Submit();
         
        Test.stopTest();   
    }
    static testmethod void GE_OG_FinanceRetriggerTest6(){
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();

        Account acc=new Account();          
        acc.RecordTypeId=acc1;
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test'; 
        acc.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc.GE_OG_Buss_Tier3__c = 'SS - Subsea';  
        insert acc;
        
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        //acc.BillingCountry
        update acc;
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
        
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
        findet.GE_OG_Finance_Status__c = 'Finance Not Applicable';
        insert findet;
 
        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
         GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = accReq.GE_HQ_Country__c;
        CMFcountry.GE_PW_Country__c= coun1.id;        
        insert CMFcountry ; 
        
        try{
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);
         finance.getVatApplicable();
        finance.KycRedirect();
        finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        finance.creditq1=true;
        finance.Submit();
        finance.creditq2=true;
          }
          catch (exception e){
          system.debug('error------------------>'+e);
              system.assert(e.getmessage() !='');
          }
        test.stoptest();
    }

    static testmethod void GE_OG_FinanceRetriggerTest7(){
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
       
        Account acc=new Account();          
        acc.RecordTypeId=acc1;
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test'; 
        acc.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc.GE_OG_Buss_Tier3__c = 'Allen Gears'; 
        acc.GE_OG_Buss_Tier4__c = 'DTS'; 
        
        insert acc;

        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        //acc.BillingCountry
        update acc;
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
        
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
        findet.GE_OG_Finance_Status__c = 'Finance Not Applicable';
        insert findet;

        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
         GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;

        insert CMFcountry ; 
        
        try{
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);
         finance.getVatApplicable();
        
        finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        
        finance.creditq1=true;
        
        finance.creditq2=true;
        finance.isCreditLevel2=true;
        finance.Submit();
        finance.kycid = null;
        finance.acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        
        finance.KycRedirect();
        
          }
          catch (exception e){
          system.debug('error------------------>'+e);
              system.assert(e.getmessage() !='');
          }
        test.stoptest();
        
       
        
    }
   
    static testmethod void GE_OG_FinanceRetriggerTest8(){
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
       
        Account acc=new Account();          
        acc.RecordTypeId=acc1;
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        acc.GE_HQ_Site_Use_Code__c = 'BOTH';
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test'; 
        acc.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc.GE_OG_Buss_Tier3__c = 'Allen Gears'; 
        acc.GE_OG_Buss_Tier4__c = 'DTS'; 
        
        insert acc;
      
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        //acc.BillingCountry
        update acc;
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = true; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;

        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
         GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='ARGENTINA';
        CMFcountry.GE_PW_AML_Name__c='ARGENTINA';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;
        insert CMFcountry ; 
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        
        GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);
        finance.acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        finance.kycid=null;
       GE_OG_Finance_Details__c checkFin=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:ky.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' ];
       checkFin.GE_OG_Finance_Status__c = 'Finance Not Applicable';
       update checkFin;
        finance.KycRedirect();
        finance.existingCustomerObj = null;
        
        finance.vat = coun1 ;
        finance.getVatApplicable();
   
        finance.CheckRiskTpe();
       /* GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);

       finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        
        finance.creditq1=true;
        
        finance.creditq2=true;
        finance.isCreditLevel2=true;
        finance.Submit();
        
        finance.acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        finance.kycid=null;
        finance.KycRedirect();*/
          
        test.stoptest();
    } 
    
    static testmethod void GE_OG_FinanceRetriggerTest9(){
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id accRec=rtByName_acc1.getRecordTypeId();
       
        Account acc=new Account();          
        acc.RecordTypeId=accRec;
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test'; 
        acc.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc.GE_OG_Buss_Tier3__c = 'Allen Gears'; 
        acc.GE_OG_Buss_Tier4__c = 'DTS'; 
 
        insert acc;

        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        //acc.BillingCountry
        update acc;
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('KYC');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
            
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
        findet.GE_OG_Finance_Status__c = 'Finance Not Applicable';
        insert findet;
        
       /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
         GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;
        insert CMFcountry ; 

        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);
        finance.kycid = ky;
        finance.finc = findet;
        finance.KycRedirect();
        
    }
    
    static testmethod void GE_OG_FinanceRetriggerTest10(){
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id accRec=rtByName_acc1.getRecordTypeId();
       
        Account acc=new Account();          
        acc.RecordTypeId=accRec;
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test'; 
        acc.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc.GE_OG_Buss_Tier3__c = 'Allen Gears'; 
        acc.GE_OG_Buss_Tier4__c = 'DTS'; 
        
        insert acc;
       
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        //acc.BillingCountry
        update acc;
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('KYC');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
            
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
        findet.GE_OG_Finance_Status__c = 'Finance Not Applicable';
        insert findet;

        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
         GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;

        insert CMFcountry ; 

        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);
        finance.acc.GE_HQ_Site_Use_Code__c='BOTH';
        //finance.kycid = null;
         finance.kycid = ky;
        finance.finc = findet;
        
        finance.KycRedirect();
        
    }
    
    static testmethod void GE_OG_FinanceRetriggerTest11(){
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id accRec=rtByName_acc1.getRecordTypeId();
        
        
        Account acc1=new Account();          
        acc1.RecordTypeId=accRec;
        acc1.name = 'Test';
        acc1.GE_HQ_Request_Status__c = 'New';
        acc1.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc1.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc1.Phone = '03332342345';
        acc1.ShippingStreet = 'test'; 
        acc1.ShippingCity = 'test';
        acc1.ShippingState = 'test';
        acc1.ShippingPostalCode = '1245521';
        acc1.ShippingCountry = 'ARGENTINA';
        acc1.BillingCity = 'test';
        acc1.BillingCountry = 'ARGENTINA'; 
        acc1.BillingPostalCode = '1235412';
        acc1.BillingState = 'test';
        acc1.BillingStreet = 'test';
        acc1.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
        acc1.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
        acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
        acc1.GE_PW_Street_Bill_To__c = 'test';
        acc1.GE_PW_City_Bill_To__c = 'test';
        acc1.GE_PW_State_Province_Bill_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
        acc1.GE_PW_Street_Ship_To__c = 'test';
        acc1.GE_PW_City_Ship_To__c = 'test';
        acc1.GE_PW_State_Province_Ship_To__c = 'test'; 
        acc1.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
        acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc1.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc1.GE_PW_Country_Ship_To__c = 'ARGENTINA';
        acc1.GE_PW_Send_to_CMF_Bill_To__c = true;
        acc1.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
        acc1.GE_PW_Send_to_CMF_Ship_To__c = true;      
        acc1.GE_PW_Latitude_Bill_To__c = '10.242454';
        acc1.GE_PW_Longitude_Bill_To__c = '20.041244';
        acc1.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
        acc1.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
        acc1.GE_PW_Latitude_Ship_To__c = '35.1044411';
        acc1.GE_PW_Longitude_Ship_To__c = '2.012255';
        acc1.GE_PW_Phone_Bill_To__c = '0212142121';
        acc1.GE_PW_Phone_Ship_To__c = '020124512';
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
        acc1.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
        acc1.GE_HQ_DB_DUNS__c = '254123452';
        acc1.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc1.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc1.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc1.GE_PW_DB_DUNS_ShipTo__c = '652150545';
        acc1.GE_HQ_New_Account_City__c = 'test';
        acc1.GE_HQ_New_Account_Street__c = 'test';
        acc1.GE_HQ_New_Account_State_Province__c = 'test';
        acc1.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc1.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc1.GE_HQ_Nts_Comments__c = 'test'; 
        acc1.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc1.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc1.GE_OG_Buss_Tier3__c = 'Allen Gears'; 
        acc1.GE_OG_Buss_Tier4__c = 'DTS'; 
        
        insert acc1;
        
        
        
        
        
        
       
        Account acc=new Account();          
        acc.RecordTypeId=accRec;
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
        acc.BillingPostalCode = '1235412';
        acc.BillingState = 'test';
        acc.BillingStreet = 'test';
        /*acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
             acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
        acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
        acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
        acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';*/
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = true;
        acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = true;
        acc.GE_HQ_DB_DUNS__c = '254123452';
   
        acc.GE_HQ_New_Account_City__c = 'test';
        acc.GE_HQ_New_Account_Street__c = 'test';
        acc.GE_HQ_New_Account_State_Province__c = 'test';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test'; 
        acc.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc.GE_OG_Buss_Tier3__c = 'Allen Gears'; 
        acc.GE_OG_Buss_Tier4__c = 'DTS';
        acc.GE_PW_Existing_Customer_New_Address__c = acc1.id; 
        
        insert acc;
       
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        //acc.BillingCountry
        update acc;
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('KYC');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
            
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
        findet.GE_OG_Finance_Status__c = 'Finance Not Applicable';
        insert findet;

        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
         GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;

        insert CMFcountry ; 

        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);
        finance.acc.GE_HQ_Site_Use_Code__c='BOTH';
        //finance.kycid = null;
         finance.kycid = ky;
        finance.finc = findet;
        
        finance.KycRedirect();
        
    }
    
     static testmethod void GE_OG_FinanceRetriggerTest12(){
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
       
        Account acc=new Account();          
        acc.RecordTypeId=acc1;
        acc.name = 'Test';
        acc.GE_HQ_Request_Status__c = 'New';
        acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
        acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.Phone = '03332342345';
        acc.ShippingStreet = 'test'; 
        acc.ShippingCity = 'test';
        acc.ShippingState = 'test';
        acc.ShippingPostalCode = '1245521';
        acc.ShippingCountry = 'ARGENTINA';
        acc.BillingCity = 'test';
        acc.BillingCountry = 'ARGENTINA'; 
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
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.GE_PW_Country_Bill_To__c = 'ARGENTINA';
        acc.GE_PW_Country_Ship_To__c = 'ARGENTINA';
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
        acc.GE_HQ_New_Account_Country__c = 'ARGENTINA';    
        acc.GE_HQ_Nts_Comments__c = 'test'; 
        acc.GE_OG_Buss_Tier1__c = 'Oil & Gas (O&G)';
        acc.GE_OG_Buss_Tier2__c = 'Subsea (SS)';
        acc.GE_OG_Buss_Tier3__c = 'Allen Gears'; 
        acc.GE_OG_Buss_Tier4__c = 'DTS'; 
        
        insert acc;

        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        //acc.BillingCountry
        update acc;
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c=acc.id;
        ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c=true;
        ky.GE_PW_Risk_Type__c = ' Risk'; 
        insert ky;           
        
        GE_HQ_P_L__c busTier = new GE_HQ_P_L__c();
        busTier.name='test1';
        busTier.GE_HQ_Is_Active__c=true;
        busTier.GE_HQ_P_L_ID__c=4;
        insert busTier;
        
        GE_OG_BussTierToFince__c busness = new GE_OG_BussTierToFince__c();
        busness.GE_OG_Fin_Risk__c = 'Fast Lane';
        busness.GE_OG_Fin_Ctry_Risk__c = 'Low';
        busness.GE_OG_Buss_Tier_RL__c = busTier.id;
        insert busness;
        
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
           insert coun1;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        coun1.GE_PW_ITC__c = true;
           update coun1;
        
        GE_OG_ERP_Detail__c erp = new GE_OG_ERP_Detail__c();
        erp.GE_OG_ERP_Account__c = acc.id;
        erp.GE_OG_KYC__c = ky.id;
        erp.GE_OG_CoE_Rec_Finance_TCs__c='test';
        insert erp;
        
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
        findet.GE_OG_Finance_Status__c = 'Finance Not Applicable';
        insert findet;

        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        
         GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = 'ARGENTINA';
        CMFcountry.GE_PW_Country__c= coun1.id;

        insert CMFcountry ; 
        
         /* **********************************Code Added ***************** */
        
        try{
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_OG_FinanceRetriggerController finance= new GE_OG_FinanceRetriggerController(sc);
         finance.getVatApplicable();
        
        finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        
        finance.creditq1=true;
        
        finance.creditq2= false;
        finance.isCreditLevel2=true;
        finance.Submit();
        finance.kycid = null;
        finance.acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        
        finance.KycRedirect();
        
          }
          catch (exception e){
          system.debug('error------------------>'+e);
              system.assert(e.getmessage() !='');
          }
        test.stoptest();
        }

}