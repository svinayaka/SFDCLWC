trigger task_start_date on Task (before insert, before update) 
{
     
         for(Task tsk:Trigger.new) 
        {  
        
             if(Trigger.isInsert){
                 tsk.Activity_Start_Date__c = DateTime.now();
             }
             
              
             if(tsk.ActivityDate != Null){

             Integer differTime = Date.valueOf(system.now()).daysBetween(tsk.ActivityDate);
             
             tsk.Activity_Due_Date__c = system.now().AddDays(differTime); 
             }
        }  
}