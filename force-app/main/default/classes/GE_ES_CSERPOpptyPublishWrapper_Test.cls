/*
=====================================
Name       :GE_ES_CSERPOpptyPublishWrapper_Test
Author     : Sneha Joshi
Created On : 19th August 2011
Purpose    : To calculate code coverage for GE_ES_CSERPOpptyPublishWrapper
=====================================
*/
@isTest
private class  GE_ES_CSERPOpptyPublishWrapper_Test  {
  /*  static testMethod void GE_ES_CSERPOpptyPublishWrapper(){
            IntegrationExecution IntegrationExecutionObj = new IntegrationExecution('PW');
            IntegrationExecutionObj.IsOrgName = true;
            //Retrieve RecordType Id for 'PGS Long Term'    
            RecordType CRecType = [Select Id From RecordType where Name ='PGS Long Term'];
               
            //Insert Account
            Account acc = new Account(name='000 HOUSTO');
            acc.GE_HQ_Request_Status__c = 'CMF Approved';
            insert acc;
            
            //Insert End User
            Account RecEnUsr = new Account(name='000 HOUSTO');
            insert RecEnUsr;
            
            //Sales Region Record
            GE_ES_Sales_Region__c SR = new GE_ES_Sales_Region__c(name='Latin America',GE_ES_P_L__c='PW');
            insert SR;
            GE_ES_Sales_Region__c recSR  = [select id,name from GE_ES_Sales_Region__c where id=:SR.id];
                      
            //Insert Opportunity         
            Opportunity opp = new Opportunity();
            opp.RecordTypeId = CRecType.Id;
            opp.GE_HQ_Business_Tier1__c='Energy Management (EM)';
            opp.name='TestOppty';
            opp.CurrencyIsoCode = 'USD';
            opp.AccountId = acc.Id;
            opp.GE_ES_Customer_Type__c = 'EPC';
            opp.GE_ES_NRE_Site__c = 'Yes';
            opp.Probability = 25;
            opp.GE_ES_Ship_To__c=acc.id;
            opp.StageName='Prospect';
            //opp.GE_ES_Primary_Reason__c = '';
            opp.GE_ES_Disposition_Reason__c = 'Sole Source';
            opp.CloseDate=Date.today();
            opp.End_User__c=recEnUsr.id;
            opp.Sales_Region__c = recSR.Id;
            opp.GE_ES_Bid_Due_Date__c = Date.Today();
           // opp.GE_PW_Sales_Region__c = 'India';          
            opp.GE_ES_R_Status__c = 'R3 Queue'; 
            opp.GE_PW_Expected_Delivery_Date__c = Date.Today();
            opp.Legacy_Id__c  = 'A-124';                   
            insert opp; 
            opp.GE_ES_R_Status__c='R3 Complete';          
            
            Set<Id> OppId = new Set<Id>();
            OppId.add(opp.Id);
       
            PriceBookEntry[] listPriceBook=[select id , name from Pricebookentry where CurrencyIsoCode='USD' and isactive=true limit 1];
            
            //intializing the line item     
            OpportunityLineItem OLI =new OpportunityLineItem();
            OLI.opportunityid=opp.Id;
            OLI.GE_PW_Sales_Price_WS__c = 555.0;        
            OLI.PRICEBOOKENTRYID=listPriceBook[0].id;        
            OLI.Quantity=2;        
            OLI.UNITPRICE=30;   
            OLI.Stage__c = 'Prospect';  
            OLI.Reason__c = 'Sole Source'; 
            OLI.GE_PW_Contract_Duration__c = 2;   
            OLI.Legacy_Id__c = 'A-12324';            
            insert OLI;
      
            GE_ES_CSERPOpptyPublishWrapper.CSERPReq(OppId);  
        }
        
        static testMethod void GE_ES_CSERPOpptyPublishWrapper1(){
            //Retrieve RecordType Id for 'PGS Long Term'    
            RecordType CRecType = [Select Id From RecordType where Name ='PGS Long Term'];
               
            //Insert Account
            Account acc = new Account(name='000 HOUSTO');
            acc.GE_HQ_Request_Status__c = 'CMF Approved';
            insert acc;
            
            //Insert End User
            Account RecEnUsr = new Account(name='000 HOUSTO');
            insert RecEnUsr;
            
            //Sales Region Record
            GE_ES_Sales_Region__c SR = new GE_ES_Sales_Region__c(name='Latin America',GE_ES_P_L__c='PW');
            insert SR;
            GE_ES_Sales_Region__c recSR  = [select id,name from GE_ES_Sales_Region__c where id=:SR.id];
                      
            //Insert Opportunity         
            Opportunity opp = new Opportunity();
            opp.RecordTypeId = CRecType.Id;
            opp.name='TestOppty';
            opp.CurrencyIsoCode = 'USD';
            opp.AccountId = acc.Id;
            opp.GE_ES_Customer_Type__c = 'EPC';
            opp.GE_ES_NRE_Site__c = 'Yes';
            opp.Probability = 25;
            opp.GE_ES_Ship_To__c=acc.id;
            opp.StageName='Prospect';
            //opp.GE_ES_Primary_Reason__c = '';
            opp.GE_ES_Disposition_Reason__c = 'Sole Source';
            opp.CloseDate=Date.today();
            opp.End_User__c=recEnUsr.id;
            opp.Sales_Region__c = recSR.Id;
            opp.GE_ES_Bid_Due_Date__c = Date.Today();
           // opp.GE_PW_Sales_Region__c = 'India';          
            opp.GE_ES_R_Status__c = 'R0'; 
            opp.GE_PW_Expected_Delivery_Date__c = Date.Today();
            opp.Legacy_Id__c  = 'A-124';       
            insert opp;         
      
            Set<Id> OppId = new Set<Id>();
            OppId.add(opp.Id);           
      
            PriceBookEntry[] listPriceBook=[select id , name from Pricebookentry where CurrencyIsoCode='USD' and isactive=true limit 1];
            
            //intializing the line item     
            OpportunityLineItem OLI =new OpportunityLineItem();
            OLI.opportunityid=opp.Id;
            OLI.GE_PW_Sales_Price_WS__c = 555.0;        
            OLI.PRICEBOOKENTRYID=listPriceBook[0].id;        
            OLI.Quantity=2;        
            OLI.UNITPRICE=30;   
            OLI.Stage__c = 'Prospect';  
            OLI.Reason__c = 'Sole Source'; 
            OLI.GE_PW_Contract_Duration__c = 2;   
            OLI.Legacy_Id__c = '12324';            
            insert OLI; 
            
        GE_OG_ES_OpptyPublish.GE_SFDC_Opportunity_Source_WebServices_publishOpportunity_WSD_Port  objGEOppSer= new GE_OG_ES_OpptyPublish.GE_SFDC_Opportunity_Source_WebServices_publishOpportunity_WSD_Port();
        GE_OG_ES_OpptyPublish.OpportunityDetailsRequest OpptyRequest = new GE_OG_ES_OpptyPublish.OpportunityDetailsRequest();
        GE_OG_ES_OpptyPublish.OpportunityDetailsResponse objResponse = new GE_OG_ES_OpptyPublish.OpportunityDetailsResponse();              
        GE_OG_ES_OpptyPublish.TASK_HEADER OppTsk = new GE_OG_ES_OpptyPublish.TASK_HEADER();
        GE_OG_ES_OpptyPublish.ITEM_DETAILS ItmDtls = new GE_OG_ES_OpptyPublish.ITEM_DETAILS();
        GE_OG_ES_OpptyPublish.OFFERING Off = new GE_OG_ES_OpptyPublish.OFFERING();
        GE_OG_ES_OpptyPublish.OPPORTUNITY_SALES_TEAM Oppsalesteam = new GE_OG_ES_OpptyPublish.OPPORTUNITY_SALES_TEAM();        
        GE_OG_ES_OpptyPublish.KEY_PLAYER keyplayer = new GE_OG_ES_OpptyPublish.KEY_PLAYER();
        GE_OG_ES_OpptyPublish.OPPORTUNITY_INFO Oppinfo = new GE_OG_ES_OpptyPublish.OPPORTUNITY_INFO();
        GE_OG_ES_OpptyPublish.COMPETITOR comp = new GE_OG_ES_OpptyPublish.COMPETITOR();
        GE_OG_ES_OpptyPublish.ArrayOfLEADS Arrleads = new GE_OG_ES_OpptyPublish.ArrayOfLEADS();
        GE_OG_ES_OpptyPublish.PROJECT proj = new GE_OG_ES_OpptyPublish.PROJECT();
        GE_OG_ES_OpptyPublish.LEADS lead = new GE_OG_ES_OpptyPublish.LEADS();
        GE_OG_ES_OpptyPublish.ArrayOfOFFERING arryofOff = new GE_OG_ES_OpptyPublish.ArrayOfOFFERING();
        GE_OG_ES_OpptyPublish.ArrayOfCOMPETITOR arryoffcomp = new GE_OG_ES_OpptyPublish.ArrayOfCOMPETITOR();
        GE_OG_ES_OpptyPublish.publishOpportunityResponse pubOppRes = new GE_OG_ES_OpptyPublish.publishOpportunityResponse();
        GE_OG_ES_OpptyPublish.ArrayOfOPPORTUNITY_SALES_TEAM arrOppSalesteam = new GE_OG_ES_OpptyPublish.ArrayOfOPPORTUNITY_SALES_TEAM();
        GE_OG_ES_OpptyPublish.OPPORTUNITY_DETAIL OppDetial = new GE_OG_ES_OpptyPublish.OPPORTUNITY_DETAIL();
        GE_OG_ES_OpptyPublish.ArrayOfKEY_PLAYER arrofkeyplayer = new GE_OG_ES_OpptyPublish.ArrayOfKEY_PLAYER();
        List<GE_OG_ES_OpptyPublish.ITEM_DETAILS> ArrayOfITEMDETAILSItem = new List<GE_OG_ES_OpptyPublish.ITEM_DETAILS>();
        GE_OG_ES_OpptyPublish.ArrayOfITEM_DETAILS ArrItmDtls = new GE_OG_ES_OpptyPublish.ArrayOfITEM_DETAILS();
       
       GE_ES_CSERPOpptyPublishWrapper.CSERPReq(OppId);  
        }
      */  
}