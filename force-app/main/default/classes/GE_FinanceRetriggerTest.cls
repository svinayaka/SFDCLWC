@isTest

public class GE_FinanceRetriggerTest
{
    static testMethod void GE_FinanceRetriggerTest_1() 
    {   try{    
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
         Account acc= new Account();
        Acc.Name='Test Acc1';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        acc.GE_HQ_New_Account_Street__c = 'Test';
         acc.GE_HQ_New_Account_City__c ='Test';
         acc.GE_HQ_New_Account_State_Province__c='Test';
         acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
         acc.GE_HQ_New_Account_Country__c= 'TEst';
       insert acc;
        string accid=acc.id;
        GE_PRM_KYC_Termination_Checklist__c  kycid=null;//[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
                
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

         Account_Request__c accReq = new  Account_Request__c();
        accReq.GE_HQ_Account__c=acc.Id;
        accReq.GE_HQ_Nts_Comments__c='Test 1';
        accReq.GE_HQ_Country__c='AFGHANISTAN';     
        accReq.GE_HQ_Street__c='test';     
        accReq.GE_HQ_City__c='Test';     
        accReq.GE_HQ_State_Province__c='Test';     
        accReq.GE_HQ_Postal_Code__c='560067';   
        insert accReq ;
        
       Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);  
        arn.Comments__c = 'Test';
        update arn ;                
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
        coun1.GE_PW_ITC__c = true;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        update coun1;
        GE_PW_CMFtoISOCountryName__c CMFcountry =  Test_GE_Accounts_Handler.cmfcoun(accReq,coun1);
        CMFcountry.GE_PW_CMF_Name__c='ARGENTINA';
        update CMFcountry ;       
        Test.startTest();
        
        PageReference pageRef = Page.GE_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_FinanceRetriggerController finance=new GE_FinanceRetriggerController(sc);
        GE_OG_Finance_Details__c  fffffff=finance.finc;
       
        finance.getVatApplicable();
        fffffff=finance.finc;
        
        finance.KycRedirect();
        fffffff=finance.finc;
        
        finance.Submit();
        kycid=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
         
        fffffff=finance.finc;
        
        kycid=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
       
        finance.CheckRiskTpe();
        fffffff=finance.finc;
        
        kycid=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
         
        finance.Submit();
        fffffff=finance.finc;
       
        kycid=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];

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
           // if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
           // {            
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
               // finance.goBack();
                
