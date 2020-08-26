trigger KeyProjects_GE_OG on Key_Project_ge_og__c (after insert, after delete) {

if(Trigger.isinsert){
ChatterfeedUtility1.Feed_on_insert(trigger.new, 'Key Project');

}

if(Trigger.isdelete){
ChatterfeedUtility1.Feed_on_delete(trigger.old, 'Key Project');

}

}