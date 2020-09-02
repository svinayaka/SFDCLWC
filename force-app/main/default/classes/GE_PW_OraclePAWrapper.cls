/*
Class Name: GE_PW_OraclePAWrapper
Used For : 
Purpose/Overview : 
Functional Area : 
Author: Sneha Joshi
Created Date: 19th Oct 2011
Test Class Name : GE_PW_OraclePAWrapper_Test 
Change History    : 
S No.    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
1        : 02/29/2012    : Lakshman Bugude    : SubmitToOracle() : Changes for CR No. C-1556, Changed product name to offering name and offering cost to sales price
         : 05/10/2012    : Sneha Joshi        : Changes for ReOrg S-07386
*/

public class GE_PW_OraclePAWrapper{
    
 /*   public Opportunity opportunity {set; get;}

    public GE_OG_ES_OpptyPublish.GE_SFDC_Opportunity_Source_WebServices_publishOpportunity_WSD_Port objGEOppSer= new GE_OG_ES_OpptyPublish.GE_SFDC_Opportunity_Source_WebServices_publishOpportunity_WSD_Port();
    public GE_OG_ES_OpptyPublish.OpportunityDetailsRequest opportunityRequest = new   GE_OG_ES_OpptyPublish.OpportunityDetailsRequest();
    public static Boolean isFromTest {get;set;}
    public list<string> msgBody = new list<string>() ;   
    public string note = '';
    public List<OpportunityLineItem> OpptyLineId = new List<OpportunityLineItem>(); 
        
    
    public GE_PW_OraclePAWrapper(ApexPages.StandardController controller) {
        opportunity = (Opportunity)controller.getRecord();
        Map<string,string> inputHeader=new Map<string,string>();
        inputHeader.put('Authorization',GE_HQ_SingleOrgEnvConfig.OG_getHTTPAuthorization());        
        objGEOppSer.inputHttpHeaders_x=inputHeader;
        objGEOppSer.endpoint_x=GE_HQ_SingleOrgEnvConfig.OG_getEndpointBase();
        objGEOppSer.timeout_x=GE_HQ_SingleOrgEnvConfig.OG_getWebServiceTimeout();   
        isFromTest = false;
        
    }
    
    
    public PageReference SubmitToOracle() {
    
          
        opportunity = [select Id,Account.GE_HQ_DUNS_Number__c,Account.Name,Probability,GE_PW_NUC_Lgl_Sel__c,GE_Ext_Opty_Id__c,Legacy_Id__c,GE_PW_Overall_Probability__c,CloseDate,Name,
                       GE_PW_TML_Icd_Rup__c,owner.GE_HQ_SSO_ID__c,GE_PW_Go__c,GE_PW_Win__c from Opportunity where ID=:opportunity.Id];               
        
        
        List<OpportunityLineItem> lstProd = [select Id,GE_PWNU_PROP_TYPE__c,Legacy_Id__c,GE_PWNU_DEF_RT_SCHD__c,GE_OG_TM_Offering_US_Amount__c,
                                            GE_OG_TM_Base_Offer__c,GE_PWNUC_Product_Id__c,GE_PW_NUC_WSD__c,GE_OG_Expected_Delivery_Date__c,
                                            UnitPrice,GE_PW_NUC_ON__c,GE_PWNUC_Offering_Code__c,GE_PW_NUC_Oracle__c from OpportunityLineItem where OpportunityId=:opportunity.id];

     
        opportunityRequest.OPERATION='I';
        opportunityRequest.SOURCE_SYSTEM='CMS';
        opportunityRequest.TARGET_SYSTEM='Nuclear';
        opportunityRequest.PUBLISH_BUSINESS='POWER GEN'; 
        
              
        GE_OG_ES_OpptyPublish.OPPORTUNITY_INFO opportunityInfo = new GE_OG_ES_OpptyPublish.OPPORTUNITY_INFO();
        if(opportunity.Legacy_Id__c == null)
            opportunityInfo.OPPORTUNITY_SIEBEL_ROW_ID = opportunity.GE_Ext_Opty_Id__c;
        else
            opportunityInfo.OPPORTUNITY_SIEBEL_ROW_ID = opportunity.Legacy_Id__c;
        opportunityInfo.PERCENT_OVERALL_PROBABILITY = opportunity.Probability;
        opportunityInfo.EXPECTED_ORDER_DATE = opportunity.CloseDate;
        opportunityInfo.PERCENT_GO = opportunity.GE_PW_Go__c;
        opportunityInfo.PERCENT_WIN = opportunity.GE_PW_Win__c;
        opportunityInfo.BUYER_DUNS_NAME = opportunity.Account.Name;
        opportunityInfo.BUYER_DUNS_NUMBER = opportunity.Account.GE_HQ_DUNS_Number__c;
        opportunityInfo.INCLUDED_FOR_ROLL_UP_FLAG = opportunity.GE_PW_TML_Icd_Rup__c;
        opportunityInfo.LEGAL_SELLING_ENTITY_BRANCH = opportunity.GE_PW_NUC_Lgl_Sel__c;
        opportunityInfo.SALES_TEAM_PRIMARY_LOGIN = opportunity.owner.GE_HQ_SSO_ID__c;
       
        if([select count() from GE_PW_Risk_Module__c where GE_PW_Opportunity__c =:opportunity.Id] > 0){
              GE_PW_Risk_Module__c rskModule = [select id from GE_PW_Risk_Module__c where GE_PW_Opportunity__c =:opportunity.Id order by CreatedDate desc limit 1];
            
        } else {
              opportunityInfo.PRICING_METHOD = '';
              opportunityInfo.DELIVERY_TERMS = '';
              opportunityInfo.TITLE_TRANSFER_TERMS = '';
        }
        
               
        GE_OG_ES_OpptyPublish.ArrayOfOFFERING arrOffering=new GE_OG_ES_OpptyPublish.ArrayOfOFFERING();
        GE_OG_ES_OpptyPublish.OFFERING objOffering=new GE_OG_ES_OpptyPublish.OFFERING();
        List<GE_OG_ES_OpptyPublish.OFFERING> ArrayOfOFFERINGItem = new List<GE_OG_ES_OpptyPublish.OFFERING>();
        if(lstProd!=null && !lstProd.IsEmpty()){
            for(OpportunityLineItem oli:lstProd){
                objOffering = new GE_OG_ES_OpptyPublish.OFFERING();
                objOffering.EXPECTED_DELIVERY_DATE = oli.GE_OG_Expected_Delivery_Date__c;
                system.debug('GE_OG_Expected_Delivery_Date__c======='+oli.GE_OG_Expected_Delivery_Date__c);
                system.debug('EXPECTED_DELIVERY_DATE====='+objOffering.EXPECTED_DELIVERY_DATE);
                if(oli.Legacy_Id__c == null)
                    objOffering.OFFERING_SIEBEL_ROW_ID= oli.GE_PWNUC_Product_Id__c;
                else
                    objOffering.OFFERING_SIEBEL_ROW_ID= oli.Legacy_Id__c;
                objOffering.PROPOSAL_TYPE_GENE = oli.GE_PWNU_PROP_TYPE__c;
                objOffering.OFFERING_TOTAL_AMOUNT_DOLLAR = oli.UnitPrice; //C-1556
                objOffering.WORK_START_DATE= oli.GE_PW_NUC_WSD__c;
                
                objOffering.BASE_OFFER = oli.GE_OG_TM_Base_Offer__c; 
                objOffering.OFFERING = oli.GE_PWNUC_Offering_Code__c;
                objOffering.PROJECT_DESC = oli.GE_PW_NUC_ON__c; //C-1556
                objOffering.DEFAULT_RATE_SCHEDULE = oli.GE_PWNU_DEF_RT_SCHD__c;                        
                ArrayOfOFFERINGItem.add(objOffering);
            }
            
            arrOffering.ArrayOfOFFERINGItem = ArrayOfOFFERINGItem;                   
            opportunityInfo.OFFERING = arrOffering;
        }
        
         opportunityRequest.OPPORTUNITY_INFO = opportunityInfo;
           GE_OG_ES_OpptyPublish.OpportunityDetailsResponse opportunitysResponse = new GE_OG_ES_OpptyPublish.OpportunityDetailsResponse();        
        if(!isFromTest)
            opportunitysResponse=objGEOppSer.publishOpportunity(opportunityRequest);
        else    
            opportunitysResponse.STATUS = 'SUCCESS';
              
            System.debug('====opportunitysResponse====='+opportunitysResponse);
            System.debug('====OPPORTUNITY STATUS====='+opportunitysResponse.STATUS);
            System.debug('====OPPORTUNITY ERROR_DESCRIPTION====='+opportunitysResponse.ERROR_DESCRIPTION);
           
            
               if(opportunitysResponse.STATUS.toUpperCase()=='SUCCESS'){
                   for(OpportunityLineItem oli:lstProd){
                       oli.GE_PW_NUC_Oracle__c = true;
                       OpptyLineId.add(oli);                       
                   }
                   update OpptyLineId;
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Opportunity successfully published. Please press below button to go back to opportunity detail screen.'));
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error Occured'));
            }
            
         GE_HQ_Integration_Activity__c objIntActivity = new GE_HQ_Integration_Activity__c();
         objIntActivity.GE_HQ_Object__c = 'Opportunity';
         objIntActivity.GE_HQ_Opportunity__c = opportunity.Id;
         objIntActivity.GE_HQ_Source_Sys__c = 'SFDC';
         objIntActivity.GE_HQ_Target_Sys__c = 'Nuclear';
         objIntActivity.GE_HQ_Status__c = opportunitysResponse.STATUS;
         objIntActivity.GE_HQ_Status_Dtl__c = opportunitysResponse.ERROR_DESCRIPTION;            
         objIntActivity.GE_HQ_Submit_Dt__c = System.Now();
         objIntActivity.GE_HQ_Submit_By__c = UserInfo.getUserID();
         objIntActivity.GE_HQ_Sbt_Rcrd_ID__c = opportunity.Id;
         objIntActivity.GE_HQ_Record_Desc__c = 'Integration submitted via Button click by Nuclear user sending Opportunity detail to the Oracle PA system';
         insert objIntActivity;
         
            return null; 
    }
    
    public void validate(){
        IntegrationExecution IntegrationExecutionObj = new IntegrationExecution('PW');
        if(IntegrationExecutionObj.IsOrgName == true){
            List<OpportunityLineItem> lstLineItem = [select Id,PricebookEntry.Product2.Name,GE_OG_Expected_Delivery_Date__c,GE_PWNU_DEF_RT_SCHD__c,
                                                    GE_PW_NUC_WSD__c,GE_PWNU_PROP_TYPE__c from OpportunityLineItem where OpportunityId=:opportunity.Id];
             
             for(OpportunityLineItem LineItm : lstLineItem){
                 if(LineItm.GE_OG_Expected_Delivery_Date__c == null){
                        msgBody.add('--> Expected Delivery Date must be entered for Opportunity Product'+ '-' + LineItm.PricebookEntry.Product2.Name);
                        note = 'Please note the following while submitting to Oracle';
                 } 
                 if(LineItm.GE_PW_NUC_WSD__c == null){
                        msgBody.add('-->Work Start Date must be entered for Opportunity Product'+ '-' + LineItm.PricebookEntry.Product2.Name);
                        note = 'Please note the following while submitting to Oracle';
                 }
                 if(LineItm.GE_PWNU_PROP_TYPE__c == null){
                        msgBody.add('-->Proposal Type must be entered for Opportunity Product'+ '-' + LineItm.PricebookEntry.Product2.Name);
                        note = 'Please note the following while submitting to Oracle';
                 }
                 if(LineItm.GE_PWNU_DEF_RT_SCHD__c == null){
                        msgBody.add('-->Default Rate Schedule must be entered for Opportunity Product'+ '-' + LineItm.PricebookEntry.Product2.Name);
                        note = 'Please note the following while submitting to Oracle';
                 }
             }
             if(note=='')    SubmitToOracle();
         }
         else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Opportunity of PW can not be submitted in ' + Label.GE_Organization_Name + ' Instance'));
            IntegrationActivity intActivity = new IntegrationActivity();
            intActivity.setStrObject('Opportunity');
            intActivity.setStrSource('SFDC');
            intActivity.setStrTarget('Nuclear');
            intActivity.setStrStatus('Failure');
            intActivity.setStrStatusDetail('Opportunity of PW can not be submitted in ' + Label.GE_Organization_Name + ' Instance');
            intActivity.setStrSubmittedRecordId(opportunity.id);
            intActivity.setStrRecordDesc('Integration submitted via Button click by Nuclear user sending Opportunity detail to the Oracle PA system');
            intActivity.insertIntegrationActivity();         
         }
    
    }
    public string getnote(){    return note; }
    public List<string> getmessages(){    return msgBody; }
    
      @Future(callout=true)
      public Static void SubmitToOracleTrg(set<Id> oppId){ 
          IntegrationExecution IntegrationExecutionObj = new IntegrationExecution('PW');
          if(IntegrationExecutionObj.IsOrgName == true){
                GE_OG_ES_OpptyPublish.GE_SFDC_Opportunity_Source_WebServices_publishOpportunity_WSD_Port objGEOppSer= new GE_OG_ES_OpptyPublish.GE_SFDC_Opportunity_Source_WebServices_publishOpportunity_WSD_Port();
                GE_OG_ES_OpptyPublish.OpportunityDetailsRequest opportunityRequest = new   GE_OG_ES_OpptyPublish.OpportunityDetailsRequest();       
                Map<string,string> inputHeader=new Map<string,string>();
                Map<Id,Opportunity> opptyLineMap;
              inputHeader.put('Authorization',GE_HQ_SingleOrgEnvConfig.OG_getHTTPAuthorization());        
                objGEOppSer.inputHttpHeaders_x=inputHeader;
                objGEOppSer.endpoint_x=GE_HQ_SingleOrgEnvConfig.OG_getEndpointBase();
                objGEOppSer.timeout_x=GE_HQ_SingleOrgEnvConfig.OG_getWebServiceTimeout();   
                opportunityRequest.SOURCE_SYSTEM='SFDC';
                opportunityRequest.OPERATION='I';
               
                opportunityRequest.TARGET_SYSTEM='Nuclear';
                opportunityRequest.PUBLISH_BUSINESS='POWER GEN';
                
                
                if(oppId.size() > 0){
               opptyLineMap = new Map<Id,Opportunity>([select Id,owner.GE_HQ_SSO_ID__c,Account.Name,GE_Ext_Opty_Id__c,Legacy_Id__c,Account.GE_HQ_DUNS_Number__c,Name,GE_PW_NUC_Lgl_Sel__c,GE_PW_TML_Icd_Rup__c,                                    
                                        (select Id,GE_PW_NUC_ON__c,GE_OG_TM_Base_Offer__c,GE_PWNUC_Product_Id__c,GE_PWNUC_Offering_Code__c,Legacy_Id__c,GE_PWNU_DEF_RT_SCHD__c from OpportunityLineItems) from Opportunity where Id in :oppId]);
                                      
    
                 system.debug('opptyLineMap'+opptyLineMap);
                
                for(Opportunity opp : opptyLineMap.Values()){ 
                    Opportunity oppty;
                    oppty = opptyLineMap.get(opp.Id);    
                        
                    GE_OG_ES_OpptyPublish.OPPORTUNITY_INFO opportunityInfo = new GE_OG_ES_OpptyPublish.OPPORTUNITY_INFO();
                    if(opportunity.Legacy_Id__c == null)
                        opportunityInfo.OPPORTUNITY_SIEBEL_ROW_ID = oppty.GE_Ext_Opty_Id__c;
                    else
                        opportunityInfo.OPPORTUNITY_SIEBEL_ROW_ID = oppty.Legacy_Id__c;
                    opportunityInfo.BUYER_DUNS_NAME = oppty.Account.Name;
                    opportunityInfo.BUYER_DUNS_NUMBER = oppty.Account.GE_HQ_DUNS_Number__c;
                    opportunityInfo.INCLUDED_FOR_ROLL_UP_FLAG = oppty.GE_PW_TML_Icd_Rup__c;
                    opportunityInfo.LEGAL_SELLING_ENTITY_BRANCH = oppty.GE_PW_NUC_Lgl_Sel__c;
                    opportunityInfo.SALES_TEAM_PRIMARY_LOGIN = oppty.owner.GE_HQ_SSO_ID__c;
                    
                    if([select count() from GE_PW_Risk_Module__c where GE_PW_Opportunity__c In :oppId] > 0){
              GE_PW_Risk_Module__c rskModule = [select id from GE_PW_Risk_Module__c where GE_PW_Opportunity__c =:oppId order by CreatedDate desc limit 1];
             
        } else {
              opportunityInfo.PRICING_METHOD = '';
              opportunityInfo.DELIVERY_TERMS = '';
              opportunityInfo.TITLE_TRANSFER_TERMS = '';
        }
                 
                    
                    system.debug('===PRICING_METHOD==='+opportunityInfo.PRICING_METHOD);
                    system.debug('===opportunityInfo.DELIVERY_TERMS==='+opportunityInfo.DELIVERY_TERMS);
                    system.debug('===opportunityInfo.TITLE_TRANSFER_TERMS==='+opportunityInfo.TITLE_TRANSFER_TERMS);
                    
                    //OFFERING          
                    GE_OG_ES_OpptyPublish.ArrayOfOFFERING arrOffering=new GE_OG_ES_OpptyPublish.ArrayOfOFFERING();
                    GE_OG_ES_OpptyPublish.OFFERING objOffering=new GE_OG_ES_OpptyPublish.OFFERING();
                    List<GE_OG_ES_OpptyPublish.OFFERING> ArrayOfOFFERINGItem = new List<GE_OG_ES_OpptyPublish.OFFERING>();
                  
                        for(OpportunityLineItem oli:opp.opportunitylineitems){
                            objOffering = new GE_OG_ES_OpptyPublish.OFFERING();
                            if(oli.Legacy_Id__c == null)
                                objOffering.OFFERING_SIEBEL_ROW_ID= oli.GE_PWNUC_Product_Id__c;
                            else
                                objOffering.OFFERING_SIEBEL_ROW_ID= oli.Legacy_Id__c;
                            objOffering.OFFERING = oli.GE_PWNUC_Offering_Code__c;
                            objOffering.PROJECT_DESC = oli.GE_PW_NUC_ON__c; //C-1556
                            objOffering.DEFAULT_RATE_SCHEDULE = oli.GE_PWNU_DEF_RT_SCHD__c;    
                            objOffering.BASE_OFFER = oli.GE_OG_TM_Base_Offer__c;                                                               
                            ArrayOfOFFERINGItem.add(objOffering);
                        }
                        
                        arrOffering.ArrayOfOFFERINGItem = ArrayOfOFFERINGItem;                   
                        opportunityInfo.OFFERING = arrOffering;
                    
                    
                     opportunityRequest.OPPORTUNITY_INFO = opportunityInfo;
                     GE_OG_ES_OpptyPublish.OpportunityDetailsResponse opportunitysResponse = new GE_OG_ES_OpptyPublish.OpportunityDetailsResponse();        
                     if(!isFromTest)
                         opportunitysResponse=objGEOppSer.publishOpportunity(opportunityRequest);
                     
                     GE_HQ_Integration_Activity__c objIntActivity = new GE_HQ_Integration_Activity__c();
                     objIntActivity.GE_HQ_Object__c = 'Opportunity';
                     objIntActivity.GE_HQ_Opportunity__c = oppty.Id;
                     objIntActivity.GE_HQ_Source_Sys__c = 'SFDC';
                     objIntActivity.GE_HQ_Target_Sys__c = 'Nuclear';
                     objIntActivity.GE_HQ_Status__c = opportunitysResponse.STATUS;
                     objIntActivity.GE_HQ_Status_Dtl__c = opportunitysResponse.ERROR_DESCRIPTION;            
                     objIntActivity.GE_HQ_Submit_Dt__c = System.Now();
                     objIntActivity.GE_HQ_Submit_By__c = UserInfo.getUserID();
                     objIntActivity.GE_HQ_Sbt_Rcrd_ID__c = oppty.Id;
                     objIntActivity.GE_HQ_Record_Desc__c = 'Integration submitted via Trigger by Nuclear user sending Opportunity detail to the Oracle PA system';
                     insert objIntActivity;
                 }
                                
            }
        }
         else{
            IntegrationActivity intActivity = new IntegrationActivity();
            intActivity.setStrObject('Opportunity');
            intActivity.setStrSource('SFDC');
            intActivity.setStrTarget('Nuclear');
            intActivity.setStrStatus('Failure');
            intActivity.setStrStatusDetail('Opportunity of PW can not be submitted in ' + Label.GE_Organization_Name + ' Instance');
            //intActivity.setStrSubmittedRecordId(opptyId);
            intActivity.setStrRecordDesc('Integration submitted via Button click by Nuclear user sending Opportunity detail to the Oracle PA system');
            intActivity.insertIntegrationActivity();
         }
    }
      
     
    
    public PageReference OrigOppPage()
     {
            pageReference pgRef;
            
            pgRef = new pageReference('/'+opportunity.id);
            return pgRef;
     }*/
     static testMethod void validateHelloWorld() {
       GE_PW_OraclePAWrapper oGE_PW_OraclePAWrapper = new GE_PW_OraclePAWrapper();
    }
}