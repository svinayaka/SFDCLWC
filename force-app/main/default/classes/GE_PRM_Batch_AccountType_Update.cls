global class GE_PRM_Batch_AccountType_Update implements Database.Batchable<sObject> {
    
   
    List<Contract> conList = New List<Contract>();
    
    global Database.QueryLocator start(Database.BatchableContext BC) { 

        String tier='LE';
        String RecordType = 'Channel Addendum Agreement';
         return Database.getQueryLocator('Select id,AccountId, GE_PRM_Commercial_Account__c, GE_Commercial_Member_Of_GE_OG__c,status,RecordType.name,Account.Type,Account.Member_of_GE_OG__c, Account.Member_of_GE_OG__r.Account_Tier_GEOG__c, Account.Member_of_GE_OG__r.Type, Account.Account_Tier_GEOG__c,Account.GE_HQ_Channel_Representative__c from Contract Where Account.Account_Tier_GEOG__c =:tier And RecordType.name =:RecordType' );
       
    }
    
     global void execute(Database.BatchableContext BC, List<Sobject> scope) {
         //For Contract Update
         map<id,contract> mapIdContract = new map<id,contract>();
         For(Sobject sObj : scope){
             Contract con =  (Contract)sObj ;
             conList.Add(con);
             mapIdContract.put(con.id,con);
         }
 
         GE_PRM_Contract_Trigger_Handler cc = new GE_PRM_Contract_Trigger_Handler();
         cc.isRunFromBatch = true;
         cc.update_acc_hier(conList,mapIdContract);
    }
     
     global void finish(Database.BatchableContext BC) {
      
     }  
    
}