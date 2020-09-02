Global Class GE_HQ_Update_Region_Matrix implements Database.Batchable<sObject> {

    Global Database.QueryLocator start(Database.BatchableContext BC){
    
        Date Td = Date.Today();
        
        return Database.getQueryLocator([Select Id, GE_HQ_External_ID__c, GE_HQ_Status__c from GE_HQ_Reg_Matrix__c where GE_HQ_Eff_Dt__c = :Td and GE_HQ_Status__c ='Pending']);
        //return Database.getQueryLocator([Select id, GE_HQ_Bus_Tier_1__c, GE_HQ_Acc__c, GE_HQ_Acct_Cr_Limit__c, GE_HQ_Cr_Watchlist__c, GE_HQ_Cr_Watchlist_Level__c, GE_HQ_Cr_Info_Available__c, GE_HQ_Tot_AR_s__c, GE_HQ_Cr_Limit_Remaining__c, GE_HQ_Cr_Limit_Exceeded__c, GE_HQ_Cr_Lt_Exceeded_Dt__c from GE_HQ_CUST_CREDIT_HIST__c]);
    }
    
    Global Void execute(Database.BatchableContext BC,List<sObject> Scope){
//        System.debug(Scope);
        List<GE_HQ_Reg_Matrix__c> ListRM = (List<GE_HQ_Reg_Matrix__c>) Scope;
        List<GE_HQ_Reg_Matrix__c> UpdateList = new List<GE_HQ_Reg_Matrix__c>();
        
        Set<String> ExtIds = new Set<String>();
        For(GE_HQ_Reg_Matrix__c RM: ListRM) {
            ExtIds.add(RM.GE_HQ_External_ID__c);
            RM.GE_HQ_Status__c = 'Active';
            UpdateList.add(RM);
            
        }
        If(ExtIds.size() >0) {
            List<GE_HQ_Reg_Matrix__c> OldRecs=[Select Id, GE_HQ_Status__c, GE_HQ_Exp_Dt__c from GE_HQ_Reg_Matrix__c where GE_HQ_External_ID__c in :ExtIds and GE_HQ_Status__c='Active'];
            For(GE_HQ_Reg_Matrix__c ul: OldRecs) {
                ul.GE_HQ_Status__c = 'Expired';
                ul.GE_HQ_Exp_Dt__c = Date.Today();
                UpdateList.add(ul);
            }
            If(UpdateList.size() >0) {
            
               System.debug('ListUpdate111' +UpdateList);
                Update UpdateList; // Contains all new and old records to be updated.
                
            }
        }
    }
    Global Void finish(Database.BatchableContext BC){
        
    }

}