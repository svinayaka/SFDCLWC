trigger LastActivityCompletedDate on Task (after insert, after update) {
    List<Id> Conids = new List<Id>();
    for(Task t:trigger.new) {
        if(t.WhoId != null) {
            string objKeyPrefix = t.WhoId;
            objKeyPrefix = objKeyPrefix.substring(0,3);
            
            if(objKeyPrefix == '003') {
                
                Conids.add(t.WhoId);
            }
        }
    }
    if(Conids.size()>0){
        map<id,Contact> mapcon = new map<id,Contact>();
        for(Contact con:[SELECT Id,Last_Activity_Completed_Date__c FROM Contact WHERE id in:Conids]) {
            mapcon.put(con.id,con);
        }
        List<Contact> lstCon = new List<Contact>();
        for(task tskobj:trigger.new) {
        if(trigger.isUpdate){
            task oldTask = Trigger.oldMap.get(tskobj.Id);
            Contact con = new Contact(Id=tskobj.whoId);
            if(oldTask.Status != 'Completed' && tskobj.Status=='Completed') {
                 con.Last_Activity_Completed_Date__c= tskobj.LastModifiedDate;
                 lstCon.add(con);
            }
        } 
        else{
            Contact con = new Contact(Id=tskobj.whoId);
            if(tskobj.Status=='Completed') {
                 con.Last_Activity_Completed_Date__c= tskobj.LastModifiedDate;
                 lstCon.add(con);
            }
        }   
            
        }
        
        update lstCon;
  }
}