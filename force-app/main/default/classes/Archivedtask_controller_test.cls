@isTest(SeeAllData=true)

public class Archivedtask_controller_test{

@isTest static void update_archivedTask_test1() {

list<String> lead_id_list = new  list<String> ();

Lead lead_with_archived_task = [select id , name from lead where id = '00Q1200000zYI07EAG' ALL ROWS];

/* - these 2 query does not work to fetch lead id where we have atleast 1 archived task record 
task t= [select id,subject, WhoId from task where isarchived = true and RecordTypeId ='01212000000oGZQ' and WhoId !='' ALL ROWS];

list<lead> ld = [select id, name,(select id , subject, isarchived from tasks where isarchived = true and RecordTypeId ='01212000000oGZQ' ALL ROWS) from lead limit 1];
*/

string lead_id =(string)lead_with_archived_task.id;
lead_id_list.add(lead_id);
Archivedtask_controller.unarhivetask(lead_id_list);

}



@isTest static void archivedTask_negativetest() {

Lead ld = new Lead();
ld.LastName = 'Test Lead';
ld.Company = 'general Electric In';
ld.Email = 'sumit.kr@gegege.com';
ld.Status = 'Active';
insert ld;

list<String> lead_id_list = new  list<String> ();
string lead_id =(string)ld.id;
lead_id_list.add(lead_id);
Archivedtask_controller.unarhivetask(lead_id_list);

}


}

// we cant create archived task in test class or in org /apex.
/*
Lead ld = new Lead();
ld.LastName = 'Test Lead';
ld.Company = 'general Electric In';
ld.Email = 'sumit.kr@gegege.com';
ld.Status = 'Active';
insert ld;

list<String> lead_id = new list<String>();
lead_id.add(ld.id);

system.debug('inserted test lead record is'+ld);

ID DealMachineTask_id = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeId();
system.debug('Record type of task is:::::'+DealMachineTask_id );
Task tsk = new  Task();
    
    tsk.ActivityDate = Date.today().addDays(-370);
    tsk.Subject='Sample Task';
    tsk.WhoId = ld.Id;
    tsk.Type ='Call';
    //tsk.Related_To_What_ge_og__c ='Campaign Member';
    //tsk.Related_To_Who_ge_og__c='Lead';
    tsk.Campaign_Lead_ID_ge_og__c='';   

    tsk.OwnerId = UserInfo.getUserId();
    tsk.SVMXC__SM_Status__c='Completed';
    tsk.RecordTypeId=DealMachineTask_id ;
    system.debug('task data for inserting is--- '+tsk);
    insert tsk ;
    
    Archivedtask_controller.unarhivetask(lead_id);
*/