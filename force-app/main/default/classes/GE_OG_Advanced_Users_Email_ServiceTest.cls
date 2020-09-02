@isTest
public class GE_OG_Advanced_Users_Email_ServiceTest
{
   static testMethod void testEmailHandler()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
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
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc1.GE_OG_Buss_Tier2__c='Lufkin';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c='timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c='outboubdtime';
        erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c='inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c='outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
        
        insert erp;
        
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
       // email.subject = 'Sandbox: Advance User Input for:ERP-0000100';
        email.plainTextBody = '1. Quote/Sold To - ERP Customer#: Erp 2. Bill To - ERP Customer#:ERPBill 3. Ship To - ERP Customer#:ERPShip 4. ERP System Customer# is located:testLocated ';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
        erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
        update erp;
        
        
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
 
       }
       
 static testMethod void testEmailHandlerElse()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='D&S - DT';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc1.GE_OG_Buss_Tier2__c='Lufkin';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
       // kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c='timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c='outboubdtime';
        erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c='inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c='outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
        erp.recordtypeid=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle-Tier4').getRecordTypeId(); 
        
        insert erp;
        
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'D&S - DT';
        insert advanceUser ;
         GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        //email.subject = 'Sandbox: Advance User Input for:ERP-0000100';
        email.plainTextBody = '1. Quote/Sold To - ERP Customer#: Erp'+ 
        '2. Bill To - ERP Customer#:ERPBill'+ 
        '3. Ship To - ERP Customer#:ERPShip'+
        '4. ERP System Customer# is located:testLocated';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=: erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
        erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
        update erp;
        
        
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
 
       }
       
       static testMethod void testEmailHandler1()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
         insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '1. Accept terms from COE?(Yes/No): 1. Quote/Sold To - ERP Customer#: Erp 2. Quote/Sold To - ERP Customer# T&Cs: 3. Bill To - ERP Customer# T&Cs: 4. Ship To - ERP Customer# T&Cs:';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }
       
       
 static testMethod void testEmailHandler6()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
         insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '1. Accept terms from COE?(Yes/No): 1. Bill To - ERP Customer#:';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }
       
       static testMethod void testEmailHandler7()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
         insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '1. Accept terms from COE?(Yes/No): 1. Ship To - ERP Customer#:';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }
       
       static testMethod void testEmailHandler8()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
       insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '1. Accept terms from COE?(Yes/No): 1. ERP System Customer# is located:';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }
       
       static testMethod void testEmailHandler9()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
         insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '1. Accept terms from COE?(Yes/No): 1. Accept terms from COE?:';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }
      static testMethod void testEmailHandler10()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
        Id ERecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Downhole Technology').getRecordTypeId();
        erp.recordtypeid = ERecordTypeId;
         insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,recordtype.name,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        system.debug('vvvvvvvvvv'+erp1.recordtype.name);
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '1. Quote/Sold To - ERP Customer#: uuuu';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
         // erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }  
       static testMethod void testEmailHandler11()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
        Id ERecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Downhole Technology').getRecordTypeId();
        erp.recordtypeid = ERecordTypeId;
         insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '1. Quote/Sold To - ERP Customer#:ge_og';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          //erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }
       
       static testMethod void testEmailHandler12()
 {
 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
       
        Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='CAT123459';
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        //Acc.GE_OG_Buss_Tier2__c='Lufkin';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='Oilfield';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc;
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc';
        Acc1.GE_HQ_DUNS_Number__c='CAT123450';
        Acc1.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
       // Acc1.GE_OG_Buss_Tier2__c='Lufkin';
       Acc1.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc1.GE_OG_Buss_Tier3__c='Oilfield';
        Acc1.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc1.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc1.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc1.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc1.GE_PW_City_Bill_To__c='United States';
        Acc1.GE_PW_State_Province_Bill_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Bill_To__c='zip';
        Acc1.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc1.GE_PW_City_Ship_To__c='city';
        Acc1.GE_PW_State_Province_Ship_To__c='state';
        Acc1.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc1.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        insert Acc1;
        // check 
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // recom.RecordTypeId=recom1;
       
       //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001CX4N';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        String countryname = Acc.GE_HQ_New_Account_Country__c;
       // GE_HQ_Country__c coun=[Select name,id from GE_HQ_Country__c where Name =:countryname];
        GE_HQ_Country__c Coun = new GE_HQ_Country__c();
        coun.GE_HQ_ISO_Code__c='12';
        coun.GE_OG_Finance_Country_Risk__c='LOW';
        coun.GE_PW_VATApplicabl__c=TRUE;
        coun.GE_PW_VAT_Format__c='Test';
        insert coun;
        
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        fin.GE_OG_KYC__c=kyc.id;
        fin.GE_OG_Account__c = Acc.Id; 
        fin.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fin.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
        insert fin; 
      
        
        GE_OG_ERP_Detail__c erp= new GE_OG_ERP_Detail__c();
        erp.GE_OG_KYC__c=kyc.id;
        erp.GE_OG_Advance_User__c='ADVANCE';
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        
        erp.GE_OG_ERP_Sales_Person_ID__c='mysalesperson';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='firstname';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='lastname';
        erp.GE_OG_ERP_Sales_Person_Email__c='ramesh@email.com';
        erp.GE_OG_ERP_CSR_First_Name__c='csrfirstname';
        erp.GE_OG_ERP_CSR_Last_Name__c='csrlastname';
        erp.GE_OG_ERP_CSR_Email__c='csrramesh@email.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        //erp.GE_OG_ERP_Quote_To_SAP__c='quotetosap';
        erp.GE_OG_ERP_Quote_To_SAP__c='';
        erp.GE_OG_ERP_Bill_To_SAP__c='erpbillto';
        erp.GE_OG_ERP_Ship_To_SAP__c='erpshipto';
        erp.GE_OG_ERP_Inbound_Timestamp__c=''+DateTime.now();//'timetext';
        erp.GE_OG_ERP_Outbound_Timestamp__c=''+DateTime.now();//'outboubdtime';
       // erp.GE_OG_ERP_Cycle_Time__c=1234;
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='erpquote';
        erp.GE_OG_ERP_Bill_To_SAP_TC__c='erpbilltosap';
        erp.GE_OG_ERP_Ship_To_SAP_TC__c='erpshiptp';
        erp.GE_OG_Fin_Inbound_Time__c=''+DateTime.now();//'inboundtime';
        erp.GE_OG_Fin_Outbound_Time__c=''+DateTime.now();//'outboundtime';
        erp.GE_OG_ERP_Accept_terms_from_COE__c='Yes';
        //erp.GE_OG_Finance_Cycle_Time__c=1234;
        erp.GE_OG_ERP_System_Customer__c ='test Customer';
        Id ERecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Downhole Technology').getRecordTypeId();
        erp.recordtypeid = ERecordTypeId;
         insert erp;
        system.debug('@@@@@@@@@@@@'+erp);
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Finance Sandbox: Advance User Input for:ERP-0000100';
        GE_OG_ERP_Detail__c  erp1= [select id,name from GE_OG_ERP_Detail__c  where id= :erp.id];
        email.subject = 'Finance Sandbox: Advance User Input for:'+erp1.name;//0000100';
        email.plainTextBody = '2. Bill To - ERP Customer#:';
        env.fromAddress = 'test@acme.com';
        email.fromAddress = env.fromAddress;
        String erpNum='ERP'+(email.subject).substringAfter('ERP');
       // String erpNum = erp.Name;
       // GE_OG_ERP_Detail__c erp1 =[Select id ,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_ERP_System_Customer__c from  GE_OG_ERP_Detail__c name=:erpNum limit 1];
       //GE_OG_ERP_Detail__c erp1=[select id,name,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];        
        erp.GE_OG_ERP_Quote_To_SAP_TC__c='QuoteTOSap';
         erp.GE_OG_ERP_Bill_To_SAP_TC__c='QuoteTOBill';
          erp.GE_OG_ERP_Ship_To_SAP_TC__c='ShipToSap';
          erp.GE_OG_ERP_System_Customer__c ='SysCustmera';
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          //erp.recordtypeid=ERPOraRecordTypeId;
         // erp.name=erpNum;
        update erp;
        system.debug('@@@@@@@@@@@@'+erpNum);
        system.debug('@@@@@@@@@@@@'+erp.name);
        
     GE_OG_Advanced_Users_Email_Service  advance= new  GE_OG_Advanced_Users_Email_Service ();
     advance.handleInboundEmail(email,env);
     
     //kyc.Bill_To_Additional_Account__c=null;
     //update kyc;
      //email.plainTextBody = 'Bill To - ERP Customer#: Ship To - ERP Customer#: ERP System Customer# is located: Accept terms from COE?:';
      //advance.handleInboundEmail(email,env);
 
       }
}