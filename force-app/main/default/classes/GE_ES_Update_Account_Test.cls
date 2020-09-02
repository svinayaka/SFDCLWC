@isTest
public class GE_ES_Update_Account_Test{
  static testmethod Void Update_AccountTest1(){
    Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id accRec=rtByName_acc1.getRecordTypeId();
       
        Account acc = new Account();          
        acc.RecordTypeId = accRec;
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

        acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'ARGENTINA';
        acc.ShippingCountry = 'brazil';
        acc.GE_PW_Country_Bill_To__c='ARGENTINA';
        acc.GE_PW_Country_Ship_To__c ='ARGENTINA';
        acc.GE_HQ_Site_Use_Code__c='none';
        acc.BillingCountry='ARGENTINA';
        update acc;
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName = rtMapByName.get('KYC');
        Id kycRT=rtByName.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  
        GE_PRM_KYC_Termination_Checklist__c ky = new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId = kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        ky.GE_HQ_Account__c = acc.id; 
        ky.GE_HQ_VAT_Tax_ID__c = 'TESTTAX789';
        ky.GE_HQ_Sold_To_Street__c = String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Sold_To_State__c = String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c = String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Sold_To_Country__c = String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Sold_To_City__c = String.valueof(acc.ShippingCity);
        ky.GE_HQ_Bill_To_Street__c = String.valueof(acc.BillingStreet);
        ky.GE_HQ_Bill_To_State__c = String.valueof(acc.BillingState);
        ky.GE_HQ_Bill_To_Zip__c = String.valueof(acc.BillingPostalCode);
        ky.GE_HQ_Bill_To_Country__c = String.valueof(acc.BillingCountry);
        ky.GE_HQ_Bill_To_City__c = String.valueof(acc.BillingCity);
        ky.GE_HQ_Ship_To_Street__c = String.valueof(acc.ShippingStreet);
        ky.GE_HQ_Ship_To_State__c = String.valueof(acc.ShippingState);
        ky.GE_HQ_Ship_To_Zip__c = String.valueof(acc.ShippingPostalCode);
        ky.GE_HQ_Ship_To_Country__c = String.valueof(acc.ShippingCountry);
        ky.GE_HQ_Ship_To_City__c = String.valueof(acc.ShippingCity);
        ky.GE_OG_Finance_checked__c = true;
        ky.GE_PW_Risk_Type__c = 'Risk'; 
        insert ky;      
        
        //test.starttest();
        ky.GE_HQ_VAT_Tax_ID__c = 'TESTUpdateTAX789';
        update ky;
        //test.stoptest();


  }

}