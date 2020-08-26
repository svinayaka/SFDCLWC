trigger PRMChannelAppointmentTrigger_GE_OG on PRM_Channel_Appointment_GE_OG__c (after insert,after update) {
    PRMChannelAppointmentHandler_GE_OG pr = new PRMChannelAppointmentHandler_GE_OG();
    if(trigger.isInsert){
        if(trigger.isAfter){
            pr.riskRatingCalculationOnCAInsert(trigger.new);
        }
    }
    if(trigger.isUpdate){
        if(trigger.isAfter){
            if(CheckRecursion_GE_OG.ChAppt){
                pr.riskRatingCalculationOnCAUpdate(trigger.new,trigger.oldMap);
            }
        }
    }
    
}