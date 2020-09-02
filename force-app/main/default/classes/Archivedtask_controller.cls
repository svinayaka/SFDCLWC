Global without sharing class Archivedtask_controller{

 public static list<Task> Tasklist_to_unarchive = new list<Task>();
//public static list<String> error_message ;
//public static list<String> dispostioning_lead;
 

@InvocableMethod(label='Archived_task_controller')
    global static void unarhivetask(list<String> LeadID_param) {
//global static list<String> unarhivetask(list<String> LeadID_param) {
  
   system.debug('**Lead Id which is in current context of dispostioning**'+LeadID_param);
   string Lead_ID  = LeadID_param[0];
   ID DealMachineTask_id = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeId();

   
// dispostioning_lead.add(Lead_ID);
//system.debug('context lead is----+'dispostioning_lead);
// dealmachinetask_id should be = '01212000000oGZQ'
    
   List<Task> Archivedtask_onLead = [SELECT 
                                            Id,IsArchived,Subject,ActivityDate,RecordTypeId,Related_To_What_ge_og__c,Related_To_Who_ge_og__c,Type,WhatId,WhoId 
                                            FROM Task 
                                            where IsArchived = true and RecordTypeId =:dealmachinetask_id and whoId IN:LeadID_param All ROWS];
                                            
     system.debug('Archived task for lead id='+ Lead_ID + 'has list size =' + Archivedtask_onLead.size() + 'and those are ==' +Archivedtask_onLead);                                       
    
    if(Archivedtask_onLead.size()>0 ||  test.isrunningtest()== false)
    {
    for(Task iterate_task : Archivedtask_onLead)
    {
        
        Task tsk = new Task();
        tsk.ActivityDate=Date.today();
        tsk.id=iterate_task .id;
        Tasklist_to_unarchive.add(tsk);
    }
    
   update Tasklist_to_unarchive;
   
  /*
    try{
 
       update Tasklist_to_unarchive;
       //return dispostioning_lead;
    }
    catch(Exception e)
    {
        
        system.debug('System encountered some error which is --'+e.getmessage());
        // error_message.add(e.getMessage());
       // return error_message;
    }
*/    
  }
  
     else{
         system.debug('you are in else block');
         } 
     
  }
}