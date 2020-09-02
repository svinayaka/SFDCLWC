@isTest
public class TaskCloseControllerTest {
    
    @testSetup
    public static void DataSetup()
    {    
    id recTypeMcsCS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
    Case MCSCase= new Case();
    MCSCase.Site_Contact_Information__c='SiteABD';
    MCSCase.SuppliedEmail='test321@gmail.com';
    //MCSCase.accountId= acc.id;
    MCSCase.recordTypeId= recTypeMcsCS;
    insert MCSCase;
        
      id recTypeNewTask = Schema.SObjectType.Task.getRecordTypeInfosByName().get('New Task').getRecordTypeId();
      task t=new task();
        t.Status='Not Started';
        t.subject='test';
        t.whatid=MCSCase.id;
        t.ActivityDate = system.today();
        t.recordTypeId= recTypeNewTask;
        insert t;   
        
        task t1=new task();
        t1.Status='Not Started';
        t1.subject='test';
        t1.whatid=MCSCase.id;
        t1.ActivityDate = system.today();
        t1.recordTypeId= recTypeNewTask;
        insert t1;  
        
        task t2=new task();
        t2.Status='Not Started';
        t2.subject='test';
        t2.whatid=MCSCase.id;
        t2.ActivityDate = system.today();
        t2.recordTypeId= recTypeNewTask;
        insert t2;  
        
        //List<task>tList=new List<task>();     
        //tList.add(t);
        //tList.add(t1);
      }
    
    public static testmethod void testupdateTask()
    {
        List<Task> tl= [Select id from Task where Subject='test'];
        //PageReference pageref = TaskCloseController.updateTask();
        
        
       TaskCloseController ctr = new TaskCloseController(new ApexPages.StandardsetController(tl));
         PageReference pageref = ctr.updateTask();
         TaskCloseController.updateTaskStatus(tl[0].id);
    }

}