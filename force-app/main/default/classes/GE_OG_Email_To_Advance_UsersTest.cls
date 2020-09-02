@istest
public class GE_OG_Email_To_Advance_UsersTest
{
  static testMethod void validateSendEmails() 
   {

EmailServicesAddress eAdd=[select EmailDomainName,LocalPart from EmailServicesAddress limit 1];
 Messaging.InboundEmail email = new Messaging.InboundEmail();


Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='Test12459';
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
        Acc1.GE_HQ_DUNS_Number__c='CAT12499';
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
 
        /*GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.name=erp.name;
        kyc.GE_HQ_Account__c=Acc.id;
       // kyc.GE_HQ_Comp_Leg_En_Nm__c='GGGGGGG';
        //kyc.GE_HQ_VAT_Tax_ID__c='vattaxid';
        kyc.id=Acc.id;
        insert kyc; */
        
         String billName,billStreet,billCity,billState,billPostalCode,billCountry,billPhone;
         String shipName,shipStreet,shipCity,shipState,shipPostalcode,shipCountry,shipPhone;
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001J5qI';
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
        
        // For Code Coverage Few lines added
        
        if(kyc.Ship_To_Additional_Account__c!=null && kyc.Bill_To_Additional_Account__c!=null){
              //acc_Bill=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Bill_To_Additional_Account__c limit 1];
             
              billName='GE OIL & GAS';
              billStreet='Bill Street ';
              billCity='NJ';
              billState='NJ';
              billPostalCode='Postal Code';
              billCountry='USA';
              billPhone='954824';
              
             // acc_Ship=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Ship_To_Additional_Account__c limit 1];
              
              
              shipName='';
              shipStreet='';
              shipCity='';
              shipState='';
              shipPostalCode='';
              shipCountry='';
              shipPhone='';
              
          }else if(kyc.Ship_To_Additional_Account__c!=null){
             // acc_Ship=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Ship_To_Additional_Account__c limit 1];
              
              shipName='';
              shipStreet='';
              shipCity='';
              shipState='';
              shipPostalCode='';
              shipCountry='';
              shipPhone='';
              
          }else if(kyc.Bill_To_Additional_Account__c!=null){
          
             // acc_Bill=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Bill_To_Additional_Account__c limit 1];
            
              billName='GE OIL & GAS';
              billStreet='Bill Street ';
              billCity='NJ';
              billState='NJ';
              billPostalCode='Postal Code';
              billCountry='USA';
              billPhone='954824';
          }
      
        
        
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
        
        GE_OG_ERP_Detail__c erp= new  GE_OG_ERP_Detail__c();

        erp.GE_OG_KYC__c = kyc.id;
        erp.GE_OG_Advance_User__c='sder@gsr.com';
        erp.GE_OG_ERP_Cycle_Time__c=20;
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='raju';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='malla';
        erp.GE_OG_ERP_Sales_Person_Email__c='abc@gmail.com';
        erp.GE_OG_ERP_CSR_First_Name__c='ssrr';
        erp.GE_OG_ERP_CSR_Last_Name__c='hsg';
        erp.GE_OG_ERP_CSR_Email__c='sder@gsr.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        insert erp;
        
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Sandbox: Advance User Input for:ERP-0001899';
      //  email.plainTextBody = '1. Quote/Sold To - ERP Customer#: Erp 2. Bill To - ERP Customer#:ERPBill 3. Ship To - ERP Customer#:ERPShip 4. ERP System Customer# is located:testLocated ';
       // env.fromAddress = 'test@acme.com';
       // email.fromAddress = env.fromAddress;
       // String erpNum='ERP'+(email.subject).substringAfter('ERP');



PageReference pageRef = new PageReference('/apex/GE_OG_ERP_Detail__c?Id='+erp.id);   

system.test.setCurrentPageReference(pageRef);       

ApexPages.StandardController controler =  new ApexPages.StandardController(erp);    
GE_OG_Email_To_Advance_Users et = new GE_OG_Email_To_Advance_Users(controler);
pagereference pf = et.sendEmails();
      
 }
      
