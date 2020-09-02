/*
Type Name [Class/Trigger/Page Name] : Class - GE_DS_Schedule_EscalationMail 
Purpose                             : Escalation Email for tasks
Overview                            : Schedule GE_Batch_DS_EscalationMail  class.
Functional Area                     : Service
Author                              : RajaKumar Malla
Created Date                        : 12 Dec 2014
Test Class                          : GE_Batch_DS_EscalationMail_Test
*/
global class GEDS_Schedule_EscMailForInProgTask implements Schedulable
{
    global void execute(SchedulableContext SC)
    {
        database.executebatch(new GEDS_Batch_EscMailForInProgTask(),200);
    }
}