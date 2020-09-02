@IsTest
Public Class GE_OG_LinkAccountToERPController_Test{

   static testMethod void GE_OG_LinkAccountToERPController1() {
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true; 
    Account Acc= new Account();
    Acc.Name='Test Acc For TestClass';  
    Acc.GE_HQ_Request_Status__c='CMF Approved';
    Acc.GE_HQ_KYC_Complete__c=TRUE;
    Acc.GE_PRM_KYC_Completed__c=TRUE;
    Acc.GE_HQ_DUNS_Number__c='555123459';  
    Acc.GE_OG_Buss_Tier1__c='Oil & Gas';
    Acc.GE_OG_Buss_Tier2__c='Lufkin';
    Acc.GE_OG_Buss_Tier3__c='Oilfield';
    Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
    Acc.GE_PW_City_Bill_To__c='United States';
    Acc.GE_PW_State_Province_Bill_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
    Acc.GE_PW_City_Ship_To__c='city';
    Acc.GE_PW_State_Province_Ship_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    Acc.GE_HQ_Nts_Comments__c='Test';
    acc.GE_HQ_New_Account_Street__c = 'Test';
    acc.GE_HQ_New_Account_City__c ='Test';
    acc.GE_HQ_New_Account_State_Province__c='Test';
    acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
    acc.GE_HQ_New_Account_Country__c= 'TEst';
    insert acc;   
      
    GE_PRM_KYC_Termination_Checklist__c kyc = createKYCTermination(acc);//Test_GE_Accounts_Handler.createKYC(acc);

    GE_HQ_Country__c count = Test_GE_Accounts_Handler.coun();                  
    count.Name ='ARGENTINA';
    count.GE_OG_Finance_Country_Risk__c = 'High';
    count.GE_PW_VAT_Format__c = 'TestFormat';
    count.GE_OG_Tax_ID_Format__c =  'TestForm';
    insert count;

    count.Name='ARGENTINA';
    count.GE_OG_Finance_Country_Risk__c='High';
    count.GE_PW_VAT_Format__c='TestFormat';
    count.GE_OG_Tax_ID_Format__c =  'TestForm';
    update count;
        
    acc.GE_HQ_New_Account_Street__c = 'Test';
    Test_GE_Accounts_Handler.cmfn(count);

    System.assertEquals(count.GE_OG_Finance_Country_Risk__c,'High');

    // GE_OG_Finance_Details__c fin=Test_GE_Accounts_Handler.fin(acc,kyc);        
    commonexecution (acc);
    }

    static testMethod void GE_OG_LinkAccountToERPController2(){
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;   
    Account Acc= new Account();
    Acc.Name='Test Acc For TestClass';  
    Acc.GE_HQ_Request_Status__c='CMF Approved';
    Acc.GE_HQ_KYC_Complete__c=TRUE;
    Acc.GE_PRM_KYC_Completed__c=TRUE;
    Acc.GE_HQ_DUNS_Number__c='555123459';  
    Acc.GE_OG_Buss_Tier1__c='Oil & Gas';
    Acc.GE_OG_Buss_Tier2__c='Lufkin';
    Acc.GE_OG_Buss_Tier3__c='Oilfield';
    Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
    Acc.GE_PW_City_Bill_To__c='United States';
    Acc.GE_PW_State_Province_Bill_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
    Acc.GE_PW_City_Ship_To__c='city';
    Acc.GE_PW_State_Province_Ship_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    Acc.GE_HQ_Nts_Comments__c='Test';
    acc.GE_HQ_New_Account_City__c ='Test';
    acc.GE_HQ_New_Account_State_Province__c='Test';
    acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
    acc.GE_HQ_New_Account_Country__c= 'TEst';
    insert acc;          

    GE_HQ_Country__c count=new GE_HQ_Country__c();
    count.GE_PW_Risk_Type__c ='Medium' ;
    count.GE_HQ_ISO_Code__c='67';
    count.GE_PW_ITC__c=false;
    count.GE_OG_Tax_ID_Format__c = 'test';
    //coun1.GE_PW_ITC__c = true;
    count.GE_PW_VATApplicabl__c = true; 
    count.Name='India';
    count.GE_OG_Finance_Country_Risk__c='Low';
    count.GE_PW_VAT_Format__c='TestFormat';
    insert count;               


    PageReference pgRef = Page.GE_OG_LinkAccountToERP; 
    Test.setCurrentPage(pgRef); 
    ApexPages.currentPage().getParameters().put('id', acc.id);
    ApexPages.StandardController sc = new ApexPages.StandardController(acc);
    GE_OG_LinkAccountToERPController erpcont=new GE_OG_LinkAccountToERPController(sc);


    System.assertEquals(count.GE_OG_Finance_Country_Risk__c,'Low');
    commonexecution (acc);
    }

 static testMethod void GE_OG_LinkAccountToERPController3() {
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;     
    Account Acc= new Account();
    Acc.Name='Test Acc For TestClass';  
    Acc.GE_HQ_Request_Status__c='CMF Approved';
    Acc.GE_HQ_KYC_Complete__c=TRUE;
    Acc.GE_PRM_KYC_Completed__c=TRUE;
    Acc.GE_HQ_DUNS_Number__c='555123459';  
    Acc.GE_OG_Buss_Tier1__c='Oil & Gas';
    Acc.GE_OG_Buss_Tier2__c='Lufkin';
    Acc.GE_OG_Buss_Tier3__c='Oilfield';
    Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
    Acc.GE_PW_City_Bill_To__c='United States';
    Acc.GE_PW_State_Province_Bill_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
    Acc.GE_PW_City_Ship_To__c='city';
    Acc.GE_PW_State_Province_Ship_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    Acc.GE_HQ_Nts_Comments__c='Test';
    acc.GE_HQ_New_Account_Street__c = 'Test';
    acc.GE_HQ_New_Account_City__c ='Test';
    acc.GE_HQ_New_Account_State_Province__c='Test';
    acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
    acc.GE_HQ_New_Account_Country__c= 'TEst';
    insert acc;  

    GE_HQ_Country__c count=new GE_HQ_Country__c();
    count.GE_PW_Risk_Type__c ='Medium' ;
    count.GE_HQ_ISO_Code__c='67';
    count.GE_PW_ITC__c=false;
    count.GE_OG_Tax_ID_Format__c = 'test';
    //coun1.GE_PW_ITC__c = true;
    count.GE_PW_VATApplicabl__c = true; 
    count.Name='India';
    count.GE_OG_Finance_Country_Risk__c='Low';
    count.GE_PW_VAT_Format__c='TestFormat';
    count.GE_OG_Tax_ID_Format__c =  'TestForm';
    insert count;                 


    Test_GE_Accounts_Handler.cmfn(count);

    System.assertEquals(count.GE_OG_Finance_Country_Risk__c,'Low');
    GE_PRM_KYC_Termination_Checklist__c kyc = createKYCTermination(acc);//Test_GE_Accounts_Handler.createKYC(acc);

    //GE_OG_ERP_Detail__c checkerp= [select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:Acc.id];
    // GE_OG_ERP_Detail__c checkerp= [select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c limit 1];

    GE_OG_ERP_Detail__c checkerp= new  GE_OG_ERP_Detail__c();
    insert checkerp;
    checkerp.GE_OG_ERP_Account__c=Acc.id;
    update checkerp;
    delete checkerp;      

    Business_Tier_Object__c bus=new Business_Tier_Object__c();
    bus.Business_Tier_11__c=acc.GE_OG_Buss_Tier1__c;
    bus.Business_Tier_2__c=acc.GE_OG_Buss_Tier2__c;
    bus.Business_Tier_3__c=acc.GE_OG_Buss_Tier3__c;
    bus.LEGACY_SYSTEM__c='Test';
    bus.Business_Unit__c='Test';
    bus.ORG_ID__c='Test';
    bus.ORG_NAME__c='Test';
    //bus.Default_Yes_No__c='Y';
    bus.ERP_Live_Yes_No__c='Y';
    bus.KYCLookup__c=kyc.id;
    bus.Default_Yes_No__c = 'N';
    insert bus;

    commonexecution (acc);
    }

  static testMethod void GE_OG_LinkAccountToERPController4() {
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;   
    Account Acc= new Account();
    Acc.Name='Test Acc For TestClass';  
    Acc.GE_HQ_Request_Status__c='CMF Approved';
    Acc.GE_HQ_KYC_Complete__c=TRUE;
    Acc.GE_PRM_KYC_Completed__c=TRUE;
    Acc.GE_HQ_DUNS_Number__c='555123459';  
    Acc.GE_OG_Buss_Tier1__c='Oil & Gas';
    Acc.GE_OG_Buss_Tier2__c='Lufkin';
    Acc.GE_OG_Buss_Tier3__c='Oilfield';
    Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
    Acc.GE_PW_City_Bill_To__c='United States';
    Acc.GE_PW_State_Province_Bill_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
    Acc.GE_PW_City_Ship_To__c='city';
    Acc.GE_PW_State_Province_Ship_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    Acc.GE_HQ_Nts_Comments__c='Test';
    acc.GE_HQ_New_Account_Street__c = 'Test';
    acc.GE_HQ_New_Account_City__c ='Test';
    acc.GE_HQ_New_Account_State_Province__c='Test';
    acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
    acc.GE_HQ_New_Account_Country__c= 'TEst';
    acc.GE_HQ_Site_Use_Code__c = 'BOTH';

    insert acc;   

    GE_HQ_Country__c count=new GE_HQ_Country__c();
    count.GE_PW_Risk_Type__c ='Low' ;
    count.GE_HQ_ISO_Code__c='67';
    count.GE_PW_ITC__c=true;
    count.GE_OG_Tax_ID_Format__c = 'test';        count.Name = 'TOGO';
    count.GE_HQ_ISO_Code__c = 'TQ';
    count.GE_PW_Risk_Type__c = 'HIGH';
    count.Name='India';
    count.GE_OG_Finance_Country_Risk__c='Low';
    count.GE_PW_VAT_Format__c='TestFormat';
    insert count;  

    commonexecution (acc);
    }

  public static void commonexecution (Account Acct){
    
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
    Test.Starttest();
    PageReference pgRef = Page.GE_OG_LinkAccountToERP; 
    Test.setCurrentPage(pgRef); 
    ApexPages.currentPage().getParameters().put('id', Acct.id);
    ApexPages.StandardController sc = new ApexPages.StandardController(Acct);
    GE_OG_LinkAccountToERPController erpcont=new GE_OG_LinkAccountToERPController(sc);

    erpcont.ERPRedirect();
    erpcont.CancelRequest();
    erpcont.getDefaultval();
    erpcont.TierMethod();
    erpcont.getTier();
    erpcont.getSelected();
    erpcont.getSaveval();
    erpcont.GetSelectedTier();
    erpcont.getDefaultStatusval();
    erpcont.getDefaultmethod();
    erpcont.input();       
    erpcont.Submit();
    Test.Stoptest();
    }


 public static GE_PRM_KYC_Termination_Checklist__c  createKYCTermination(Account acc) {      
 
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
    Id rt1 = Schema.SObjectType.GE_PRM_Recommendation__c.getRecordTypeInfosByName().get('New/Renewal').getRecordTypeId();
    // GE_PRM_Appointment__c App= new GE_PRM_Appointment__c(GE_PRM_Status__c ='Approved',GE_PRM_Account_Name__c = acc.id, recordtypeid = rt);  Insert App;
    //System.assertequals(App.GE_PRM_Status__c,'Approved');        

    //GE_PRM_Recommendation__c Recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' And recordtypeid =: rt1 limit 1];
    GE_PRM_Recommendation__c recom = new  GE_PRM_Recommendation__c(GE_PRM_KYC_Page__c='Completed', recordtypeid=rt1);
    insert recom;

    // String KYCRevId, KYCLFId, KYCCheckId;

    Id KYCRevId=Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('KYC Review').getRecordTypeId();
    ID KYCCheckId=Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('KYC Short Form - Approved').getRecordTypeId();
    Id KYCLFId=Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Locked Record Type').getRecordTypeId();

    Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
    Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
    Id kyc1=rtByName_kyc1.getRecordTypeId();

    // GE_PRM_KYC_Termination_Checklist__c kyc =[select id,name from  GE_PRM_KYC_Termination_Checklist__c where  recordtypeid =: kyc1 and GE_HQ_Account__r.GE_PRM_KYC_Completed__c=TRUE And GE_PRM_Status__c = 'KYC In Progress' and GE_HQ_Status__c = 'Manual Due Diligence Approved' limit 1];
    GE_PRM_KYC_Termination_Checklist__c kyc=new GE_PRM_KYC_Termination_Checklist__c();
    kyc.GE_HQ_Status__c='Manual Due Diligence Sent back';
    kyc.GE_PRM_Status__c='KYC Need More Information';
    kyc.recordtypeid=kyc1;
    kyc.GE_HQ_Account__c=acc.id;
    kyc.GE_PRM_Recommendation__c=recom.id;
    kyc.GE_HQ_SFDC_LEGACY_ID__c='12345678';
    insert kyc;

    return kyc;
    }

  static testMethod void GE_OG_LinkAccountToERPController5() {
        
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;   
    Account Acc= new Account();
    Acc.Name='Test Acc For TestClass';  
    Acc.GE_HQ_Request_Status__c='CMF Approved';
    Acc.GE_HQ_KYC_Complete__c=TRUE;
    Acc.GE_PRM_KYC_Completed__c=TRUE;
    Acc.GE_HQ_DUNS_Number__c='555123459';  
    Acc.GE_OG_Buss_Tier1__c='Oil & Gas';
    Acc.GE_OG_Buss_Tier2__c='Digital Solutions';
    Acc.GE_OG_Buss_Tier3__c='Flow & Process Technologies';
    Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
    Acc.GE_PW_City_Bill_To__c='United States';
    Acc.GE_PW_State_Province_Bill_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
    Acc.GE_PW_City_Ship_To__c='city';
    Acc.GE_PW_State_Province_Ship_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    Acc.GE_HQ_Nts_Comments__c='Test';
    acc.GE_HQ_New_Account_Street__c = 'Test';
    acc.GE_HQ_New_Account_City__c ='Test';
    acc.GE_HQ_New_Account_State_Province__c='Test';
    acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
    acc.GE_HQ_New_Account_Country__c= 'TEst';
    acc.GE_HQ_Site_Use_Code__c = 'BILL_TO';
    acc.GE_PW_Phone_Ship_To__c ='';
    acc.GE_PW_Phone_Bill_To__c ='8963217459';
    insert acc;   

    GE_HQ_Country__c count=new GE_HQ_Country__c();
    count.GE_PW_Risk_Type__c ='Low' ;
    count.GE_HQ_ISO_Code__c='67';
    count.GE_PW_ITC__c=true;
    count.GE_OG_Tax_ID_Format__c = 'test';        count.Name = 'TOGO';
    count.GE_HQ_ISO_Code__c = 'TQ';
    count.GE_PW_Risk_Type__c = 'HIGH';
    count.Name='India';
    count.GE_OG_Finance_Country_Risk__c='Medium';
    count.GE_PW_VAT_Format__c='TestFormat';
    insert count;  

    commonexecution (acc);
    } 
    
  static testMethod void GE_OG_LinkAccountToERPController6() { 

    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;   
    Account Acc= new Account();
    Acc.Name='Test Acc For TestClass';  
    Acc.GE_HQ_Request_Status__c='CMF Approved';
    Acc.GE_HQ_KYC_Complete__c=TRUE;
    Acc.GE_PRM_KYC_Completed__c=TRUE;
    Acc.GE_HQ_DUNS_Number__c='555123459';  
    Acc.GE_OG_Buss_Tier1__c='Oil & Gas';
    Acc.GE_OG_Buss_Tier2__c='Digital Solutions';
    Acc.GE_OG_Buss_Tier3__c='Flow & Process Technologies';
    Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
    Acc.GE_PW_City_Bill_To__c='United States';
    Acc.GE_PW_State_Province_Bill_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
    Acc.GE_PW_City_Ship_To__c='city';
    Acc.GE_PW_State_Province_Ship_To__c='state';
    Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    Acc.GE_HQ_Nts_Comments__c='Test';
    acc.GE_HQ_New_Account_Street__c = 'Test';
    acc.GE_HQ_New_Account_City__c ='Test';
    acc.GE_HQ_New_Account_State_Province__c='Test';
    acc.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
    acc.GE_HQ_New_Account_Country__c= 'TEst';
    acc.GE_HQ_Site_Use_Code__c = 'BOTH';
    acc.GE_PW_Phone_Ship_To__c ='';
    acc.GE_PW_Phone_Bill_To__c ='8963217459';
    insert acc;   

    GE_HQ_Country__c count=new GE_HQ_Country__c();
    count.GE_PW_Risk_Type__c ='Low' ;
    count.GE_HQ_ISO_Code__c='67';
    count.GE_PW_ITC__c=true;
    count.GE_OG_Tax_ID_Format__c = 'test';        count.Name = 'TOGO';
    count.GE_HQ_ISO_Code__c = 'TQ';
    count.GE_PW_Risk_Type__c = 'HIGH';
    count.Name='India';
    count.GE_OG_Finance_Country_Risk__c='Medium';
    count.GE_PW_VAT_Format__c='TestFormat';
    insert count;  

    commonexecution (acc);
    }
    }