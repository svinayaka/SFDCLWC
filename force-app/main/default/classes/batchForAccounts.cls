global class batchForAccounts implements Database.Batchable<sObject>, Database.Stateful
{
    global boolean isRunForAll{get;set;}
    static boolean recursive = false;
    public Set<Id> lstMemeberOf=new Set<Id>();
    global Database.QueryLocator start(Database.BatchableContext BC){
      DateTime NowDate = datetime.now();
      DateTime LastWeek = system.now().AddDays(-7);
      Set<String> accTier = new Set<String>();
      accTier.add('Global');
      accTier.add('Country');
      accTier.add('Regional');
      String query; 
      
      //If null than populate only
      if(isRunForAll == null ){
          isRunForAll = false;
      }
      
      /*********Testing ***************/
      //Remove isRunForAll = true; from Line No 22
      isRunForAll = true;
      Set<Id> testsetData = new Set<Id>();
        String idDatamigrationUser;
        List<User> lstUser = new List<User>([Select Id, Name from User where Name = 'Accounts Data Migration']);
        if(lstUser.size()>0){
             System.debug('===='+lstUser);
             idDatamigrationUser = lstUser[0].Id;
        }   
        if(isRunForAll){
         query = 'SELECT Id, Account_Tier_GEOG__c, Type, OwnerId, Owner.isActive,Member_of_GE_OG__c FROM Account where Account_Tier_GEOG__c in : accTier';
        
        }
        else{
            if(idDatamigrationUser !=null){
             query = 'SELECT Id, Member_of_GE_OG__c, Account_Tier_GEOG__c, Type, OwnerId, Owner.isActive FROM Account where LastModifiedDate < : NowDate and LastModifiedDate >: LastWeek and Account_Tier_GEOG__c in: accTier and LastModifiedById != :idDatamigrationUser'; 
            }
            else{
                query = 'SELECT Id, Member_of_GE_OG__c, Account_Tier_GEOG__c, Type, OwnerId, Owner.isActive FROM Account where LastModifiedDate < : NowDate and LastModifiedDate >: LastWeek and Account_Tier_GEOG__c in: accTier'; 
            }       
        }
         system.debug('===query ===='+query );
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Account> scope){
        
        system.debug('===scope===='+scope.size());
        List<Account> lstCountryAccMemberOfNull = new List<Account>();
        for(Account acc : scope){
            if(acc.Member_of_GE_OG__c == null && acc.Account_Tier_GEOG__c == 'Country'){
                lstCountryAccMemberOfNull.add(acc); 
            }
        }

        BatchRollupToAccount objBatchRollupToAccount = new BatchRollupToAccount();

        objBatchRollupToAccount.LegalEntityQuickView(scope);
        objBatchRollupToAccount.ActiveGroupOpportunities(scope);
        
        Set<Id> setAccountId  = new Set<Id>();

        For(Account ac : scope){
            setAccountId.add(ac.Id);
            
        }
        objBatchRollupToAccount.MemberOfNull_Account_LEquickView(lstCountryAccMemberOfNull);
        objBatchRollupToAccount.MemberOfNull_ActiveGroupOpportunities(lstCountryAccMemberOfNull);


    }   
    global void finish(Database.BatchableContext BC){
            
            system.debug('------list--------'+lstMemeberOf.size() +'--------' + lstMemeberOf);
         /*   DateTime NowDate = datetime.now();
            DateTime Past24 = system.now().AddDays(-1);
            Set<String> accTier = new Set<String>();
            accTier.add('Global');
            accTier.add('Country');
            accTier.add('Regional');
            String idDatamigrationUser;
            List<User> lstUser = new List<User>([Select Id, Name from User where Name = 'Accounts Data Migration']);
            if(lstUser.size()>0){
             System.debug('===='+lstUser);
             idDatamigrationUser = lstUser[0].Id;
            }   
            List<Account> cases = [SELECT Id, Member_of_GE_OG__c, Account_Tier_GEOG__c, Type, OwnerId, Owner.isActive FROM Account where LastModifiedDate < : NowDate and LastModifiedDate >: Past24 and Account_Tier_GEOG__c in: accTier and LastModifiedById != :idDatamigrationUser];
            if(!recursive && cases.size()>0) {
                recursive = true;
                batchForAccounts batch = new batchForAccounts();
                batch.isRunForAll = false;
                if(!Test.isRunningTest())
                database.executeBatch(batch ,200);
            }
            else{
                //if(!Test.isRunningTest()){
                datetime dt = system.now().addhours(4);
                String day = string.valueOf(dt.day());
                String month = string.valueOf(dt.month());
                String hour = string.valueOf(dt.hour());
                String minute = string.valueOf(dt.minute());
                String second = string.valueOf(dt.second());
                String year = string.valueOf(dt.year());
                String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
                String strJobName = 'Account Roll Up batch job '+strSchedule;
                
                List<CronJobDetail> lstCron = new list<CronJobDetail>([SELECT Id,JobType,Name FROM CronJobDetail where Name like 'Account Roll Up batch job%']);

                Set<Id> cronid = new Set<Id>();
                if(lstCron.size()>0){
                    for(CronJobDetail cj : lstCron){
                        cronid.add(cj.Id);
                    }
                    List<CronTrigger> ct = new List<CronTrigger>();
                    if(cronid.size()>0){
                        ct = new List<CronTrigger>([SELECT CronExpression,CronJobDetailId,Id FROM CronTrigger where CronJobDetailId in : cronid]);
                    }
                    for(CronTrigger c : ct){
                        System.abortJob(c.Id);
                    }
                } 
                System.schedule(strJobName, strSchedule, new AccountRollupSchedule());
                //}
            }
            
         */   
    }
}