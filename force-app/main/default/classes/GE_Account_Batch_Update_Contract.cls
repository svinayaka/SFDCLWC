global class GE_Account_Batch_Update_Contract implements Database.Batchable<sObject> {
    
   
    List<Contract> conList = new List<Contract>();
    
    global Database.QueryLocator start(Database.BatchableContext BC) {  
       
        String Accounttier = 'LE';
        String Recordtype='Master Frame Agreement';
       // String query = 'Select Id,AccountId,GE_PRM_Commercial_Account__c,GE_Commercial_Member_Of_GE_OG__c,Recordtype.Name, Account.name, Account.Oil_Gas_Parent_Account__c, Account.Member_of_GE_OG__c, GE_PRM_Channel_Appointment_ID__r.GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c,Account.Account_Tier_GEOG__c From Contract where Account.Account_Tier_GEOG__c=:Accounttier and Recordtype.Name=:Recordtype' ;
            
        String query='select GE_PRM_Commercial_Account__c,GE_Commercial_Member_Of_GE_OG__c,RecordType.Name,Account.Oil_Gas_Parent_Account__c,Account.Member_of_GE_OG__c ,Account.Account_Tier_GEOG__c from Contract where RecordType.Name=:Recordtype and Account.Account_Tier_GEOG__c=:Accounttier and GE_Commercial_Member_Of_GE_OG__c =Null ';
        return Database.getQueryLocator(query);
       
    }
    
     global void execute(Database.BatchableContext BC, List<Sobject> scope) {
       //System.debug('SCopeeemmd'+scope);
     For(Sobject sObj : scope){

     //For Contract Update
     Contract con =  (Contract)sObj ;
     con.GE_PRM_Commercial_Account__c = con.Account.Oil_Gas_Parent_Account__c;
     con.GE_Commercial_Member_Of_GE_OG__c = con.Account.Member_of_GE_OG__c; 
     conList.Add(con);
     }
     // System.debug('Sizeeee'+conList.size());
     If ( conList.size() >0)
     Update conList; 

    
    }
     
     global void finish(Database.BatchableContext BC) {
        /* GE_PRM_Batch_AccountType_Update caBatch = new GE_PRM_Batch_AccountType_Update();
          Database.ExecuteBatch(caBatch,10);*/
     }
      
     
    
}