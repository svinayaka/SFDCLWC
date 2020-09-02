global class ProcessHistoryUtils implements Database.Batchable<sObject>{

 global ProcessHistoryUtils(){}
 global void execute(Database.BatchableContext BC, List<sObject> scope){
  List <ProcessInstance> processHistories =new List <ProcessInstance>();            
  List<GE_ES_ProcessInstanceHistory__c> processHists = new List<GE_ES_ProcessInstanceHistory__c>();
  List<ProcessInstanceHistory> workItemsList= new List<ProcessInstanceHistory>();
  //Database.QueryLocator ql = Database.getQueryLocator([SELECT Id, TargetObjectId, (SELECT Id, StepStatus, Comments, ActorId, OriginalActorId, CreatedDate, RemindersSent  FROM StepsAndWorkitems) FROM ProcessInstance]); 

      //processHistories = Database.QueryLocator([SELECT Id, TargetObjectId, (SELECT Id, StepStatus, Comments, ActorId, OriginalActorId, CreatedDate, RemindersSent  FROM StepsAndWorkitems) FROM ProcessInstance]; 
            //if(processHistories.size()>0) {
                for(sObject s: scope) {
                    ProcessInstance pInstance = (ProcessInstance)s;
                    workItemsList = pInstance.StepsAndWorkitems;
                    System.debug('WorkItemsList::::'+workItemsList);
                    for(ProcessInstanceHistory processHistory : workItemsList) {
                    GE_ES_ProcessInstanceHistory__c customHistory = new GE_ES_ProcessInstanceHistory__c();
                    customHistory.Actor_ID__c=processHistory.ActorID;
                    customHistory.StepStatus__c=processHistory.StepStatus;
                    customHistory.Comments__c=processHistory.Comments;
                    customHistory.OriginalActorId__c=processHistory.OriginalActorId;
                    customHistory.Date__c=processHistory.CreatedDate;
                    customHistory.Target_Object_Id__c=pInstance.TargetObjectId;
                    customHistory.ProcessInstanceId__c = pInstance.Id;
                    customHistory.RemindersSent__c=(processHistory.RemindersSent==1?true:false);
                    processHists.add(customHistory);
                    }
                    //workItems.put(pInstance.Id, pInstance.StepsAndWorkitems);
                }
           // }          
          
    //}
    //System.debug('ProcessHistories::::'+processHistories.size());
    System.debug('ProcessHistories::2222::'+processHists);
    insert processHists;
   }
   global Database.querylocator start(Database.BatchableContext BC){
   If(test.isrunningtest())
   {
   return Database.getQueryLocator([SELECT Id, TargetObjectId, (SELECT Id, StepStatus, Comments, ActorId, OriginalActorId, CreatedDate, RemindersSent  FROM StepsAndWorkitems) FROM ProcessInstance Limit 10]); 
   }
            return Database.getQueryLocator([SELECT Id, TargetObjectId, (SELECT Id, StepStatus, Comments, ActorId, OriginalActorId, CreatedDate, RemindersSent  FROM StepsAndWorkitems) FROM ProcessInstance]); 
    }
    global void finish(Database.BatchableContext BC){
    //Do Nothing
    }

    
}