 static testMethod void validateSendEmailsElse() 
   {

   //EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress limit 1];
   EmailServicesAddress eAdd=new EmailServicesAddress();
   //eAdd.EmailDomainName='';
   eAdd.LocalPart='test_LocalPart';
   eAdd.IsActive=true;
   
   Messaging.InboundEmail email = new Messaging.InboundEmail();


   Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='Test12845';
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
        Acc1.GE_HQ_DUNS_Number__c='Test00021';
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
        
        /*GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.name=erp.name;
        kyc.GE_HQ_Account__c=Acc.id;
       // kyc.GE_HQ_Comp_Leg_En_Nm__c='GGGGGGG';
        //kyc.GE_HQ_VAT_Tax_ID__c='vattaxid';
        kyc.id=Acc.id;
        insert kyc; */
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
       // GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        
        kyc.GE_PRM_Recommendation__c = 'a1WA0000001J5qI';
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        kyc.GE_HQ_Account__c=Acc.id;
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
        
        GE_OG_ERP_Detail__c erp= new  GE_OG_ERP_Detail__c();

        erp.GE_OG_KYC__c = kyc.id;
        erp.GE_OG_Advance_User__c='sder@gsr.com';
        erp.GE_OG_ERP_Cycle_Time__c=20;
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='raju';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='malla';
        erp.GE_OG_ERP_Sales_Person_Email__c='abc@gmail.com';
        erp.GE_OG_ERP_CSR_First_Name__c='ssrr';
        erp.GE_OG_ERP_CSR_Last_Name__c='hsg';
        erp.GE_OG_ERP_CSR_Email__c='sder@gsr.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
        insert erp;
        
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Sandbox: Advance User Input for:ERP-0001899';
      //  email.plainTextBody = '1. Quote/Sold To - ERP Customer#: Erp 2. Bill To - ERP Customer#:ERPBill 3. Ship To - ERP Customer#:ERPShip 4. ERP System Customer# is located:testLocated ';
       // env.fromAddress = 'test@acme.com';
       // email.fromAddress = env.fromAddress;
       // String erpNum='ERP'+(email.subject).substringAfter('ERP');



PageReference pageRef = new PageReference('/apex/GE_OG_ERP_Detail__c?Id='+erp.id);   

system.test.setCurrentPageReference(pageRef);       

ApexPages.StandardController controler =  new ApexPages.StandardController(erp);    
GE_OG_Email_To_Advance_Users et = new GE_OG_Email_To_Advance_Users(controler);
pagereference pf = et.sendEmails();
      }
      
      
      
