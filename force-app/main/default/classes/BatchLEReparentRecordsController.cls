global class BatchLEReparentRecordsController implements Database.Batchable<sObject>,Database.Stateful{
    global List<SObject> lstRelated = new List<SObject>();
    global Id rId;
    global Map<Id, String> errorMap = new Map<Id, String>();
    public BatchLEReparentRecordsController(Id requestId, List<SObject> lstRelatedRecords){
        lstRelated = lstRelatedRecords;
        rId = requestId;
    }
    global List<SObject> start(Database.BatchableContext BC){
        return lstRelated;
    }
    
    global void execute(Database.BatchableContext BC, List<SObject> scope){
        if(!scope.isEmpty()){
            try{
                Integer index = 0;
                Database.SaveResult[] srList = Database.update(scope, false);
                for(Database.SaveResult dsr : srList){
                                   
                    if(dsr.isSuccess()){
                        
                    }
                    else{
                        String errMsg = dsr.getErrors()[0].getMessage();
                        errorMap.put(scope[index].Id, errMsg);
                        
                    }
                    index++;
                }
              }
            catch(Exception e){
                system.debug('Error while processing records.... '+e.getMessage());
            }
           
        }
    }
    
    global void finish(Database.BatchableContext BC){
        List<Re_Parenting_LE_Request__c> lstReparenting = [SELECT id, name,Request_Status__c
                                                            FROM Re_Parenting_LE_Request__c
                                                            WHERE id=: rId
                                                            LIMIT 1];
        String finalstr = 'Id, Error \n';
        String attName = 'LE Reparenting Errors.csv';
        for(Id id  : errorMap.keySet()){
            string err = errorMap.get(id);
            string recordString = '"'+id+'","'+err+'"\n';
            finalstr = finalstr +recordString;
        } 

        if(!errorMap.isEmpty()){  
            Attachment efa = new Attachment();
            efa.name = attName;
            efa.ParentId = rId;
            efa.body = Blob.valueOf(finalstr);
            try{
                insert efa;
            }
            catch(Exception e){
                System.debug('Error while inserting attachment...   '+e.getMessage());
            }
        }
        if(!lstReparenting.isEmpty()){
            for(Re_Parenting_LE_Request__c objReparenting: lstReparenting){
                objReparenting.Request_Status__c = 'Completed';
            }
            try{
                update lstReparenting;
            }
            catch(Exception e){
                System.debug('Error while updating request...   '+e.getMessage());
            }
        }   
    }
}