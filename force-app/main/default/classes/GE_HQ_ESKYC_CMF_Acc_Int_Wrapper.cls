/*    
Class Name        : GE_HQ_ESKYC_CMF_Acc_Int_Wrapper
Purpose/Overview  : To implement the CMF integration from the KYC itself. Previously the KYC was outside SFDC. To incoroporate this inside SFDC, the CMF submission has to be automated from KYC process. So the copy of AccountIntegrationWrapper was implemented to accomplish this.
Author            : Jayadev Rath
Test Class        : GE_HQ_KYC_Process_Test 
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 23rd Oct 2011 : Jayadev Rath       : Created : Replica of the old AccountIntegrationWrapper class specially modified for a future call to be executed from KYC records.
                  : 7th Nov 2011  : Jayadev Rath       : Constructor : Updated the code to increase the % coverage without any functionality change
                  : 1st July 2013 : Harsh Sharma       : Replaced new WS client method calls as per August Major Release.
                  : 4th July 2013 : Harsh Sharma       : Added the code to send the Request D&B Duns and Subscribed System Information.
                  : 10th July 2013: Harsh Sharma       : Added the code to send Legacy System and Org Name.
                  : 6th Aug 2013  : Harsh Sharma       : Replaced the code to send Legacy System and Org Id.
                  : 24th Sept 2013: Somnath Das        : Added the code for Bill to and Ship to Accounts to pass through integration.
*/
Public class GE_HQ_ESKYC_CMF_Acc_Int_Wrapper {  

    Public Static AccountWSClient.GE_SFDC_OG_CustomerRequest_Source_WebServices_Provider_publishCustomerRequest_WSD_Port webclient;
    Public Static AccountWSClient.RESPONSE objResponse;
    Public Static AccountWSClient.REQUEST accDetails;
    Public Static String wsdlstatus;
    Public Static String wsdldesc;
    Public Static Boolean FromTest = False;
     
    Public GE_HQ_ESKYC_CMF_Acc_Int_Wrapper() {

        accDetails = new AccountWSClient.REQUEST();
        webclient = new AccountWSClient.GE_SFDC_OG_CustomerRequest_Source_WebServices_Provider_publishCustomerRequest_WSD_Port();
        objResponse=new AccountWSClient.RESPONSE();
        FromTest=False;
       
        // Credentials for Web Service (HTTP Header)
       if (GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useHTTPAuthorization()) { webclient.inputHttpHeaders_x = new Map<string, string>(); webclient.inputHttpHeaders_x.put('Authorization', GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getHTTPAuthorization()); }
       // Certification for Web Service
       if (GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useClientCertificate()) { webclient.clientCert_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificate(); webclient.clientCertPasswd_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificatePassword(); }
       // Set webservice timeout
       webclient.timeout_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getWebServiceTimeout();
       webclient.endpoint_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getEndpointBase(); 

    }  
    
    // Added for R-4681, CMF from KYC.
    @Future(callout=true)
    Public Static void NewAccountRequest(String objAccountid) {
        // == Code from constructor, as it is not getting called now.
        accDetails= new AccountWSClient.REQUEST();
        webclient = new AccountWSClient.GE_SFDC_OG_CustomerRequest_Source_WebServices_Provider_publishCustomerRequest_WSD_Port();
        objResponse=new AccountWSClient.RESPONSE();

        // Credentials for Web Service (HTTP Header)
       if (GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useHTTPAuthorization()) { webclient.inputHttpHeaders_x = new Map<string, string>(); webclient.inputHttpHeaders_x.put('Authorization', GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getHTTPAuthorization()); }
       // Certification for Web Service
       if (GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useClientCertificate()) { webclient.clientCert_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificate(); webclient.clientCertPasswd_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificatePassword(); }
       // Set webservice timeout
       webclient.timeout_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getWebServiceTimeout();
       webclient.endpoint_x = GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getEndpointBase(); 


        //Fetching the records to be sent to WebMethod for NewAccountRequest
        Account objAccount=[Select id,name,OwnerId,GE_HQ_Account_Request_ID__c,GE_PW_City_Ship_To__c,GE_PW_Country_Ship_To__c,GE_PW_Zip_Postal_Code_Ship_To__c,GE_PW_State_Province_Ship_To__c,GE_PW_Street_Ship_To__c,GE_PW_City_Bill_To__c,GE_PW_Country_Bill_To__c,GE_PW_Zip_Postal_Code_Bill_To__c,GE_PW_State_Province_Bill_To__c,GE_PW_Street_Bill_To__c,GE_PW_City_Quote_To_Sold_To_HQ__c,GE_PW_Country_Quote_To_Sold_To_HQ__c,GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c,GE_PW_State_Province_Quote_To_Sold_To_HQ__c,GE_PW_Street_Quote_To_Sold_To_HQ__c,GE_PW_Send_to_CMF_Ship_To__c,GE_PW_Send_to_CMF_Bill_To__c,GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c,GE_HQ_Request_Type__c,GE_HQ_Site_Use_Code__c, GE_HQ_New_Account_City__c,GE_HQ_New_Account_Street__c,GE_HQ_New_Account_State_Province__c,GE_HQ_New_Account_Zip_Postal_Code__c, GE_HQ_New_Account_Country__c,GE_HQ_Comments__c,GE_HQ_Documentation__c,GE_HQ_Documentation1__c,GE_HQ_Documentation2__c,GE_HQ_Documentation3__c,Phone,GE_HQ_Legacy_System__c, GE_HQ_Vat_Registration__c,GE_HQ_Source__c,GE_HQ_Vat_Number__c,GE_HQ_Vat_Notes__c,GE_HQ_Vat_Group__c,GE_HQ_Requester_Id__c,GE_HQ_SSO_ID__c, GE_HQ_Org_ID__c,GE_HQ_Location__c,Website ,  GE_HQ_REQUEST_STATUS__C, GE_HQ_WATCHLIST_FLAG__c, GE_HQ_MARKETING_NAME__c,GE_HQ_Alternate_Tradestyle_Name__c, GE_HQ_Internal_Customer__c,GE_HQ_Vat_Reg_Code__c,GE_HQ_GE_VAT_Number_Data_Source__c,GE_HQ_VAT_Expiration_Date__c,GE_HQ_Gold_ID__c,GE_HQ_Glo_Ult_Duns__c,GE_HQ_Dom_Ult_Duns__c,GE_HQ_HQ_Parent_Duns__c, GE_HQ_Longitude__c, GE_HQ_Latitude__c, GE_HQ_ACCOUNT_ID__c,GE_HQ_KYC_Complete__c, IsPartner, GE_PRM_KYC_Completed__c,GE_HQ_GOVT_FLG__c,GE_PW_DB_DUNS_New_Request__c from account where id = :objAccountid limit 1];
        //GE_HQ_ACCOUNT_ID__c -- this is used to send the WEB_REQUEST_ID
        
        //Fetching the User Records           
        List<User> usrRec=[select id,Email,GE_HQ_SSO_ID__c from User where id=:objAccount.OwnerId];                 
         
        //changes made for comments to be sent from account notes object
        List<Account_Request_Note__c> accNoteCom = [Select id, Comments__c, Type__c, CreatedDate from Account_Request_Note__c where Type__c ='User' AND Account__c =:objAccount.id order by CreatedDate desc limit 1];               

        if(accNoteCom!= Null && accNoteCom.size() >0 && accNoteCom.isEmpty()== false && accNoteCom[0].Type__c=='User') { accDetails.COMMENTS=accNoteCom[0].Comments__c; }
        else {
            string accStr1 = '\"No Comments\"';
            accDetails.COMMENTS=accStr1; // Since there are no comments for this account the following note will be sent
        }
             
        accDetails.ACCOUNT_NAME=objAccount.name;
        //accDetails.SALESFORCE_ACCOUNT_ID=objAccount.GE_HQ_Account_Request_ID__c;
        accDetails.ACCOUNT_REQUEST_ID=objAccount.GE_HQ_Account_Request_ID__c;
        
       // Added by Raj
        if(objAccount.GE_HQ_ACCOUNT_ID__c!=null)
          //  accDetails.WEB_REQUEST_ID=Integer.valueOf(objAccount.GE_HQ_ACCOUNT_ID__c);
            accDetails.WEB_REQUEST_ID=objAccount.GE_HQ_ACCOUNT_ID__c;
        
        objAccount.GE_HQ_Requester_Id__c=usrRec[0].Email;
        objAccount.GE_HQ_SSO_ID__c=usrRec[0].GE_HQ_SSO_ID__c;
        accDetails.REQUESTER_ID=objAccount.GE_HQ_Requester_Id__c;
        accDetails.SSO_ID=objAccount.GE_HQ_SSO_ID__c;
        
        accDetails.SALESFORCE_ORG_ID=objAccount.GE_HQ_Org_ID__c;
        accDetails.REQUEST_TYPE=objAccount.GE_HQ_Request_Type__c;
        accDetails.SITE_USE_CODE=objAccount.GE_HQ_Site_Use_Code__c;
        System.debug('*******GE_PW_Send_to_CMF_Ship_To__c'+objAccount.GE_PW_Send_to_CMF_Ship_To__c);
        System.debug('*******GE_PW_Send_to_CMF_Bill_To__c'+objAccount.GE_PW_Send_to_CMF_Bill_To__c);
        System.debug('*******GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c'+objAccount.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c);
        if(objAccount.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c ||( objAccount.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c && objAccount.GE_PW_Send_to_CMF_Ship_To__c && objAccount.GE_PW_Send_to_CMF_Bill_To__c)||(objAccount.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c && objAccount.GE_PW_Send_to_CMF_Ship_To__c && !objAccount.GE_PW_Send_to_CMF_Bill_To__c)||(objAccount.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c && !objAccount.GE_PW_Send_to_CMF_Ship_To__c && objAccount.GE_PW_Send_to_CMF_Bill_To__c)){
            accDetails.CITY=objAccount.GE_PW_City_Quote_To_Sold_To_HQ__c;
            accDetails.COUNTRY=objAccount.GE_PW_Country_Quote_To_Sold_To_HQ__c;
            accDetails.POSTALCODE=objAccount.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c;
            accDetails.PROVINCE=objAccount.GE_PW_State_Province_Quote_To_Sold_To_HQ__c  ;          
            accDetails.STATE=objAccount.GE_PW_State_Province_Quote_To_Sold_To_HQ__c ;
            accDetails.STREET=objAccount.GE_PW_Street_Quote_To_Sold_To_HQ__c;
        }
        else if(objAccount.GE_PW_Send_to_CMF_Ship_To__c){
            accDetails.CITY=objAccount.GE_PW_City_Ship_To__c;
            accDetails.COUNTRY=objAccount.GE_PW_Country_Ship_To__c;
            accDetails.POSTALCODE=objAccount.GE_PW_Zip_Postal_Code_Ship_To__c;
            accDetails.PROVINCE=objAccount.GE_PW_State_Province_Ship_To__c;          
            accDetails.STATE=objAccount.GE_PW_State_Province_Ship_To__c;
            accDetails.STREET=objAccount.GE_PW_Street_Ship_To__c;
        }
        else if(objAccount.GE_PW_Send_to_CMF_Bill_To__c){
            accDetails.CITY=objAccount.GE_PW_City_Bill_To__c;
            accDetails.COUNTRY=objAccount.GE_PW_Country_Bill_To__c;
            accDetails.POSTALCODE=objAccount.GE_PW_Zip_Postal_Code_Bill_To__c;
            accDetails.PROVINCE=objAccount.GE_PW_State_Province_Bill_To__c;          
            accDetails.STATE=objAccount.GE_PW_State_Province_Bill_To__c;
            accDetails.STREET=objAccount.GE_PW_Street_Bill_To__c;
        }
            
        accDetails.DOCUMENTATION_URL1=objAccount.GE_HQ_Documentation__c;
        accDetails.DOCUMENTATION_URL2=objAccount.GE_HQ_Documentation1__c;
        accDetails.DOCUMENTATION_URL3=objAccount.GE_HQ_Documentation2__c;
        accDetails.DOCUMENTATION_URL4=objAccount.GE_HQ_Documentation3__c;
        accDetails.PHONE=objAccount.Phone ;
        accDetails.LEGACY_SYSTEM=objAccount.GE_HQ_Legacy_System__c;
        //accDetails.LEGACY_SYSTEM='SFDC';
        accDetails.Website=objAccount.Website;
        
        System.debug('********************'+objAccount.GE_HQ_REQUEST_STATUS__C);
        
        //Always 'W' and 'E' is sent for the CMF integration (R-4681). (Previously checked for (K,W,'' etc).
         accDetails.REQUEST_STATUS='W';
         accDetails.WATCHLIST_FLAG='E';

       
       
       
        // Added by Raj on 22 July 2011

        System.debug('********************'+accDetails.REQUEST_STATUS);
       
        
        //accDetails.REQUEST_STATUS=objAccount.GE_HQ_REQUEST_STATUS__C;
        //accDetails.WATCHLIST_FLAG=objAccount.GE_HQ_WATCHLIST_FLAG__c;
        accDetails.GE_MARKETING_NAME=objAccount.GE_HQ_MARKETING_NAME__c;
        accDetails.ALTERNATE_TRADE_STYLE_NAME=objAccount.GE_HQ_Alternate_Tradestyle_Name__c;
        accDetails.INTERNAL_CUSTOMER=objAccount.GE_HQ_Internal_Customer__c;
        accDetails.LONGITUDE=objAccount.GE_HQ_Longitude__c;
        accDetails.LATITUDE=objAccount.GE_HQ_Latitude__c;

                                          
        accDetails.VAT_REGISTRATION=objAccount.GE_HQ_Vat_Registration__c;
        accDetails.VAT_NUMBER=objAccount.GE_HQ_Vat_Number__c;
        accDetails.VAT_NOTES=objAccount.GE_HQ_Vat_Notes__c;
        accDetails.VAT_GROUP=objAccount.GE_HQ_Vat_Group__c;
        accDetails.SOURCE=objAccount.GE_HQ_Source__c;
        accDetails.LOCATION=objAccount.GE_HQ_Location__c;
        // Added By Durga
        //accDetails.GOVERNMENT_LEGAL_ENTITY_CHECK =objAccount.GE_HQ_GOVT_FLG__c;
        accDetails.GOVERNMENT_LEGAL_ENTITY_CHECK =String.valueOf(objAccount.GE_HQ_GOVT_FLG2__c);

        accDetails.VAT_REASON_CODE =objAccount.GE_HQ_Vat_Reg_Code__c;
        accDetails.GE_DATA_SOURCE =objAccount.GE_HQ_GE_VAT_Number_Data_Source__c;
        accDetails.VAT_EXPIRATION_DATE =String.valueOf(objAccount.GE_HQ_VAT_Expiration_Date__c);
        accDetails.Gold_ID =objAccount.GE_HQ_Gold_ID__c;
        accDetails.GLO_ULT_DUNS=objAccount.GE_HQ_Glo_Ult_Duns__c;
        accDetails.DOM_ULT_DUNS=objAccount.GE_HQ_Dom_Ult_Duns__c;
        accDetails.HQ_PARENT_DUNS=objAccount.GE_HQ_HQ_Parent_Duns__c; 
        
        //added by Harsh on 4th July 2013-- START
        List<GE_HQ_SUBSCR_SYSTEMS__c> subsList=[select id,name,GE_HQ_Account__c,GE_HQ_Subscr_Sys_Name__c,GE_OG_Org_Name__c from GE_HQ_SUBSCR_SYSTEMS__c where GE_HQ_Account__c=:objAccount.id];
        List<Business_Tier_Object__c> bToSubs=[select id,name,LEGACY_SYSTEM__c,ORG_NAME__c,ORG_ID__c from Business_Tier_Object__c];
        Map<String,String> legacyOrgMap=new Map<String,String>();
        for(Business_Tier_Object__c bSub:bToSubs){
            //String key=bSub.LEGACY_SYSTEM__c+bSub.ORG_NAME__c,;
            legacyOrgMap.put(bSub.ORG_NAME__c,bSub.ORG_ID__c);
        }
        String subString='';
        if(subsList.size()>0){
            for(GE_HQ_SUBSCR_SYSTEMS__c subs:subsList){
            //String fetchKey=subs.LEGACY_SYSTEM__c+subs.ORG_ID__c;
            if(subs.GE_OG_Org_Name__c==null /*&&(legacyOrgMap.get(subs.GE_HQ_Subscr_Sys_Name__c)==null || legacyOrgMap.get(subs.GE_HQ_Subscr_Sys_Name__c)=='')*/){
                subString+=subs.GE_HQ_Subscr_Sys_Name__c +'#'+'999'+';';
                //system.debug('*******orgIDS******'+legacyOrgMap.get(subs.GE_HQ_Subscr_Sys_Name__c));

            }else{
                subString+=subs.GE_HQ_Subscr_Sys_Name__c +'#'+legacyOrgMap.get(subs.GE_OG_Org_Name__c)+';';
                system.debug('*******orgIDS******'+legacyOrgMap.get(subs.GE_OG_Org_Name__c));
            }
            }
        }
        //subString=subString.removeEnd('#');
        //subString=subString+';';
        system.debug('*******orgIDS******'+subString);
        accDetails.ADDITIONAL_LEGACY_SYSTEMS=subString;
        accDetails.REQUESTED_DUNS=objAccount.GE_PW_DB_DUNS_New_Request__c;
        //END
         
        If(!FromTest) objResponse=webclient.publishCustomerRequest(accDetails); // Send the request
        System.debug('accDetails'+accDetails);
        System.debug('objAccountid'+objAccountid);
        System.debug('objResponse'+objResponse);
        wsdlstatus=objResponse.STATUS;
        wsdldesc=objResponse.ERROR_DESCRIPTION;
        System.debug('wsdlstatus'+wsdlstatus);
        // == Added for R-4681
        objAccount.GE_HQ_WebService_Response_Status__c = wsdlstatus;
        objAccount.GE_HQ_KYC_Completed__c = True;  // Check this field, so that User can directly submit to CMF if any modification required once KYC is Done. (Changed as per Bug# 0000006428)
        objAccount.GE_HQ_Request_Status__c ='Submitted To CMF';
        if(wsdlstatus == 'SUCCESS') { objAccount.GE_HQ_CMF_Request_Status__c ='N'; }
        
        Update objAccount;
        //== Addition ended
    }

/*     
    Public Account_Request__c AccountModifyRequest(Account_Request__c objAccReq)
    {

                    objAccReq=[select id,name,OwnerId,GE_HQ_Billing_Street__c,GE_HQ_Account_Name__c,GE_HQ_City__c,GE_HQ_Country__c,GE_HQ_Postal_Code__c,GE_HQ_Account_Request_ID__c,
                    GE_HQ_DUNS_Number__c,GE_HQ_Request_Type__c,GE_HQ_Site_Use_Code__c,GE_HQ_Billing_City__c,
                    GE_HQ_Billing_Country__c,GE_HQ_Billing_State_Province__c,GE_HQ_Billing_Zip_Postal_Code__c,GE_HQ_State_Province__c,GE_HQ_Street__c,GE_HQ_Phone__c,GE_HQ_Documentation1__c,
                    GE_HQ_Documentation2__c,GE_HQ_Documentation3__c,GE_HQ_Documentation4__c,GE_HQ_Legacy_System__c,GE_HQ_VAT_Registration__c,GE_HQ_Vat_Number__c,
                    GE_HQ_VAT_Notes__c,GE_HQ_Source__c,GE_HQ_Account__c,GE_HQ_VAT_Group__c,GE_HQ_SSO_ID__c,GE_HQ_Requester_Id__c,GE_HQ_Org_ID__c,GE_HQ_Original_Web_Request_Id__c,
                    GE_HQ_Location__c,GE_HQ_Website__c,GE_HQ_REQUEST_STATUS__C, GE_HQ_WATCHLIST_FLAG__c, GE_HQ_MARKETING_NAME__c,GE_HQ_Alternate_Tradestyle_Name__c,GE_HQ_Internal_Customer__c,
                    GE_HQ_GE_VAT_Number_Data_Source__c,GE_HQ_VAT_Expiration_Date__c,GE_HQ_Gold_ID__c,GE_HQ_Vat_Reg_Code__c,
                    GE_HQ_Requested_Account_Name__c, GE_HQ_Longitude__c, GE_HQ_Latitude__c, GE_HQ_WEB_REQUEST_ID__c from Account_Request__c where id =:objAccReq.id limit 1];
                     //GE_HQ_WEB_REQUEST_ID__c -- this is used to send the WEB_REQUEST_ID
                    
                    
                    //Fetching User Details
                    List<User> usrRec=[select id,Email,GE_HQ_SSO_ID__c from User where id=:objAccReq.OwnerId];
                    
                    //Fetching Modification Note Details
                    List<Account_Modification_Note__c> NoteCom = [select id, Comments__c from Account_Modification_Note__c where Account_Request__c=:objAccReq.id limit 1];
                    
                    //objAccReq.GE_HQ_Requester_Id__c=notecom[0].Comments__c;
                    system.debug('****************'+objAccReq.GE_HQ_Requester_Id__c);
                    string str2=objAccReq.GE_HQ_Original_Web_Request_Id__c; 
                    
                    if(NoteCom.isEmpty()==true)
                    {
                    system.debug('************************When no notes'+notecom);
                    accDetails.COMMENTS=str2; 
                    system.debug('**************accDetails.COMMENTS is:'+accDetails.COMMENTS);            
                    }
                    else
                    {
                    String str1=notecom[0].Comments__c;
                    accDetails.COMMENTS=str1+str2; 
                    system.debug('******************************************000000000'+accDetails.COMMENTS);
                    }            
               
                                 
                    accDetails.ACCOUNT_NAME=objAccReq.GE_HQ_Account_Name__c;//Account Formula field is mapped 
                    accDetails.ACCOUNT_REQUEST_ID=objAccReq.Name;
                                                     
                    //Email and EmployeeNumber are fetched based on the Account Owner
                    objAccReq.GE_HQ_SSO_ID__c=usrRec[0].GE_HQ_SSO_ID__c;
                    objAccReq.GE_HQ_Requester_Id__c=usrRec[0].Email;
                    
                    accDetails.REQUESTER_ID=objAccReq.GE_HQ_Requester_Id__c;
                    accDetails.SSO_ID=objAccReq.GE_HQ_SSO_ID__c;
                    
                    //required field for Account Modify Request
                    //accDetails.SALESFORCE_ACCOUNT_REQUEST_ID=Integer.valueof(objAccReq.GE_HQ_Account_Request_ID__c);
                    
                    if(objAccReq.GE_HQ_WEB_REQUEST_ID__c!=null)
                   // accDetails.WEB_REQUEST_ID=Integer.valueOf(objAccReq.GE_HQ_WEB_REQUEST_ID__c);
                    accDetails.WEB_REQUEST_ID=objAccReq.GE_HQ_WEB_REQUEST_ID__c;
                    accDetails.ACCOUNT_REQUEST_ID=objAccReq.GE_HQ_Account_Request_ID__c;
                    accDetails.SALESFORCE_ORG_ID=objAccReq.GE_HQ_Org_ID__c; 
                    accDetails.DUNS_NUMBER=objAccReq.GE_HQ_DUNS_Number__c;  
                    accDetails.REQUEST_TYPE=objAccReq.GE_HQ_Request_Type__c;
                    accDetails.SITE_USE_CODE=objAccReq.GE_HQ_Site_Use_Code__c;
                 
                    //This values are for Billing address
                    accDetails.BILLING_CITY=objAccReq.GE_HQ_Billing_City__c;//updated as per the updated WSDL 21st july
                    accDetails.BILLING_COUNTRY=objAccReq.GE_HQ_Billing_Country__c;//updated as per the updated WSDL 21st july
                    accDetails.BILLING_POSTAL_CODE=objAccReq.GE_HQ_Billing_Zip_Postal_Code__c;//updated as per the updated WSDL 21st july
                    accDetails.BILLING_STATE_PROVINCE=objAccReq.GE_HQ_Billing_State_Province__c;//updated as per the updated WSDL. 21st july
                    accDetails.BILLING_STREET=objAccReq.GE_HQ_Billing_Street__c;//updated as per the updated WSDL 21st july
                           
                    //This values are for shipping address                  
                    accDetails.CITY=objAccReq.GE_HQ_City__c;
                    accDetails.COUNTRY=objAccReq.GE_HQ_Country__c;
                    accDetails.POSTALCODE=objAccReq.GE_HQ_Postal_Code__c;
                    accDetails.PROVINCE=objAccReq.GE_HQ_Billing_State_Province__c; //This field is extra in wsdl from webmethods side and not needed         
                    accDetails.STATE=objAccReq.GE_HQ_State_Province__c;//This field is enough and the above field is not needed
                    accDetails.STREET=objAccReq.GE_HQ_Street__c;
                     
    
//                    if((objAccReq.GE_HQ_Site_Use_Code__c)=='BILL_TO')
//                          {
//                                 accDetails.CITY=objAccReq.GE_HQ_Billing_City__c;
//                                 accDetails.COUNTRY=objAccReq.GE_HQ_Billing_Country__c;
//                                 accDetails.POSTALCODE=objAccReq.GE_HQ_Billing_Zip_Postal_Code__c;
//                                 accDetails.PROVINCE=objAccReq.GE_HQ_Billing_State_Province__c;          
//                                 accDetails.STATE=objAccReq.GE_HQ_Billing_State_Province__c;
//                                 accDetails.STREET=objAccReq.GE_HQ_Billing_Street__c;
//                          }
//                    if((objAccReq.GE_HQ_Site_Use_Code__c)=='SHIP_TO')
//                          {
//                                  accDetails.CITY=objAccReq.GE_HQ_City__c;
//                                  accDetails.COUNTRY=objAccReq.GE_HQ_Country__c;
//                                  accDetails.POSTALCODE=objAccReq.GE_HQ_Postal_Code__c;
//                                  accDetails.PROVINCE=objAccReq.GE_HQ_Billing_State_Province__c;          
//                                  accDetails.STATE=objAccReq.GE_HQ_State_Province__c;
//                                  accDetails.STREET=objAccReq.GE_HQ_Street__c;
//                           }

                    accDetails.DOCUMENTATION_URL1=objAccReq.GE_HQ_Documentation1__c;
                    accDetails.DOCUMENTATION_URL2=objAccReq.GE_HQ_Documentation2__c;
                    accDetails.DOCUMENTATION_URL3=objAccReq.GE_HQ_Documentation3__c;
                    accDetails.DOCUMENTATION_URL4=objAccReq.GE_HQ_Documentation4__c;
                    accDetails.PHONE=objAccReq.GE_HQ_Phone__c;
                    accDetails.LEGACY_SYSTEM=objAccReq.GE_HQ_Legacy_System__c;
                    //accDetails.LEGACY_SYSTEM='SFDC';
                                                    
                    accDetails.VAT_REGISTRATION=objAccReq.GE_HQ_VAT_Registration__c;
                    accDetails.VAT_NUMBER=objAccReq.GE_HQ_Vat_Number__c;
                    accDetails.VAT_NOTES=objAccReq.GE_HQ_VAT_Notes__c;
                    accDetails.VAT_GROUP=objAccReq.GE_HQ_VAT_Group__c;
                    accDetails.SOURCE=objAccReq.GE_HQ_Source__c;
                    accDetails.LOCATION=objAccReq.GE_HQ_Location__c;
                    accDetails.WEBSITE=objAccReq.GE_HQ_Website__c;//updated as per the updated WSDL 21st July.
                    
//                      if(objAccReq.GE_HQ_REQUEST_STATUS__C=='New')
//                       {
//                         accDetails.REQUEST_STATUS='W';
//                       }
//                   
//                   if(objAccReq.GE_HQ_REQUEST_STATUS__C=='New')
//                       {
//                         accDetails.WATCHLIST_FLAG='W';
//                       }

                   If(objAccReq.GE_HQ_REQUEST_STATUS__C=='New' || objAccReq.GE_HQ_REQUEST_STATUS__C=='Pending User Review')
                       {
                         accDetails.REQUEST_STATUS='W';
                       }
                       
                       if(objAccReq.GE_HQ_REQUEST_STATUS__C=='New' || objAccReq.GE_HQ_REQUEST_STATUS__C=='Pending User Review')
                       {
                         accDetails.WATCHLIST_FLAG='E';
                       }
                                       
                   //accDetails.REQUEST_STATUS=objAccReq.GE_HQ_REQUEST_STATUS__C;
                   //accDetails.WATCHLIST_FLAG=objAccReq.GE_HQ_WATCHLIST_FLAG__c;
                   accDetails.GE_MARKETING_NAME=objAccReq.GE_HQ_MARKETING_NAME__c;
                   accDetails.ALTERNATE_TRADE_STYLE_NAME=objAccReq.GE_HQ_Alternate_Tradestyle_Name__c;
                   accDetails.INTERNAL_CUSTOMER=objAccReq.GE_HQ_Internal_Customer__c;
                   accDetails.REQUESTED_ACCOUNT_NAME=objAccReq.GE_HQ_Requested_Account_Name__c;
                   accDetails.LONGITUDE=objAccReq.GE_HQ_Longitude__c;
                   accDetails.LATITUDE=objAccReq.GE_HQ_Latitude__c;
                   
                   // Added Durga
                   
                    accDetails.VAT_REASON_CODE =objAccReq.GE_HQ_Vat_Reg_Code__c;
                    accDetails.GE_DATA_SOURCE =objAccReq.GE_HQ_GE_VAT_Number_Data_Source__c;
                    accDetails.VAT_EXPIRATION_DATE =String.valueOf(objAccReq.GE_HQ_VAT_Expiration_Date__c);
                    accDetails.Gold_ID =objAccReq.GE_HQ_Gold_ID__c;
                   
                   
                                    
                    objResponse=webclient.publishAccount(accDetails);
                    System.debug('==============================Service Response Start==============================');
                    System.debug(objResponse.STATUS + '==============================' + objResponse.ERROR_DESCRIPTION);
                    System.debug('==============================Service Response Stop==============================');
                    
                    wsdlstatus=objResponse.STATUS;
                    wsdldesc=objResponse.ERROR_DESCRIPTION;
           return objAccReq;
          
   }
*/
}