/*
Class/Trigger Name      : GE_Code_Utilization_Purge
Used Where ?            : Code Utlization
Purpose/Overview        : To delete the code utilization records older than 180 days
Functional Area         : Innovation & Simplification
Author                  : Prasad Yadala
Created Date            : 12/30/2014
Test Class Name         : 
Code Coverage           : 

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/

//schedulable batch apex to schedule batches every day and delete the records older than 180 days
global class GE_Code_Utilization_Purge implements Database.Batchable<sObject>,Schedulable
{
    public static Integer Duration = Integer.valueof(Label.GE_OG_Code_Util_Purge_Value);
    //intialize the batch
    Global Database.QueryLocator start(Database.BatchableContext BC) 
    { 
        Duration =  (Duration != null) ? Duration : 180;
        String query = 'SELECT Id,createddate FROM GE_Code_Utilization__c where CreatedDate = N_DAYS_AGO:'+Duration; 
        return Database.getQueryLocator(query); 
    } 
    
    //execute the batch apex, deleting the records
    Global void execute(Database.BatchableContext BC, List<GE_Code_Utilization__c> scope) 
    { 
        
        delete scope; 
    } 
    
    //any final actions to be made are declared here
    Global void finish(Database.BatchableContext BC) 
    {
    }
    
    //method to schedule the controller
    Global void execute(SchedulableContext sc)
    { 
        GE_Code_Utilization_Purge b= new GE_Code_Utilization_Purge(); 
        Database.executebatch(b,200); 
    } 
    

}