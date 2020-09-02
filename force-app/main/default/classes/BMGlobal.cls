public class BMGlobal {
Public void aMethod(){}

    public static final String TEST_USER = 'BM ~ Test User';
    public static final String TEST_USER_100 = 'BM ~ Test 100 User';
    public static final String ERROR_MULTIPLE_ACTIVE_CONFIGS = 'Error: only one active BigMachines Configuration record must exist';
    public static final String ERROR_NO_CONFIG_RECORD = 'Error: No BigMachines Configuration record exists';
    //public static final String ERROR_NO_ACTIVE_CONFIG_RECORD = 'Error: At least one active BigMachines Configuration record should exist';
    public static final String ERROR_USER_NOT_PROVISIONED = 'Error: A BigMachines session was not established and therefore the user was not provisioned';
    public static final String ERROR_USER_EXIST_CHECK = 'Error: CheckUserExist returned an error while checking the user in BigMachines';
    public static final String ERROR_USER_ADD_UPDATE = 'Error: User was not Added/Updated within BigMachines';
    public static final String ERROR_CALLOUT_LIMIT_REACHED = 'Error: Your Salesforce Asynchronous call limit has reached, please try this function again later';
    //salesforce error
    public static final String ERROR_SFDC_CALLOUT_LIMIT_REACHED = 'FutureRequests Request Limit';   
    
    public static final String BM_SUPER_USER = 'superuser';
    public static final String BM_INTERNAL_USER = 'Internal User';
    public static final String BM_PARTNER_USER = 'Partner User';
    public static final String SECURITY = 'Security';
    public static final String XMLNS_BM = 'xmlns:bm';
    public static final String XMLNS_BM_CATEGORY = 'bm:category';
    public static final String XMLNS_BM_URN = 'urn:soap.bigmachines.com';
    public static final String SOAPENV_ACTOR = 'soapenv:actor';
    public static final String SOAPENV_ACTOR_URL = 'http://schemas.xmlsoap.org/soap/actor/next';
    public static final String SOAPENV_MUSTUNDERSTAND = 'soapenv:mustUnderstand';
    public static final String SOAPENV_MUSTUNDERSTAND_VALUE = '0';
    public static final String BM_XSDINFO = 'bm:xsdInfo';
    public static final String BM_SCHEMA_LOCATION = 'bm:schemaLocation';
    public static final String BM_LOGIN = 'bm:login';
    public static final String BM_LOGOUT = 'bm:logout';
    public static final String BM_USER_INFO = 'bm:userInfo';
    public static final String BM_USER_NAME = 'bm:username';
    public static final String BM_PASSWORD = 'bm:password';
    public static final String XML_VERSION_ENCODING = '<?xml version="1.0" encoding="UTF-8"?>';

    public static final String SOAP_ENV_HEADER = 'soapenv:Header';
    public static final String SOAP_ENV_BODY = 'soapenv:Body';
    public static final String SOAPENV_ENVELOPE = 'soapenv:Envelope';
    public static final String XMLNS_SOAPENV = 'xmlns:soapenv';
    public static final String XMLNS_SOAPENV_VALUE = 'http://schemas.xmlsoap.org/soap/envelope/';
    public static final String XMLNS_XSD = 'xmlns:xsd';
    public static final String XMLNS_XSD_VALUE = 'http://www.w3.org/2001/XMLSchema';
    public static final String XMLNS_XSI = 'xmlns:xsi';
    public static final String XMLNS_XSI_VALUE = 'http://www.w3.org/2001/XMLSchema-instance';

    public static final String SESSIONID_VALUE = '7f00000150447d8961f5a9447b8d23d0c9f7e9f8a1';
    public static final String METHOD = 'POST';
    public static final String OK = 'OK';   
    public static final String BM_SESSIONID = 'sessionId';
    public static final String BM_EXCEPTIONMESSAGE  = 'exceptionMessage';
    public static final String BM_SUCCESS = 'success';
    public static final String BM_SUB_DOMAIN = '%subdomain%';
    public static final String BM_HTTP_REPLACE_VALUE = '%http%';

    public static final String BM_HTTP_VALUE = 'http';
    public static final String BM_HTTP_WITH_SSL_VALUE = 'https';
    public static final String BM_END_POINT = '%http%://%subdomain%.bigmachines.com/v1_0/receiver';
    public static final String BM_SECURITY_SCHEMA_LOCATION_VALUE = '%http%://%subdomain%.bigmachines.com/bmfsweb/%subdomain%/schema/v1_0/security/Security.xsd';
    public static final String BM_USER_SCHEMA_LOCATION_VALUE = '%http%://%subdomain%.bigmachines.com/bmfsweb/%subdomain%/schema/v1_0/users/Users.xsd';
    public static final String BM_COMPANY_VALUE = '%subdomain%';
    public static final String BM_BILL_COMPANY_VALUE = 'BMI Salesforce-Demo';
    public static final String BM_TYPE_SALES_AGENT = 'SalesAgent';
    public static final String BM_GET_USER = 'bm:getUser';
    public static final String BM_ADD_USERS = 'bm:addUsers';
    public static final String BM_UPDATE_USERS = 'bm:updateUsers';
    public static final String BM_USER_ID = 'bm:user_id';
    public static final String USERS = 'Users';
    public static final String BM_USER = 'bm:User';
    public static final String BM_EACH_RECORD = 'bm:each_record';
    public static final String BM_SESSION_ID = 'bm:sessionId';

    public static final String BM_PARTNER_LOGIN = 'bm:partner_login';
    public static final String BM_PARTNER_PASSWORD = 'bm:partner_password';
    public static final String BM_SEND_PASSWORD_EMAIL = 'bm:send_password_email';
    public static final String BM_PARTNER_PASSWORD_VALUE = 'passw0rd';

    public static final String BM_COMPANY_NAME = 'bm:company_name';
    public static final String BM_TYPE = 'bm:type';
    public static final String BM_FIRST_NAME = 'bm:first_name';
    public static final String BM_LAST_NAME = 'bm:last_name';
    public static final String BM_JOB_TITLE = 'bm:job_title';
    public static final String BM_EMAIL = 'bm:email';
    public static final String BM_PHONE = 'bm:phone';
    public static final String BM_FAX = 'bm:fax';
    public static final String BM_BILL_ADDRESS = 'bm:bill_address';
    public static final String BM_BILL_ADDRESS_2 = 'bm:bill_address_2';
    public static final String BM_BILL_CITY = 'bm:bill_city';
    public static final String BM_BILL_STATE = 'bm:bill_state';
    public static final String BM_BILL_STATE_PROVINCE = 'bm:bill_state_province';
    public static final String BM_BILL_ZIP = 'bm:bill_zip';
    public static final String BM_BILL_COUNTRY = 'bm:bill_country';
    public static final String BM_SEPARATE_SHIP_ADDR = 'bm:separate_ship_addr';
    public static final String BM_SHIP_ADDRESS_1 = 'bm:ship_address_1';
    public static final String BM_SHIP_ADDRESS_2 = 'bm:ship_address_2';
    public static final String BM_SHIP_CITY = 'bm:ship_city';
    public static final String BM_SHIP_STATE = 'bm:ship_state';
    public static final String BM_SHIP_STATE_PROVINCE = 'bm:ship_state_province';
    public static final String BM_SHIP_ZIP = 'bm:ship_zip';
    public static final String BM_SHIP_COUNTRY = 'bm:ship_country';
    public static final String BM_NOTIFICATION_PREF = 'bm:notification_pref';
    public static final String BM_IS_NOTIFY_PREF = 'bm:is_notify_email';
    public static final String BM_LANGUAGE = 'bm:bm_language';
    public static final String BM_CURRENCY_PREFERENCE = 'bm:currency_preference';
    public static final String BM_BILL_FIRST_NAME = 'bm:bill_first_name';
    public static final String BM_BILL_LAST_NAME = 'bm:bill_last_name';
    public static final String BM_BILL_COMPANY = 'bm:bill_company';
    public static final String BM_BILL_COMPANY_2 = 'bm:bill_company_2';
    public static final String BM_BILL_PHONE = 'bm:bill_phone';
    public static final String BM_BILL_FAX = 'bm:bill_fax';
    public static final String BM_BILL_EMAIL = 'bm:bill_email';
    public static final String BM_SHIP_FIRST_NAME = 'bm:ship_first_name';
    public static final String BM_SHIP_LAST_NAME = 'bm:ship_last_name';
    public static final String BM_SHIP_COMPANY = 'bm:ship_company';
    public static final String BM_SHIP_COMPANY_2 = 'bm:ship_company_2';
    public static final String BM_SHIP_PHONE = 'bm:ship_phone';
    public static final String BM_SHIP_FAX = 'bm:ship_fax';
    public static final String BM_SHIP_EMAIL = 'bm:ship_email';
    public static final String BM_UNITS = 'bm:bm_units';
    public static final String BM_DATE_FORMAT = 'bm:date_format';
    public static final String BM_TIME_ZONE = 'bm:time_zone';
    public static final String BM_NUMBER_FORMAT = 'bm:number_format';
    public static final String BM_STATUS = 'bm:status';
    public static final String BM_GROUP_LIST = 'bm:group_list';
    public static final String BM_GROUP = 'bm:group';
    public static final String BM_VARIABLE_NAME = 'variable_name';


    public static final String BODY = 'Body';
    public static final String GET_USER = 'getUser';
    public static final String USER_INFO = 'userInfo';
    public static final String USER_ID = 'user_id';
    public static final String BM = 'bm';
    
    public static final String BM_RECORDS_FAILED = 'records_failed';
    public static final String BM_FALSE = 'false';
    public static final String BM_SUCCESSFUL = 'successful';
    public static final String BM_MESSAGE = 'message';
    public static final String BM_DETAILEDSTATUS = 'detailedStatus';
    public static final String BM_RECORD = 'record';
    public static final String IN_ACTIVE_STATUS = 'Inactive';
    public static final String ACTIVE_STATUS = 'Active';
    public static final String NULL_STRING = 'null';
    
}