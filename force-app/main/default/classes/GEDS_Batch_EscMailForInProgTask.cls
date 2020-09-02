/*
Type Name [Class/Trigger/Page Name] : Class - GEDS_Batch_EscMailForInProgTask 
Purpose                             : Escalation Email for tasks
Overview                           : Send escalation mail for task creators and assigners which is not completed within DueDate.
Functional Area                 : Service
Author                                : RajaKumar Malla
Created Date                     : 12 Dec 2014
Test Class                         :GE_Batch_DS_EscalationMail_Test
*/
global class GEDS_Batch_EscMailForInProgTask implements Database.batchable<Sobject>{
    
     global database.querylocator start(Database.batchableContext BC)
    {
        date TodayDate= System.Today();
        Id DSId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('DS').getRecordTypeId();
        return Database.getQueryLocator('SELECT id, Owner.email, Description,Subject,What.Name,CreatedBy.email,Owner.FirstName,owner.LastName, Status, RecordTypeId, ActivityDate, whatid, what.type From Task where status = \'In Progress\' and recordtypeid = :DSId and ActivityDate <= :TodayDate and what.type = \'Case\' ');
    }
    global void execute(Database.batchableContext BC,list<Task>TaskList)
    {
        String body;
        List<Messaging.SingleEmailMessage> MailList = new List<Messaging.SingleEmailMessage>();
        for(Task t: TaskList){
            body='';
            String taskurl=URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t.id;
            String caseurl=URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t.Whatid;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[]{}; 
            if( t.Owner.Email != null)          
                toAddresses.add(t.Owner.Email);
            if( t.createdby.Email != null) 
            toAddresses.add(t.createdby.Email);
            mail.setToAddresses(toAddresses);
            mail.setSubject(' Escalation Mail On Task: '+t.Id);
            body+='<html>Hello '+t.Owner.FirstName+'&nbsp;'+t.owner.LastName+',<br/><br/><b>The task assigned to you is not completed with in Due Date '+t.ActivityDate.format()+'. Please complete the task.</b><br/><br/>';
            body+='The task details are as follows:<br/><br/>';
            body+='<b>Description  &nbsp;  &nbsp; &nbsp;  :</b> ';
            if(t.Description == null)
                body+= ''+'<br/><br/>';
            else
                body+= t.Description+'<br/><br/>';
            body+='<b>Subject  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:</b> '+t.Subject+'<br/><br/>';
            body+='<b>Case Number  &nbsp;   :</b> '+t.What.Name+'<br/><br/>';
            body+='<b>Due Date  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; :</b> '+t.ActivityDate.format()+'<br/><br/>';
            body+='<b>Status  &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:</b> '+t.Status+'<br/><br/>';
            body+='<a href='+caseurl+'>Please Click this Link to open The Case</a><br/><br/>';
            body+='<a href='+taskurl+'>Please Click this Link to open The Task</a><br/><br/><br/>Thanks.</html>';
            mail.setHtmlBody(body);
            mail.setsaveasactivity(false);
            mailList.add(mail);
        }
        Messaging.SendEmail(MailList);
    }
    global void finish(Database.batchableContext BC)
    {
       
     
    }
}