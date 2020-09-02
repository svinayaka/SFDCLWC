/*
Class/Trigger Name     : O_ReDispositionCMR_GE_OG
Used Where ?           : "Redisposition CMR" button on Campaign Member record
Purpose/Overview       :  Used to Redisposition CMR
Scrum Team             :  Marketing
Requirement Number     : 
Author                 : Rupal Seth
Created Date           : 03/05/2018
Test Class Name        : 
Code Coverage          : 
*/
global class O_ReDispositionCMR_GE_OG {
    // Method to reopen Closed Oppty record
    @InvocableMethod(label = 'Redisposition CMR'
        description = 'Redisposition CMR from Prospect to Qualifying')
    public static list < String > reDispCMR(List < Id > CampaignMemberId) {
        System.debug('------------------Inside Invocable method loop--------------------');
        List < String > successResult = new List < String > ();
        successResult.add(reDispCMRLogic(CampaignMemberId[0]));
        return successResult;

    }

    webservice static string reDispCMR(String CampaignMemberId) {
        return reDispCMRLogic(CampaignMemberId);

    }

    public static String reDispCMRLogic(String CampaignMemberId) {
        System.debug('------------Inside reDispCMRLogic loop-----------' + CampaignMemberId);
        CampaignMember cmr = [SELECT Id,CMR_Type_ge_og__c,Status_ge_og__c, Status, Date_Dispositioned_ge_og__c, Date_Qualifiying_Started_ge_og__c, Dispostion_Reason_ge_og__c FROM CampaignMember WHERE Id =: CampaignMemberId];
        
        if (cmr.Status_ge_og__c == 'Prospect') {
            cmr.Status_ge_og__c = '';
            cmr.Status = 'Qualifying';
            cmr.Dispostion_Reason_ge_og__c = '';
            cmr.Date_Dispositioned_ge_og__c = null;
            if(cmr.Date_Qualifiying_Started_ge_og__c == NULL){
            cmr.Date_Qualifiying_Started_ge_og__c = System.today();
            }
            //update cmr;
            try {
                update cmr;
            } catch (Exception e) {
                System.debug(e);
                //return String.valueOf(e);
                throw e;
            }
            System.debug('-----------CMR Redispositioned------------');
            

        } 

        return null;
    }
}