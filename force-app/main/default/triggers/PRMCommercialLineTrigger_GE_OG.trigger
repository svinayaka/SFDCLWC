trigger PRMCommercialLineTrigger_GE_OG on PRM_Commercial_Line_GE_OG__c (after insert,after update, before update) {
    PRMCommercialLineHandler_GE_OG prmCL = new PRMCommercialLineHandler_GE_OG();
    
    if(trigger.isInsert){
        if(trigger.isAfter){
            prmCL.riskRatingCalculationOnCLInsert(trigger.new);
            prmCL.SyncFieldsfromCommLinesOnInsert(trigger.new);
            prmCL.CLSalesRepCountInsert(trigger.new);
        }
    }
    
    if(trigger.isUpdate){
        
        if(trigger.isBefore)
        {
           PRMCommercialLineHandler_GE_OG.handleBeforeUpdate(Trigger.new, Trigger.OldMap); 
        }
        if(trigger.isAfter){
            if(CheckRecursion_GE_OG.comLine){
                prmCL.riskRatingCalculationOnCLUpdate(trigger.new,trigger.oldMap);
                prmCL.SyncFieldsfromCommLinesOnUpdate(trigger.new,trigger.oldMap);
                //prmCL.CLSalesRepCountUpdate(trigger.new,trigger.oldMap);
            }
            prmCL.CLSalesRepCountUpdate(trigger.new,trigger.oldMap);
        }
    }
}