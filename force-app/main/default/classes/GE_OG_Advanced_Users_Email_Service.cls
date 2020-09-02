/*
Class Name:GE_OG_Advanced_Users_Email_Service 
Used For : Used for sending the Email to the Finance User in the ERP process
Purpose/Overview : Send an Email to the Finance User 
Functional Area : Lead/Account&Contacts
Author: Harsh Sharma 
Created Date: 
Test Class Name : GE_OG_Advanced_Users_Email_ServiceTest

Change History - 

Date Modified : Developer Name  : Section/PageBlock Modified/Added : Purpose/Overview of Change
12/23/2013    : Malemleima Chanu  :                                  : For the req :

*/



global class GE_OG_Advanced_Users_Email_Service implements Messaging.InboundEmailHandler {
     global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          String erpNum='ERP'+(email.subject).substringAfter('ERP');
          system.debug('ERP Num**********'+erpNum);
          GE_OG_ERP_Detail__c erp=[select id,name,GE_OG_ERP_Sales_Person_ID__c,recordtypeid,GE_OG_KYC__c,GE_OG_Advance_User__c,GE_OG_ERP_Industry_Code__c,GE_OG_ERP_Customer_Class__c,GE_OG_ERP_Sales_Org__c,GE_OG_ERP_Sales_Person_First_Name__c,GE_OG_ERP_Sales_Person_Last_Name__c,GE_OG_ERP_Sales_Person_Email__c,GE_OG_ERP_CSR_First_Name__c,GE_OG_ERP_CSR_Last_Name__c,GE_OG_ERP_CSR_Email__c,GE_OG_Pref_Mthd_Pay__c,GE_OG_ERP_Quote_To_SAP__c,GE_OG_ERP_Bill_To_SAP__c,GE_OG_ERP_Ship_To_SAP__c,GE_OG_ERP_Inbound_Timestamp__c,GE_OG_ERP_Outbound_Timestamp__c,GE_OG_ERP_Cycle_Time__c,GE_OG_ERP_Quote_To_SAP_TC__c,GE_OG_ERP_Bill_To_SAP_TC__c,GE_OG_ERP_Ship_To_SAP_TC__c,GE_OG_Fin_Inbound_Time__c,GE_OG_Fin_Outbound_Time__c,GE_OG_ERP_Accept_terms_from_COE__c,GE_OG_Finance_Cycle_Time__c,GE_OG_ERP_Subscribed_Legacy_Systems__c,GE_OG_ERP_Tier_1_P_L__c,GE_OG_ERP_Tier_2_P_L__c,GE_OG_ERP_Tier_3_P_L__c,GE_OG_ERP_System_Customer__c,GE_OG_ERP_Account_Phone__c,Requested_Credit_Limit__c,Requested_Payment_Terms__c,GE_OG_ERP_Sales_Office__c,GE_OG_ERP_Price_Group__c,GE_OG_ERP_Region_Manager__c,GE_OG_ERP_Shipping_Conditions__c,GE_OG_ERP_Delivering_Plant__c,GE_OG_ERP_Incoterms_1__c,GE_OG_ERP_Incoterms_2__c,GE_OG_ERP_Currency__c,GE_OG_ERP_Sales_Org_Currency_Remit_To__c,GE_OG_ERP_Is_the_Customer_part_of_GE__c,GE_OG_ERP_Is_the_Customer_part_of_GE_E__c,GE_OG_ERP_Is_the_Customer_part_of_GE_ES__c,GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c,GE_OG_ERP_Internal_Billing_System__c,GE_OG_Company_Code__c from GE_OG_ERP_Detail__c where name=:erpNum limit 1];
          system.debug('ERP id**********'+erp.id);          
          GE_PRM_KYC_Termination_Checklist__c kyc=[select id,name,GE_HQ_Account__c,Ship_To_Additional_Account__c,Bill_To_Additional_Account__c,GE_HQ_Comp_Leg_En_Nm__c,GE_HQ_VAT_Tax_ID__c from GE_PRM_KYC_Termination_Checklist__c where id=:erp.GE_OG_KYC__c];
          system.debug('KYC Id**********'+kyc.id);
          Account acc=[select id,name,GE_HQ_DUNS_Number__c,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c,GE_PW_Street_Quote_To_Sold_To_HQ__c,GE_PW_Street_Bill_To__c,GE_PW_Street_Ship_To__c,GE_PW_Country_Quote_To_Sold_To_HQ__c,GE_PW_City_Quote_To_Sold_To_HQ__c,GE_PW_State_Province_Quote_To_Sold_To_HQ__c,GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c,GE_PW_Country_Bill_To__c,GE_PW_City_Bill_To__c,GE_PW_State_Province_Bill_To__c,GE_PW_Zip_Postal_Code_Bill_To__c,GE_PW_Country_Ship_To__c,GE_PW_City_Ship_To__c,GE_PW_State_Province_Ship_To__c,GE_PW_Zip_Postal_Code_Ship_To__c from Account where id=:kyc.GE_HQ_Account__c];
          system.debug('Acc Id**********'+acc.id);

          Id ERPOraRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle').getRecordTypeId(); 
          Id ERPOraTierRecordTypeId=Schema.SObjectType.GE_OG_ERP_Detail__c.getRecordTypeInfosByName().get('ERP Oracle-Tier4').getRecordTypeId();                  

          if((email.subject).contains('ERP') && (email.subject).contains('Advance')){     
          List<String> content=email.plainTextBody.split('\n');
          if(content.size()>0 && erp.GE_OG_ERP_Cycle_Time__c==null){
              String adv1,adv2,adv3,adv4;
              String fin1,fin2,fin3,fin4;
              for(String str:content){
                if (erp.recordtypeid == ERPOraRecordTypeId || erp.recordtypeid == ERPOraTierRecordTypeId ) {
                  if(str.contains('Quote/Sold To - ERP Customer#:') && !str.contains('Quote/Sold To - ERP Customer#:XXXXXXX')){
                      erp.GE_OG_ERP_Quote_To_SAP__c=str.substringAfter('Quote/Sold To - ERP Customer#:');
                      adv1=str.substringAfter('Quote/Sold To - ERP Customer#:');
                  }
                  if(str.contains('Bill To - ERP Customer#:') && !str.contains('Bill To - ERP Customer#:XXXXXXX')){
                      erp.GE_OG_ERP_Bill_To_SAP__c=str.substringAfter('Bill To - ERP Customer#:');
                      adv2=str.substringAfter('Bill To - ERP Customer#:');
                  }
                  if(str.contains('Ship To - ERP Customer#:') && !str.contains('Ship To - ERP Customer#:XXXXXXX')){
                      erp.GE_OG_ERP_Ship_To_SAP__c=str.substringAfter('Ship To - ERP Customer#:');
                      adv3=str.substringAfter('Ship To - ERP Customer#:');
                  }
                  if(str.contains('ERP System Customer# is located:') && !str.contains('ERP System Customer# is located:XXXXXXX')){
                      erp.GE_OG_ERP_System_Customer__c=str.substringAfter('ERP System Customer# is located:');
                      adv4=str.substringAfter('ERP System Customer# is located:');
                  }
                  if(str.contains('Accept terms from COE?:') && !str.contains('Accept terms from COE?:XXXXXXX')){
                      erp.GE_OG_ERP_Accept_terms_from_COE__c=str.substringAfter('Accept terms from COE?:');
                      fin1=str.substringAfter('Accept terms from COE?:');
                  }
                  if(str.contains('Quote/Sold To - ERP Customer# T&Cs:') && !str.contains('Quote/Sold To - ERP Customer# T&Cs:XXXXXXX')){
                      erp.GE_OG_ERP_Quote_To_SAP_TC__c=str.substringAfter('Quote/Sold To - ERP Customer# T&Cs:');
                      fin2=str.substringAfter('Quote/Sold To - ERP Customer# T&Cs:');
                  }
                  if(str.contains('Bill To - ERP Customer# T&Cs:') && !str.contains('Bill To - ERP Customer# T&Cs:XXXXXXX')){
                      erp.GE_OG_ERP_Bill_To_SAP_TC__c=str.substringAfter('Bill To - ERP Customer# T&Cs:');
                      fin3=str.substringAfter('Bill To - ERP Customer# T&Cs:');
                  }
                  if(str.contains('Ship To - ERP Customer# T&Cs:') && !str.contains('Ship To - ERP Customer# T&Cs:XXXXXXX')){
                      erp.GE_OG_ERP_Ship_To_SAP_TC__c=str.substringAfter('Ship To - ERP Customer# T&Cs:');
                      fin4=str.substringAfter('Ship To - ERP Customer# T&Cs:');
                  }             
                } else {
                  if(str.contains('1. Quote/Sold To - ERP Customer#:') && !str.contains('1. Quote/Sold To - ERP Customer#:XXXXXXX')){
                      erp.GE_OG_ERP_Quote_To_SAP__c=str.substringAfter('1. Quote/Sold To - ERP Customer#:');
                      adv1=str.substringAfter('1. Quote/Sold To - ERP Customer#:');
                  }
                  if(str.contains('2. Bill To - ERP Customer#:') && !str.contains('2. Bill To - ERP Customer#:XXXXXXX')){
                      erp.GE_OG_ERP_Bill_To_SAP__c=str.substringAfter('2. Bill To - ERP Customer#:');
                      adv2=str.substringAfter('2. Bill To - ERP Customer#:');
                  }
                  if(str.contains('3. Ship To - ERP Customer#:') && !str.contains('3. Ship To - ERP Customer#:XXXXXXX')){
                      erp.GE_OG_ERP_Ship_To_SAP__c=str.substringAfter('3. Ship To - ERP Customer#:');
                      adv3=str.substringAfter('3. Ship To - ERP Customer#:');
                  }
                  if(str.contains('4. ERP System Customer# is located:') && !str.contains('4. ERP System Customer# is located:XXXXXXX')){
                      erp.GE_OG_ERP_System_Customer__c=str.substringAfter('4. ERP System Customer# is located:');
                      adv4=str.substringAfter('4. ERP System Customer# is located:');
                  }
                }
              }
              
              update erp;
              
              if(!String.isBlank(adv1) || !String.isBlank(adv2) || !String.isBlank(adv3)){
              erp.GE_OG_ERP_Inbound_Timestamp__c=String.valueOf(DateTime.now());
              erp.GE_OG_ERP_Advance_Input_Pending__c=false;
              Datetime startDate = DateTime.valueOf(erp.GE_OG_ERP_Outbound_Timestamp__c);// Start date
              
              Datetime endDate = DateTime.Now();//End Date
              String enddateformat = endDate.formatGMT('yyyy-MM-dd HH:mm:ss');
              erp.GE_OG_ERP_Inbound_Timestamp__c=enddateformat;
              
              Datetime lastdate = DateTime.valueOf(erp.GE_OG_ERP_Inbound_Timestamp__c); //enddate1
              
              Decimal intDays = lastdate.day()-startDate.day();
              Decimal intHours= lastdate.hour()-startDate.hour();
              Decimal intMins = lastdate.minute()-startDate.minute();
              Decimal cycleTime=intDays*24 + intHours + intMins/60;
              
              erp.GE_OG_ERP_Cycle_Time__c=cycleTime;
              
              update erp;
              }
              
           /* if ( erp.GE_OG_Finance_Cycle_Time__c==null ) {
                if (erp.recordtypeid == ERPOraRecordTypeId || erp.recordtypeid == ERPOraTierRecordTypeId ) {
                    if((!String.isBlank(fin2) || !String.isBlank(fin3) || !String.isBlank(fin4)) && !String.isBlank(fin1)){
                      Datetime FstartDate = DateTime.valueOf(erp.GE_OG_Fin_Outbound_Time__c);// Start date
                      Datetime FendDate = DateTime.now();//End Date
                        
                      Decimal FintDays = FendDate.day()-FstartDate.day();
                      Decimal FintHours= FendDate.hour()-FstartDate.hour();
                      Decimal FintMins = FendDate.minute()-FstartDate.minute();
                      Decimal FcycleTime=FintDays*24 + FintHours + FintMins/60;
                      
                      erp.GE_OG_Finance_Cycle_Time__c=FcycleTime;
                      erp.GE_OG_Fin_Inbound_Time__c=String.valueOf(DateTime.now());
                      erp.GE_OG_ERP_Finance_Input_Pending__c=false;
                    }
                  }
                update erp; 
             }*/
          }
          
        if (String.isBlank(erp.GE_OG_ERP_Quote_To_SAP_TC__c) || String.isBlank(erp.GE_OG_ERP_Bill_To_SAP_TC__c) || String.isBlank(erp.GE_OG_ERP_Ship_To_SAP_TC__c)) {
          if( !String.isBlank(erp.GE_OG_ERP_Quote_To_SAP__c) || !String.isBlank(erp.GE_OG_ERP_Bill_To_SAP__c) || !String.isBlank(erp.GE_OG_ERP_Ship_To_SAP__c)){
              
              GE_PRM_KYC_Termination_Checklist__c erpKYC=[select id,name,GE_HQ_Account__c from GE_PRM_KYC_Termination_Checklist__c where id=:erp.GE_OG_KYC__c];
              Account erpACC=[select id,name,GE_OG_Buss_Tier3__c from Account where id=:erpKYC.GE_HQ_Account__c];
              List<GE_OG_ERP_Finance_User__c> finUsers=[select id,name,GE_OG_ERP_Finance_User__c,GE_OG_ERP_Tier_3_P_L__c from GE_OG_ERP_Finance_User__c where GE_OG_ERP_Tier_3_P_L__c=:erpACC.GE_OG_Buss_Tier3__c limit 10];
              List<Attachment> kycAtt=[select id,name,body,BodyLength from Attachment where parentId=:kyc.Id and BodyLength>0];
              List<Attachment> erpAtt=[select id,name,body,BodyLength from Attachment where parentId=:erp.Id and BodyLength>0];
              
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
              
              //String eString='';
              String[] toAddresses = new String[] {};
              if(finUsers.size()>0){
                  for(GE_OG_ERP_Finance_User__c fin:finUsers){
                      //eString+=fin.GE_OG_ERP_Finance_User__c+',';
                      toAddresses.add(fin.GE_OG_ERP_Finance_User__c);
                  }
                  //eString=eString.removeEnd(',');
              }else{
                  toAddresses.add('harsh1.sharma@ge.com');
              }
              
              Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
              //String[] toAddresses = new String[] {'Raji.Ranganathan@ge.com','Harsh1.Sharma@ge.com','Deborah.Wolschrijn@ge.com','Doug.Cole@ge.com'};
              //String[] toAddresses = new String[] {eString};
              String msg;
              EmailServicesAddress eAdd=[select EmailDomainName from EmailServicesAddress where LocalPart =: 'erp_users_input'];
              msg='You have been selected as the Finance Resource who will Add Credit Limits and Payment Terms to the New Customer Locations Created for this SFDC Account Request. Please complete the Credit Limits and Payment Terms process and send your acknowledgement back to SFDC ASAP. If the Credit Limits and Payment Terms Process is not completed and acknowledged within 24 hours you and the Account Requestor will receive an escalation notification.';
              msg+='\n\n'+'PLEASE FOLLOW THE BELOW INSTRUCTIONS AND SEND YOUR RESPONSE IN THE FOLLOWING ORDER/FORMAT ONLY:';
              msg+='\n\n\n'+'***********************************************************************';
              msg+='\n'+'1. CLICK ON REPLY IN YOUR OUTLOOK EMAIL';    
              msg+='\n\n'+'2. IN THE BODY OF THE EMAIL, COPY & PASTE THE QUESTIONS & ADD YOUR RESPONSE IN THE SECTION MARKED AS "XXXXXXX":';
              msg+='\n\n'+'1. Accept terms from COE?(Yes/No):XXXXXXX'; 
              msg+='\n\n'+'2. Quote/Sold To - ERP Customer# T&Cs:XXXXXXX'; 
              msg+='\n\n'+'3. Bill To - ERP Customer# T&Cs:XXXXXXX';
              msg+='\n\n'+'4. Ship To - ERP Customer# T&Cs:XXXXXXX';
              msg+='\n\n'+'3. PLEASE ENSURE TO ENTER Yes or No value for "Accept terms from COE?" AND ATLEAST ONE OF THE THREE INPUTS ABOVE FOR "QUOTE TO", "BILL TO" OR "SHIP TO".';
              msg+='\n\n'+'4. CLICK "SEND" IN YOUR OUTLOOK EMAIL';
              msg+='\n'+'***********************************************************************';
              //msg+='\n\n\n'+'IMPORTANT NOTE: PLEASE COPY & PASTE THE ABOVE 4 LINES WHILE REPLYING TO THIS EMAIL AND MAKE SURE THAT YOU DELETED EVERYTHING ELSE FROM THE EMAIL BODY!!';
              msg+='\n\n\n';
              msg+='\n'+'Advanced User Input Details:';
              msg+='\n\n'+'1. Quote/Sold To - ERP Customer#: '+erp.GE_OG_ERP_Quote_To_SAP__c; 
              msg+='\n\n'+'2. Bill To - ERP Customer#: '+erp.GE_OG_ERP_Bill_To_SAP__c;
              msg+='\n\n'+'3. Ship To - ERP Customer#: '+erp.GE_OG_ERP_Ship_To_SAP__c;
              msg+='\n\n'+'4. ERP System Customer# is located: '+erp.GE_OG_ERP_System_Customer__c;
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
              msg+='\n'+'VAT/ Tax ID ';
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
               // For the Drilling & Surface
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
              
              // For the Drilling & Surface
              else if(acc.GE_OG_Buss_Tier2__c=='Lufkin') {
                  msg+='\n\n'+'Company Code: '+erp.GE_OG_Company_Code__c;
                 // msg+='\n\n'+'Payment Terms Requested: '+erp.GE_OG_Payt_Terms_Requested__c;
                //  msg+='\n\n'+'Credit Limit Requested: '+erp.GE_OG_Credit_Limit_Request__c;
                  msg+='\n\n'+'Is the Customer part of GE?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE__c;
                  msg+='\n\n'+'Is the Customer part of GE Oil & Gas?: '+erp.GE_OG_ERP_Is_the_Customer_part_of_GE_OG__c;
                 }
             
             
              mail.setReplyTo('erp_users_input@'+eAdd.EmailDomainName);
              mail.setToAddresses(toAddresses);
              mail.setBccSender(false);
              mail.setSenderDisplayName('ERP Finance User Support'); 
              mail.setSubject('Finance User Input for:'+erp.name);
              mail.setUseSignature(false);
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
              
              erp.GE_OG_Fin_Outbound_Time__c=String.valueOf(DateTime.now());
              erp.GE_OG_Fin_Inbound_Time__c='';
              erp.GE_OG_Finance_Cycle_Time__c=null;
              erp.GE_OG_ERP_Finance_Input_Pending__c=true;
              update erp;
          }
          }
         }
         
          if((email.subject).contains('ERP') && (email.subject).contains('Finance')){
              
              List<String> finContent=email.plainTextBody.split('\n');
              if(finContent.size()>0 && erp.GE_OG_Finance_Cycle_Time__c==null){
              String fin1,fin2,fin3,fin4;
              
              for(String str:finContent){
                  if(str.contains('1. Accept terms from COE?(Yes/No):') && !str.contains('1. Accept terms from COE?(Yes/No):XXXXXXX')){
                      erp.GE_OG_ERP_Accept_terms_from_COE__c=str.substringAfter('1. Accept terms from COE?(Yes/No):').trim();
                      fin1=str.substringAfter('1. Accept terms from COE?(Yes/No):').trim();
                  }
                  if(str.contains('2. Quote/Sold To - ERP Customer# T&Cs:') && !str.contains('2. Quote/Sold To - ERP Customer# T&Cs:XXXXXXX')){
                      erp.GE_OG_ERP_Quote_To_SAP_TC__c=str.substringAfter('2. Quote/Sold To - ERP Customer# T&Cs:');
                      fin2=str.substringAfter('2. Quote/Sold To - ERP Customer# T&Cs:');
                  }
                  if(str.contains('3. Bill To - ERP Customer# T&Cs:') && !str.contains('3. Bill To - ERP Customer# T&Cs:XXXXXXX')){
                      erp.GE_OG_ERP_Bill_To_SAP_TC__c=str.substringAfter('3. Bill To - ERP Customer# T&Cs:');
                      fin3=str.substringAfter('3. Bill To - ERP Customer# T&Cs:');
                  }
                  if(str.contains('4. Ship To - ERP Customer# T&Cs:') && !str.contains('4. Ship To - ERP Customer# T&Cs:XXXXXXX')){
                      erp.GE_OG_ERP_Ship_To_SAP_TC__c=str.substringAfter('4. Ship To - ERP Customer# T&Cs:');
                      fin4=str.substringAfter('4. Ship To - ERP Customer# T&Cs:');
                  }
              }
              
              update erp;
              
              if((!String.isBlank(fin2) || !String.isBlank(fin3) || !String.isBlank(fin4)) && !String.isBlank(fin1)){
              Datetime startDate = DateTime.valueOf(erp.GE_OG_Fin_Outbound_Time__c);// Start date
              Datetime endDate = DateTime.now();//End Date
              

              String enddateformat = endDate.formatGMT('yyyy-MM-dd HH:mm:ss');
              erp.GE_OG_Fin_Inbound_Time__c=enddateformat;
              
              Datetime lastdate = DateTime.valueOf(erp.GE_OG_ERP_Inbound_Timestamp__c); //enddate1
              
              Decimal intDays = lastdate.day()-startDate.day();
              Decimal intHours= lastdate.hour()-startDate.hour();
              Decimal intMins = lastdate.minute()-startDate.minute();  
              Decimal cycleTime=intDays*24 + intHours + intMins/60;
              
              erp.GE_OG_Finance_Cycle_Time__c=cycleTime;
              //erp.GE_OG_Fin_Inbound_Time__c=String.valueOf(DateTime.now());
              erp.GE_OG_ERP_Finance_Input_Pending__c=false;
              
              update erp;
              }
              }
          }
          result.success=true;
          return result;
      }
  }