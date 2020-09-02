/*
Class Name:GE_OG_Email_To_Advance_Users
Used For : Used for sending the Email to the Finance User in the ERP process
Purpose/Overview : Send an Email to the Finance User 
Functional Area : Lead/Account&Contacts
Author: Harsh Sharma 
Created Date: 
Test Class Name : GE_OG_Email_To_Advance_UsersTest

Change History - 

Date Modified : Developer Name  : Section/PageBlock Modified/Added : Purpose/Overview of Change
12/23/2013    : Malemleima Chanu  :                                  : For the req :

*/



   public class GE_OG_Email_To_Advance_Users{
     private GE_OG_ERP_Detail__c erp;
      
      public GE_OG_Email_To_Advance_Users(ApexPages.StandardController con){
          this.erp=(GE_OG_ERP_Detail__c)con.getRecord();
      }
      
      public PageReference sendEmails(){
          String erpId=ApexPages.currentPage().getParameters().get('id');
          GE_OG_ERP_Detail__c erp=[select id,name,recordtypeid,GE_OG_KYC__c,Owner.Name,GE_OG_ERP_Is_this_Customer_Tax_Exempt__c,GE_OG_Tier4_PL__c,GE_OG_ERP_Tax_ID__c,GE_OG_Billing_Information__c,GE_OG_Type_Cat_Grp_Usage__c,GE_OG_Website_Address__c,GE_OG_Advance_User__c,GE_OG_Sales_Territory__c,GE_OG_Sales_Channel__c,GE_OG_Revenue_Code__c,GE_OG_Requested_Payment_Terms_FPT__c,GE_OG_Req_Pay_Terms__c,GE_OG_Rec_Acc_Code__c,GE_OG_Profile_Class__c,GE_OG_Price_List__c,GE_OG_Owner_EMail__c,GE_OG_Market_Code__c,GE_OG_Intrnl_Custmr__c,GE_OG_Cust_Lang__c,GE_OG_Cust_Cntct_No__c,GE_OG_Custmr_cntct_name__c,GE_OG_Customer_Code__c,GE_OG_Cust_Classification__c,GE_OG_Cust_AP_Ph_No__c,GE_OG_Cust_AP_Fax_No__c,GE_OG_Cust_AP_Email_Add__c,GE_OG_Customer_AP_Contact__c,GE_OG_Collector_Name__c,GE_OG_Control_AC_Code__c,GE_OG_Credit_Control__c,GE_OG_CoE_Rec_Finance_TCs__c,GE_OG_CoE_Reco_OG_Credit_Lim__c,GE_OG_Freight_Terms__c,GE_OG_FOB__c,GE_OG_Additional_info__c,GE_OG_Site_Number__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Account_Phone__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c,GE_OG_ERP_Sales_Person_ID__c,GE_OG_ERP_CSR_Number__c  from GE_OG_ERP_Detail__c where id=:erpId];
          erp.GE_OG_ERP_Outbound_Timestamp__c=String.valueOf(DateTime.Now());
          DateTime myDateTime = DateTime.Now();
          String formatted = myDateTime.formatGMT('yyyy-MM-dd HH:mm:ss');
          erp.GE_OG_ERP_Outbound_Timestamp__c=formatted;
          erp.GE_OG_ERP_Inbound_Timestamp__c='';
          erp.GE_OG_ERP_Cycle_Time__c=null;
          erp.GE_OG_ERP_Advance_Input_Pending__c=true;
          update erp;
          GE_PRM_KYC_Termination_Checklist__c kyc=[select id,name,GE_HQ_Account__c,Ship_To_Additional_Account__c,Bill_To_Additional_Account__c,GE_HQ_Comp_Leg_En_Nm__c,GE_HQ_VAT_Tax_ID__c from GE_PRM_KYC_Termination_Checklist__c where id=:erp.GE_OG_KYC__c];
          Account acc=[select id,name,GE_HQ_DUNS_Number__c,GE_HQ_Vat_Number__c,GE_PW_Phone_Quote_To_Sold_To_HQ__c,GE_PW_Phone_Bill_To__c,GE_PW_Phone_Ship_To__c,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c,GE_PW_Street_Quote_To_Sold_To_HQ__c,GE_PW_Street_Bill_To__c,GE_PW_Street_Ship_To__c,GE_PW_Country_Quote_To_Sold_To_HQ__c,GE_PW_City_Quote_To_Sold_To_HQ__c,GE_PW_State_Province_Quote_To_Sold_To_HQ__c,GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c,GE_PW_Country_Bill_To__c,GE_PW_City_Bill_To__c,GE_PW_State_Province_Bill_To__c,GE_PW_Zip_Postal_Code_Bill_To__c,GE_PW_Country_Ship_To__c,GE_PW_City_Ship_To__c,GE_PW_State_Province_Ship_To__c,GE_PW_Zip_Postal_Code_Ship_To__c from Account where id=:kyc.GE_HQ_Account__c];
          //User usr=[select id,name, Email from User where Id=:erp.OWNERID];
          Account acc_Bill=new Account();
          Account acc_Ship=new Account();
          String billName,billStreet,billCity,billState,billPostalCode,billCountry,billPhone;
          String shipName,shipStreet,shipCity,shipState,shipPostalcode,shipCountry,shipPhone;
          
          if(kyc.Ship_To_Additional_Account__c!=null && kyc.Bill_To_Additional_Account__c!=null){
              acc_Bill=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Bill_To_Additional_Account__c limit 1];
              billName=acc_Bill.name;
              billStreet=acc_Bill.shippingStreet;
              billCity=acc_Bill.shippingCity;
              billState=acc_Bill.shippingState;
              billPostalCode=acc_Bill.shippingPostalCode;
              billCountry=acc_Bill.shippingCountry;
              billPhone=acc_Bill.phone;
              
              acc_Ship=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Ship_To_Additional_Account__c limit 1];
              shipName=acc_Ship.name;
              shipStreet=acc_Ship.shippingStreet;
              shipCity=acc_Ship.shippingCity;
              shipState=acc_Ship.shippingState;
              shipPostalCode=acc_Ship.shippingPostalCode;
              shipCountry=acc_Ship.shippingCountry;
              shipPhone=acc_Ship.phone;
          }else if(kyc.Ship_To_Additional_Account__c!=null){
              acc_Ship=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Ship_To_Additional_Account__c limit 1];
              shipName=acc_Ship.name;
              shipStreet=acc_Ship.shippingStreet;
              shipCity=acc_Ship.shippingCity;
              shipState=acc_Ship.shippingState;
              shipPostalCode=acc_Ship.shippingPostalCode;
              shipCountry=acc_Ship.shippingCountry;
              shipPhone=acc_Ship.phone;
          }else if(kyc.Bill_To_Additional_Account__c!=null){
              acc_Bill=[select id,name,phone,GE_HQ_DUNS_Number__c,shippingStreet,shippingCity,shippingState,shippingPostalCode,shippingCountry from Account where id=:kyc.Bill_To_Additional_Account__c limit 1];
              billName=acc_Bill.name;
              billStreet=acc_Bill.shippingStreet;
              billCity=acc_Bill.shippingCity;
              billState=acc_Bill.shippingState;
              billPostalCode=acc_Bill.shippingPostalCode;
              billCountry=acc_Bill.shippingCountry;
              billPhone=acc_Bill.phone;
          }
          
          List<Attachment> kycAtt=[select id,name,body,BodyLength from Attachment where parentId=:kyc.Id and BodyLength>0];
          List<Attachment> erpAtt=[select id,name,body,BodyLength from Attachment where parentId=:erpId and BodyLength>0];
          
          Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
          String[] toAddresses = new String[] {erp.GE_OG_Advance_User__c};
          String msg;
          EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress where LocalPart =: 'erp_users_input' ];          
          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          Id ERPOraTierRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle-Tier4').getRecordTypeId(); 
          if (erp.recordtypeid == ERPOraRecordTypeId || erp.recordtypeid == ERPOraTierRecordTypeId ) {
            msg='You have been selected as the Advanced User for this SFDC New Account Request. Please complete the Customer Creation process in the appropriate ERP System and send your acknowledgement back to SFDC ASAP. If the ERP Customer Creation Process is not completed and acknowledged within 24 hours you and the Account Requestor will receive an escalation notification.' ;
            msg+='\n\n'+'TO RECORD YOUR ACKNOWLEDGEMENT FOLLOW THE BELOW INSTRUCTIONS AND SEND YOUR RESPONSE IN THE FOLLOWING ORDER/FORMAT ONLY:';
            msg+='\n\n'+'***********************************************************************';
            msg+='\n'+'1. CLICK ON REPLY IN YOUR OUTLOOK EMAIL';
            msg+='\n\n'+'2. IN THE BODY OF THE EMAIL, COPY & PASTE THE QUESTIONS & ADD YOUR RESPONSE IN THE SECTION MARKED AS "XXXXXXX":';
            msg+='\n\n'+'Quote/Sold To - ERP Customer#:XXXXXXX';
            msg+='\n\n'+'Bill To - ERP Customer#:XXXXXXX';
            msg+='\n\n'+'Ship To - ERP Customer#:XXXXXXX';
            msg+='\n\n'+'ERP System Customer# is located:XXXXXXX';
            msg+='\n\n'+'Accept terms from COE?:XXXXXXX';
            msg+='\n\n'+'Quote/Sold To - ERP Customer# T&Cs:XXXXXXX';
            msg+='\n\n'+'Bill To - ERP Customer# T&Cs:XXXXXXX';
            msg+='\n\n'+'Ship To - ERP Customer# T&Cs:XXXXXXX';
            msg+='\n\n'+'3. PLEASE ENSURE TO ENTER ATLEAST ONE OF THE THREE INPUTS ABOVE FOR "QUOTE TO", "BILL TO" OR "SHIP TO".';
            msg+='\n\n'+'4. CLICK "SEND" IN YOUR OUTLOOK EMAIL';
            msg+='\n'+'***********************************************************************';
            msg+='\n\n'+'Below are the related Accounts and ERP details:';
            msg+='\n\n'+'SFDC ERP Record Link:'+ URL.getSalesforceBaseUrl().toExternalForm() + '/' + erp.id;
            msg+='\n\n'+'Request Owner:'+erp.owner.name;
            msg+='\n\n'+'Request Owners Email:'+ erp.GE_OG_Owner_EMail__c;
            msg+='\n\n'+'Account Name:'+acc.name;
            msg+='\n\n'+'KYC Record#:'+ kyc.name;
            msg+='\n\n'+'KYC Tier 1 P&L:'+erp.GE_OG_ERP_Tier_1_P_L__c;
            msg+='\n\n'+'KYC Tier 2 P&L:'+erp.GE_OG_ERP_Tier_2_P_L__c;
            msg+='\n\n'+'KYC Tier 3 P&L:'+erp.GE_OG_ERP_Tier_3_P_L__c;
            msg+='\n\n'+'KYC Tier 4 P&L:'+erp.GE_OG_Tier4_PL__c;
            msg+='\n\n'+'Address Information';
            msg+='\n'+'[Quote/Sold To Address Details]';
            msg+='\n\n'+'Company Legal Entity Name:'+ acc.Name;
            msg+='\n\n'+'Street:'+acc.GE_PW_Street_Quote_To_Sold_To_HQ__c ;
            msg+='\n\n'+'City:'+acc.GE_PW_City_Quote_To_Sold_To_HQ__c;
            msg+='\n\n'+'State/Province: '+ acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c;
            msg+='\n\n'+'Zip Code/Postal Code:'+acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c;
            msg+='\n\n'+'Registered/Quote Country: '+acc.GE_PW_Country_Quote_To_Sold_To_HQ__c;
            msg+='\n\n'+'VAT/ Tax ID:'+acc.GE_HQ_Vat_Number__c;
            msg+='\n\n'+'DUNS/CATDUNS: '+acc.GE_HQ_DUNS_Number__c;
            msg+='\n\n'+'Phone#: '+acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c;
            msg+='\n\n'+'[Bill To Address Details]';
            msg+='\n'+'Company Legal Entity Name: '+acc.Name;
            msg+='\n'+'Street:'+acc.GE_PW_Street_Bill_To__c;
            msg+='\n\n'+'City:'+acc.GE_PW_City_Bill_To__c;
            msg+='\n\n'+'State/Province: '+acc.GE_PW_State_Province_Bill_To__c;
            msg+='\n\n'+'Zip Code/Postal Code: '+acc.GE_PW_Zip_Postal_Code_Bill_To__c;
            msg+='\n\n'+'Registered/Bill To Country: '+acc.GE_PW_Country_Bill_To__c;
            msg+='\n\n'+'VAT/ Tax ID: '+acc.GE_HQ_Vat_Number__c;
            msg+='\n\n'+'DUNS/CATDUNS:'+acc.GE_HQ_DUNS_Number__c;
            msg+='\n\n'+'Phone#: '+acc.GE_PW_Phone_Bill_To__c;
            msg+='\n\n'+'[Ship To Address Details]';
            msg+='\n\n'+'Company Legal Entity Name: '+acc.Name;
            msg+='\n\n'+'Street: '+acc.GE_PW_Street_Ship_To__c;
            msg+='\n\n'+'City: '+acc.GE_PW_City_Ship_To__c;
            msg+='\n\n'+'State/Province: '+acc.GE_PW_State_Province_Ship_To__c;
            msg+='\n\n'+'Zip Code/Postal Code: '+acc.GE_PW_Zip_Postal_Code_Ship_To__c;
            msg+='\n\n'+'Registered/Quote Country: '+acc.GE_PW_Country_Ship_To__c;
            msg+='\n\n'+'VAT/ Tax ID: '+acc.GE_HQ_Vat_Number__c;
            msg+='\n\n'+'DUNS/CATDUNS:'+acc.GE_HQ_DUNS_Number__c;
            msg+='\n\n'+'Phone#:' +acc.GE_PW_Phone_Ship_To__c;
            msg+='\n\n'+'ERP Setup Information Details';
            msg+='\n\n'+'[Subscribed/Legacy System(s)] ';
            msg+='\n\n'+erp.GE_OG_ERP_Subscribed_Legacy_Systems__c;
            msg+='\n\n'+'[Customer Information] ';
            msg+='\n\n'+'Customer Contact Name: '+erp.GE_OG_Custmr_cntct_name__c;
            msg+='\n\n'+'Customer Contact Number: '+erp.GE_OG_Cust_Cntct_No__c;
            msg+='\n\n'+'Website Address: '+erp.GE_OG_Website_Address__c;
            msg+='\n\n'+'Customer A/P Contact: '+erp.GE_OG_Customer_AP_Contact__c;
            msg+='\n\n'+'Customer A/P Phone No. : '+erp.GE_OG_Cust_AP_Ph_No__c;
            msg+='\n\n'+'Customer  A/P Fax No. : '+erp.GE_OG_Cust_AP_Fax_No__c;
            msg+='\n\n'+'Customer A/P Email Address: '+erp.GE_OG_Cust_AP_Email_Add__c;
            msg+='\n\n'+'Customer Classification: '+erp.GE_OG_Cust_Classification__c;
            msg+='\n\n'+'Type / Category / Group / Usage:'+erp.GE_OG_Type_Cat_Grp_Usage__c;
            msg+='\n\n'+'Industry Code (Branch) : '+erp.GE_OG_ERP_Industry_Code__c;
            msg+='\n\n'+'Market Code: '+erp.GE_OG_Market_Code__c;
            msg+='\n\n'+'Profile Class: '+erp.GE_OG_Profile_Class__c;
            msg+='\n\n'+'Customer Code : '+erp.GE_OG_Customer_Code__c;
            msg+='\n\n'+'Customer Language: '+erp.GE_OG_Cust_Lang__c;
            msg+='\n\n'+'Internal Customer? : '+erp.GE_OG_Intrnl_Custmr__c;
            msg+='\n\n'+'Billing Information (Internal Only) : '+erp.GE_OG_Billing_Information__c;
            msg+='\n\n'+'[Tax] ';
            msg+='\n\n'+'Is this Customer Tax Exempt? : '+erp.GE_OG_ERP_Is_this_Customer_Tax_Exempt__c;
            msg+='\n\n'+'Tax ID: '+erp.GE_OG_ERP_Tax_ID__c;
            msg+='\n\n'+'[Credit Terms] ';
            msg+='\n\n'+'CoE Recommended Finance T&Cs: '+erp.GE_OG_CoE_Rec_Finance_TCs__c;
            msg+='\n\n'+'CoE Recommended O&G credit limit: '+erp.GE_OG_CoE_Reco_OG_Credit_Lim__c;
            /*if(erp.GE_OG_Req_Pay_Terms__c!=null){
            msg+='\n\n'+'Requested Payment Terms: '+erp.GE_OG_Req_Pay_Terms__c;}
            else{
            msg+='\n\n'+'Requested Payment Terms: '+erp.GE_OG_Requested_Payment_Terms_FPT__c;}*/
            msg+='\n\n'+'Requested Credit Limit: '+erp.Requested_Credit_Limit__c;
            msg+='\n\n'+'[Other Information] ';
            msg+='\n\n'+'Sales Territory: '+erp.GE_OG_Sales_Territory__c;
            msg+='\n\n'+'Sales Channel: '+erp.GE_OG_Sales_Channel__c;
            msg+='\n\n'+'Sales Person First Name: '+erp.GE_OG_ERP_Sales_Person_First_Name__c;
            msg+='\n\n'+'Sales Person Last Name: '+erp.GE_OG_ERP_Sales_Person_Last_Name__c;
            msg+='\n\n'+'Sales Person ID: '+erp.GE_OG_ERP_Sales_Person_ID__c;
            msg+='\n\n'+'Sales Person Email: '+erp.GE_OG_ERP_Sales_Person_Email__c;
            msg+='\n\n'+'Collector Name: '+erp.GE_OG_Collector_Name__c;
            msg+='\n\n'+'Credit Control: '+erp.GE_OG_Credit_Control__c;
            msg+='\n'+'Currency: '+erp.GE_OG_ERP_Currency__c;
            msg+='\n\n'+'FOB: '+erp.GE_OG_FOB__c;
            msg+='\n\n'+'Freight Terms: '+erp.GE_OG_Freight_Terms__c;
            msg+='\n\n'+'Price List: '+erp.GE_OG_Price_List__c;
            msg+='\n\n'+'Site Number: '+erp.GE_OG_Site_Number__c;
            msg+='\n\n'+'Control A/C Code: '+erp.GE_OG_Control_AC_Code__c;
            msg+='\n\n'+'Receivable Account Code: '+erp.GE_OG_Rec_Acc_Code__c;
            msg+='\n\n'+'Revenue Code: '+erp.GE_OG_Revenue_Code__c;
            msg+='\n\n'+'Specify any additional information: '+erp.GE_OG_Additional_info__c;
          } else {
              msg='You have been selected as the Advanced User who will Create New Customer Locations for this SFDC Account Request in your ERP System. Please complete the ERP Customer Creation process and send your acknowledgement back to SFDC ASAP. If the ERP Customer Creation Process is not completed and acknowledged within 24 hours you and the Account Requestor will receive an escalation notification. ';
              msg+='\n\n'+'PLEASE FOLLOW THE BELOW INSTRUCTIONS AND SEND YOUR RESPONSE IN THE FOLLOWING ORDER/FORMAT ONLY:';
              msg+='\n\n\n'+'***********************************************************************';
              msg+='\n'+'1. CLICK ON REPLY IN YOUR OUTLOOK EMAIL';    
              msg+='\n\n'+'2. IN THE BODY OF THE EMAIL, COPY & PASTE THE QUESTIONS & ADD YOUR RESPONSE IN THE SECTION MARKED AS "XXXXXXX":';
              msg+='\n\n'+'1. Quote/Sold To - ERP Customer#:XXXXXXX'; 
              msg+='\n\n'+'2. Bill To - ERP Customer#:XXXXXXX';
              msg+='\n\n'+'3. Ship To - ERP Customer#:XXXXXXX';
              msg+='\n\n'+'4. ERP System Customer# is located:XXXXXXX';
              msg+='\n\n'+'3. PLEASE ENSURE TO ENTER ATLEAST ONE OF THE THREE INPUTS ABOVE FOR "QUOTE TO", "BILL TO" OR "SHIP TO".';
              msg+='\n\n'+'4. CLICK "SEND" IN YOUR OUTLOOK EMAIL';
              msg+='\n'+'***********************************************************************';
              //msg+='\n\n\n'+'IMPORTANT NOTE: PLEASE MAKE SURE THAT YOU HAVE DELETED EVERYTHING ELSE FROM THE EMAIL BODY!!';
              msg+='\n\n\n';
              msg+='\n'+'Below are the Accounts and ERP details:';
              msg+='\n';
              msg+='\n\n'+'ERP Record Link: '+URL.getSalesforceBaseUrl().toExternalForm() + '/' + erp.id;
              msg+='\n';
              msg+='\n\n'+'SFDC New Account ID #: '+acc.Name;
              msg+='\n'+'KYC ID#: '+kyc.Name;
              msg+='\n\n'+'ERP Details:';
              msg+='\n'+'Subscribed/Legacy Systems passed during KYC: \n'+erp.GE_OG_ERP_Subscribed_Legacy_Systems__c;
              msg+='\n\n'+'KYC Tier 1 P&L: '+erp.GE_OG_ERP_Tier_1_P_L__c;
              msg+='\n\n'+'KYC Tier 2 P&L: '+erp.GE_OG_ERP_Tier_2_P_L__c;
              msg+='\n\n'+'KYC Tier 3 P&L: '+erp.GE_OG_ERP_Tier_3_P_L__c;
              msg+='\n\n'+'Phone#: '+erp.GE_OG_ERP_Account_Phone__c;
              msg+='\n\n'+'ERP Related List Reference # ';
              msg+='\n'+'Tier 1: '+acc.GE_OG_Buss_Tier1__c;
              msg+='\n'+'Tier 2: '+acc.GE_OG_Buss_Tier2__c;
              msg+='\n'+'Tier 3: '+acc.GE_OG_Buss_Tier3__c;
              msg+='\n\n'+'Quote/Sold To Address Details:';
              msg+='\n'+'CMF Approved Customer DUNS/CATDUNS: '+acc.GE_HQ_DUNS_Number__c;
              msg+='\n\n'+'Company Legal Entity Name: '+acc.Name;
              //msg+='\n\n'+'Registered/Quote Address Line 1: ';
              //msg+='\n'+'Registered/Quote Address Line 2: ';
              msg+='\n'+'Street: '+acc.GE_PW_Street_Quote_To_Sold_To_HQ__c;
              msg+='\n'+'City: '+acc.GE_PW_City_Quote_To_Sold_To_HQ__c;
              msg+='\n'+'State/Province: '+acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c;
              msg+='\n'+'Zip Code/Postal Code: '+acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c;
              msg+='\n'+'Registered/Quote Country: '+acc.GE_PW_Country_Quote_To_Sold_To_HQ__c;
              msg+='\n'+'VAT/ Tax ID: '+kyc.GE_HQ_VAT_Tax_ID__c;
              msg+='\n\n'+'Bill To Address Details:';
              msg+='\n'+'CMF Approved Customer DUNS/CATDUNS: '+acc_Bill.GE_HQ_DUNS_Number__c;
              msg+='\n\n'+'Company Legal Entity Name: '+billName;
              //msg+='\n\n'+'Registered/Quote Address Line 1: ';
              //msg+='\n'+'Registered/Quote Address Line 2: ';
              msg+='\n'+'Street: '+billStreet;
              msg+='\n'+'City: '+billCity;
              msg+='\n'+'State/Province/County: '+billState;
              msg+='\n'+'Zip Code/Postal Code: '+billPostalCode;
              msg+='\n'+'Bill To Country: '+billCountry;
              msg+='\n'+'Phone #: '+billPhone;
              msg+='\n'+'VAT/ Tax ID: '+kyc.GE_HQ_VAT_Tax_ID__c;
              msg+='\n\n'+'Ship To Address Details:';
              msg+='\n'+'CMF Approved Customer DUNS/CATDUNS: '+acc_Ship.GE_HQ_DUNS_Number__c;
              msg+='\n\n'+'Company Legal Entity Name: '+shipName;
              //msg+='\n\n'+'Registered/Quote Address Line 1: ';
              //msg+='\n'+'Registered/Quote Address Line 2: ';
              msg+='\n'+'Street: '+shipStreet;
              msg+='\n'+'City: '+shipStreet;
              msg+='\n'+'State/Province: '+shipState;
              msg+='\n'+'Zip Code/Postal Code: '+shipPostalCode;
              msg+='\n'+'Ship To Country: '+shipCountry;
              msg+='\n'+'Phone #: '+shipPhone;
              msg+='\n'+'VAT/ Tax ID: '+kyc.GE_HQ_VAT_Tax_ID__c;
              msg+='\n\n'+'ERP DEtails:';
             // msg+='\n'+'Industry Code: '+erp.GE_OG_ERP_Industry_Code__c;
             // msg+='\n'+'Customer Classification: '+erp.GE_OG_ERP_Customer_Class__c;
              msg+='\n'+'SAP Sales Org: '+erp.GE_OG_ERP_Sales_Org__c;
              msg+='\n'+'Sales Person Name: '+erp.GE_OG_ERP_Sales_Person_First_Name__c+' '+erp.GE_OG_ERP_Sales_Person_Last_Name__c;
              msg+='\n'+'Sales Person Email: '+erp.GE_OG_ERP_Sales_Person_Email__c;
              msg+='\n'+'Sales Sales Person ID: '+erp.GE_OG_ERP_Sales_Person_ID__c;
              msg+='\n\n'+'CSR Person Name: '+erp.GE_OG_ERP_CSR_First_Name__c+' '+erp.GE_OG_ERP_CSR_Last_Name__c;
              msg+='\n\n'+'CSR Person Email: '+erp.GE_OG_ERP_CSR_Email__c;
              msg+='\n\n'+'CSR Person CSR Number: '+erp.GE_OG_ERP_CSR_Number__c;
              
              //msg+='\n'+'Phone # ';
              //msg+='\n'+'FAX Number: ';
              //msg+='\n'+'Email: ';
              msg+='\n\n'+'Payment Terms Requested: '+erp.Requested_Payment_Terms__c;
              msg+='\n\n'+'Requested credit limit: '+erp.Requested_Credit_Limit__c;
              msg+='\n\n'+'Preferred Method of Payment: '+erp.GE_OG_Pref_Mthd_Pay__c;
              
               // For the Measurement & Control 
              if(acc.GE_OG_Buss_Tier2__c=='Digital Solutions'){
                     msg+='\n\n'+'Industry Code: '+erp.GE_OG_ERP_Industry_Code__c;
                     msg+='\n\n'+'Customer Classification: '+erp.GE_OG_ERP_Customer_Class__c;
                 
                   }
              
              else if(acc.GE_OG_Buss_Tier2__c=='Drilling & Surface (D&S)'){
                  msg+='\n\n'+'Sales Office: '+erp.GE_OG_ERP_Sales_Office__c;
                  msg+='\n\n'+'Price Group: '+erp.GE_OG_ERP_Price_Group__c;
                  msg+='\n\n'+'Region Manager: '+erp.GE_OG_ERP_Region_Manager__c;
                  msg+='\n\n'+'Shipping Conditions: '+erp.GE_OG_ERP_Shipping_Conditions__c;
                  msg+='\n\n'+'Delivery Plant: '+erp.GE_OG_ERP_Delivering_Plant__c;
                  msg+='\n\n'+'Incoterms 1: '+erp.GE_OG_ERP_Incoterms_1__c;
                  msg+='\n\n'+'Incoterms 2: '+erp.GE_OG_ERP_Incoterms_2__c;
                  msg+='\n\n'+'Currency: '+erp.GE_OG_ERP_Currency__c;
                  msg+='\n\n'+'Sales Org - Currency - Remit To: '+erp.GE_OG_ERP_Sales_Org_Currency_Remit_To__c;
                  msg+='\n\n'+'Is the Customer part of GE?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE__c;
                  msg+='\n\n'+'Is the Customer part of GE Energy?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE_E__c;
                  msg+='\n\n'+'Is the Customer part of GE Energy Srvcs?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c;
                  msg+='\n\n'+'Is the Customer part of GE Oil & Gas?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c;
                  msg+='\n\n'+'Will the Customer be on the IBS?: '+erp.GE_OG_ERP_Internal_Billing_System__c;
              }
              else if(acc.GE_OG_Buss_Tier2__c=='Lufkin') {
                      msg+='\n\n'+'Company Code: '+erp.GE_OG_Company_Code__c;
                     // msg+='\n\n'+'Payment Terms Requested: '+erp.GE_OG_Payt_Terms_Requested__c;
                    //  msg+='\n\n'+'Credit Limit Requested: '+erp.GE_OG_Credit_Limit_Request__c;
                      msg+='\n\n'+'Is the Customer part of GE?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE__c;
                      msg+='\n\n'+'Is the Customer part of GE Oil & Gas?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c;
                     }
            }
          mail.setReplyTo('erp_users_input@'+eAdd.EmailDomainName);
          mail.setToAddresses(toAddresses);
          mail.setBccSender(false);
          mail.setSenderDisplayName('ERP Advance User Support'); 
          mail.setSubject('Advance User Input for:'+erp.name);
          mail.setUseSignature(false);
          //mail.setTargetObjectId(erp.id);
          //mail.setTemplateId('00XZ0000000QSyZ');
          mail.setPlainTextBody(msg);
          
          Messaging.EmailFileAttachment[] efaList=new Messaging.EmailFileAttachment[] {};
          
          if(kycAtt.size()>0){
              for(Attachment att:kycAtt){
                  Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                  efa.setFileName(att.name);
                  efa.setBody(att.body);
                  efaList.add(efa);
              }
          }
          
          if(erpAtt.size()>0){
              for(Attachment att:erpAtt){
                  Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                  efa.setFileName(att.name);
                  efa.setBody(att.body);
                  efaList.add(efa);
              }
          }
          
          if(efaList.size()>0){
              mail.setFileAttachments(efaList);
          }
          
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
          
          PageReference pageRef=new PageReference('/'+erpId);
          pageRef.setRedirect(true);
          return pageRef;
      }
}