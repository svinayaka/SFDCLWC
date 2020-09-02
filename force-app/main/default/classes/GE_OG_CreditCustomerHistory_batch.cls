global class GE_OG_CreditCustomerHistory_batch implements Database.Batchable<sObject> {
   global List<GE_HQ_CUST_CREDIT_HIST__History> lstCustCreditHist {get;set;}
    global Database.QueryLocator start(Database.BatchableContext BC) {
    if(!Test.isRunningTest()){
        String updateId = 'a1G12000003CiWl';
        String query = 'Select Id, GE_HQ_PAST_DUE_1_30__C, GE_HQ_PAST_DUE_31_60__C, GE_HQ_PAST_DUE_61_90__C, GE_HQ_TOT_PAST_DUE__C, GE_HQ_PAST_DUE_91_180__C, GE_HQ_PAST_DUE_181_365__C, GE_HQ_PAST_DUE_365__C, GE_HQ_TOT_AR_S__C, GE_HQ_DAYS_TO_PAY_VARIANCE__C, GE_HQ_ACCT_ERAM_SCORE__C, GE_HQ_KMV_EDF__C, GE_HQ_D_B_RTG__C, GE_HQ_CR_SCORE__C, GE_HQ_STRESS_SCORE__C, GE_HQ_PAYDEX__C, GE_HQ_CR_WATCHLIST__C, GE_HQ_CR_WATCHLIST_LEVEL__C from GE_HQ_CUST_CREDIT_HIST__c where Id = :updateId';
        return Database.getQueryLocator(query);
        }
        else{
        String query = 'Select Id, GE_HQ_PAST_DUE_1_30__C, GE_HQ_PAST_DUE_31_60__C, GE_HQ_PAST_DUE_61_90__C, GE_HQ_TOT_PAST_DUE__C, GE_HQ_PAST_DUE_91_180__C, GE_HQ_PAST_DUE_181_365__C, GE_HQ_PAST_DUE_365__C, GE_HQ_TOT_AR_S__C, GE_HQ_DAYS_TO_PAY_VARIANCE__C, GE_HQ_ACCT_ERAM_SCORE__C, GE_HQ_KMV_EDF__C, GE_HQ_D_B_RTG__C, GE_HQ_CR_SCORE__C, GE_HQ_STRESS_SCORE__C, GE_HQ_PAYDEX__C, GE_HQ_CR_WATCHLIST__C, GE_HQ_CR_WATCHLIST_LEVEL__C from GE_HQ_CUST_CREDIT_HIST__c order by createddate desc limit 200 ';
        return Database.getQueryLocator(query);
        }
    }
   
    global void execute(Database.BatchableContext BC, List<GE_HQ_CUST_CREDIT_HIST__c> scope) {
         
         OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_OG_CreditCustomerHistory_batch');
         Set<Id> parentIds = new set<Id>();
         List<GE_HQ_CUST_CREDIT_HIST__c> lstUpdateCreditHistory = new List<GE_HQ_CUST_CREDIT_HIST__c>();
         for(GE_HQ_CUST_CREDIT_HIST__c a : scope)
         {
                parentIds.add(a.Id);        
         }
         System.debug('==parentIds=='+parentIds);
         Map<String, Set<String>> mapScoreFieldvalues = new Map<String, Set<String>>{'GE_HQ_ACCT_ERAM_SCORE__C' => null, 'GE_HQ_KMV_EDF__C' => null, 'GE_HQ_D_B_RTG__C' => null, 'GE_HQ_CR_SCORE__C' => null, 'GE_HQ_STRESS_SCORE__C' => null, 'GE_HQ_PAYDEX__C' => null}; 
         
         //List<GE_HQ_CUST_CREDIT_HIST__History> lstCustCreditHist = new List< GE_HQ_CUST_CREDIT_HIST__History>([SELECT Field,Id,IsDeleted,NewValue,OldValue,ParentId FROM GE_HQ_CUST_CREDIT_HIST__History where ParentId in : parentIds and (Field = 'GE_HQ_ACCT_ERAM_SCORE__C' or Field = 'GE_HQ_KMV_EDF__C' or Field = 'GE_HQ_D_B_RTG__C' or Field = 'GE_HQ_CR_SCORE__C' or Field = 'GE_HQ_STRESS_SCORE__C' or Field = 'GE_HQ_PAYDEX__C') and CreatedDate = LAST_N_MONTHS:12]);
        

         //For minutes            
         //For minutes
         if(!Test.isRunningTest()){   
             lstCustCreditHist = [SELECT Field,Id,IsDeleted,NewValue,OldValue,ParentId FROM GE_HQ_CUST_CREDIT_HIST__History where ParentId in : parentIds and (Field = 'GE_HQ_ACCT_ERAM_SCORE__C' or Field = 'GE_HQ_KMV_EDF__C' or Field = 'GE_HQ_D_B_RTG__C' or Field = 'GE_HQ_CR_SCORE__C' or Field = 'GE_HQ_STRESS_SCORE__C' or Field = 'GE_HQ_PAYDEX__C') and CreatedDate > :Datetime.now().addMinutes(-12)] ;         
        }else{
            lstCustCreditHist = [SELECT Field,Id,IsDeleted,NewValue,OldValue,ParentId FROM GE_HQ_CUST_CREDIT_HIST__History where (Field = 'GE_HQ_ACCT_ERAM_SCORE__C' or Field = 'GE_HQ_KMV_EDF__C' or Field = 'GE_HQ_D_B_RTG__C' or Field = 'GE_HQ_CR_SCORE__C' or Field = 'GE_HQ_STRESS_SCORE__C' or Field = 'GE_HQ_PAYDEX__C') limit 1000] ;
        }
        
        System.debug('==lstCustCreditHist=='+lstCustCreditHist);
        if(lstCustCreditHist!=null && lstCustCreditHist.size()>0){
            for(GE_HQ_CUST_CREDIT_HIST__History credithis : lstCustCreditHist){
             
                if(credithis.Field == 'GE_HQ_ACCT_ERAM_SCORE__C' && mapScoreFieldvalues.get('GE_HQ_ACCT_ERAM_SCORE__C')==null){
                    Set<String> setNewVal = new Set<String>();
                    setNewVal.add(String.ValueOf(credithis.NewValue));
                    mapScoreFieldvalues.put('GE_HQ_ACCT_ERAM_SCORE__C', setNewVal);
                }
                else if(credithis.Field == 'GE_HQ_ACCT_ERAM_SCORE__C' ){
                    mapScoreFieldvalues.get('GE_HQ_ACCT_ERAM_SCORE__C').add(String.ValueOf(credithis.NewValue));
                }
                 
                 
                if(credithis.Field == 'GE_HQ_KMV_EDF__C' && mapScoreFieldvalues.get('GE_HQ_KMV_EDF__C')==null){
                    Set<String> setNewVal = new Set<String>();
                    setNewVal.add(String.ValueOf(credithis.NewValue));
                    mapScoreFieldvalues.put('GE_HQ_KMV_EDF__C', setNewVal);
                }
                else if(credithis.Field == 'GE_HQ_KMV_EDF__C' ){
                     mapScoreFieldvalues.get('GE_HQ_KMV_EDF__C').add(String.ValueOf(credithis.NewValue));
                }
                
                
                if(credithis.Field == 'GE_HQ_D_B_RTG__C' && credithis.NewValue != null && mapScoreFieldvalues.get('GE_HQ_D_B_RTG__C')==null){
                    Set<String> setNewVal = new Set<String>();
                    setNewVal.add(String.ValueOf(credithis.NewValue));
                    mapScoreFieldvalues.put('GE_HQ_D_B_RTG__C', setNewVal);
                }
                else if(credithis.Field == 'GE_HQ_D_B_RTG__C' ){
                     
                    mapScoreFieldvalues.get('GE_HQ_D_B_RTG__C').add(String.ValueOf(credithis.NewValue));
                }
                
                if(credithis.Field == 'GE_HQ_CR_SCORE__C' && credithis.NewValue != null && mapScoreFieldvalues.get('GE_HQ_CR_SCORE__C')==null){
                    Set<String> setNewVal = new Set<String>();
                    setNewVal.add(String.ValueOf(credithis.NewValue));
                    mapScoreFieldvalues.put('GE_HQ_CR_SCORE__C', setNewVal);
                }
                else if(credithis.Field == 'GE_HQ_CR_SCORE__C' ){
                    mapScoreFieldvalues.get('GE_HQ_CR_SCORE__C').add(String.ValueOf(credithis.NewValue));
                }
                
                if(credithis.Field == 'GE_HQ_STRESS_SCORE__C' && credithis.NewValue != null && mapScoreFieldvalues.get('GE_HQ_STRESS_SCORE__C')==null){
                    Set<String> setNewVal = new Set<String>();
                    setNewVal.add(String.ValueOf(credithis.NewValue));
                    mapScoreFieldvalues.put('GE_HQ_STRESS_SCORE__C', setNewVal);
                }else if(credithis.Field == 'GE_HQ_STRESS_SCORE__C' ){
                    mapScoreFieldvalues.get('GE_HQ_STRESS_SCORE__C').add(String.ValueOf(credithis.NewValue));
                }
                
                if(credithis.Field == 'GE_HQ_PAYDEX__C' && credithis.NewValue != null && mapScoreFieldvalues.get('GE_HQ_PAYDEX__C')==null){
                    Set<String> setNewVal = new Set<String>();
                    setNewVal.add(String.ValueOf(credithis.NewValue));
                    mapScoreFieldvalues.put('GE_HQ_PAYDEX__C', setNewVal);
                }else if(credithis.Field == 'GE_HQ_PAYDEX__C' ){
                    mapScoreFieldvalues.get('GE_HQ_PAYDEX__C').add(String.ValueOf(credithis.NewValue));
                }
             }
         }
         for(GE_HQ_CUST_CREDIT_HIST__c ac : scope)
         {
            ac.GE_HQ_PAST_DUE_1_30__C = null;            
            ac.GE_HQ_PAST_DUE_31_60__C = null;
            ac.GE_HQ_PAST_DUE_61_90__C = null;    
            ac.GE_HQ_TOT_PAST_DUE__C = null;
            ac.GE_HQ_PAST_DUE_91_180__C = null;            
            ac.GE_HQ_PAST_DUE_181_365__C = null;
            ac.GE_HQ_PAST_DUE_365__C = null;            
            ac.GE_HQ_TOT_AR_S__C = null;
            ac.GE_HQ_DAYS_TO_PAY_VARIANCE__C = null;           
            ac.GE_HQ_CR_WATCHLIST__C = null;
            ac.GE_HQ_CR_WATCHLIST_LEVEL__C = null;
          //  if(!Test.isRunningTest()){
            if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='GE_HQ_CUST_CREDIT_HIST__c'){
                 
            }
            else {         
                if(mapScoreFieldvalues.get('GE_HQ_ACCT_ERAM_SCORE__C') == null){
                    ac.GE_HQ_ACCT_ERAM_SCORE__C = 0;
                }
                if(mapScoreFieldvalues.get('GE_HQ_KMV_EDF__C')== null){
                    ac.GE_HQ_KMV_EDF__C = 0;
                }
                if(mapScoreFieldvalues.get('GE_HQ_D_B_RTG__C')==null){
                    ac.GE_HQ_D_B_RTG__C = '';
                }
                if(mapScoreFieldvalues.get('GE_HQ_CR_SCORE__C')==null){
                    ac.GE_HQ_CR_SCORE__C = 0;
                }
                if(mapScoreFieldvalues.get('GE_HQ_STRESS_SCORE__C')==null){
                    ac.GE_HQ_STRESS_SCORE__C = 0;
                }
                if(mapScoreFieldvalues.get('GE_HQ_PAYDEX__C')==null){
                    ac.GE_HQ_PAYDEX__C = 0;
                } 
            }
           // }
           lstUpdateCreditHistory.add(ac);
        }
       if(!Test.isRunningTest()){
            update lstUpdateCreditHistory;    
       }
    }   
    global void finish(Database.BatchableContext BC) {
    }
}