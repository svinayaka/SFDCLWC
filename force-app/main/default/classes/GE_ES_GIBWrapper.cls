/*
Class Name:-      GE_ES_GIBWrapper
Overview:-        This Class is Istalled base wapper class for Integration. 
Author:-          Durga
Created Date:-    28th June 2011
ModifiedBy :      9th Dec 2011: Durga BuildCard(S-04162) Merge the GE_ES_GIBEnvConfig  class into GE_HQ_SingleOrgEnvConfig class 
*/

public class GE_ES_GIBWrapper
{
    public String strIBId;
    public GE_ES_GIBWrapper(ApexPages.StandardController controller)
    {
        //Fetching the Current Record ID       
        strIBId=ApexPages.currentPage().getParameters().get('id');
    }

    @Future(callout=true)
    public static void IBReq(set<Id> iBId)
    {
       GE_ES_GIBWSClient.GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port  webclient= new GE_ES_GIBWSClient.GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port();
       GE_ES_GIBWSClient.GIBUnitUpdateRequest IBRequest = new GE_ES_GIBWSClient.GIBUnitUpdateRequest();
       GE_ES_GIBWSClient.GIBUnitUpdateResponse objResponse = new GE_ES_GIBWSClient.GIBUnitUpdateResponse();              
       GE_ES_GIBWSClient.GIBUNITUPDATE  IBInfo = new GE_ES_GIBWSClient.GIBUNITUPDATE ();

       webclient.timeout_x=GE_HQ_SingleOrgEnvConfig.GIB_getWebServiceTimeout();
       webclient.endpoint_x =GE_HQ_SingleOrgEnvConfig.GIB_getEndpointBase();
       webclient.inputHttpHeaders_x = new Map<string, string>();   
       Map<string,string> inputHeader=new Map<string,string>();      
       inputHeader.put('Authorization',GE_HQ_SingleOrgEnvConfig.GIB_getHTTPAuthorization());     
       webClient.inputHttpHeaders_x=inputHeader;

       if(iBId.size()>0)
       {
            List <GE_Installed_Base__c> IB = [select id,Name,GE_ES_Account_Manager__r.GE_HQ_SSO_ID__c,GE_ES_Sales_Channel__c,GE_HQ_lntrv_BIs__c,GE_HQ_lntrv_CIs__c,GE_HQ_lntrv_HGPMIs__c,GE_HQ_lntrv_Major__c,GE_HQ_lntrv_Minor__c,GE_HQ_lntrv_SMI__c from GE_Installed_Base__c where id IN :iBId];
            //GIBUNITUPDATE Records
            for(GE_Installed_Base__c IBVar:IB)
            {
                IBInfo = new GE_ES_GIBWSClient.GIBUNITUPDATE ();
                IBInfo.SALES_CHANNEL=IBVar.GE_ES_Sales_Channel__c;
                IBInfo.EQUIPMENT_SERIAL_NUMBER=IBVar.Name;//Needs Clarification
                IBInfo.EMPLOYEE_CODE=IBVar.GE_ES_Account_Manager__r.GE_HQ_SSO_ID__c;//Needs Clarification
                IBInfo.BIS_INTERVAL = String.Valueof(IBVar.GE_HQ_lntrv_BIs__c);
                IBInfo.CIS_INTERVAL = String.Valueof(IBVar.GE_HQ_lntrv_CIs__c);
                IBInfo.MIS_INTERVAL = String.Valueof(IBVar.GE_HQ_lntrv_HGPMIs__c);
                IBInfo.MAJORS_INTERVAL = String.Valueof(IBVar.GE_HQ_lntrv_Major__c);
                IBInfo.MINORS_INTERVAL = String.Valueof(IBVar.GE_HQ_lntrv_Minor__c);
                IBInfo.SCM_INTERVAL = String.Valueof(IBVar.GE_HQ_lntrv_SMI__c);

                IBRequest.GIBUNITUPDATE=IBInfo;
                IBRequest.SOURCE_SYSTEM='SFDC';
                IBRequest.TARGET_SYSTEM='GIB';    
                objResponse = webclient.publishGIBUnitUpdate(IBRequest);    
                system.Debug('SSSSSS'+objResponse);
            }
        }
    }

    //For Button Click
    public GE_Installed_Base__c IBReqBtn(ID iBId)
    {
        GE_ES_GIBWSClient.GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port  webclient= new GE_ES_GIBWSClient.GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port();
        GE_ES_GIBWSClient.GIBUnitUpdateRequest IBRequest = new GE_ES_GIBWSClient.GIBUnitUpdateRequest();
        GE_ES_GIBWSClient.GIBUnitUpdateResponse objResponse = new GE_ES_GIBWSClient.GIBUnitUpdateResponse();              
        GE_ES_GIBWSClient.GIBUNITUPDATE  IBInfo = new GE_ES_GIBWSClient.GIBUNITUPDATE ();
        webclient.timeout_x=GE_HQ_SingleOrgEnvConfig.GIB_getWebServiceTimeout();
        webclient.endpoint_x =GE_HQ_SingleOrgEnvConfig.GIB_getEndpointBase();
        webclient.inputHttpHeaders_x = new Map<string, string>();   
        Map<string,string> inputHeader=new Map<string,string>();      
        inputHeader.put('Authorization',GE_HQ_SingleOrgEnvConfig.GIB_getHTTPAuthorization());     
        webClient.inputHttpHeaders_x=inputHeader;
        GE_Installed_Base__c IB = [select id,Name,GE_ES_Account_Manager__r.GE_HQ_SSO_ID__c,GE_ES_Sales_Channel__c from GE_Installed_Base__c where id =:iBId];
        //GIBUNITUPDATE Records
        IBInfo.SALES_CHANNEL=IB.GE_ES_Sales_Channel__c;
        IBInfo.EQUIPMENT_SERIAL_NUMBER=IB.Name;//Needs Clarification
        IBInfo.EMPLOYEE_CODE=IB.GE_ES_Account_Manager__r.GE_HQ_SSO_ID__c;//Needs Clarification

        IBRequest.GIBUNITUPDATE=IBInfo;
        IBRequest.SOURCE_SYSTEM='SFDC';
        IBRequest.TARGET_SYSTEM='GIB';
        objResponse = webclient.publishGIBUnitUpdate(IBRequest);
        return null;
    }

    public pageReference submit() 
    { 
        IBReqBtn(strIBId);
        pageReference pgRf;
        return pgRf;
    } 

    public pageReference OrigIBPage()
    {  
        pageReference pgRef; 
        pgRef = new pageReference('/'+strIBId); 
        return pgRef;  
    }
}