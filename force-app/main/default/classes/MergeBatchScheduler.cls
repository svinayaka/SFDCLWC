global class MergeBatchScheduler implements Schedulable{
    global Id masterMergeId = null;
    global Id masterHQId = null;
    global Id masterRecordId = null;
    global Map<Id, Id> mapChildParent = new Map<Id, Id>();
    global MergeBatchScheduler(Id masterMergeId, Id masterHQId, Id masterRecordId, Map<Id, Id> mapChildParent){
        this.masterHQId = masterHQId;
        this.mapChildParent = mapChildParent;
        this.masterMergeId = masterMergeId;
        this.masterRecordId = masterRecordId;
    }
    global void execute(SchedulableContext SC) {
        BatchProcessRelatedRecordsController bc = new BatchProcessRelatedRecordsController(masterMergeId,masterHQId,masterRecordId,mapChildParent); 
        Database.executeBatch(bc,50);
    }
}