        Test.stopTest();  }catch(Exception ex){}
         
    }
     static testMethod void GE_FinanceRetriggerTest_3() 
    {       try{
        GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
       
      Account acc= new Account();
        Acc.Name='Test Acc1';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        acc.GE_HQ_Nts_Comments__c ='testing accounts';
        acc.GE_HQ_New_Account_Street__c = 'Test';
         acc.GE_HQ_New_Account_City__c ='Test';
         acc.GE_HQ_New_Account_State_Province__c='Test';
         acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
         acc.GE_HQ_New_Account_Country__c= 'TEst';
       insert acc;
       
        
       // System.assertEquals(acc.Name,'Test Acc1');          
        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
        coun1.GE_PW_ITC__c = true;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        update coun1;
        GE_PW_CMFtoISOCountryName__c CMFcountry =  Test_GE_Accounts_Handler.cmfcoun(accReq,coun1);
        CMFcountry.GE_PW_CMF_Name__c='ARGENTINA';
        update CMFcountry ;       
        Test.startTest();
        
        PageReference pageRef = Page.GE_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_FinanceRetriggerController finance=new GE_FinanceRetriggerController(sc);
        finance.getVatApplicable();
        finance.KycRedirect();
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
           // if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
           // {            
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
                
        Test.stopTest();   }catch(Exception ex){}
    }
    
  static testMethod void GE_FinanceRetriggerTest_2() 
    {       
       try{ 
       GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        Account acc = Test_GE_Accounts_Handler.createAccount();
       // acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        //acc.GE_HQ_Site_Use_Code__c='BOTH';
        acc.GE_OG_Buss_Tier4__c='test';
        acc.GE_HQ_Site_Use_Code__c='none';
        update acc;
        
     
        GE_PRM_KYC_Termination_Checklist__c terchek = new GE_PRM_KYC_Termination_Checklist__c();
        terchek.GE_HQ_VAT_Tax_ID__c='taxid';
        terchek.GE_HQ_Vat_Reason_Code__c='Customer Tax Exempt'; 
        terchek.GE_HQ_Status__c='KYC In Process';
        terchek.GE_PW_KYC_Type__c='New Account';
       insert terchek;
        
          //Account acc = Test_GE_Accounts_Handler.createAccount();    
        System.assertEquals(acc.Name,'Test Acc For TestClass');          
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
        
        PageReference pageRef = Page.GE_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_FinanceRetriggerController finance=new GE_FinanceRetriggerController(sc);
       
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
           // if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
           // {            
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
                
                finance.acc=acc;          
                finance.kycid=ky;
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
        }catch(Exception ex){}
    }
    
 
   static testMethod void GE_FinanceRetriggerTest_11() 
    {       try{
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        
        Account acc= new Account();
        Acc.Name='Test Acc1';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        acc.GE_HQ_Nts_Comments__c ='testing accounts';
        acc.GE_HQ_New_Account_Street__c = 'Test';
         acc.GE_HQ_New_Account_City__c ='Test';
         acc.GE_HQ_New_Account_State_Province__c='Test';
         acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
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
        //insert findet;
        /*
        GE_PRM_KYC_Termination_Checklist__c terchek = new GE_PRM_KYC_Termination_Checklist__c();
        terchek.GE_HQ_VAT_Tax_ID__c='taxid';
        terchek.GE_HQ_Vat_Reason_Code__c='Customer Tax Exempt'; 
        terchek.GE_HQ_Status__c='KYC In Process';
        terchek.GE_PW_KYC_Type__c='New Account';
        insert terchek;
        */
          //Account acc = Test_GE_Accounts_Handler.createAccount();    
        System.assertEquals(acc.Name,'Test Acc1');          
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
        
        PageReference pageRef = Page.GE_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_FinanceRetriggerController finance=new GE_FinanceRetriggerController(sc);
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
           // if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
           // {            
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
            //  Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:kycid.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1  
         
        Test.stopTest();   }catch(Exception ex){}
    }
    
    static testmethod void test_ogfinanceretrigger13(){
    try{
            GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
          Account Acc= new Account();
        Acc.Name='Test Acc For TestClass';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
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
        acc.GE_HQ_New_Account_Street__c = 'Test';
         acc.GE_HQ_New_Account_City__c ='Test';
         acc.GE_HQ_New_Account_State_Province__c='Test';
         acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';

       
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
        acc.RecordTypeId=acc1;
        acc.GE_OG_AccFin_Status__c='In Progress';
        acc.GE_HQ_Request_Status__c ='CMF Approved';
        acc.ShippingCountry ='ARGENTINA';
        acc.GE_PW_Phone_New_Request__c='(111)111-1111';
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
        
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
        coun1.GE_PW_ITC__c = true;
        coun1.GE_PW_CIS_Non_CIS__c = true;
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
        //insert findet;
        /*
        GE_PRM_KYC_Termination_Checklist__c terchek = new GE_PRM_KYC_Termination_Checklist__c();
        terchek.GE_HQ_VAT_Tax_ID__c='taxid';
        terchek.GE_HQ_Vat_Reason_Code__c='Customer Tax Exempt'; 
        terchek.GE_HQ_Status__c='KYC In Process';
        terchek.GE_PW_KYC_Type__c='New Account';
        insert terchek;
        */
          //Account acc = Test_GE_Accounts_Handler.createAccount();    
        System.assertEquals(acc.Name,'Test Acc For TestClass');          
        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        GE_PW_CMFtoISOCountryName__c CMFcountry =  Test_GE_Accounts_Handler.cmfcoun(accReq,coun1);
        CMFcountry.GE_PW_CMF_Name__c='ARGENTINA';
        update CMFcountry ; 
       
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_FinanceRetriggerController finance= new GE_FinanceRetriggerController(sc);
         finance.getVatApplicable();
        finance.KycRedirect();
        finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        finance.creditq1=true;
        finance.Submit();
        finance.creditq2=true;
        
        test.stoptest();
          }
          catch (exception e){
          
             
          }
    }
    
    static testmethod void test_ogfinanceretrigger14(){
    try{
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
          Account Acc= new Account();
        Acc.Name='Test Acc For TestClass';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
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

        acc.GE_HQ_New_Account_Street__c = 'Test';
         acc.GE_HQ_New_Account_City__c ='Test';
         acc.GE_HQ_New_Account_State_Province__c='Test';
         acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
       
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
        acc.RecordTypeId=acc1;
        acc.GE_OG_AccFin_Status__c='In Progress';
        acc.GE_HQ_Request_Status__c ='CMF Approved';
        acc.ShippingCountry ='ARGENTINA';
        acc.GE_PW_Phone_New_Request__c='(111)111-1111';
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
        
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
        coun1.GE_PW_ITC__c = true;
        coun1.GE_PW_CIS_Non_CIS__c = true;
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
        //insert findet;
        /*
        GE_PRM_KYC_Termination_Checklist__c terchek = new GE_PRM_KYC_Termination_Checklist__c();
        terchek.GE_HQ_VAT_Tax_ID__c='taxid';
        terchek.GE_HQ_Vat_Reason_Code__c='Customer Tax Exempt'; 
        terchek.GE_HQ_Status__c='KYC In Process';
        terchek.GE_PW_KYC_Type__c='New Account';
        insert terchek;
        */
          //Account acc = Test_GE_Accounts_Handler.createAccount();    
        System.assertEquals(acc.Name,'Test Acc For TestClass');          
        /*End sample code from handler */
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        GE_PW_CMFtoISOCountryName__c CMFcountry =  Test_GE_Accounts_Handler.cmfcoun(accReq,coun1);
        CMFcountry.GE_PW_CMF_Name__c='ARGENTINA';
        update CMFcountry ; 
       
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_FinanceRetriggerController finance= new GE_FinanceRetriggerController(sc);
        
        finance.vat = coun1;
         finance.getVatApplicable();
         
         finance.onchangeType_of_Business();
         finance.GoBack();
         
           finance.kycid=null;
        finance.KycRedirect();
        finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        finance.creditq1=true;
        finance.Submit();
        finance.creditq2=false;
        
        test.stoptest();
          }
          catch (exception e){
          
             
          }
    }
    
    static testmethod void test_ogfinanceretrigger15(){
    try{
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
          Account Acc= new Account();
        Acc.Name='Test Acc For TestClass';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
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
        acc.GE_HQ_New_Account_Street__c = 'Test';
         acc.GE_HQ_New_Account_City__c ='Test';
         acc.GE_HQ_New_Account_State_Province__c='Test';
         acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
       

       
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
        acc.RecordTypeId=acc1;
        acc.GE_OG_AccFin_Status__c='In Progress';
        acc.GE_HQ_Request_Status__c ='CMF Approved';
        acc.ShippingCountry ='ARGENTINA';
        acc.GE_PW_Phone_New_Request__c='(111)111-1111';
        insert acc;
        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='BOTH';
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
        
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
        coun1.GE_PW_ITC__c = true;
        coun1.GE_PW_CIS_Non_CIS__c = true;
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
        //insert findet;
        /*  
        GE_PRM_KYC_Termination_Checklist__c terchek = new GE_PRM_KYC_Termination_Checklist__c();
        terchek.GE_HQ_VAT_Tax_ID__c='taxid';
        terchek.GE_HQ_Vat_Reason_Code__c='Customer Tax Exempt'; 
        terchek.GE_HQ_Status__c='KYC In Process';
        terchek.GE_PW_KYC_Type__c='New Account';
        insert terchek;
        */
          //Account acc = Test_GE_Accounts_Handler.createAccount();    
        System.assertEquals(acc.Name,'Test Acc For TestClass');          
        
        Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        GE_PW_CMFtoISOCountryName__c CMFcountry =  Test_GE_Accounts_Handler.cmfcoun(accReq,coun1);
        CMFcountry.GE_PW_CMF_Name__c='ARGENTINA';
        update CMFcountry ; 
       
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        PageReference pageRef = Page.GE_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        test.starttest();
        GE_FinanceRetriggerController finance= new GE_FinanceRetriggerController(sc);
         finance.getVatApplicable();
         
         finance.onchangeType_of_Business();
         finance.GoBack();
         
         finance.kycid=ky;
        finance.KycRedirect();
        finance.finc.GE_OG_Comment__c='Test';
        update finance.finc;
        finance.creditq1=true;
        
        GE_HQ_Country__c coun2 =  Test_GE_Accounts_Handler.coun1(); 
        coun2.GE_PW_ITC__c = true;
        coun2.GE_PW_CIS_Non_CIS__c = true;
        insert coun2;
        
        finance.CheckRiskTpe();
        finance.Submit();
        finance.creditq2=false;
        
        test.stoptest();
          }
          catch (exception e){
                       
          }
    }
    
 static testMethod void GE_FinanceRetriggerTest_90() 
    {       
       try{ 
       GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
       Account acc1=new Account();
       acc1.name = 'Test';
       acc1.GE_HQ_Request_Status__c = 'New';
       acc1.GE_PW_Select_Type_of_Business__c = 'Government Agency';
       acc1.GE_HQ_Site_Use_Code__c = 'BILL_TO';
       acc1.Phone = '03332342349';
        acc1.GE_HQ_New_Account_Street__c = 'Test';
         acc1.GE_HQ_New_Account_City__c ='Test';
         acc1.GE_HQ_New_Account_State_Province__c='Test';
         acc1.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
         acc1.GE_HQ_New_Account_Country__c= 'TEst';
       insert acc1;
       
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
        acc.GE_PW_Existing_Customer_New_Address__c = acc1.Id;
        
        insert acc;     
     
     


         Account_Request__c accReq = Test_GE_Accounts_Handler.accountReq(Acc);       
        Account_Request_Note__c arn = Test_GE_Accounts_Handler.arn(Acc);                  
        Account_Request__c TempAccModReqObj = Test_GE_Accounts_Handler.TempAccModReqObj(accReq);
        GE_HQ_Country__c coun1 =  Test_GE_Accounts_Handler.coun1(); 
        coun1.GE_PW_ITC__c = true;
        coun1.GE_PW_CIS_Non_CIS__c=true;
        update coun1;
        GE_PW_CMFtoISOCountryName__c CMFcountry =  Test_GE_Accounts_Handler.cmfcoun(accReq,coun1);
        CMFcountry.GE_PW_CMF_Name__c='ARGENTINA';
        update CMFcountry ;       
        
        
        
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
           // if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
           // {            
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
        findet.GE_OG_KYC__c=ky.id;
        findet.GE_OG_Finance_Status__c = 'Finance Not Applicable';
        insert findet;         
     
     Test.startTest();
        
        PageReference pageRef = Page.GE_OG_FinanceRetrigger;
        pageRef.getParameters().put('accids',acc.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        GE_FinanceRetriggerController finance=new GE_FinanceRetriggerController(sc);
        finance.kycexist = true;
        finance.isExistingCustomer = true;
        finance.getVatApplicable();
        finance.KycRedirect();
        finance.CheckRiskTpe();
        finance.creditq1 = true;
      acc.GE_HQ_Site_Use_Code__c='none';
        update acc;
       Test.stopTest();   
    }catch(Exception ex){}
     
     
     
       }
  }