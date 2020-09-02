@isTest
public class GE_OG_Insert_FinHistoryTest{
    static testMethod void validateFinHistory(){    

    Account acc = new Account();
    GE_HQ_Country__c coun=new GE_HQ_Country__c();    
    GE_PRM_KYC_Termination_Checklist__c kyc=new GE_PRM_KYC_Termination_Checklist__c();
    GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
    GE_OG_Fin_Histry__c finhistory= new GE_OG_Fin_Histry__c();
        
    Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('Relationship Account');
    Id acc1=rtByName_acc1.getRecordTypeId();
    Test.startTest();
    acc.Name='Test';
    acc.GE_HQ_New_Account_Country__c='ARGENTINA';
    acc.GE_HQ_KYC_Complete__c=TRUE;
    acc.GE_PRM_KYC_Completed__c=TRUE;
    acc.RecordTypeId=acc1;
    acc.GE_OG_Buss_Tier2__c ='Digital Solutions';
    acc.Type = 'Direct Customer';
    acc.Classification__c = 'Strategic';
    insert acc;

    /*GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];*/
    
    GE_PRM_Recommendation__c recom = new GE_PRM_Recommendation__c();
    recom.GE_PRM_KYC_Page__c = 'Partially Completed';
    insert recom;
    
    kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
    kyc.GE_HQ_Account__c=acc.Id;
    kyc.GE_OG_Finance_checked__c=true;
    kyc.GE_PRM_Recommendation__c=recom.Id;
    //kyc.RecordTypeId='012Z00000000L8L';
    Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
    Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
    Id kyc1=rtByName_kyc1.getRecordTypeId();
    kyc.RecordTypeId=kyc1;
    kyc.GE_PW_KYC_Type__c = 'New Account';
    insert kyc;

    coun.GE_HQ_ISO_Code__c='12';
    coun.GE_OG_Finance_Country_Risk__c='High';
    coun.GE_PW_VATApplicabl__c=TRUE;
    coun.GE_PW_VAT_Format__c='Test';
    insert coun;

    fin.GE_OG_Account__c = acc.Id; 
    fin.GE_OG_KYC__c = kyc.Id;
    fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
    fin.GE_OG_Finance_Status__c = 'In Progress';
    fin.GE_HQ_Finance_Risk_Score__c = 'Less than -1.5';
    fin.GE_OG_Finance_Credit_Limit__c = '$10001 - $500000';
    fin.GE_OG_Actual__c ='100000';
    fin.GE_OG_Finan_TC__c='Consult Commercial Finance Team';
    insert fin;
    Test.stopTest();

    fin.GE_OG_Finance_Status__c = 'Completed ';
    // fin.GE_OG_KYC__r.GE_PW_KYC_Type__c = 'New Account';
    update fin;
    //acc.GE_OG_AccFin_Status__c = 'Finance Not Applicable ';
    // update acc;

    finhistory.GE_OG_Finance_Details__c = fin.id;
    finhistory.GE_OG_Fin_RiskScore__c = fin.GE_HQ_Finance_Risk_Score__c;
    finhistory.GE_OG_Fin_CredLmt__c = fin.GE_OG_Finance_Credit_Limit__c;
    finhistory.GE_OG_Fin_T_C_s__c =  fin.GE_OG_Finan_TC__c;
    finhistory.GE_OG_ActualHst__c = fin.GE_OG_Actual__c;
    finhistory.GE_OG_FinHist_status__c =  fin.GE_OG_Finance_Status__c;
    insert finhistory;
    }
        
 static testMethod void validateFinHistory2(){
 
    Account acc = new Account();
    GE_HQ_Country__c coun = new GE_HQ_Country__c();    
    GE_PRM_KYC_Termination_Checklist__c kyc = new GE_PRM_KYC_Termination_Checklist__c();
    GE_OG_Finance_Details__c fin = new GE_OG_Finance_Details__c();
    GE_OG_Fin_Histry__c finhistory = new GE_OG_Fin_Histry__c();

    Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('Relationship Account');
    Id acc1=rtByName_acc1.getRecordTypeId();
    Test.startTest();
    acc.Name='TestAccount';
    acc.GE_HQ_New_Account_Country__c='ARGENTINA';
    acc.GE_HQ_KYC_Complete__c=TRUE;
    acc.GE_PRM_KYC_Completed__c=TRUE;
    acc.RecordTypeId=acc1;
    acc.GE_OG_Buss_Tier2__c ='Digital Solutions';
    acc.Type = 'Direct Customer';
    acc.Classification__c = 'Strategic';    
    insert acc;
        
    /*GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];*/
    
    GE_PRM_Recommendation__c recom = new GE_PRM_Recommendation__c();
    recom.GE_PRM_KYC_Page__c = 'Partially Completed';
    insert recom;
    
    kyc.GE_HQ_Vat_Reason_Code__c='Non - VAT country';
    kyc.GE_HQ_Account__c=acc.Id;
    kyc.GE_OG_Finance_checked__c=true;
    kyc.GE_PRM_Recommendation__c=recom.Id;
    //kyc.RecordTypeId='012Z00000000L8L';
    Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c;  
    Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
    Id kyc1=rtByName_kyc1.getRecordTypeId();
    kyc.RecordTypeId=kyc1;
    kyc.GE_PW_KYC_Type__c = 'Modify Account';
    insert kyc;

    coun.GE_HQ_ISO_Code__c='12';
    coun.GE_OG_Finance_Country_Risk__c='High';
    coun.GE_PW_VATApplicabl__c=TRUE;
    coun.GE_PW_VAT_Format__c='Test';
    insert coun;

    fin.GE_OG_Account__c = acc.Id; 
    fin.GE_OG_KYC__c = kyc.Id;
    fin.GE_OG_Finance_Country_Risk__c=coun.GE_OG_Finance_Country_Risk__c;
    fin.GE_OG_Finance_Status__c = 'In Progress';
    fin.GE_HQ_Finance_Risk_Score__c = 'Less than -1.5';
    fin.GE_OG_Finance_Credit_Limit__c = '$10001 - $500000';
    fin.GE_OG_Actual__c ='100000';
    fin.GE_OG_Finan_TC__c='Consult Commercial Finance Team';
    insert fin;
    Test.stopTest();

    fin.GE_OG_Finance_Status__c = 'Finance Not Applicable ';

    update fin;
    acc.GE_OG_AccFin_Status__c = 'Finance Not Applicable ';
    update acc;
  
        }
   
    }