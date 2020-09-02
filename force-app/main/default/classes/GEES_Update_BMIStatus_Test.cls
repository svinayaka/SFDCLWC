/*
Class Name : GEES_Update_BMIStatus_Test
Used Where ? : 
Purpose/Overview : Test class for the controller GEES_Update_BMIStatus
Functional Area : Opportunity Management
Author:  
Created Date: 
Test Class Name : 

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
09/08/2011    : Prasad Yadala      :                               : Modified test methods to clear the Custom Validation exceptions
*/

@isTest(seeAllData=true)
private class GEES_Update_BMIStatus_Test{
 /*
static testMethod void GEES_Update_BMIStatus_Test() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Prospect', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   opp.GE_ES_P_5_0_App__c = false; 
   opp.GE_DP_Price_Apr_Stat__c = 'Approved';
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';

   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
//   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Abandoned';
   oppWithQuote.GE_ES_P_5_0_App__c = true;  
   oppWithQuote.GE_DP_Price_Apr_Stat__c = 'Approved';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   update oppWithQuote;
    
    GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;

   Opportunity opp2= [Select Id, StageName from Opportunity where Id=:OppID];
   opp2.Expected_Delivery_Date__c = date.newInstance(2010,10,11);
   opp2.StageName = 'Cancelled';
   opp2.GE_ES_Disposition_Reason__c='ROI';
   opp2.Expected_Delivery_Date__c = system.today();
   opp2.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   opp2.GE_ES_Disposition_Reason__c = 'Cycle';
   opp2.GE_ES_R_Status__c='R2 Complete';
   opp2.GE_ES_L0L1_Risk_Process_Only__c=TRUE;
   opp2.GE_ES_Funding_Source__c='Commercial Bank';
   opp2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //opp2.GE_ES_GE_Bid_Legal_Entity_Name__c=accID;

   //update opp2;


/////////
    
   objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = OppID;
   lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   insert objComp;            

   
   }
 


   
   
   
   static testMethod void GEES_Update_BMIStatus_Test2() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Prospect', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';

   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
//   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Closed Won';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   //update oppWithQuote;
    
    GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;

   Opportunity opp2= [Select Id, StageName from Opportunity where Id=:OppID];
   opp2.Expected_Delivery_Date__c = date.newInstance(2010,10,11);
   opp2.StageName = 'Prospect';
   opp2.GE_ES_Disposition_Reason__c='ROI';
   opp2.Expected_Delivery_Date__c = system.today();
   opp2.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   opp2.GE_ES_Disposition_Reason__c = 'Cycle';
   opp2.GE_ES_R_Status__c='R2 Complete';
   opp2.GE_ES_L0L1_Risk_Process_Only__c=TRUE;
   opp2.GE_ES_Funding_Source__c='Commercial Bank';
   opp2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //opp2.GE_ES_GE_Bid_Legal_Entity_Name__c=accID;

   update opp2;

   }
   
    static testMethod void GEES_Update_BMIStatus_Test3() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Prospect', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';

   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
   //   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Prospect';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   oppWithQuote.GE_ES_P_5_0_App__c = true;  
   oppWithQuote.GE_DP_Price_Apr_Stat__c = 'Approved';
   update oppWithQuote;
    
    GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;

   Opportunity opp2= [Select Id, StageName from Opportunity where Id=:OppID];
   opp2.Expected_Delivery_Date__c = date.newInstance(2010,10,11);
   opp2.StageName = 'Duplicate';
   opp2.GE_ES_Disposition_Reason__c='ROI';
   opp2.Expected_Delivery_Date__c = system.today();
   opp2.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   opp2.GE_ES_Disposition_Reason__c = 'Cycle';
   opp2.GE_ES_R_Status__c='R2 Complete';
   opp2.GE_ES_L0L1_Risk_Process_Only__c=TRUE;
   opp2.GE_ES_Funding_Source__c='Commercial Bank';
   opp2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   opp2.GE_ES_P_5_0_App__c = false; 
   opp2.GE_DP_Price_Apr_Stat__c = 'Approved';
   //opp2.GE_ES_GE_Bid_Legal_Entity_Name__c=accID;

   //update opp2;

   }
   
    static testMethod void GEES_Update_BMIStatus_Test4() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Prospect', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';
    opp.GE_ES_P_5_0_App__c = true;    
   opp.GE_DP_Price_Apr_Stat__c = 'Approved';
   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;


   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
   //   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Prospect';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   oppWithQuote.GE_ES_P_5_0_App__c = false;  
   oppWithQuote.GE_DP_Price_Apr_Stat__c = 'Approved';
   update oppWithQuote;
    
  

   }
   
     static testMethod void GEES_Update_BMIStatus_Test5() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_HQ_Business_Tier2__c = 'Measurement & Control (M&C)',GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Prospect', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';
   
   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
   //   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Closed Won';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   oppWithQuote.GE_ES_P_5_0_App__c = true;
   oppWithQuote.GE_DP_Price_Apr_Stat__c = 'Approved';
   update oppWithQuote;
    
  

   }
   
   
   static testMethod void GEES_Update_BMIStatus_Test10() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_HQ_Business_Tier2__c = 'Measurement & Control (M&C)',GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Duplicate', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';
   
   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
   //   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Prospect';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   oppWithQuote.GE_ES_P_5_0_App__c = true;     
   oppWithQuote.GE_DP_Price_Apr_Stat__c = 'Approved';
   update oppWithQuote;
    
  

   }
   
     static testMethod void GEES_Update_BMIStatus_Test6() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_HQ_Business_Tier2__c = 'Measurement & Control (M&C)',GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Duplicate', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';
   
   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
   //   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Cancelled';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   //oppWithQuote.GE_ES_P_5_0_App__c = true;
   update oppWithQuote;
    
  

   }
     static testMethod void GEES_Update_BMIStatus_Test7() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_HQ_Business_Tier2__c = 'Measurement & Control (M&C)',GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Duplicate', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';
   
   opp.AccountID=accID;
   insert opp;
         
   Id OppID =[select Id from Opportunity where name =: 'Sample Opp Test'].id;
   Product2 newProd= new Product2(Name='My test product', CurrencyIsoCode='USD', GE_ES_P_L__c='PS' );
   insert newProd;
    
   //Product2 prod =[select id, name from Product2 where name =:'My test product' Limit 1];
   PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
   String standardPriceBookId = pb2Standard.Id;
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:OppID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
   //   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Closed - Partially Won';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   //oppWithQuote.GE_ES_P_5_0_App__c = true;
   update oppWithQuote;
    
  

   }
   
   static testMethod void GEES_Update_BMIStatus_Test8() {
   List<RecordType> recTypeAcc = [Select ID, Name from RecordType where Name =:'GE Legal Entity' and SObjectType ='Account' Limit 1];
   List<RecordType> recTypeOpp = [Select ID, Name from RecordType where Name =:'MCS' and  SObjectType = 'Opportunity' Limit 1];
   List<RecordType> recTypeCMF = [Select ID, Name from RecordType where Name =:'CMF Approved' and SObjectType ='Account' Limit 1];    
   List<Account> acclst = new List<Account>(); 
   User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
   system.runAs(u){
   
   //Account acc = new Account(Name = 'Sample Acc Test', RecordTypeId = recTypeCMF[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(acc);
   Account acc = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //Account accComp =new Account(Name = 'Sample Acc Competitor Test', RecordTypeId =recTypeAcc[0].Id, GE_ES_Competitor__c = 'Yes', GE_HQ_New_Account_Street__c = 'Sample Street', GE_HQ_New_Account_City__c = 'Sample City', GE_HQ_New_Account_State_Province__c = 'Sample State', GE_HQ_New_Account_Zip_Postal_Code__c = '00000', GE_HQ_New_Account_Country__c = 'UNITED STATES', Phone = '9560102882', GE_HQ_Request_Status__c = 'CMF Approved');
   //acclst.add(accComp);
   Account accComp = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount-EndUser' and  GE_HQ_Request_Status__c = 'CMF Approved' limit 1];   
   //insert acclst;
   
    }
   Id accID = [select id from Account where name = 'TestClassAccount' Limit 1].id;   
   
        GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.ESProductFlag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.COProdFlag = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true;
   Opportunity opp= new Opportunity(Name = 'Sample Opp Test', GE_HQ_Business_Tier1__c = 'Energy Management (EM)', GE_HQ_Business_Tier2__c = 'Measurement & Control (M&C)',GE_ES_Customer_Type__c = 'End user', CloseDate = date.newInstance(2010,10,10), StageName= 'Duplicate', CurrencyIsoCode = 'USD');
   opp.RecordTypeId =recTypeOpp[0].Id;
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_Engineering_Approval__c = 'No';
   opp.GE_ES_On_Site__c = 'No';
   opp.GE_ES_Multi_Year__c = 'No';
   opp.GE_ES_Audit_or_Boycott__c = 'No';
   opp.GE_ES_Export_Credit_or_Free_Trade__c = 'No';
   opp.GE_ES_Governing_Law_Dispute_Resolution__c = 'Yes';
   opp.GE_ES_LDs_15_Contract__c = 'No';
   opp.GE_ES_Deal_Size_Credit_Limit__c = 'Yes';
   opp.GE_ES_Non_Functional_Currency__c = 'No';
   opp.GE_ES_New_Tax_Presence__c = 'No';
   opp.GE_ES_End_User_not_Buyer_or_CE__c = 'Yes';
   opp.GE_ES_NRE__c = 'No';
   opp.GE_ES_US_Gov_or_ARRA__c = 'No';
   opp.GE_ES_Country_Restrictions__c = 'No';
   
   opp.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   opp.GE_ES_Funding_Source__c = 'EXIM';
   opp.GE_ES_R_Status__c='R1 Submitted';
   opp.GE_ES_Standard_Product__c = 'Yes';
   opp.GE_ES_P_5_0_App__c = true;   
   opp.GE_DP_Price_Apr_Stat__c = 'Approved';
   opp.AccountID=accID;
   insert opp;
         
   
   //PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=prod.Id, UnitPrice=99, isActive=true);
   //insert pbe;

   //PricebookEntry pbeEntry = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
   //OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id,OpportunityId=OppID, Quantity=1, TotalPrice=1);
   //insert oli; 

   Opportunity oppWithQuote= [Select Id, StageName from Opportunity where Id=:Opp.ID];
    
   BigMachines__Quote__c bmQuote = new BigMachines__Quote__c();
   bmQuote.BigMachines__Is_Primary__c = TRUE;
   bmQuote.Name = 'Big Machine Quote Name Test';
   bmQuote.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 1: ' + bmQuote.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';

   BigMachines__Quote__c bmQuote2 = new BigMachines__Quote__c();
   bmQuote2.BigMachines__Is_Primary__c = FALSE;
   bmQuote2.Name = 'Big Machine Quote Name Test2';
   bmQuote2.BigMachines__Opportunity__c = oppWithQuote.ID;
   bmQuote.BigMachines__Status__c = 'Approved';
   system.debug ('BMQ Tran Id - 2: ' + bmQuote2.BigMachines__Transaction_Id__c);
   bmQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 02';
   
   List<BigMachines__Quote__c> bmQuoteList = new List<BigMachines__Quote__c>();
   bmQuoteList.add(bmQuote);
   bmQuoteList.add(bmQuote2);
   insert bmQuoteList;

   GE_ES_ITO_Competitor__c objComp = new GE_ES_ITO_Competitor__c();
   objComp.GE_ES_Opportunity__c = oppWithQuote.id;
   //   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'GE ENERGY SERVICES' LIMIT 1];
   List<Account> lstAcc = [SELECT ID from Account WHERE name = 'TestClassAccount' LIMIT 1];
   lstAcc[0].GE_ES_Competitor__c = 'Yes'; 
   update lstAcc[0];
   objComp.GE_ES_Competitor__c = lstAcc[0].id;
   
   BMIIntegrationUtil.blnTestvariable = true;            
   insert objComp; 
    
   GE_ES_Sales_Region__c sReg = new GE_ES_Sales_Region__c(GE_ES_P_L__c= 'ES', Name = 'Test Reg');
   insert sReg; 
   oppWithQuote.stagename = 'Duplicate';
   oppWithQuote.Expected_Delivery_Date__c = system.today();
   oppWithQuote.GE_ES_Last_Allowable_Ship_Date__c = system.today();
   oppWithQuote.GE_ES_R_Status__c='R2 Complete';
   oppWithQuote.GE_ES_Disposition_Reason__c = 'Cycle';
   oppWithQuote.GE_ES_L0L1_Risk_Process_Only__c = TRUE;
   oppWithQuote.GE_ES_Funding_Source__c = 'EXIM';
   //oppWithQuote.GE_ES_GE_Bid_Legal_Entity_Name__c =accID;
   oppWithQuote.GE_ES_Standard_Product__c = 'Yes';
   oppWithQuote.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
   //oppWithQuote.GE_ES_Proposal_Creation_Date__c = true;
   oppWithQuote.GE_ES_Risk_Path__c = 'Express' ;
   oppWithQuote.GE_ES_R2_Completed_Date__c = system.today();
   oppWithQuote.Proposal_Date_Stamp__c = system.today();
   oppWithQuote.Sales_Region__c = sReg.id;
   oppWithQuote.GE_ES_Disposition_Date__c = system.today();
   oppWithQuote.GE_ES_P_5_0_App__c = true;
   oppWithQuote.GE_DP_Price_Apr_Stat__c = 'Approved';
   update oppWithQuote;
   } 
  */

   }