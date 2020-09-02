@isTest
public class AccountModificationNotesTest
{
    static testMethod void AccountModificationNote() 
    { 
     GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
     Account Acc= new Account();
        Acc.Name='Test Acc';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555126837';  
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
        insert Acc;
        
        Account_Request__c accReq = new  Account_Request__c();
        accReq.GE_HQ_Account__c=acc.Id;
        accReq.GE_HQ_Nts_Comments__c='Test 1';
        accReq.GE_HQ_Country__c='AFGHANISTAN';     
        accReq.GE_HQ_Street__c='test';     
        accReq.GE_HQ_City__c='Test';     
        accReq.GE_HQ_State_Province__c='Test';     
        accReq.GE_HQ_Postal_Code__c='560067'; 
        insert accReq;
        
        GE_PRM_Recommendation__c recom1 = new  GE_PRM_Recommendation__c(GE_PRM_KYC_Page__c='Completed');
         insert recom1;
        
         GE_PRM_KYC_Termination_Checklist__c kyc=new GE_PRM_KYC_Termination_Checklist__c();
            kyc.GE_HQ_Account__c=acc.Id;
            kyc.GE_PRM_Recommendation__c=recom1.id;
            String rt1 = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Edit Record Type').getRecordTypeId();
            kyc.RecordTypeId=rt1;
            kyc.GE_OG_Fin_Status__c='In Progress';
            kyc.GE_HQ_Status__c='Manual Due Diligence Submitted';
            kyc.GE_PW_KYC_Type__c='Modify Account';       
            kyc.GE_PW_Risk_Type__c = 'High';
            kyc.GE_HQ_Sold_To_Country__c = 'Tajikistan';   
            kyc.GE_PW_Acc_Mod_Req__c = accReq.id;       
            insert kyc;              
            System.assertEquals(kyc.GE_OG_Fin_Status__c, 'In Progress');
        
        Account_Modification_Note__c accMod = new Account_Modification_Note__c();
        accMod.Account_Request__c = accReq.id;
        accMod.Comments__c = accReq.GE_HQ_Nts_Comments__c;
        accMod.Type__c = 'User';
        insert accMod;
        
    }
    
    static testMethod void AccountModificationNote1() 
    { 
     GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
     Account Acc= new Account();
        Acc.Name='Test Acc';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555126948';  
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
        insert Acc;
        
        Account_Request__c accReq = new  Account_Request__c();
        accReq.GE_HQ_Account__c=acc.Id;
        
        accReq.GE_HQ_Nts_Comments__c='Test 1';
        accReq.GE_HQ_Country__c='AFGHANISTAN';     
        accReq.GE_HQ_Street__c='test';     
        accReq.GE_HQ_City__c='Test';     
        accReq.GE_HQ_State_Province__c='Test';     
        accReq.GE_HQ_Postal_Code__c='560067'; 
        insert accReq;
        
        
        
        GE_PRM_Recommendation__c recom1 = new  GE_PRM_Recommendation__c(GE_PRM_KYC_Page__c='Completed');
         insert recom1;
        
         GE_PRM_KYC_Termination_Checklist__c kyc=new GE_PRM_KYC_Termination_Checklist__c();
            kyc.GE_HQ_Account__c=acc.Id;
            kyc.GE_PRM_Recommendation__c=recom1.id;
            String rt1 = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Edit Record Type').getRecordTypeId();
            kyc.RecordTypeId=rt1;
            kyc.GE_OG_Fin_Status__c='In Progress';
            kyc.GE_HQ_Status__c='Manual Due Diligence Submitted';
            kyc.GE_PW_KYC_Type__c='Modify Account';       
            kyc.GE_PW_Risk_Type__c = 'High';
            kyc.GE_HQ_Sold_To_Country__c = 'Tajikistan';   
            kyc.GE_PW_Acc_Mod_Req__c = accReq.id;       
            insert kyc;              
            System.assertEquals(kyc.GE_OG_Fin_Status__c, 'In Progress');
            
            accReq.GE_HQ_Nts_Comments__c='Test ACCount';
            accReq.GE_HQ_Request_Status__c = 'Pending User Review';
        update accReq;
        
        Account_Modification_Note__c accMod = new Account_Modification_Note__c();
        accMod.Account_Request__c = accReq.id;
        accMod.Comments__c = accReq.GE_HQ_Nts_Comments__c;
        accMod.Type__c = 'User';
        insert accMod;
     }
        static testMethod void AccountModificationNote2() 
    { 
        GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
        Account Acc= new Account();
        Acc.Name='Test Acc';  
        Acc.GE_HQ_Request_Status__c='CMF Approved';
        Acc.GE_HQ_KYC_Complete__c=TRUE;
        Acc.GE_PRM_KYC_Completed__c=TRUE;
        Acc.GE_HQ_DUNS_Number__c='555126239';  
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
        insert Acc;
        
        Account_Request__c accReq = new  Account_Request__c();
        accReq.GE_HQ_Account__c=acc.Id;
        
        accReq.GE_HQ_Nts_Comments__c='Test 1';
        accReq.GE_HQ_Country__c='AFGHANISTAN';     
        accReq.GE_HQ_Street__c='test';     
        accReq.GE_HQ_City__c='Test';     
        accReq.GE_HQ_State_Province__c='Test';     
        accReq.GE_HQ_Postal_Code__c='560067'; 
        insert accReq;
        
        
        
        GE_PRM_Recommendation__c recom1 = new  GE_PRM_Recommendation__c(GE_PRM_KYC_Page__c='Completed');
         insert recom1;
        
         GE_PRM_KYC_Termination_Checklist__c kyc=new GE_PRM_KYC_Termination_Checklist__c();
            kyc.GE_HQ_Account__c=acc.Id;
            kyc.GE_PRM_Recommendation__c=recom1.id;
            String rt1 = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('GE PW KYC Edit Record Type').getRecordTypeId();
            kyc.RecordTypeId=rt1;
            kyc.GE_OG_Fin_Status__c='In Progress';
            kyc.GE_HQ_Status__c='Manual Due Diligence Submitted';
            kyc.GE_PW_KYC_Type__c='Modify Account';       
            kyc.GE_PW_Risk_Type__c = 'High';
            kyc.GE_HQ_Sold_To_Country__c = 'Tajikistan';   
            kyc.GE_PW_Acc_Mod_Req__c = accReq.id;       
            insert kyc;              
            System.assertEquals(kyc.GE_OG_Fin_Status__c, 'In Progress');
            
            accReq.GE_HQ_Nts_Comments__c='Test ACCount1';
            accReq.GE_HQ_Request_Status__c = 'Pending User Review';
        update accReq;
        
        Account_Modification_Note__c accMod = new Account_Modification_Note__c();
        accMod.Account_Request__c = accReq.id;
        accMod.Comments__c = accReq.GE_HQ_Nts_Comments__c;
        accMod.Type__c = 'User';
        insert accMod;
       
     } 
     
}