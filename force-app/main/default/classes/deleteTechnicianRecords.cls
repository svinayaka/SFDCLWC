/* Batch class created to delete old Technician Records before OHR Technician Batch job run with the fresh data*/

global class deleteTechnicianRecords implements Database.Batchable<sObject>{
    global String query ;
    global deleteTechnicianRecords (){
     System.Debug('.... Non Parameterized Cons... ');
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
     query='SELECT id , GE_OG_Technician_Batch_Run_Date__c from GE_OG_OHR_User_Data_Sync__c where GE_OG_Technician_Batch_Run_Date__c >= LAST_N_DAYS:10';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC,List<GE_OG_OHR_User_Data_Sync__c > scope){
        delete scope;
    }

    global void finish(Database.BatchableContext BC){}
}