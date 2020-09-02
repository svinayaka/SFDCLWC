global class GE_PRM_Batch_Update_ComAccs_Agreement {
    
    public void pusedomethod(){string x ='10';
        system.debug('hahahhaa'+x);}
    
//global class GE_PRM_Batch_Update_ComAccs_Agreement implements Database.Batchable<sObject>{
  /**  
   
    List<Apttus__APTS_Agreement__c> agList = New List<Apttus__APTS_Agreement__c>();
    global Database.QueryLocator start(Database.BatchableContext BC) {  
        return Database.getQueryLocator('Select Id,Apttus__Account__c,GE_PRM_Commercial_Account__c, GE_PRM_Channel_Appointment_ID__c, GE_PRM_Contract__r.Account.Oil_Gas_Parent_Account__c, GE_PRM_Contract__r.Account.Member_of_GE_OG__c From Apttus__APTS_Agreement__c where GE_PRM_Commercial_Account__c=null');
       
    }
    
     global void execute(Database.BatchableContext BC, List<Sobject> scope) {
     
     
     
     
     For(Sobject sObj : scope){ 
     //For Contract Update
     Apttus__APTS_Agreement__c ag =  (Apttus__APTS_Agreement__c)sObj ;
     if(ag.GE_PRM_Contract__r.Account.Oil_Gas_Parent_Account__c!=null)
     ag.GE_PRM_Commercial_Account__c = ag.GE_PRM_Contract__r.Account.Oil_Gas_Parent_Account__c;
     else
         ag.GE_PRM_Commercial_Account__c = null;
     agList .Add(ag);
       
     }
     
     If ( agList.size() >0)
     Update agList ; 
    
    }
     
     global void finish(Database.BatchableContext BC) {
    
    
     
     }
    **/     
}