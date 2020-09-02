@isTest(seeAllData = true)
public class GE_OG_CreditCustomerHistory_batch_Test {
    static testMethod void GE_OG_CreditCustomerHistory_batch_Test() {
    
    Account acc = new Account();
    acc.name = 'Test';
    insert acc;
       
    list<GE_HQ_CUST_CREDIT_HIST__c> scope = new list<GE_HQ_CUST_CREDIT_HIST__c>();
    GE_HQ_CUST_CREDIT_HIST__c custcrd = new GE_HQ_CUST_CREDIT_HIST__c();
    custcrd.GE_HQ_Acc__c = acc.id;
    custcrd.GE_HQ_PAST_DUE_1_30__C = 0;
    custcrd.GE_HQ_PAST_DUE_31_60__C = 0;
    custcrd.GE_HQ_PAST_DUE_61_90__C = 0;
    custcrd.GE_HQ_TOT_PAST_DUE__C = 0;
    custcrd.GE_HQ_PAST_DUE_91_180__C = 0;
    custcrd.GE_HQ_PAST_DUE_181_365__C = 0;
    custcrd.GE_HQ_PAST_DUE_365__C = 0;
    custcrd.GE_HQ_TOT_AR_S__C = 0;
    custcrd.GE_HQ_DAYS_TO_PAY_VARIANCE__C = 12;
    custcrd.GE_HQ_ACCT_ERAM_SCORE__C = 1;
    custcrd.GE_HQ_KMV_EDF__C = 1;
    custcrd.GE_HQ_D_B_RTG__C = '150';
    custcrd.GE_HQ_CR_SCORE__C = 10;
    custcrd.GE_HQ_STRESS_SCORE__C = 14;
    custcrd.GE_HQ_PAYDEX__C = 45;
    custcrd.GE_HQ_CR_WATCHLIST__C = '';
    custcrd.GE_HQ_CR_WATCHLIST_LEVEL__C = '';
    custcrd.CreatedDate = System.now().addMinutes(-12);
    insert custcrd ;
   scope.add(custcrd);
   
   
    
    
    System.debug('customer credit history-- ' +scope);
    
    custcrd.GE_HQ_KMV_EDF__C = 1;
    custcrd.GE_HQ_D_B_RTG__C = '120';
    custcrd.GE_HQ_CR_SCORE__C = 12;
    custcrd.GE_HQ_ACCT_ERAM_SCORE__C = 0;
    custcrd.GE_HQ_PAYDEX__C = 35;
    custcrd.GE_HQ_STRESS_SCORE__C = 10;
    custcrd.GE_HQ_DAYS_TO_PAY_VARIANCE__C = 15;
    update custcrd ;
   
   List<GE_HQ_CUST_CREDIT_HIST__History> lstHistory = new List<GE_HQ_CUST_CREDIT_HIST__History>();
   lstHistory = [SELECT Field,Id,IsDeleted,NewValue,OldValue,ParentId FROM GE_HQ_CUST_CREDIT_HIST__History where ParentId =: custcrd.Id];
   
   test.starttest();    
   GE_OG_CreditCustomerHistory_batch gecreditcust = new GE_OG_CreditCustomerHistory_batch();
   Database.BatchableContext BC;
    Database.executebatch(gecreditcust);
    gecreditcust.execute(BC,scope);
    test.stoptest(); 
    
    }
    
     static testMethod void GE_OG_CreditCustomerHistory_batch_Test1() {
    
    Account acc = new Account();
    acc.name = 'Test';
    insert acc;
       
    list<GE_HQ_CUST_CREDIT_HIST__c> scope = new list<GE_HQ_CUST_CREDIT_HIST__c>();
    GE_HQ_CUST_CREDIT_HIST__c custcrd = new GE_HQ_CUST_CREDIT_HIST__c();
    custcrd.GE_HQ_Acc__c = acc.id;
    custcrd.GE_HQ_PAST_DUE_1_30__C = 0;
    custcrd.GE_HQ_PAST_DUE_31_60__C = 0;
    custcrd.GE_HQ_PAST_DUE_61_90__C = 0;
    custcrd.GE_HQ_TOT_PAST_DUE__C = 0;
    custcrd.GE_HQ_PAST_DUE_91_180__C = 0;
    custcrd.GE_HQ_PAST_DUE_181_365__C = 0;
    custcrd.GE_HQ_PAST_DUE_365__C = 0;
    custcrd.GE_HQ_TOT_AR_S__C = 0;
    custcrd.GE_HQ_DAYS_TO_PAY_VARIANCE__C = 12;
    custcrd.GE_HQ_ACCT_ERAM_SCORE__C = 1;
    custcrd.GE_HQ_KMV_EDF__C = 1;
    custcrd.GE_HQ_D_B_RTG__C = '150';
    custcrd.GE_HQ_CR_SCORE__C = 10;
    custcrd.GE_HQ_STRESS_SCORE__C = 14;
    custcrd.GE_HQ_PAYDEX__C = 45;
    custcrd.GE_HQ_CR_WATCHLIST__C = '';
    custcrd.GE_HQ_CR_WATCHLIST_LEVEL__C = '';
    custcrd.CreatedDate = System.now().addMinutes(-12);
    insert custcrd ;
   scope.add(custcrd);
   
   
    
    
    System.debug('customer credit history-- ' +scope);
    
   /* custcrd.GE_HQ_KMV_EDF__C = 1;
    custcrd.GE_HQ_D_B_RTG__C = '120';
    custcrd.GE_HQ_CR_SCORE__C = 12;
    custcrd.GE_HQ_ACCT_ERAM_SCORE__C = 0;
    custcrd.GE_HQ_PAYDEX__C = 35;
    custcrd.GE_HQ_STRESS_SCORE__C = 10;
    custcrd.GE_HQ_DAYS_TO_PAY_VARIANCE__C = 15;
    update custcrd ;*/
   
   List<GE_HQ_CUST_CREDIT_HIST__History> lstHistory = new List<GE_HQ_CUST_CREDIT_HIST__History>();
   lstHistory = [SELECT Field,Id,IsDeleted,NewValue,OldValue,ParentId FROM GE_HQ_CUST_CREDIT_HIST__History where ParentId =: custcrd.Id];
   
   test.starttest();    
   GE_OG_CreditCustomerHistory_batch gecreditcust = new GE_OG_CreditCustomerHistory_batch();
   Database.BatchableContext BC;
    Database.executebatch(gecreditcust);
    gecreditcust.execute(BC,scope);
    test.stoptest(); 
    
    }
}