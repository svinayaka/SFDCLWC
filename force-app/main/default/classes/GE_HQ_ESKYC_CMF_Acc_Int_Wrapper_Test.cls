/*    
Class Name        : GE_HQ_ESKYC_CMF_Acc_Int_Wrapper_Test
Purpose/Overview  : Test Class for GE_HQ_ESKYC_CMF_Acc_Int_Wrapper, AccountIntegrationWrapper
Author            : Jayadev Rath
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 7th Nov 2011  : Jayadev Rath       : Created : For covering GE_HQ_ESKYC_CMF_Acc_Int_Wrapper.
                  : 18th Nov 2011 : Jayadev Rath       : Updated : For covering another wrapper class :AccountIntegrationWrapper
*/
@isTest
Private Class GE_HQ_ESKYC_CMF_Acc_Int_Wrapper_Test {
    Static TestMethod void ESKYC_Acc_Wrapper_Test() {
        Account Acc = new Account(Name ='Test',GE_HQ_ACCOUNT_ID__c='1010'); Insert Acc;
        Account_Request__c AccReq = new Account_Request__c(GE_HQ_Account__c= Acc.Id); Insert AccReq;
        String Accmodreq=Accreq.Id;
        // Covering GE_HQ_ESKYC_CMF_Acc_Int_Wrapper class
        GE_HQ_ESKYC_CMF_Acc_Int_Wrapper KycWrapper = new GE_HQ_ESKYC_CMF_Acc_Int_Wrapper();
        GE_HQ_ESKYC_CMF_Acc_Int_Wrapper.FromTest=True;
        GE_HQ_ESKYC_CMF_Acc_Int_Wrapper.NewAccountRequest(Acc.Id);
        
        // Covering AccountIntegrationWrapper Class
        AccountIntegrationWrapper AccWpr = new AccountIntegrationWrapper();
        AccountIntegrationWrapper.FromTest = True;
        Account ResponseAcc = AccWpr.NewAccountRequest(Acc);  // Calling the first method for Account
        AccountIntegrationWrapper.AccountModifyRequest(Accmodreq);  // Calling the second method for Account Modification Request
    }
}