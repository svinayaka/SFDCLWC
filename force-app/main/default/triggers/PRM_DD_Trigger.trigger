trigger PRM_DD_Trigger on PRM_Due_Diligence__c (after update) {
    List<PRM_Due_Diligence__c> updlst = new List<PRM_Due_Diligence__c>();
    PRMDueDiligenceHandler_GE_OG dueDlgnc = new PRMDueDiligenceHandler_GE_OG();
    
    for(PRM_Due_Diligence__c dd: Trigger.New){
        if((dd.PRM_Due_Diligence_Status__c == 'Due Diligence Accepted' || dd.PRM_Due_Diligence_Status__c == 'None' ||dd.PRM_Due_Diligence_Status__c == 'Yellow Flag' ||dd.PRM_Due_Diligence_Status__c == 'Orange Flag' ||dd.PRM_Due_Diligence_Status__c == 'Red Flag') && Trigger.oldMap.get(dd.Id).PRM_Active__c != dd.PRM_Active__c && !dd.PRM_Active__c){
            updlst.add(dd);
            
        }
    }
    if(updlst != null){
        PRM_CreateCloneDueDiligence.createDDfromPrevious(updlst);
    } 
    
    if(trigger.isUpdate){
        if(trigger.isAfter){
            dueDlgnc.populateLastDueDiligenceReview(trigger.new);
            dueDlgnc.dueDiligenceStatusChangePDFGeneration(trigger.new,trigger.oldMap);
            dueDlgnc.emailNotificationOnDDNotStarted(trigger.new,trigger.oldMap);
        }
    }
}