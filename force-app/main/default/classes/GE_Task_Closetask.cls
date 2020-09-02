/*    
Class Name      : GE_Task_Closetask
Purpose/Overview  : Ability to close multiple activities at ones.
Author            : Lakshmi Prasanna Kethu
Created Date      : 28 Jan 2013
Test Class        : GE_Task_Closetask_Test
*/

Global class GE_Task_Closetask
{
  Webservice static Boolean Closetask(String s)
  {
     String urlTaskId;
     List<String> lTaskId= New List<String>();
     List<Task> lTask_selected= New List<Task>();
     List<Task> updatetask= New List<Task>();
       
     urlTaskId=s;
     system.debug('<<After Processing>>'+s);
     lTaskId=urlTaskId.split(',');            
            
 lTask_selected=[select id,OwnerID,Status from Task where ID in :lTaskId];
              
  for(Task t:lTask_Selected)
  {      
     t.Status = 'Completed';
     updatetask.add(t);
  }
            
  if(updatetask.size()>0)
  {
    update updatetask;
  }                              
  return true;  
 
 }

}