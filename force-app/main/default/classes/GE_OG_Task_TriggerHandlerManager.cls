public class GE_OG_Task_TriggerHandlerManager 
{
    
    public  void afterinsertsendemail(Map<ID,Task> newTasks)
    {
       
       TaskEmailOperations.SendEmailOnStatusChange(newTasks); 
        
                                       
                                  
    }
    
    // added for R-28937

    Public void afterinsertpostchatter(Map<ID,Task> newTasks)
    {
    PostChatteronAccount.postchattertask(newTasks); 
    
    }
    
    // end of R-28937

    
    public  void afterupdatesendemail(Map<ID,Task> oldTasks, Map<ID,Task> newTasks)
    {
       TaskEmailOperations.SendEmailOnStatusChange(oldTasks,newTasks); 
                                  
    }
    
    
   /* 
   commenting the below two methods as these are no more invoked from trigger
   public  void afterinsertforecastupdate(list<task> newtasks)
    {
       GEOGCIRTaskforecastclass taskclass=new GEOGCIRTaskforecastclass();
       taskclass.GEOGCIRTaskforecastdateinsert(newTasks); 
        
                                       
                                  
    }
    
    public  void afterupdateforecastupdate(list<task> newtasks,Map<ID,Task> oldTasks)
    {
        GEOGCIRTaskforecastclass taskclass=new GEOGCIRTaskforecastclass();
       taskclass.GEOGCIRTaskforecastdateupdate(newTasks,oldtasks); 
                                  
    }
    */
    
     public  void afterupdatciremailalert(list<task> newtasks,Map<ID,Task> oldTasks)
    {
        GE_OG_CIREmailAlert  taskclass=new GE_OG_CIREmailAlert();
       taskclass.ciremailalertnotification(newTasks,oldtasks); 
                                  
    }
    /*
    Method to call only after update Context 
    */
    Public void afterUpdateTskStatusChangngMailToOwner(List<Task> NewList,Map<Id,Task> NewMap,Map<id,Task> OldMap){
        GE_OG_Tsk_Status_Changng_Mail.TaskStatusChgangingMail(NewList,NewMap,OldMap);
   
    }
    
    
     //Add parent for Dashboard comment Task
    public void setRelatedObject(List<Task> lstNew){
        Id rcTypeDashBoardComment = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Dashboard Comments').getRecordTypeId();
        Id accId;
     
        for(Account acc : [SELECT ID FROM Account Where Name = 'GE OIL & GAS (QMI) / HQ' AND RecordType.Name = 'Relationship Account' limit 1]){
            accId = acc.Id;
        }
        for(Task t : lstNew){
            if(t.RecordTypeId == rcTypeDashBoardComment){
                t.whatId = accId;
            }
        }        
    }

    // Method is related to R-25011 to block non secure related attachments
    public void validateAttachments(List<Task> lstNew){

        GE_OG_RestrictDllAndExeFileUtil.removeNonCompliantAttachments(lstNew);
    }
    
    //R-29632 - Kiru
    public  void beforedelete(List<task> delTasks, Map<ID,Task> oldTask)
    {
    system.debug('delTasks '+delTasks);
    //get ID of Deal Machine Task recordType
        Id rt = [SELECT id FROM recordType WHERE name = 'Deal Machine Task'].id;
        
        List<Task> queriedTask = [Select Id, recordtype.id,subject from Task where id=:delTasks];
       system.debug('queriedTask  '+queriedTask );
          for(Task t : queriedTask ){
     system.debug('task record type '+t.RecordTypeId +' '+t.subject);
       if(t.RecordType.Id == rt){
       system.debug('RT Id = '+rt );
       system.debug('Record Type Matches');
     Task actualRecord = (Task)Trigger.oldMap.get(t.Id);

       actualRecord.addError('Users are no longer allowed to delete activities. Please either Cancel or Complete the following activity');
        
              }                     
                                  
    }
        
                                       
                                  
    }
    public void checkMCTSCaseStatus(List<Task> lstNew){
        Map<Id,Task> caseIdsMap = new Map<Id,Task>();

            for(Task tRec:lstNew){
                if(tRec.whatId != null && tRec.whatId.getsObjectType() == Case.sObjectType){
                    caseIdsMap.put(tRec.whatId,tRec);
                }
            }
            if(caseIdsMap != null){
                List<Case> caseList = [Select id,Status,OwnerId from case where id IN:caseIdsMap.keySet() and Recordtype.DeveloperName =: 'MC_TS'];
                if(caseList.size()>0){
                    for(Case cRec :caseList){
                        Task taskRec = caseIdsMap.get(cRec.Id);
                         /* if(cRec.OwnerId != UserInfo.getUserId()){                           
                           taskRec.addError('Only Case Owner Can create a new Task'); 
                        }*/
                        
                           if(cRec.Status == 'Closed'){
                           taskRec.addError('Task cannot be created if the status of the case is Closed');
                        }
                    }
                }
            }
        
        
    }

}