      static testMethod void validateSendEmails1() 
   {

EmailServicesAddress eAdd=[select EmailDomainName,LocalPart from EmailServicesAddress limit 1];
 Messaging.InboundEmail email = new Messaging.InboundEmail();


Account Acc= new Account();
        Acc.Name='Test Acc';
        Acc.GE_HQ_DUNS_Number__c='Test12459';
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
        Acc1.GE_HQ_DUNS_Number__c='CAT12499';
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
  
        /*GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
        kyc.name=erp.name;
        kyc.GE_HQ_Account__c=Acc.id;
       // kyc.GE_HQ_Comp_Leg_En_Nm__c='GGGGGGG';
        //kyc.GE_HQ_VAT_Tax_ID__c='vattaxid';
        kyc.id=Acc.id;
        insert kyc; */
        
         String billName,billStreet,billCity,billState,billPostalCode,billCountry,billPhone;
         String shipName,shipStreet,shipCity,shipState,shipPostalcode,shipCountry,shipPhone;
        
        Schema.DescribeSObjectResult recomObj = Schema.SObjectType.GE_PRM_Recommendation__c;  
        Map<String,Schema.RecordTypeInfo> recomByName = recomObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_recom1 =  recomByName.get('New/Renewal');
        Id recom1=rtByName_recom1.getRecordTypeId();
        //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' and RecordTypeId =:recom1 limit 1];
        
        GE_PRM_KYC_Termination_Checklist__c kyc= new GE_PRM_KYC_Termination_Checklist__c();
         kyc.GE_PRM_Recommendation__c = 'a1WA0000001J5qI';
       
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=Acc.id;
        kyc.Ship_To_Additional_Account__c = Acc1.Id;
        //kyc.Bill_To_Additional_Account__c = Acc1.Id;
        insert kyc; 
        
        // For Code Coverage Few lines added
        
        if(kyc.Ship_To_Additional_Account__c!=null && kyc.Bill_To_Additional_Account__c!=null){
              //acc_Bill=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Bill_To_Additional_Account__c limit 1];
             
              billName='GE OIL & GAS';
              billStreet='Bill Street ';
              billCity='NJ';
              billState='NJ';
              billPostalCode='Postal Code';
              billCountry='USA';
              billPhone='954824';
              
             // acc_Ship=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Ship_To_Additional_Account__c limit 1];
              
              
              shipName='';
              shipStreet='';
              shipCity='';
              shipState='';
              shipPostalCode='';
              shipCountry='';
              shipPhone='';
              
          }else if(kyc.Ship_To_Additional_Account__c!=null){
             // acc_Ship=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Ship_To_Additional_Account__c limit 1];
              
              shipName='';
              shipStreet='';
              shipCity='';
              shipState='';
              shipPostalCode='';
              shipCountry='';
              shipPhone='';
              
          }else if(kyc.Bill_To_Additional_Account__c!=null){
          
             // acc_Bill=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Bill_To_Additional_Account__c limit 1];
            
              billName='GE OIL & GAS';
              billStreet='Bill Street ';
              billCity='NJ';
              billState='NJ';
              billPostalCode='Postal Code';
              billCountry='USA';
              billPhone='954824';
          }
      
        
        
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
        
        GE_OG_ERP_Detail__c erp= new  GE_OG_ERP_Detail__c();

        erp.GE_OG_KYC__c = kyc.id;
        erp.GE_OG_Advance_User__c='sder@gsr.com';
        erp.GE_OG_ERP_Cycle_Time__c=20;
        erp.GE_OG_ERP_Industry_Code__c='Agriculture-675';
        erp.GE_OG_ERP_Customer_Class__c='"AS- Assembler"';
        erp.GE_OG_ERP_Sales_Org__c='1-Sales Org. 001';
        erp.GE_OG_ERP_Sales_Person_First_Name__c='raju';
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='malla';
        erp.GE_OG_ERP_Sales_Person_Email__c='abc@gmail.com';
        erp.GE_OG_ERP_CSR_First_Name__c='ssrr';
        erp.GE_OG_ERP_CSR_Last_Name__c='hsg';
        erp.GE_OG_ERP_CSR_Email__c='sder@gsr.com';
        erp.GE_OG_Pref_Mthd_Pay__c='Credit Cards';
         erp.recordtypeid=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
        insert erp;
        
        GE_OG_ERP_Advance_User__c advanceUser = new GE_OG_ERP_Advance_User__c();
        advanceUser.GE_OG_ERP_Advance_User__c = 'test@acme.com';
        advanceUser.GE_OG_ERP_Tier_3__c = 'Oilfield';
        insert advanceUser ;
        
        //email.subject = 'Sandbox: Advance User Input for:ERP-0001899';
      //  email.plainTextBody = '1. Quote/Sold To - ERP Customer#: Erp 2. Bill To - ERP Customer#:ERPBill 3. Ship To - ERP Customer#:ERPShip 4. ERP System Customer# is located:testLocated ';
       // env.fromAddress = 'test@acme.com';
       // email.fromAddress = env.fromAddress;
       // String erpNum='ERP'+(email.subject).substringAfter('ERP');



PageReference pageRef = new PageReference('/apex/GE_OG_ERP_Detail__c?Id='+erp.id);   

system.test.setCurrentPageReference(pageRef);       

ApexPages.StandardController controler =  new ApexPages.StandardController(erp);    
GE_OG_Email_To_Advance_Users et = new GE_OG_Email_To_Advance_Users(controler);
pagereference pf = et.sendEmails();
      
 }
}