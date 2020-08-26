/*
Trigger Name                 - SD_CustomJobTrigger
Object Name                  - FX5__Job__c
Created Date                 - 8/28/2019
Create By                    - Naveen Vuppu
LastModifiedDate             -
Test Class                   - SD_JobupdatephaseclassTest
Description                  - Single Trigger on the Job object, Uses a Handler Clas SD_JobTriggerHandler 
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class

Last Modified By             - VijayaLakshmi Murukutla
LastModified Date            - Oct/01/2019
Purpose                      - Auto update feilds ('Job Items Added','Fundamentals Added','Fundamentals To Be Added') of Job Object when JobItems are inserted or deleted for the job.

Last Modified By             - VijayaLakshmi Murukutla
LastModified Date            - Dec/26/2019 - Jan/07/2020
Purpose                      - Ref: Story/Requirement R-33390
                                1. Create/modify a job trigger so that whenever a job is selected as a rotator crew, it copies over all the crew records from the job to the current job
                                2. If user removes a rotator crew job, it deletes all the crew copied over from the rotator crew job
                                3. If there is a modification on the rotator crew job with regards to crew planning, it should reflect the change in all the jobs with are associated with that job as a rotator crew.

====================================================================================================
*/
trigger SD_CustomJobTrigger on FX5__Job__c ( Before insert,before update,after update,after insert, after delete, after undelete) {

    // SD_JobTriggerHandler handler = new SD_JobTriggerHandler();
    SD_JobTriggerHandler ObjJobTrgrHndlr = new SD_JobTriggerHandler();
    
    
    /* Before Insert*/
    if(Trigger.isInsert && Trigger.isBefore){
        ObjJobTrgrHndlr.OnBeforeInsert(Trigger.new,null);
    }
    /* Before Update*/
    if(Trigger.isUpdate && Trigger.isBefore){
        ObjJobTrgrHndlr.OnBeforeUpdate(Trigger.new,trigger.oldmap);
    }

    /* After Insert*/
    if(Trigger.isInsert && Trigger.isAfter){
        ObjJobTrgrHndlr.OnAfterInsert(Trigger.new);
        ObjJobTrgrHndlr.autoInsertRCCrewsOnJob(Trigger.new);
    }

    /* After Update */
    else if(Trigger.isUpdate && Trigger.isAfter){
        ObjJobTrgrHndlr.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);
        ObjJobTrgrHndlr.autoResetRCCrewsOnJobUpdate(Trigger.oldmap, Trigger.new);
    }

    /* After Delete */
   else if(Trigger.isDelete && Trigger.isAfter){
        ObjJobTrgrHndlr.OnAfterDelete(Trigger.old, Trigger.oldMap);
   }

    /* After Undelete */
   else if(Trigger.isUnDelete){
       ObjJobTrgrHndlr.OnUndelete(Trigger.new);
    }

}