/*
=====================================
Name       : GE_ES_CustomerGalaxyIntegrationWrapper
Author     : SaiKrishna V.
Created On : 14 Sept 2010 
Purpose    : To write the mapping between the SFDC and WebMethod fields and calling the webservice
Test Class : GEESGalaxyCustomerTest

//Number of SOQL queries: 3 out of 100
//Number of query rows: N out of 500, N<10 (insert or update batch size)
//Number of DML statements: 1
//Number of DML rows: 10

Change History-

Changed By:        Date:                    Purpose:
Sneha Joshi        01/06/2012                For R-8332, S-05940
=====================================
*/


public class GE_ES_CustomerGalaxyIntegrationWrapper
{  
    //This method will get the set of AccoutIDs,UserIDs and RegionID from the trigger and call the webservice
    //by setting the corresponding webmethod variables.
    public static Boolean isFromTest = false;
    @Future(callout=true)
    Public static void newAccountRequest(Set<ID> AccountIDs,Set<ID> UserIds,Set<ID> RegionIds)
    {   /*
        IntegrationExecution IntegrationExecutionObj = new IntegrationExecution('PW');
        if(IntegrationExecutionObj.IsOrgName == true){
            List<Account> srcList = [SELECT ID,GE_HQ_DUNS_Number__c,GE_HQ_Request_Status__c,CreatedById,CreatedDate,LastModifiedById,LastModifiedDate,GE_HQ_Region_Tier1__c,GE_ES_Primary_Industry__c from Account where ID in :AccountIDs];
            GE_ES_PublishCustomer.GE_SFDC_RDBCustomer_Source_WebServices_publishCustomer_WSD_Port webclient;
            GE_ES_PublishCustomer.CustomerDetailsResponse  objResponse;          
            GE_ES_PublishCustomer.CustomerDetailsRequest accDetails;
            List<GE_HQ_Integration_Activity__c> lstIntAct = new List<GE_HQ_Integration_Activity__c>();
        
            accDetails= new GE_ES_PublishCustomer.CustomerDetailsRequest();
            webclient = new GE_ES_PublishCustomer.GE_SFDC_RDBCustomer_Source_WebServices_publishCustomer_WSD_Port();
            objResponse=new GE_ES_PublishCustomer.CustomerDetailsResponse();

            Credentials for Web Service (HTTP Header)
            if (GE_HQ_SingleOrgEnvConfig.GACC_useHTTPAuthorization())
            {
              webclient.inputHttpHeaders_x = new Map<string, string>();
              webclient.inputHttpHeaders_x.put('Authorization', GE_HQ_SingleOrgEnvConfig.GACC_getHTTPAuthorization());
            }
            
            // Set webservice timeout
            webclient.timeout_x = GE_HQ_SingleOrgEnvConfig.GACC_getWebServiceTimeout();
            webclient.endpoint_x = GE_HQ_SingleOrgEnvConfig.GACC_getEndpointBase(); 
    
            //Set the User details and sales region names to the MAP objects
            Map<Id, User> UserDetails = new map<Id, User>([Select NAME from User where id IN :UserIds]);
            Map<Id, GE_HQ_Region__c> RegionDetails = new Map<Id, GE_HQ_Region__c>([Select NAME from GE_HQ_Region__c where id IN :RegionIds]);
            Map<Id, GE_HQ_P_L_Specific_Info__c> PLSpecificInfo = new Map<Id, GE_HQ_P_L_Specific_Info__c>([Select GE_HQ_Account__c,GE_ES_Env_Prim_Ind__c from GE_HQ_P_L_Specific_Info__c where GE_HQ_Account__c in :AccountIDs and GE_HQ_Buss_Tier__c = 'Power & Water (P&W)' and GE_HQ_Buss_Tier1__c = 'Thermal' and GE_HQ_Buss_Tier2__c = 'Environmental Services']);
            Map<Id, GE_HQ_P_L_Specific_Info__c> PLObj = new Map<Id, GE_HQ_P_L_Specific_Info__c>();
    
            for(GE_HQ_P_L_Specific_Info__c PL :PLSpecificInfo.Values()){
                PLObj.put(PL.GE_HQ_Account__c,PL);
            }
    
            //iterate through each account record in the list and call the webservice for each account.
            for(Account objAccount :srcList) {
                accDetails= new GE_ES_PublishCustomer.CustomerDetailsRequest();
                accDetails.DUNS_NUMBER=objAccount.GE_HQ_DUNS_Number__c;
                if(PLSpecificInfo.size() > 0) {
                    accDetails.PRIMARY_INDUSTRY = PLObj.get(objAccount.Id).GE_ES_Env_Prim_Ind__c;
                }
                if(RegionDetails.get(objAccount.GE_HQ_Region_Tier1__c) != null)
                accDetails.REGION=RegionDetails.get(objAccount.GE_HQ_Region_Tier1__c).Name;
                accDetails.CREATION_DATE=objAccount.CreatedDate;
                accDetails.CREATED_BY=UserDetails.get(objAccount.CreatedById).Name;
                accDetails.LAST_UPDATE_DATE=objAccount.LastModifiedDate;
                accDetails.LAST_UPDATED_BY=UserDetails.get(objAccount.LastModifiedById).Name;
    
                //update the WebService status to SFDC objects.
                if(!isFromTest)
                    objResponse=webclient.publishCustomer(accDetails);
                
                objAccount.GE_ES_Galaxy_Status__c = objResponse.STATUS;
                objAccount.GE_ES_Galaxy_Error_Description__c = objResponse.ERROR_DESCRIPTION;
                system.debug('objResponse'+objResponse.STATUS);
                
                GE_HQ_Integration_Activity__c objIntActivity = new GE_HQ_Integration_Activity__c();
                objIntActivity.GE_HQ_Object__c = 'Account';
                objIntActivity.GE_HQ_Account__c = objAccount.Id;
                objIntActivity.GE_HQ_Source_Sys__c = 'SFDC';
                objIntActivity.GE_HQ_Target_Sys__c = 'Galaxy';
                objIntActivity.GE_HQ_Status__c = objResponse.STATUS;                       
                objIntActivity.GE_HQ_Status_Dtl__c = objResponse.ERROR_DESCRIPTION;                  
                objIntActivity.GE_HQ_Submit_Dt__c = System.Now();
                objIntActivity.GE_HQ_Data_Flow__c = 'Outbound';
                objIntActivity.GE_HQ_Submit_By__c = UserInfo.getUserID();
                lstIntAct.add(objIntActivity);
            }
            //updates the SFDC accounts(status and error fields) with the response from Webservice.
            update srcList;     
            insert lstIntAct;
        }
        else{
            IntegrationActivity intActivity = new IntegrationActivity();
            intActivity.setStrObject('Opportunity');
            intActivity.setStrSource('SFDC');
            intActivity.setStrTarget('Galaxy');
            intActivity.setStrStatus('Failure');
            intActivity.setStrStatusDetail('Opportunity of PW can not be submitted in ' + Label.GE_Organization_Name + ' Instance');
            intActivity.setStrSubmittedRecordId(OpptyId);
            intActivity.setStrRecordDesc('Integration submitted via Trigger to send Account detail to the Galaxy system');
            intActivity.insertIntegrationActivity();
        }
        
        */
    }
    
     public static testmethod void GE_ES_CustomerGalaxyIntegrationWrappertest(){
        GE_ES_CustomerGalaxyIntegrationWrapper.newAccountRequest(new Set<ID>(), new Set<ID>(), new Set<ID>());
        Boolean  res = GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest;

    }
    
}