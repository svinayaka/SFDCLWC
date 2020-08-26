trigger GE_DS_EventBefore on Event (before delete, before insert, before update) 
{
    //if(trigger.isBefore && trigger.isDelete)
       // SVMXC_WorkOrderHelper.deleteTechAssignment (Trigger.oldMap);
        
    if(Trigger.isInsert || trigger.isupdate){
        set<id> whoIds = new set<Id>();
        for(Event ev : trigger.new){
            whoIds.add(ev.WhoId);
        }
        Map<Id, Contact> mapUser =new Map<Id, Contact>();
        if(whoIds.size()>0)
        mapUser = new Map<Id, Contact>([Select Id, Name from Contact where Id in : whoIds]);
        
        for(Event ev : trigger.new){
            
            if(mapUser.get(ev.whoId)!=null){
                ev.Contact__c = mapUser.get(ev.whoId).Name ;
            }
        }
    }    
}