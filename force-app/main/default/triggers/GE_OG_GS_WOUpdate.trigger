trigger GE_OG_GS_WOUpdate on GE_OG_GS_WO_Updates__c (after insert) {
	
	GE_OG_GS_WO_UpdateCallOut.sendCallout(trigger.new);

}