/*
Class Name:-      GE_ES_KintanaWrapper
Overview:-        To publish the data from SFDC to Kintana via Webservice Callout
Author:-          Chetan Vaidya
Created Date:-    06th Apr 2011
Test Class Name:- GE_ES_KintanaWrapper_Test
Change History:-  Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  2nd Jun 2011  : Chetan Vaidya      : Added the mapping for Pressure Record Type for Currency and Phone Number fields.
                  9th Dec 2011 : Durga              : Build card(S-04017) Merge the GE_ES_KintanaEnvConfig class into GE_HQ_SingleOrgEnvConfig class
                  12th Mar 2012 : Lakshman Bugude : Build Card (S-04994), Remove condition on the Account Shipping State.                
                  23rd Mar 2012 : Lakshman Bugude : Build Card (S-04776), Changes for Attachment Description.
                  5th Oct 2012  : Sneha Joshi        : ReOrg Changes S-07465
*/

public class GE_ES_KintanaWrapper{

public String reqTypeid;
public GE_ES_Request_Type__c opptyReq;
User usr {get;set;}
//public Boolean isError{get;set;}
public GE_ES_KintanaWSClient.GE_SFDC_CustomOpportunity_Source_webServices_publishCustomOpportunity_WSD_Port webclient;
GE_ES_KintanaWSClient.CustomOpportunityRequest  oppReq;
GE_ES_KintanaWSClient.CUSTOM_OPPORTUNITY CO;
GE_ES_KintanaWSClient.ADDRESS addr ;
GE_ES_KintanaWSClient.CONTACT cont ;
GE_ES_KintanaWSClient.TEMPERATURE_WORKFLOW_DETAILS tempWF ;
GE_ES_KintanaWSClient.FMGV_WORKFLOW_DETAILS fmgvWF;
GE_ES_KintanaWSClient.PRESSURE_WORKFLOW_DETAILS preWF;
GE_ES_KintanaWSClient.CustomOpportunityResponse oppRes;


public GE_ES_KintanaWrapper(ApexPages.StandardController controller)
    {
        webclient =  new GE_ES_KintanaWSClient.GE_SFDC_CustomOpportunity_Source_webServices_publishCustomOpportunity_WSD_Port();
        oppReq = new GE_ES_KintanaWSClient.CustomOpportunityRequest();
        CO = new GE_ES_KintanaWSClient.CUSTOM_OPPORTUNITY();
        addr = new GE_ES_KintanaWSClient.ADDRESS();
        cont = new GE_ES_KintanaWSClient.CONTACT();
        tempWF = new GE_ES_KintanaWSClient.TEMPERATURE_WORKFLOW_DETAILS();
        fmgvWF = new GE_ES_KintanaWSClient.FMGV_WORKFLOW_DETAILS();
        preWF = new GE_ES_KintanaWSClient.PRESSURE_WORKFLOW_DETAILS();
        oppRes = new GE_ES_KintanaWSClient.CustomOpportunityResponse();
        
        reqTypeid= ApexPages.currentpage().getparameters().get('id');
        system.debug('************reqTypeid **********'+ reqTypeid);
        
        usr =[ select id, GE_HQ_SSO_ID__c from User where id=:userinfo.getuserid()];
        system.debug('************current user logged in is **********'+ usr );
      
       /* webclient.timeout_x=GE_ES_KintanaEnvConfig.getWebServiceTimeOut();
        webclient.endpoint_x=GE_ES_KintanaEnvConfig.getEndpointBase();
        Map<String,String> inputHeader = new Map<String,String>();
        inputHeader.put('Authorization',GE_ES_KintanaEnvConfig.getHttpAuthorization());
        webclient.inputHttpHeaders_x=inputHeader;*/
        
        webclient.timeout_x=GE_HQ_SingleOrgEnvConfig.KIN_getWebServiceTimeout();
        webclient.endpoint_x=GE_HQ_SingleOrgEnvConfig.KIN_getEndpointBase();
        Map<String,String> inputHeader = new Map<String,String>();
        inputHeader.put('Authorization',GE_HQ_SingleOrgEnvConfig.KIN_getHTTPAuthorization());
        webclient.inputHttpHeaders_x=inputHeader;
        
        
    }


Public GE_ES_Request_Type__c opportunityPublish(GE_ES_Request_Type__c reqTyp)
    {
        List<RecordType> RecType= [Select Name, Id From RecordType where sObjectType='GE_ES_Request_Type__c'];  
        Map<String,String> reqRecordTypes = new Map<String,String>{}; 
        for(RecordType rt: RecType)   
        reqRecordTypes.put(rt.Name,rt.Id);
        System.debug('************reqRecordTypes ************************'+reqRecordTypes );
        
        //-------------Querying GE_ES_Request_Type__c Object
        GE_ES_Request_Type__c reqType = [Select id,RecordTypeId,GE_ES_Source_of_Target_Price__c,
        GE_ES_One_time_buy_or_Continuous_Program__c, GE_ES_If_Continuous_prog_what_is_prog_l__c,
        GE_ES_Inquiry_Type__c, GE_ES_Customer_Requested_Response_Date__c, 
        GE_ES_Estimated_Ship_Date_for_Prod_Units__c, GE_ES_Application_Description__c,
        GE_ES_Pole_of_Customer_Location__c, GE_ES_Market_Segment__c, GE_ES_Market_Sub_segment__c, 
        GE_ES_Customer_Contact_for_Quote__c, GE_ES_Customer_Phone_Number__c, GE_ES_Measurand__c,
        GE_ES_EAU_Year_1__c, GE_ES_Target_Price_for_Year_1__c,
        GE_ES_EAU_Year_2__c, GE_ES_Target_Price_for_Year_2__c,
        GE_ES_EAU_Year_3__c, GE_ES_Target_Price_for_Year_3__c, 
        GE_ES_EAU_Year_4__c, GE_ES_Target_Price_for_Year_4__c,
        GE_ES_EAU_Year_5__c, GE_ES_Target_Price_for_Year_5__c,
        GE_ES_Target_Quantity_for_Year_1__c,GE_ES_Target_Quantity_for_Year_2__c, 
        GE_ES_Target_Quantity_for_Year_3__c ,GE_ES_Target_Quantity_for_Year_4__c,
        GE_ES_Target_Quantity_for_Year_5__c , 
        GE_ES_CUSTOMER_CURRENCY__c, GE_ES_ESTIMATED_ANNUAL_VALUE_EAV__c, GE_ES_ESTIMATED_PO_DATE__c,
        GE_ES_Win_Strategy__c, GE_ES_Sample_Type__c, GE_ES_Opportunity_Type__c,
        Opportunity__r.account.ShippingStreet, Opportunity__r.account.ShippingCity,GE_ES_Customer_Space_Envelope__c,
        Opportunity__r.account.ShippingState, Opportunity__r.account.ShippingPostalCode,
        Opportunity__r.account.ShippingCountry, GE_ES_Who_Will_create_Quote__c,Opportunity__r.Name,
        GE_ES_RFQ_Receipt_Date__c, GE_ES_Project_Name__c,GE_ES_If_Military_Enter_The_ML_Code__c,
        GE_ES_Customer_RFQ_Number__c, GE_ES_Bid_Deadline_Date__c, GE_ES_Special_Requirements__c,
        GE_ES_Urgent_Instructions__c, GE_ES_Is_This_Product_for_Military_Use__c,Opportunity__r.Probability,
        GE_ES_Project_Opportunity_Name_Descripti__c, opportunity__r.owner.GE_HQ_SSO_ID__c,
        GE_ES_Work_Phone_from_Primary_Contact__c, GE_ES_Contact_Name__c,GE_ES_PPAP_Required__c,
        GE_ES_Ship_to_Pole__c, GE_ES_Email_Address_from_Primary_Contact__c,GE_ES_Samples_Required__c,
        GE_ES_Product_Family__c, GE_ES_Product_Line__c,Opportunity__r.account.Name,GE_ES_Compensated_Temperature_Range__c,
        GE_ES_Requested_Delivery_Date_Prod_Unit__c, GE_ES_How_often_would_deliveries_reqrd__c,GE_ES_CPO_Status__c,
        GE_ES_Sales_Potential_Year_1__c, GE_ES_Opportunity_Selling_Price_Currency__c,GE_ES_Output_Signal_Type__c,
        GE_ES_Media_Comptblty_or_accble_wetted__c,GE_ES_Pressure_Connection__c,GE_ES_NLH_R_at_Room_Temp__c,
        GE_ES_Application_Requirements__c ,GE_ES_Pressure_Range_s__c ,GE_ES_Gauge_Absolute_Differential__c,
        GE_ES_Possible_Model_Type__c, GE_ES_Is_Customer_spec_docs_attached__c,GE_ES_Electrical_Connection__c,
        GE_ES_Certifications_Hazardous_approvals__c,GE_ES_Operating_Temperature_Media__c,
        GE_ES_Initial_Reviewer__c,GE_ES_Attachment_URL1__c, GE_ES_Attachment_URL2__c,
        GE_ES_Attachment_URL3__c,GE_ES_Attachment_URL4__c, GE_ES_Attachment_URL5__c, GE_ES_Attachment_URL6__c,
        GE_ES_Attachment_URL7__c, GE_ES_Attachment_URL8__c, GE_ES_Attachment_URL9__c, 
        GE_ES_Attachment_URL10__c, GE_ES_Attachment_URL11__c, GE_ES_Attachment_URL12__c, 
        GE_ES_Attachment_URL13__c, GE_ES_Attachment_URL14__c, GE_ES_Attachment_URL15__c, 
        GE_ES_Attachment_URL16__c, GE_ES_Attachment_URL17__c, GE_ES_Attachment_URL18__c, 
        GE_ES_Attachment_URL19__c, GE_ES_Attachment_URL20__c, GE_ES_Attach_Desc1__c, GE_ES_Attach_Desc2__c,
        GE_ES_Attach_Desc3__c, GE_ES_Attach_Desc4__c, GE_ES_Attach_Desc5__c, GE_ES_Attach_Desc6__c,
        GE_ES_Attach_Desc7__c, GE_ES_Attach_Desc8__c, GE_ES_Attach_Desc9__c, GE_ES_Attach_Desc10__c,
        GE_ES_Attach_Desc11__c, GE_ES_Attach_Desc12__c, GE_ES_Attach_Desc13__c, GE_ES_Attach_Desc14__c,
        GE_ES_Attach_Desc15__c, GE_ES_Attach_Desc16__c, GE_ES_Attach_Desc17__c, GE_ES_Attach_Desc18__c,
        GE_ES_Attach_Desc19__c, GE_ES_Attach_Desc20__c, GE_HQ_SFDC_LEGACY_ID__c
        from GE_ES_Request_Type__c where id =:reqTyp.id];
        System.debug('************reqType ***********'+reqType);

        //---------------------- Common Fields to be sent ------------------------------------
        oppReq.SOURCE_SYSTEM = 'SFDC';
        oppReq.TARGET_SYSTEM = 'Kintana';
        CO.USER_SSO = usr.GE_HQ_SSO_ID__c;
        
        //------------for attachment URLs(common fields)--------------------
        List <string> atchURLs = new List<string>();
        GE_ES_KintanaWSClient.ArrayOfstring arrString = new GE_ES_KintanaWSClient.ArrayOfstring();
        
        if(reqType.GE_ES_Attachment_URL1__c !=null || reqType.GE_ES_Attachment_URL1__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL1__c);
        
        if(reqType.GE_ES_Attachment_URL2__c !=null || reqType.GE_ES_Attachment_URL2__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL2__c);
        
        if(reqType.GE_ES_Attachment_URL3__c !=null || reqType.GE_ES_Attachment_URL3__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL3__c);
        
        if(reqType.GE_ES_Attachment_URL4__c !=null || reqType.GE_ES_Attachment_URL4__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL4__c);
        
        if(reqType.GE_ES_Attachment_URL5__c !=null || reqType.GE_ES_Attachment_URL5__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL5__c);
        
        if(reqType.GE_ES_Attachment_URL6__c !=null || reqType.GE_ES_Attachment_URL6__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL6__c);
        
        if(reqType.GE_ES_Attachment_URL7__c !=null || reqType.GE_ES_Attachment_URL7__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL7__c);
        
        if(reqType.GE_ES_Attachment_URL8__c !=null || reqType.GE_ES_Attachment_URL8__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL8__c);
        
        if(reqType.GE_ES_Attachment_URL9__c !=null || reqType.GE_ES_Attachment_URL9__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL9__c);
        
        if(reqType.GE_ES_Attachment_URL10__c !=null || reqType.GE_ES_Attachment_URL10__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL10__c);
        
        if(reqType.GE_ES_Attachment_URL11__c !=null || reqType.GE_ES_Attachment_URL11__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL11__c);
        
        if(reqType.GE_ES_Attachment_URL12__c !=null || reqType.GE_ES_Attachment_URL12__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL12__c);
        
        if(reqType.GE_ES_Attachment_URL13__c !=null || reqType.GE_ES_Attachment_URL13__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL13__c);
        
        if(reqType.GE_ES_Attachment_URL14__c !=null || reqType.GE_ES_Attachment_URL14__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL14__c);
        
        if(reqType.GE_ES_Attachment_URL15__c !=null || reqType.GE_ES_Attachment_URL15__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL15__c);
        
        if(reqType.GE_ES_Attachment_URL16__c !=null || reqType.GE_ES_Attachment_URL16__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL16__c);
        
        if(reqType.GE_ES_Attachment_URL17__c !=null || reqType.GE_ES_Attachment_URL17__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL17__c);
        
        if(reqType.GE_ES_Attachment_URL18__c !=null || reqType.GE_ES_Attachment_URL18__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL18__c);
        
        if(reqType.GE_ES_Attachment_URL19__c !=null || reqType.GE_ES_Attachment_URL19__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL19__c);
        
        if(reqType.GE_ES_Attachment_URL20__c !=null || reqType.GE_ES_Attachment_URL20__c != '' )
        atchURLs.add(reqType.GE_ES_Attachment_URL20__c);
        
        system.debug('************atchURLs*********'+atchURLs);
        
        if(atchURLs != null)
        arrString.ArrayOfstringItem = atchURLs;
        system.debug('************All Attachment URLs *********' + arrString.ArrayOfstringItem );
        CO.ATTACHMENT_URLS = arrString;

        //------------for attachment URLs Description(common fields)--------------------
        List <string> atchDesc = new List<string>();
        
        if(reqType.GE_ES_Attach_Desc1__c !=null || reqType.GE_ES_Attach_Desc1__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc1__c);
        
        if(reqType.GE_ES_Attach_Desc2__c !=null || reqType.GE_ES_Attach_Desc2__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc2__c);
        
        if(reqType.GE_ES_Attach_Desc3__c !=null || reqType.GE_ES_Attach_Desc3__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc3__c);
        
        if(reqType.GE_ES_Attach_Desc4__c !=null || reqType.GE_ES_Attach_Desc4__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc4__c);
        
        if(reqType.GE_ES_Attach_Desc5__c !=null || reqType.GE_ES_Attach_Desc5__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc5__c);
        
        if(reqType.GE_ES_Attach_Desc6__c !=null || reqType.GE_ES_Attach_Desc6__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc6__c);
        
        if(reqType.GE_ES_Attach_Desc7__c !=null || reqType.GE_ES_Attach_Desc7__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc7__c);
        
        if(reqType.GE_ES_Attach_Desc8__c !=null || reqType.GE_ES_Attach_Desc8__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc8__c);
        
        if(reqType.GE_ES_Attach_Desc9__c !=null || reqType.GE_ES_Attach_Desc9__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc9__c);
        
        if(reqType.GE_ES_Attach_Desc10__c !=null || reqType.GE_ES_Attach_Desc10__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc10__c);
        
        if(reqType.GE_ES_Attach_Desc11__c !=null || reqType.GE_ES_Attach_Desc11__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc11__c);
        
        if(reqType.GE_ES_Attach_Desc12__c !=null || reqType.GE_ES_Attach_Desc12__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc12__c);
        
        if(reqType.GE_ES_Attach_Desc13__c !=null || reqType.GE_ES_Attach_Desc13__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc13__c);
        
        if(reqType.GE_ES_Attach_Desc14__c !=null || reqType.GE_ES_Attach_Desc14__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc14__c);
        
        if(reqType.GE_ES_Attach_Desc15__c !=null || reqType.GE_ES_Attach_Desc15__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc15__c);
        
        if(reqType.GE_ES_Attach_Desc16__c !=null || reqType.GE_ES_Attach_Desc16__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc16__c);
        
        if(reqType.GE_ES_Attach_Desc17__c !=null || reqType.GE_ES_Attach_Desc17__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc17__c);
        
        if(reqType.GE_ES_Attach_Desc18__c !=null || reqType.GE_ES_Attach_Desc18__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc18__c);
        
        if(reqType.GE_ES_Attach_Desc19__c !=null || reqType.GE_ES_Attach_Desc19__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc19__c);
        
        if(reqType.GE_ES_Attach_Desc20__c !=null || reqType.GE_ES_Attach_Desc20__c != '')
        atchDesc.add(reqType.GE_ES_Attach_Desc20__c);
        
        system.debug('************Attachment Description*********'+atchDesc);
        
        GE_ES_KintanaWSClient.ArrayOfstring attachDescArrayString = new GE_ES_KintanaWSClient.ArrayOfstring();
        if(atchDesc != null)
            attachDescArrayString.ArrayOfstringItem = atchDesc;
        system.debug('************All fields *********'+arrString.ArrayOfstringItem);
        CO.ATTACHMENT_DESCRIPTION = attachDescArrayString;
        
        System.debug('URLs:- ' + CO.ATTACHMENT_URLS);
        System.debug('Descriptions:- ' + CO.ATTACHMENT_DESCRIPTION);

        //---------------------- Common Fields ends ------------------------------------
        
        //----------------------------Mapping for TempMEMS SFDC to KINTANA-------------------------------
        if(reqType.RecordTypeId==reqRecordTypes.get('AS'))
            {
                tempWF.SOURCE_TARGET_PRICE = reqType.GE_ES_Source_of_Target_Price__c;
                tempWF.ONE_TIME_BUY =  reqType.GE_ES_One_time_buy_or_Continuous_Program__c;
                tempWF.PROGRAM_LIFETIME= string.valueof(reqType.GE_ES_If_Continuous_prog_what_is_prog_l__c);
                tempWF.INQUIRY_TYPE = reqType.GE_ES_Inquiry_Type__c;
                tempWF.RESPONSE_DATE = reqType.GE_ES_Customer_Requested_Response_Date__c;
                tempWF.ESTIMATED_DELIVERY_DATE = reqType.GE_ES_Estimated_Ship_Date_for_Prod_Units__c;
                tempWF.APPLICATION_DESCRIPTION = reqType.GE_ES_Application_Description__c;
                tempWF.PPAP_REQUIRED_FLAG = reqType.GE_ES_PPAP_Required__c;
                tempWF.SAMPLES_REQUIRED_FLAG = reqType.GE_ES_Samples_Required__c;
                
                addr.ADDRESS_LINE1 = reqType.Opportunity__r.account.ShippingStreet;
                addr.CITY = reqType.Opportunity__r.account.ShippingCity;
                addr.STATE_PROVINCE = reqType.Opportunity__r.account.ShippingState;
                addr.COUNTRY = reqType.Opportunity__r.account.ShippingCountry;
                addr.ZIP_CODE = reqType.Opportunity__r.account.ShippingPostalCode;
                /*if(addr.ADDRESS_LINE1==null || addr.CITY==null ||addr.STATE_PROVINCE==null ||addr.COUNTRY==null  || addr.ZIP_CODE ==null)
                {
                isError=true;
                }
                else
                {isError=false;}
                */
                tempWF.SUB_SEGMENT  =reqType.GE_ES_Market_Sub_segment__c;
                tempWF.CONTACT_QUOTE =reqType.GE_ES_Customer_Contact_for_Quote__c;
                cont.PHONE_NUMBER =reqType.GE_ES_Customer_Phone_Number__c;
                tempWF.EAU_YEAR1 = string.Valueof(reqType.GE_ES_EAU_Year_1__c);
                tempWF.TARGET_PRICE1 = string.Valueof(reqType.GE_ES_Target_Price_for_Year_1__c);
                tempWF.EAU_YEAR2 = string.Valueof(reqType.GE_ES_EAU_Year_2__c);
                tempWF.TARGET_PRICE2 = string.Valueof(reqType.GE_ES_Target_Price_for_Year_2__c);
                tempWF.EAU_YEAR3 = string.Valueof(reqType.GE_ES_EAU_Year_3__c);
                tempWF.TARGET_PRICE3 = string.Valueof(reqType.GE_ES_Target_Price_for_Year_3__c);
                tempWF.EAU_YEAR4 = string.Valueof(reqType.GE_ES_EAU_Year_4__c);
                tempWF.TARGET_PRICE4 = string.Valueof(reqType.GE_ES_Target_Price_for_Year_4__c);
                tempWF.EAU_YEAR5 = string.Valueof(reqType.GE_ES_EAU_Year_5__c);
                tempWF.TARGET_PRICE5 = string.Valueof(reqType.GE_ES_Target_Price_for_Year_5__c);
                tempWF.ESTIMATED_ANNUAL_VALUE = string.valueof(reqType.GE_ES_ESTIMATED_ANNUAL_VALUE_EAV__c);
                tempWF.ESTIMATED_PO_DATE = reqType.GE_ES_ESTIMATED_PO_DATE__c;
                tempWF.WIN_STRATEGY = reqType.GE_ES_Win_Strategy__c;
                tempWF.SAMPLE_TYPE = reqType.GE_ES_Sample_Type__c;
                tempWF.OPPORTUNITY_TYPE = reqType.GE_ES_Opportunity_Type__c;
                CO.MEASURAND =reqType.GE_ES_Measurand__c;
                CO.PRODUCT_FAMILY =reqType.GE_ES_Product_Family__c;
                CO.SHIP_TO_POLE = reqType.GE_ES_Pole_of_Customer_Location__c;
                CO.MARKET = reqType.GE_ES_Market_Segment__c;
                CO.MILITARY_USE_FLAG = reqType.GE_ES_Is_This_Product_for_Military_Use__c;
                //CO.MILITARY_CODE = reqType.GE_ES_If_Military_Enter_The_ML_Code__c;
                if(reqType.GE_ES_If_Military_Enter_The_ML_Code__c!=null)
                    {
                    CO.MILITARY_CODE=reqType.GE_ES_If_Military_Enter_The_ML_Code__c;
                    }
                else
                    {
                    CO.MILITARY_CODE='N/A';
                    }
                if(reqType.GE_HQ_SFDC_LEGACY_ID__c != null){
                     CO.OPPORTUNITY_ID = reqType.GE_HQ_SFDC_LEGACY_ID__c;
                }
                else{
                    CO.OPPORTUNITY_ID = reqType.id;
                }
                CO.OPPORTUNITY_NAME = reqType.Opportunity__r.Name;
                CO.PROBABILITY_SALE = string.Valueof(reqType.Opportunity__r.Probability);
                CO.ACCOUNT_MANAGER = reqType.Opportunity__r.owner.GE_HQ_SSO_ID__c;
                CO.ACCOUNT_NAME = reqType.Opportunity__r.account.Name;
                CO.CPO_CURRENCY = reqType.GE_ES_CUSTOMER_CURRENCY__c;
                CO.ADDRESS=addr;
                CO.CONTACT=cont;
                CO.TEMPERATURE_WORKFLOW_DETAILS=tempWF;
                oppReq.CUSTOM_OPPORTUNITY=CO;
                oppReq.MESSAGE_TYPE = 'AS';
            }

        //-------------------------------Mapping for FMGV SFDC to Kintana-----------------------
        if(reqType.RecordTypeId==reqRecordTypes.get('FMG'))
            {
                fmgvWF.QUOTE_CREATED_BY=reqType.GE_ES_Who_Will_create_Quote__c;
                fmgvWF.RFQ_RECEIPT_DATE=reqType.GE_ES_RFQ_Receipt_Date__c;
                fmgvWF.PROJECT_NAME=reqType.GE_ES_Project_Name__c;
                fmgvWF.CUSTOMER_RFQ_NUMBER=reqType.GE_ES_Customer_RFQ_Number__c;
                fmgvWF.SPECIAL_REQUIREMENTS=reqType.GE_ES_Special_Requirements__c;
                fmgvWF.URGENT_INSTRUCTIONS=reqType.GE_ES_Urgent_Instructions__c;
                addr.STATE_PROVINCE = reqType.Opportunity__r.Account.ShippingState;
                addr.COUNTRY = reqType.Opportunity__r.account.ShippingCountry;
                cont.CONTACT_NAME=reqType.GE_ES_Contact_Name__c;
                cont.PHONE_NUMBER=reqType.GE_ES_Work_Phone_from_Primary_Contact__c;
                cont.EMAIL_ADDRESS=reqType.GE_ES_Email_Address_from_Primary_Contact__c;
                fmgvWF.POTENTIAL_SALE_YEAR1=string.valueof(reqType.GE_ES_Sales_Potential_Year_1__c);
                fmgvWF.INITIAL_REVIEWER=reqType.GE_ES_Initial_Reviewer__c;
                CO.MILITARY_USE_FLAG=reqType.GE_ES_Is_This_Product_for_Military_Use__c;
                if(reqType.GE_ES_If_Military_Enter_The_ML_Code__c!=null)
                    {
                    CO.MILITARY_CODE=reqType.GE_ES_If_Military_Enter_The_ML_Code__c;
                    }
                else
                    {
                    CO.MILITARY_CODE='N/A';
                    }
                CO.BID_DEADLINE_DATE=reqType.GE_ES_Bid_Deadline_Date__c;
                if(reqType.GE_HQ_SFDC_LEGACY_ID__c != null){
                    CO.OPPORTUNITY_ID = reqType.GE_HQ_SFDC_LEGACY_ID__c;
                }
                else{
                    CO.OPPORTUNITY_ID=reqType.id;
                }
                CO.OPPORTUNITY_NAME=reqType.Opportunity__r.Name;
                CO.ACCOUNT_MANAGER=reqType.opportunity__r.owner.GE_HQ_SSO_ID__c;
                CO.ACCOUNT_NAME = reqType.Opportunity__r.account.Name;
                CO.SHIP_TO_POLE=reqType.GE_ES_Ship_to_Pole__c;
                CO.MEASURAND=reqType.GE_ES_Measurand__c;
                CO.PRODUCT_FAMILY=reqType.GE_ES_Product_Family__c;
                CO.PRODUCT_LINE=reqType.GE_ES_Product_Line__c;
                CO.CPO_CURRENCY=reqType.GE_ES_Opportunity_Selling_Price_Currency__c;
                CO.ADDRESS=addr;
                CO.CONTACT=cont;
                CO.FMGV_WORKFLOW_DETAILS = fmgvWF;
                oppReq.CUSTOM_OPPORTUNITY=CO;
                oppReq.MESSAGE_TYPE = 'FMG';
            }

        //-------------------------------Mapping for Pressure SFDC to Kintana---------------------
        if(reqType.RecordTypeId==reqRecordTypes.get('Pressure'))
            {
                tempWF.INQUIRY_TYPE=reqType.GE_ES_Inquiry_Type__c;
                cont.CONTACT_NAME = reqType.GE_ES_Contact_Name__c;
                cont.PHONE_NUMBER = reqType.GE_ES_Customer_Phone_Number__c;//Added on June 2nd 2011
                addr.STATE_PROVINCE = reqType.Opportunity__r.Account.ShippingState;
                addr.COUNTRY = reqType.Opportunity__r.account.ShippingCountry;
                preWF.REQUESTED_DELIVERY_DATE=reqType.GE_ES_Requested_Delivery_Date_Prod_Unit__c;
                preWF.DELIVERIES_REQUIRED=reqType.GE_ES_How_often_would_deliveries_reqrd__c;
                preWF.POSSIBLE_MODEL_TYPE=reqType.GE_ES_Possible_Model_Type__c;
                preWF.DOCUMENTS_ATTACHED=reqType.GE_ES_Is_Customer_spec_docs_attached__c;
                preWF.APPLICATION_REQUIREMENTS=reqType.GE_ES_Application_Requirements__c;
                preWF.PRESSURE_RANGE=reqType.GE_ES_Pressure_Range_s__c;
                preWF.GAD=reqType.GE_ES_Gauge_Absolute_Differential__c;
                preWF.MEDIA_COMPATIBILITY=reqType.GE_ES_Media_Comptblty_or_accble_wetted__c;
                preWF.PRESSURE_CONNECTION=reqType.GE_ES_Pressure_Connection__c;
                preWF.ELECTRICAL_CONNECTION=reqType.GE_ES_Electrical_Connection__c;
                preWF.COMBINED_ACCURACY=reqType.GE_ES_NLH_R_at_Room_Temp__c;
                preWF.COMPENSATED_TEMPERATURE_RANGE=reqType.GE_ES_Compensated_Temperature_Range__c;
                preWF.OUTPUT_SIGNAL_TYPE=reqType.GE_ES_Output_Signal_Type__c;
                preWF.CUSTOMER_SPACE_ENVELOPE=reqType.GE_ES_Customer_Space_Envelope__c;
                preWF.CERTIFICATION_APPROVALS=reqType.GE_ES_Certifications_Hazardous_approvals__c;
                preWF.OPERATING_TEMPERATURE=reqType.GE_ES_Operating_Temperature_Media__c;
                preWF.POTENTIAL_QUANTITY_YEAR1 = string.valueof(reqType.GE_ES_Target_Quantity_for_Year_1__c);
                preWF.CUSTOMER_TARGET_PRICE1 = string.valueof(reqType.GE_ES_Target_Price_for_Year_1__c);
                preWF.POTENTIAL_QUANTITY_YEAR2 = string.valueof(reqType.GE_ES_Target_Quantity_for_Year_2__c);
                preWF.CUSTOMER_TARGET_PRICE2 = string.valueof(reqType.GE_ES_Target_Price_for_Year_2__c);
                preWF.POTENTIAL_QUANTITY_YEAR3 = string.valueof(reqType.GE_ES_Target_Quantity_for_Year_3__c);
                preWF.CUSTOMER_TARGET_PRICE3 = string.valueof(reqType.GE_ES_Target_Price_for_Year_3__c);
                preWF.POTENTIAL_QUANTITY_YEAR4 = string.valueof(reqType.GE_ES_Target_Quantity_for_Year_4__c);
                preWF.CUSTOMER_TARGET_PRICE4 = string.valueof(reqType.GE_ES_Target_Price_for_Year_4__c);
                preWF.POTENTIAL_QUANTITY_YEAR5 = string.valueof(reqType.GE_ES_Target_Quantity_for_Year_5__c) ;
                preWF.CUSTOMER_TARGET_PRICE5 = string.valueof(reqType.GE_ES_Target_Price_for_Year_5__c);
                CO.BID_DEADLINE_DATE=reqType.GE_ES_Bid_Deadline_Date__c;
                CO.MILITARY_USE_FLAG=reqType.GE_ES_Is_This_Product_for_Military_Use__c;
                //CO.MILITARY_CODE=reqType.GE_ES_If_Military_Enter_The_ML_Code__c;
                if(reqType.GE_ES_If_Military_Enter_The_ML_Code__c!=null)
                    {
                    CO.MILITARY_CODE=reqType.GE_ES_If_Military_Enter_The_ML_Code__c;
                    }
                else
                    {
                    CO.MILITARY_CODE='N/A';
                    }
                if(reqType.GE_HQ_SFDC_LEGACY_ID__c != null){
                    CO.OPPORTUNITY_ID = reqType.GE_HQ_SFDC_LEGACY_ID__c;
                }
                else{
                    CO.OPPORTUNITY_ID=reqType.id;
                }
                CO.OPPORTUNITY_NAME = reqType.opportunity__r.name;
                CO.PROBABILITY_SALE = string.valueof(reqType.Opportunity__r.Probability);
                CO.ACCOUNT_MANAGER = reqType.opportunity__r.owner.GE_HQ_SSO_ID__c;
                CO.ACCOUNT_NAME = reqType.Opportunity__r.Account.Name;
                CO.SHIP_TO_POLE = reqType.GE_ES_Ship_to_Pole__c;
                CO.MARKET = reqType.GE_ES_Market_Segment__c;
                CO.MEASURAND = reqType.GE_ES_Measurand__c;
                CO.PRODUCT_FAMILY = reqType.GE_ES_Product_Family__c;
                CO.PRODUCT_LINE = reqType.GE_ES_Product_Line__c;
                CO.CPO_CURRENCY = reqType.GE_ES_CUSTOMER_CURRENCY__c;//Added on June 2nd 2011
                CO.ADDRESS=addr;
                CO.CONTACT=cont;
                CO.TEMPERATURE_WORKFLOW_DETAILS=tempWF;
                CO.PRESSURE_WORKFLOW_DETAILS = preWF;
                oppReq.CUSTOM_OPPORTUNITY=CO;
                oppReq.MESSAGE_TYPE = 'Pressure';
            }

        oppRes = webclient.publishCustomOpportunity(oppReq);
        system.debug('************ System Response Start');  
        system.debug('************ Status*****'+oppRes.STATUS);  
        system.debug('************ ERROR_DESCRIPTION******'+oppRes.ERROR_DESCRIPTION); 
        system.debug('************ System Response Ends'); 
        
        if(oppRes.STATUS == 'SUCCESS')
        {
        reqType.GE_ES_CPO_Status__c='Initiated';
        update reqType;
        system.debug('************reqType.GE_ES_CPO_Status__c****' +reqType.GE_ES_CPO_Status__c);
        }
        return null;
    }

public pagereference submit()
    {
        IntegrationExecution IntegrationExecutionObj = new IntegrationExecution('OG');        
        pageReference pgref;
        if(IntegrationExecutionObj.IsOrgName == true){
            List<RecordType> RecType= [Select Name, Id From RecordType where sObjectType='GE_ES_Request_Type__c'];  
            Map<String,String> reqRecordTypes = new Map<String,String>{}; 
            for(RecordType rt: RecType)   
            reqRecordTypes.put(rt.Name,rt.Id);
            
            system.debug('**********reqRecordTypes***********'+reqRecordTypes  );
            
            opptyReq = new GE_ES_Request_Type__c(id=reqTypeid);
            system.debug('**********opptyReq ***********'+opptyReq );
    
            GE_ES_Request_Type__c reqTypeRec = [select id,RecordTypeId,Opportunity__r.account.ShippingStreet,
            Opportunity__r.account.ShippingCity,Opportunity__r.account.ShippingPostalCode,
            Opportunity__r.account.ShippingState,Opportunity__r.account.ShippingCountry
            from GE_ES_Request_Type__c where id=:opptyReq.id];
            
            system.debug('**********reqTypeRec ***********'+reqTypeRec );
    
            if ( (reqTypeRec.RecordTypeId==reqRecordTypes.get('AS'))&& (reqTypeRec.Opportunity__r.account.ShippingStreet ==null || reqTypeRec.Opportunity__r.account.ShippingCity ==null || reqTypeRec.Opportunity__r.account.ShippingPostalCode ==null || reqTypeRec.Opportunity__r.account.ShippingCountry ==null ))
            {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR,'All shipping address fields are mandatory. Go to Account and enter all the values for shipping address fields' );
            Apexpages.addMessage(mymsg);
            system.debug('**********mymsg***********'+mymsg);
            } 
            else
            {
            opptyReq = new GE_ES_Request_Type__c(id=reqTypeid);
            opportunityPublish(opptyReq);
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.INFO, 'CPO has been submitted!');
            Apexpages.addMessage(mymsg);
            }
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Opportunity of OG can not be submitted in ' + Label.GE_Organization_Name + ' Instance'));
            IntegrationActivity intActivity = new IntegrationActivity();
            intActivity.setStrObject('Request Type (ES)');
            intActivity.setStrSource('SFDC');
            intActivity.setStrTarget('Kintana');
            intActivity.setStrStatus('Failure');
            intActivity.setStrStatusDetail('Opportunity of OG can not be submitted in ' + Label.GE_Organization_Name + ' Instance');
            intActivity.setStrRecordDesc('Integration submitted via Button click by sending Opportunity detail to the Kintana system');
            intActivity.insertIntegrationActivity();
        }
        return pgref;
    }

public pageReference origOpp()
    {
        pageReference pgRef;
        opptyReq = new GE_ES_Request_Type__c(id=reqTypeid);
        pgRef=new pageReference ('/'+opptyReq.id);
        return pgRef;
    }     

}