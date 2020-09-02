@isTest

public class GE_OG_Update_FinanceUpdateStatusTest{
    static testMethod void StatusTest1(){
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account acc= new Account();
        Acc.Name='Test Acc1';  
        Acc.GE_HQ_Request_Status__c='New';
        Acc.GE_HQ_KYC_Complete__c=true;
        Acc.GE_PRM_KYC_Completed__c=true;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        acc.Type = 'EPC';
        acc.Classification__c = 'Strategic';
        insert acc;
        
        
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
        insert findet;
        
        acc.GE_HQ_Request_Status__c='CMF Approved';
        update acc;
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        //ky.GE_HQ_Account__c=accReq.id;
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

        // Koshay update:  doing an update on Account to run through update scenario in trigger
        test.startTest();
        acc.phone='555-555-5555';
        update acc;
        
        test.stopTest();
        // end edit        
        
    }
    
     static testMethod void StatusTest2(){
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account acc= new Account();
        Acc.Name='Test Acc1';  
       Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=true;
        Acc.GE_PRM_KYC_Completed__c=true;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        acc.Type = 'EPC';
        acc.Classification__c = 'Strategic';
        insert acc;

        
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Resubmitted__c = false;
        findet.GE_OG_Finance_Status__c = 'In Progress';
        findet.GE_OG_Comment__c='nrnrn test test test';
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c='salestest';
        findet.GE_OG_Approx_of_Employees__c='approxemp';
        findet.GE_OG_Pre_Yr_Sales__c='yearsaltest';
        findet.GE_OG_Approx_yrs_in_Business__c='bussinyrstest';
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;       
                
        acc.GE_HQ_Request_Status__c='New';
        update acc;
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        //ky.GE_HQ_Account__c=accReq.id;
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

        // Koshay update:  doing an update on Account to run through update scenario in trigger
        test.startTest();
        acc.phone='555-555-5555';
        update acc;
        
        test.stopTest();
        // end edit 
        
    }
    
     static testMethod void StatusTest3(){
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account acc= new Account();
        Acc.Name='Test Acc1';  
        Acc.GE_HQ_Request_Status__c='New';
        Acc.GE_HQ_KYC_Complete__c=true;
        Acc.GE_PRM_KYC_Completed__c=true;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        acc.Type = 'EPC';
        acc.Classification__c = 'Strategic';
        insert acc;
           
        GE_OG_Finance_Details__c findet = new GE_OG_Finance_Details__c();
        findet.GE_OG_Actual__c='actualtest';
        findet.GE_OG_Cust_accepted__c=true;
        findet.GE_OG_Resubmitted__c = false;
        findet.GE_OG_Comment__c='nrnrn test test test';
        findet.GE_OG_Credit_Line_Request__c='test new test new';
        findet.GE_OG_Currnt_Yr_Sales__c='salestest';
        findet.GE_OG_Approx_of_Employees__c='approxemp';
        findet.GE_OG_Pre_Yr_Sales__c='yearsaltest';
        findet.GE_OG_Approx_yrs_in_Business__c='bussinyrstest';
        findet.GE_OG_level1_met__c='yes';
        findet.GE_OG_Fast_Lane_Criteria__c=true;
        findet.GE_OG_Account__c=acc.id;
        insert findet;
        
        acc.GE_HQ_Request_Status__c='Pending CMF';
        update acc;
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
        Id kycRT=rtByName.getRecordTypeId();
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        //ky.GE_HQ_Account__c=accReq.id;
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

        // Koshay update:  doing an update on Account to run through update scenario in trigger
        test.startTest();
        acc.phone='555-555-5555';
        update acc;
        
        test.stopTest();
        // end edit 
    }
    
}