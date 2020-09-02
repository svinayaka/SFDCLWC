public class TaskCloseController {
    
     ApexPages.StandardSetController standardController;
     List<Task> SelectedTasks= new List<Task>();
    
    
    public TaskCloseController(ApexPages.StandardSetController standardController) 
    {
             this.standardController= standardController;
    }
    
    
    public  PageReference updateTask()
    {    
         Schema.DescribeSObjectResult result = Task.WhatId.SObjectType.getDescribe(); 
        PageReference pageRef2 = new PageReference('/' + result.getKeyPrefix());  
         SelectedTasks= (List<Task>)standardController.getSelected();
        List<Task>updateTaskList= New List<Task>();
        
        for(Task tsk:SelectedTasks)
        {
            tsk.Status= 'Completed';
            updateTaskList.add(tsk);
            
        }
        update updateTaskList;    
         return pageRef2;
        
     } 
     @AuraEnabled
     public static String updateTaskStatus(Id taskId){
         Task taskRec = [Select id,Status from Task where id =:taskId limit 1];
         taskRec.Status = 'Completed';
         Database.SaveResult sr = database.update(taskRec);
         if (sr.isSuccess()){
             return 'Task updated successfully';
         }
         else{
             return 'Error Occured';
         }
     } 
    
}