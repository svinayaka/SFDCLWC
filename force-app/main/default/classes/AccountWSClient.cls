//Generated by wsdl2apex

Global class AccountWSClient {
    Global class publishAccount {
        public AccountWSClient.Request Request;
        private String[] Request_type_info = new String[]{'Request','http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','Request','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','false','false'};
        private String[] field_order_type_info = new String[]{'Request'};
    }
    Global class SERVICE_ENVELOPE {
        public String OPERATION;
        public String SOURCE_SYSTEM;
        public String TARGET_SYSTEM;
        public String VERSION;
        public String MESSAGE_TYPE;
        public String INTERFACE_NAME;
        public String BATCH_NUM;
        public String UNIQUE_TXN_ID;
        public String SOURCE_BUSINESS;
        public String TARGET_BUSINESS;
        public String TIMESTAMP;
        private String[] OPERATION_type_info = new String[]{'OPERATION','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] SOURCE_SYSTEM_type_info = new String[]{'SOURCE_SYSTEM','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] TARGET_SYSTEM_type_info = new String[]{'TARGET_SYSTEM','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] VERSION_type_info = new String[]{'VERSION','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] MESSAGE_TYPE_type_info = new String[]{'MESSAGE_TYPE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] INTERFACE_NAME_type_info = new String[]{'INTERFACE_NAME','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] BATCH_NUM_type_info = new String[]{'BATCH_NUM','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] UNIQUE_TXN_ID_type_info = new String[]{'UNIQUE_TXN_ID','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] SOURCE_BUSINESS_type_info = new String[]{'SOURCE_BUSINESS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] TARGET_BUSINESS_type_info = new String[]{'TARGET_BUSINESS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] TIMESTAMP_type_info = new String[]{'TIMESTAMP','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','false','false'};
        private String[] field_order_type_info = new String[]{'OPERATION','SOURCE_SYSTEM','TARGET_SYSTEM','VERSION','MESSAGE_TYPE','INTERFACE_NAME','BATCH_NUM','UNIQUE_TXN_ID','SOURCE_BUSINESS','TARGET_BUSINESS','TIMESTAMP'};
    }
    Global class Response {
        public AccountWSClient.SERVICE_ENVELOPE SERVICE_ENVELOPE;
        public String STATUS;
        public String ERROR_DESCRIPTION;
        private String[] SERVICE_ENVELOPE_type_info = new String[]{'SERVICE_ENVELOPE','http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','SERVICE_ENVELOPE','1','1','true'};
        private String[] STATUS_type_info = new String[]{'STATUS','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] ERROR_DESCRIPTION_type_info = new String[]{'ERROR_DESCRIPTION','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','false','false'};
        private String[] field_order_type_info = new String[]{'SERVICE_ENVELOPE','STATUS','ERROR_DESCRIPTION'};
    }
    Global class Request {
        public AccountWSClient.SERVICE_ENVELOPE SERVICE_ENVELOPE;
        public String ACCOUNT_NAME;
        public String ACCOUNT_REQUEST_ID;
        public String REQUESTER_ID;
        public String SSO_ID;
        public String WEB_REQUEST_ID;
        public String SALESFORCE_ORG_ID;
        public String DUNS_NUMBER;
        public String HQ_PARENT_DUNS;
        public String DOM_ULT_DUNS;
        public String GLO_ULT_DUNS;
        public String REQUEST_TYPE;
        public String SITE_USE_CODE;
        public String CITY;
        public String COUNTRY;
        public String POSTALCODE;
        public String PROVINCE;
        public String STATE;
        public String STREET;
        public String COMMENTS;
        public String DOCUMENTATION_URL1;
        public String DOCUMENTATION_URL2;
        public String DOCUMENTATION_URL3;
        public String DOCUMENTATION_URL4;
        public String PHONE;
        public String LEGACY_SYSTEM;
        public Integer WEB_REQUEST_REF;
        public String VAT_REGISTRATION;
        public String VAT_NUMBER;
        public String VAT_NOTES;
        public String VAT_GROUP;
        public String SOURCE;
        public String LOCATION;
        public String BILLING_POSTAL_CODE;
        public String BILLING_CITY;
        public String BILLING_COUNTRY;
        public String BILLING_STATE_PROVINCE;
        public String BILLING_STREET;
        public String WEBSITE;
        public String REQUEST_STATUS;
        public String WATCHLIST_FLAG;
        public String REQUESTED_ACCOUNT_NAME;
        public String LATITUDE;
        public String LONGITUDE;
        public String INTERNAL_CUSTOMER;
        public String ALTERNATE_TRADE_STYLE_NAME;
        public String GOLD_ID;
        public String GE_MARKETING_NAME;
        public String VAT_EXPIRATION_DATE;
        public String GE_DATA_SOURCE;
        public String GOVERNMENT_LEGAL_ENTITY_CHECK;
        public String VAT_REASON_CODE;
        public String REQUESTED_DUNS;
        public String ADDITIONAL_LEGACY_SYSTEMS;
        private String[] SERVICE_ENVELOPE_type_info = new String[]{'SERVICE_ENVELOPE','http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','SERVICE_ENVELOPE','1','1','true'};
        private String[] ACCOUNT_NAME_type_info = new String[]{'ACCOUNT_NAME','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] ACCOUNT_REQUEST_ID_type_info = new String[]{'ACCOUNT_REQUEST_ID','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] REQUESTER_ID_type_info = new String[]{'REQUESTER_ID','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] SSO_ID_type_info = new String[]{'SSO_ID','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] WEB_REQUEST_ID_type_info = new String[]{'WEB_REQUEST_ID','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] SALESFORCE_ORG_ID_type_info = new String[]{'SALESFORCE_ORG_ID','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] DUNS_NUMBER_type_info = new String[]{'DUNS_NUMBER','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] HQ_PARENT_DUNS_type_info = new String[]{'HQ_PARENT_DUNS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] DOM_ULT_DUNS_type_info = new String[]{'DOM_ULT_DUNS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] GLO_ULT_DUNS_type_info = new String[]{'GLO_ULT_DUNS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] REQUEST_TYPE_type_info = new String[]{'REQUEST_TYPE','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] SITE_USE_CODE_type_info = new String[]{'SITE_USE_CODE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] CITY_type_info = new String[]{'CITY','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] COUNTRY_type_info = new String[]{'COUNTRY','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] POSTALCODE_type_info = new String[]{'POSTALCODE','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] PROVINCE_type_info = new String[]{'PROVINCE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] STATE_type_info = new String[]{'STATE','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] STREET_type_info = new String[]{'STREET','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] COMMENTS_type_info = new String[]{'COMMENTS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] DOCUMENTATION_URL1_type_info = new String[]{'DOCUMENTATION_URL1','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] DOCUMENTATION_URL2_type_info = new String[]{'DOCUMENTATION_URL2','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] DOCUMENTATION_URL3_type_info = new String[]{'DOCUMENTATION_URL3','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] DOCUMENTATION_URL4_type_info = new String[]{'DOCUMENTATION_URL4','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] PHONE_type_info = new String[]{'PHONE','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] LEGACY_SYSTEM_type_info = new String[]{'LEGACY_SYSTEM','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] WEB_REQUEST_REF_type_info = new String[]{'WEB_REQUEST_REF','http://www.w3.org/2001/XMLSchema','int','0','1','true'};
        private String[] VAT_REGISTRATION_type_info = new String[]{'VAT_REGISTRATION','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] VAT_NUMBER_type_info = new String[]{'VAT_NUMBER','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] VAT_NOTES_type_info = new String[]{'VAT_NOTES','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] VAT_GROUP_type_info = new String[]{'VAT_GROUP','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] SOURCE_type_info = new String[]{'SOURCE','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] LOCATION_type_info = new String[]{'LOCATION','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] BILLING_POSTAL_CODE_type_info = new String[]{'BILLING_POSTAL_CODE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] BILLING_CITY_type_info = new String[]{'BILLING_CITY','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] BILLING_COUNTRY_type_info = new String[]{'BILLING_COUNTRY','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] BILLING_STATE_PROVINCE_type_info = new String[]{'BILLING_STATE_PROVINCE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] BILLING_STREET_type_info = new String[]{'BILLING_STREET','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] WEBSITE_type_info = new String[]{'WEBSITE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] REQUEST_STATUS_type_info = new String[]{'REQUEST_STATUS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] WATCHLIST_FLAG_type_info = new String[]{'WATCHLIST_FLAG','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] REQUESTED_ACCOUNT_NAME_type_info = new String[]{'REQUESTED_ACCOUNT_NAME','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] LATITUDE_type_info = new String[]{'LATITUDE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] LONGITUDE_type_info = new String[]{'LONGITUDE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] INTERNAL_CUSTOMER_type_info = new String[]{'INTERNAL_CUSTOMER','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] ALTERNATE_TRADE_STYLE_NAME_type_info = new String[]{'ALTERNATE_TRADE_STYLE_NAME','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] GOLD_ID_type_info = new String[]{'GOLD_ID','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] GE_MARKETING_NAME_type_info = new String[]{'GE_MARKETING_NAME','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] VAT_EXPIRATION_DATE_type_info = new String[]{'VAT_EXPIRATION_DATE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] GE_DATA_SOURCE_type_info = new String[]{'GE_DATA_SOURCE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] GOVERNMENT_LEGAL_ENTITY_CHECK_type_info = new String[]{'GOVERNMENT_LEGAL_ENTITY_CHECK','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] VAT_REASON_CODE_type_info = new String[]{'VAT_REASON_CODE','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] REQUESTED_DUNS_type_info = new String[]{'REQUESTED_DUNS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] ADDITIONAL_LEGACY_SYSTEMS_type_info = new String[]{'ADDITIONAL_LEGACY_SYSTEMS','http://www.w3.org/2001/XMLSchema','string','0','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','false','false'};
        private String[] field_order_type_info = new String[]{'SERVICE_ENVELOPE','ACCOUNT_NAME','ACCOUNT_REQUEST_ID','REQUESTER_ID','SSO_ID','WEB_REQUEST_ID','SALESFORCE_ORG_ID','DUNS_NUMBER','HQ_PARENT_DUNS','DOM_ULT_DUNS','GLO_ULT_DUNS','REQUEST_TYPE','SITE_USE_CODE','CITY','COUNTRY','POSTALCODE','PROVINCE','STATE','STREET','COMMENTS','DOCUMENTATION_URL1','DOCUMENTATION_URL2','DOCUMENTATION_URL3','DOCUMENTATION_URL4','PHONE','LEGACY_SYSTEM','WEB_REQUEST_REF','VAT_REGISTRATION','VAT_NUMBER','VAT_NOTES','VAT_GROUP','SOURCE','LOCATION','BILLING_POSTAL_CODE','BILLING_CITY','BILLING_COUNTRY','BILLING_STATE_PROVINCE','BILLING_STREET','WEBSITE','REQUEST_STATUS','WATCHLIST_FLAG','REQUESTED_ACCOUNT_NAME','LATITUDE','LONGITUDE','INTERNAL_CUSTOMER','ALTERNATE_TRADE_STYLE_NAME','GOLD_ID','GE_MARKETING_NAME','VAT_EXPIRATION_DATE','GE_DATA_SOURCE','GOVERNMENT_LEGAL_ENTITY_CHECK','VAT_REASON_CODE','REQUESTED_DUNS','ADDITIONAL_LEGACY_SYSTEMS'};
    }
    Global class publishAccountResponse {
        public AccountWSClient.Response Response;
        private String[] Response_type_info = new String[]{'Response','http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','Response','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD','false','false'};
        private String[] field_order_type_info = new String[]{'Response'};
    }
    Global class GE_SFDC_OG_CustomerRequest_Source_WebServices_Provider_publishCustomerRequest_WSD_Port {
        public String endpoint_x = 'http://SATHST-PCS76745.gegdc.ad:5555/ws/GE_SFDC_OG_CustomerRequest_Source.WebServices.Provider:publishCustomerRequest_WSD';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD', 'AccountWSClient'};
        public AccountWSClient.Response publishCustomerRequest(AccountWSClient.Request Request) {
            AccountWSClient.publishAccount request_x = new AccountWSClient.publishAccount();
            AccountWSClient.publishAccountResponse response_x;
            request_x.Request = Request;
            Map<String, AccountWSClient.publishAccountResponse> response_map_x = new Map<String, AccountWSClient.publishAccountResponse>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'GE_SFDC_OG_CustomerRequest_Source_WebServices_Provider_publishCustomerRequest_WSD_Binder_publishCustomerRequest',
              'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD',
              'publishAccount',
              'http://SATHST-PCS76745.gegdc.ad/GE_SFDC_OG_CustomerRequest_Source/WebServices/Provider/publishCustomerRequest_WSD',
              'publishAccountResponse',
              'AccountWSClient.publishAccountResponse'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.Response;
        }
    }
}