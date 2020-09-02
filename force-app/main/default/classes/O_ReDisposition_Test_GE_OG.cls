@isTest
(seeAlldata = true)
public class O_ReDisposition_Test_GE_OG {
    public static testMethod void Test_reDispCMR() {
        test.startTest();
        CampaignMember cmr = [Select id,Status_ge_og__c from CampaignMember where Status_ge_og__c =: 'Prospect' and Owner_ge_og__r.IsActive=true and Account_Primary_Sales_ge_og__r.IsActive=true limit 1];
        List < Id > lstCMRId = new List < Id > {cmr.Id};
        system.debug('R%%%%% Test'+cmr.Id);
        system.debug('R%%%%% Test'+cmr.Status_ge_og__c);
        string OpptySuccess = O_ReDispositionCMR_GE_OG.reDispCMR(cmr.Id);
        List < string > submitResult = O_ReDispositionCMR_GE_OG.reDispCMR(lstCMRId);
        test.stopTest();
    }
}