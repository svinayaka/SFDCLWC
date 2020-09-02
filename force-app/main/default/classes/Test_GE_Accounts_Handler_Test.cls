@IsTest
Public Class Test_GE_Accounts_Handler_Test
{
   static testmethod void createTest()
   {
        Account acc = Test_GE_Accounts_Handler.createAccount();   
                
        GE_PRM_KYC_Termination_Checklist__c kyc = createKYCTermination(acc);
        
        GE_HQ_Country__c count=Test_GE_Accounts_Handler.coun();                  
        /*count.Name='ARGENTINA';
        count.GE_OG_Finance_Country_Risk__c='High';
        count.GE_PW_VAT_Format__c='TestFormat';
        count.GE_OG_Tax_ID_Format__c =  'TestForm';
        update count;*/
        
        Test_GE_Accounts_Handler.cmfn(count);
        Business_Tier_Object__c bus = Test_GE_Accounts_Handler.bus(acc,kyc);
        GE_OG_ERP_Detail__c ce =  Test_GE_Accounts_Handler.createERP(acc,kyc);
        Account_Request__c  ar =   Test_GE_Accounts_Handler.accountReq(acc);
        
        Account_Request_Note__c  arn = Test_GE_Accounts_Handler.arn(acc);
        
        Account_Request__c rr=   Test_GE_Accounts_Handler.TempAccModReqObj(ar);
        Test_GE_Accounts_Handler.createAcct();
        GE_HQ_Country__c  c1=  Test_GE_Accounts_Handler.coun1();
        Test_GE_Accounts_Handler.cmfcoun(rr , c1);
        Test_GE_Accounts_Handler.Acckyc(acc);
        Test_GE_Accounts_Handler.councmf(acc,count );
          Test_GE_Accounts_Handler.Subs(acc);
          Test_GE_Accounts_Handler.salesteam(kyc);
          Test_GE_Accounts_Handler.acnt();
          Test_GE_Accounts_Handler.fin(acc,kyc);
          //Test_GE_Accounts_Handler.Accf();
          Test_GE_Accounts_Handler.kycf(acc);
          Test_GE_Accounts_Handler.a();
          Test_GE_Accounts_Handler.b();
          Test_GE_Accounts_Handler.fina(acc,kyc,count);
         
    }
    
    
   
   public static GE_PRM_KYC_Termination_Checklist__c  createKYCTermination(Account acc)
   {  
  
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
}