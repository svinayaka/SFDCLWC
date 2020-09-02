/*
Type Name [Class/Trigger/Page Name] : Accounts Class Handler
Used Where ?                        : 
Purpose/Overview                    :
Functional Area                     : Accounts
Author                              : Levaka Divya
Created Date                        : 05/26/2014           
Change History -
Date Modified   : Developer Name    : Method/Section Modified/Added     : Purpose/Overview of Change
*/
public class Test_GE_Accounts_Handler
{
    /* this method is used for creating 'Account' record, that is using in all Accounts test classes for creating Account */
    public static Account createAccount()
    {
        User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        Account Acc= new Account();
        Acc.Name='Test Acc For TestClass';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
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


       
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
        acc.RecordTypeId=acc1;
        acc.GE_OG_AccFin_Status__c='In Progress';
        acc.GE_HQ_Request_Status__c ='CMF Approved';
        acc.ShippingCountry ='ARGENTINA';
        acc.GE_PW_Phone_New_Request__c='(111)111-1111';
        if (!Test.isRunningTest())
{
        insert acc;}
        return acc;
    }   
    
    /* this method is used for creating 'KYC' record, that is using in all Accounts test classes for creating 'KYC' */
    public static GE_PRM_KYC_Termination_Checklist__c createKYC(Account acc)
    {
       GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
        ky.GE_HQ_Account__c=acc.Id;
        ky.GE_PRM_Recommendation__c=recom.id;
        ky.GE_OG_Fin_Status__c='Completed';
        ky.GE_PW_KYC_Type__c = 'In Progress';
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        ky.RecordTypeId=kyc1;
               if (!Test.isRunningTest())
{
        insert ky;}
        return ky;
    }
    
      /* this method is used for creating 'ERP' record, that is using in all Accounts test classes for creating 'ERP' */
    public static GE_OG_ERP_Detail__c createERP(Account Acc,GE_PRM_KYC_Termination_Checklist__c ky)
    {
     User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];     
        GE_OG_ERP_Detail__c erp=new GE_OG_ERP_Detail__c();
        GE_PRM_App_Structure__c struct=new GE_PRM_App_Structure__c();        
        erp.GE_OG_ERP_Is_this_Customer_Tax_Exempt__c='Yes';
        erp.GE_OG_KYC__c=ky.ID;        
        erp.GE_OG_ERP_Sales_Person__c=u.id;
        erp.GE_OG_ERP_Sales_Person_First_Name__c='Test';
        erp.GE_OG_ERP_CSR_Person__c=u.id;
        erp.GE_OG_Advance_User__c=acc.id;
        erp.GE_OG_ERP_Sales_Person_Last_Name__c='Test';
        erp.GE_OG_ERP_CSR_First_Name__c='Test';
        erp.GE_OG_ERP_CSR_Last_Name__c='Test';
        erp.GE_OG_ERP_Sales_Person_Email__c='Test@test.com';
        erp.GE_OG_ERP_CSR_Email__c='Testcsr@test.com';       
        erp.GE_OG_ERP_Sales_Person_Email__c='email@email.com';
        erp.GE_OG_ERP_Outbound_Timestamp__c = String.valueOf(system.now());
               if (!Test.isRunningTest())
{
        insert erp;}
        return erp;
    }
    
      /* this method is used for creating account modification record, that is using in all Accounts test classes */
    public static Account_Request__c accountReq(Account acc){
        Account_Request__c accReq = new  Account_Request__c();
        accReq.GE_HQ_Account__c=Acc.Id;
        accReq.GE_HQ_Nts_Comments__c='Test 1';
        accReq.GE_HQ_Country__c='UNITED STATES';   
        accReq.GE_HQ_Phone__c='9999009991';
        accReq.Shipping_Street_Up__c = 'xyz street';
        accReq.GE_HQ_Street__c = 'bfsdjkaf';
        accReq.Shipping_City_Up__c = 'Atlanta';
        accReq.GE_HQ_City__c = 'Atlanta';
        accReq.Shipping_State_Province_Up__c = 'Atlanta';
        accReq.GE_HQ_State_Province__c = 'Atlanta';
        accReq.Shipping_PostalCode_Up__c = '6251245';
        accReq.GE_HQ_Postal_Code__c = '54516545';
        accReq.Shipping_Country_Up__c = 'UNITED STATES';
        accReq.GE_HQ_Country__c = 'UNITED STATES';
        accReq.GE_PW_Modify_Requested_Account_Name__c = false;
        accReq.GE_HQ_Requested_Account_Name_Up__c = 'NewAccount';
        accReq.GE_HQ_Requested_Account_Name__c = 'NewAccount';
        accReq.GE_HQ_Site_Use_Code__c = 'BOTH'; 
        accReq.GE_PW_KYC_Status__c = 'Pending User Submission';         
               if (!Test.isRunningTest())
{
        insert accReq;}
        return accReq;

    }
      /* this method is used for creating account modification notes ,that is using in all Accounts test classes*/
        public static Account_Request_Note__c arn(Account acc){    
        Account_Request_Note__c arn = new Account_Request_Note__c();
        arn.Comments__c=acc.GE_HQ_Nts_Comments__c;
              if (!Test.isRunningTest())
{
        insert arn;  }
        return arn;
        } 
    
