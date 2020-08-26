trigger PRMChannelPartnerBackgroundTrigger_GE_OG on PRM_Channel_Partner_Background__c (after insert,after update) {
	PRMChannelPartnerBackgroundHandler_GE_OG chPa = new PRMChannelPartnerBackgroundHandler_GE_OG();
    if(trigger.isInsert){
        if(trigger.isAfter){
            chPa.riskRatingCalculationOnCPInsert(trigger.new);
        }
    }
    if(trigger.isUpdate){
        if(trigger.isAfter){
            if(CheckRecursion_GE_OG.cp_background){
            	chPa.riskRatingCalculationOnCPUpdate(trigger.new,trigger.oldMap);
            }
        }
    }
}