public static Account_Request__c TempAccModReqObj(Account_Request__c accReq)
{
List<Account_Request__c> TempAccModReqObj = new List<Account_Request__c> ([select id,GE_HQ_Account__r.id,Shipping_Street_Up__c, GE_HQ_Street__c, Shipping_City_Up__c, GE_HQ_City__c, Shipping_State_Province_Up__c, GE_HQ_State_Province__c, Shipping_PostalCode_Up__c, GE_HQ_Postal_Code__c, Shipping_Country_Up__c, GE_HQ_Country__c, GE_PW_Modify_Requested_Account_Name__c, GE_HQ_Requested_Account_Name_Up__c, GE_HQ_Requested_Account_Name__c, GE_HQ_Site_Use_Code__c from Account_Request__c where id=:accReq.Id ]);
return null;
}   

  /* this method is used for creating Account record, that is using in all Accounts test classes */
     public static Account createAcct()
    {
        Account acct=new Account();         
        User user=[Select id,FirstName,LastName,Email from user  where Email != Null limit 1];
        acct.GE_HQ_New_Account_Country__c='ARGENTINA';
        acct.Name='test';
        acct.GE_PW_Select_Type_of_Business__c='Publically Traded Company';
        acct.GE_PW_Country_Quote_To_Sold_To_HQ__c='Test';
        acct.GE_PW_Country_Bill_To__c='Test';
        acct.GE_PW_Country_Ship_To__c='Test';
        acct.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        acct.GE_OG_Buss_Tier2__c='TMS';
        acct.GE_OG_Buss_Tier3__c='Opex - CS';
        acct.GE_PW_KYC_Status__c='Manual Due Diligence Approved';
        acct.GE_OG_AccFin_Status__c ='Stared';
        acct.GE_HQ_New_Account_Street__c = 'Test';
         acct.GE_HQ_New_Account_City__c ='Test';
         acct.GE_HQ_New_Account_State_Province__c='Test';
         acct.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
         acct.GE_HQ_New_Account_Country__c= 'TEst';
              if (!Test.isRunningTest())
{
        insert acct;}
        return acct;
     }
     
       /* this method is used for creating country record, that is using in all Accounts test classes*/
         public static GE_HQ_Country__c coun()
      { 
        GE_HQ_Country__c coun=new GE_HQ_Country__c();
        coun.GE_PW_Risk_Type__c ='Low' ;
        coun.GE_HQ_ISO_Code__c='67';
        coun.GE_PW_ITC__c=true;
        coun.GE_OG_Tax_ID_Format__c = 'test';
               if (!Test.isRunningTest())
{
        insert coun;}
        return coun;
       }
       
         public static GE_HQ_Country__c coun1(){
        GE_HQ_Country__c coun1 = new GE_HQ_Country__c();
        coun1.Name = 'UNITED STATES';
        coun1.GE_HQ_ISO_Code__c = 'UT';
        coun1.GE_PW_ITC__c = false;     
        coun1.GE_PW_CIS_Non_CIS__c = false;
        coun1.GE_HQ_Sanct_Cnty__c = false;
        coun1.GE_PW_VATApplicabl__c = false; 
        coun1.GE_PW_Risk_Type__c = 'Low';
            if (!Test.isRunningTest())
{
       insert coun1;}
       return coun1;
       }
       
         /* this method is used for creating CMF country record, that is using in all Accounts test classes */
        public static GE_PW_CMFtoISOCountryName__c cmfcoun(Account_Request__c accReq,GE_HQ_Country__c coun1){
        try{
        GE_PW_CMFtoISOCountryName__c CMFcountry = new  GE_PW_CMFtoISOCountryName__c();        
        CMFcountry.GE_PW_Country_Name__c='UNITED STATES';
        CMFcountry.GE_PW_AML_Name__c='UNITED STATES';    
        CMFcountry.GE_PW_Active__c='Yes';
        CMFcountry.GE_PW_CMF_Name__c = accReq.GE_HQ_Country__c;
        CMFcountry.GE_PW_Country__c= coun1.id;
             if (!Test.isRunningTest())
{
        insert CMFcountry; }}catch (Exception ex){}
        return null; 
       }
       
        public static GE_PW_CMFtoISOCountryName__c cmfn(GE_HQ_Country__c coun1){
        GE_PW_CMFtoISOCountryName__c cmf = new GE_PW_CMFtoISOCountryName__c();
        cmf.GE_PW_CMF_Name__c = 'UNITED STATES';
        cmf.GE_PW_Country__c = coun1.Id;
        cmf.GE_PW_AML_Name__c = 'UNITED STATES';
        cmf.GE_PW_Country_Name__c ='UNITED STATES';
               if (!Test.isRunningTest())
{
        insert cmf;}
        return cmf;
        }
          /* this method is used for creating 'KYC' record, that is using in all Accounts test classes for creating 'KYC' */
        public static GE_PRM_KYC_Termination_Checklist__c Acckyc(Account Acc){
        GE_PRM_KYC_Termination_Checklist__c kyc01=new GE_PRM_KYC_Termination_Checklist__c();
        kyc01.GE_HQ_Account__c=acc.Id;
        kyc01.GE_PRM_Recommendation__c='a1WA0000001CX4N';
        String rt = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Locked Record Type').getRecordTypeId();
        kyc01.RecordTypeId=rt;
        kyc01.GE_HQ_Status__c='Manual Due Diligence Approved';      
               if (!Test.isRunningTest())
{
        insert kyc01; }
        return kyc01;
        }       
       
         /* this method is used for creating Finance record, that is using in all Accounts test classes*/
       public static GE_OG_Finance_Details__c fina(Account acc,GE_PRM_KYC_Termination_Checklist__c kyc01,GE_HQ_Country__c coun1){
        GE_OG_Finance_Details__c fina=new GE_OG_Finance_Details__c();
        fina.GE_OG_Finance_Status__c='Completed';
        fina.GE_OG_KYC__c=kyc01.id;
        fina.GE_OG_Account__c = acc.Id; 
        fina.GE_OG_Finance_Credit_Limit__c = '$500001 - $1000000';
        fina.GE_HQ_Finance_Risk_Score__c = '-1.5 to 1.5';
        fina.GE_OG_Finance_Country_Risk__c=  coun1.GE_OG_Finance_Country_Risk__c;
              if (!Test.isRunningTest())
{
        insert fina; }
        return fina;
        }
       
       
        public static GE_PW_CMFtoISOCountryName__c councmf(Account acct,GE_HQ_Country__c coun)
        {
        GE_PW_CMFtoISOCountryName__c councmf=new GE_PW_CMFtoISOCountryName__c();
        councmf.GE_PW_CMF_Name__c = acct.GE_PW_Country_Quote_To_Sold_To_HQ__c;
        councmf.GE_PW_Country__c=coun.id;
               if (!Test.isRunningTest())
{
        insert councmf;}
        return councmf;
        }
        
  /* this method is used for creating Business Tier object record, that is using in all Accounts test classes */
       public static Business_Tier_Object__c bus(Account acct,GE_PRM_KYC_Termination_Checklist__c ky)
       {
        Business_Tier_Object__c bus=new Business_Tier_Object__c();
        bus.Business_Tier_11__c=acct.GE_OG_Buss_Tier1__c;
        bus.Business_Tier_2__c=acct.GE_OG_Buss_Tier2__c;
        bus.Business_Tier_3__c=acct.GE_OG_Buss_Tier3__c;
        bus.LEGACY_SYSTEM__c='Test';
        bus.Business_Unit__c='Test';
        bus.ORG_ID__c='Test';
        bus.ORG_NAME__c='Test';
        bus.Default_Yes_No__c='Y';
        bus.ERP_Live_Yes_No__c='Y';
        bus.KYCLookup__c=ky.id;
               if (!Test.isRunningTest())
{
        insert bus; }
        return bus;
        }
        
         /* this method is used for creating SUBS record, that is using in all Accounts test classes */ 
        public static GE_HQ_SUBSCR_SYSTEMS__c Subs(Account acct)
        {
        GE_HQ_SUBSCR_SYSTEMS__c Subs=new GE_HQ_SUBSCR_SYSTEMS__c();
        Subs.GE_HQ_Account__c=acct.id;
        Subs.GE_HQ_Business_Tier1__c=acct.GE_OG_Buss_Tier1__c;
        Subs.GE_HQ_Business_Tier2__c=acct.GE_OG_Buss_Tier2__c;
        Subs.GE_HQ_Business_Tier3__c=acct.GE_OG_Buss_Tier3__c;
        Subs.GE_HQ_Business_Unit__c= 'Business_Unit';
        Subs.GE_HQ_Subscr_Sys_Name__c= 'LEGACY_SYSTEM ';
        Subs.GE_OG_Org_Name__c= 'ORG_NAME ';
        Subs.GE_HQ_Account__c= acct.id;
        Subs.GE_OG_Status_val__c='True';
        Subs.GE_OG_Default__c='Y';
               if (!Test.isRunningTest())
{
        insert Subs;}
        return Subs;
        }
       
         /* this method is used for creating PRM app structure record, that is using in all Accounts test classes*/ 
        public static GE_PRM_App_Structure__c salesteam(GE_PRM_KYC_Termination_Checklist__c ky)
        {
        GE_PRM_App_Structure__c salesteam=new  GE_PRM_App_Structure__c();
        salesteam.GE_PRM_Ownership__c=100;
        salesteam.GE_PRM_City__c='New Delhi';
        salesteam.GE_PRM_Contact__c='test';
        salesteam.GE_PRM_Legal_Country__c='ARGENTINA';
        salesteam.GE_HQ_KYC__c =ky.Id;
        salesteam.GE_PRM_Name__c='testName';
        salesteam.GE_PRM_Nationality__c='Indian';
        salesteam.GE_PRM_Phone__c='2734767463';
        salesteam.GE_PRM_Title__c='testMr';
        salesteam.GE_PRM_Complete_Address__c='new delhi';
               if (!Test.isRunningTest())
{
        insert salesteam; }
        return salesteam;
        }
       
       public static Account acnt()
       {
        Account acnt=new Account();       
        acnt.Name='Test';        
        acnt.GE_PW_Select_Type_of_Business__c='Publically Traded Company';
        acnt.GE_PW_Country_Quote_To_Sold_To_HQ__c='Test';
        acnt.GE_PW_Country_Bill_To__c='Test';
        acnt.GE_PW_Country_Ship_To__c='Test';
        acnt.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        acnt.GE_OG_Buss_Tier2__c='TMS';
        acnt.GE_OG_Buss_Tier3__c='Opex - CS';
        acnt.GE_PW_KYC_Status__c='Manual Due Diligence Approved';
        acnt.GE_OG_AccFin_Status__c ='Stared';
        acnt.GE_HQ_Comments__c ='testing account';
        acnt.GE_HQ_Nts_Comments__c ='testing accounts';
        acnt.GE_PW_Phone_New_Request__c ='8374284738';
        acnt.GE_HQ_New_Account_City__c ='new Delhi';
        acnt.GE_HQ_New_Account_State_Province__c ='test New Delhi';
        acnt.GE_HQ_New_Account_Zip_Postal_Code__c ='38574857';
        acnt.GE_HQ_New_Account_Street__c ='Test road';
        acnt.GE_HQ_New_Account_Country__c='ARGENTINA';
               if (!Test.isRunningTest())
{
        insert acnt;}
        return acnt;
        }
        
        public static GE_OG_Finance_Details__c fin(Account acnt,GE_PRM_KYC_Termination_Checklist__c ky)
        {
        GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();      
        fin.GE_OG_Account__c=acnt.id;
        fin.GE_OG_KYC__c=ky.id;
        fin.GE_OG_Finance_Status__c = 'Started';
        fin.GE_OG_Com_Finance_Contact_First_Name__c =' test';
        fin.GE_OG_Com_Finance_Contact_Last_Name__c =' test';
        fin.GE_OG_Com_Finance_Contact_Email__c ='test@ge.com';
        fin.GE_OG_Cust_accepted__c = true;
        fin.GE_OG_Comment__c = 'test';
        fin.GE_OG_Credit_Line_Request__c = '0';
        fin.GE_OG_Finance_Country_Risk__c='High';
               if (!Test.isRunningTest())
{
        insert fin; }
        return fin;
        }    
        
        /*public static Account Accf(){
        Account accf=new Account();
        accf.Name='Test';
        accf.GE_PW_Street_Quote_To_Sold_To_HQ__c='Test';
        accf.GE_PW_City_Quote_To_Sold_To_HQ__c='testcity';
        accf.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='teststate';
        accf.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='testcode';
        accf.GE_PW_Country_Quote_To_Sold_To_HQ__c='testquote';
        accf.GE_HQ_New_Account_Country__c='ARGENTINA';
        //acc.GE_HQ_Site_Use_Code__c='Test';
        accf.GE_HQ_Site_Use_Code__c='BOTH';
        accf.ShippingCity='test';
        accf.ShippingPostalCode='test';
        accf.ShippingState='test';
        accf.ShippingStreet='test';
        accf.ShippingCountry='test';
        accf.BillingCity='test';
        accf.BillingState='test';
        accf.BillingStreet='test';
        accf.BillingPostalCode='test';
        accf.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        accf.GE_OG_Buss_Tier2__c='Digital Solutions';
        accf.GE_OG_Buss_Tier3__c='Bently Nevada';
        accf.GE_HQ_KYC_Complete__c=TRUE;
        accf.GE_PRM_KYC_Completed__c=TRUE;
        //accf.GE_OG_AccFin_Status__c='In Progress';
        //accf.GE_HQ_Request_Status__c ='CMF Approved';
        
         accf.GE_HQ_New_Account_Street__c = 'Test';
         accf.GE_HQ_New_Account_City__c ='Test';
         accf.GE_HQ_New_Account_State_Province__c='Test';
         accf.GE_HQ_New_Account_Zip_Postal_Code__c='201301';
         accf.GE_HQ_New_Account_Country__c= 'TEst';
        
        accf.ShippingCountry ='United States';
        accf.GE_PW_Phone_New_Request__c='(111)111-1111';
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('New_Request');
        Id acc1=rtByName_acc1.getRecordTypeId();
        accf.RecordTypeId=acc1;
        insert accf;
        return accf;
        }*/
          /* this method is used for creating 'KYC' record, that is using in all Accounts test classes for creating 'KYC' */
        public static GE_PRM_KYC_Termination_Checklist__c kycf(Account acc){
         GE_PRM_KYC_Termination_Checklist__c kyc=new GE_PRM_KYC_Termination_Checklist__c(); 
         List<GE_PRM_Recommendation__c> recom= new list<GE_PRM_Recommendation__c>([select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1]);
        kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
        kyc.GE_HQ_Account__c=acc.Id;
        //kyc.GE_PRM_Recommendation__c=recom[0].Id;     
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
        Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
        Id kyc1=rtByName_kyc1.getRecordTypeId();
        kyc.RecordTypeId=kyc1;
        kyc.GE_OG_Finance_checked__c = True;
        kyc.GE_PW_Risk_Type__c = 'Low';
               if (!Test.isRunningTest())
{
        insert kyc;}
        return null;
        }
        
        public static Account a(){
                Account a = new Account(Name = 'a test account',
                                ShippingStreet = '123 Test Ave.',
                                ShippingCity = 'Testville',
                                ShippingPostalCode = '32951',
                                ShippingState = 'MH',
                                ShippingCountry = 'IN_TESTX',
                                GE_HQ_DUNS_Number__c = 'test',
                                GE_HQ_SIC1__c=7359,GE_HQ_SIC2__c=7363,GE_HQ_SIC3__c=7359);
                               
                if (!Test.isRunningTest())
{                       
        insert a; }
       List<Account> act =new List<Account>([Select ID,GE_ES_SIC1_Description__c,GE_ES_SIC2_Description__c,GE_ES_SIC3_Description__c from Account where Id =: a.Id limit 1]);
        return null;
        }
        
        public static Account b(){
                Account a = new Account(name='Unittest TT1 Account',
                                ShippingStreet='123 Taj rd', 
                                ShippingCity='Mumbai', 
                                ShippingState='MH', 
                                ShippingPostalCode='20143', 
                                ShippingCountry='IN_TESTX',
                                GE_HQ_SIC1__c=7359,GE_HQ_SIC2__c=7363,GE_HQ_SIC3__c=7370,
                                GE_HQ_DUNS_Number__c = 'test');        
               if (!Test.isRunningTest())
{
        insert a;
}

        a.GE_HQ_SIC1__c=6153;
        a.GE_HQ_SIC2__c=6159;  
        a.GE_HQ_SIC3__c=6162;
        a.ShippingCountry='IN_TESTX2';
               if (!Test.isRunningTest())
{
        update a; }
        
        List<Account> ac2 = new list<Account>([Select ID, GE_ES_Sales_Region__c, GE_ES_SIC1_Description__c,GE_ES_SIC2_Description__c,GE_ES_SIC3_Description__c from Account where Id =: a.Id limit 1]);
        return null;
        }
        
    
}