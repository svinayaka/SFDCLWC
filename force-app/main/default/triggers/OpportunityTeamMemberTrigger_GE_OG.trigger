trigger OpportunityTeamMemberTrigger_GE_OG on OpportunityTeamMember (before Insert,after Insert,before update,after update, after delete) {
   if(trigger.isinsert || trigger.isupdate){
  
        AddOpportunityTeamMemberAutomation_GE_OG aotm = new AddOpportunityTeamMemberAutomation_GE_OG();
        //Added by Gourav
        OpportunityChatterFollow_GE_OG otmFollow = new OpportunityChatterFollow_GE_OG();
        Map<String,String> mexistingFollower = new Map<string,String>();
        Set<Id> idSet = new Set<Id>();
        for(OpportunityTeamMember otm: Trigger.new ){
            idSet.add(otm.opportunityId);
        }
        
        if(trigger.isAfter){
            aotm.updateOpportunityAccessLevel(idSet);
            aotm.insertCommercialManagercheck(Trigger.new, idSet,trigger.oldmap);
                        
        }
        //Added by Gourav
        if(trigger.isAfter && trigger.isUpdate){
           //Boolean isDelete= true; 
           otmFollow.updFollowChatter(Trigger.new, Trigger.old);
         }
       
        if(Trigger.isBefore && Trigger.isInsert) {
            //Added by Madhuri - R-24033 : If the opportunity owner is already into the Deal Team then throw an error
            if(!Util_GE_OG.isFromOppTriggerInsert){
                aotm.updateOpportunityAccessLevel(idSet);
                aotm.checkOppOwnerInsertUpdate(Trigger.new, idSet,trigger.oldmap);
            }
            
            //Added by Gourav
            otmFollow.followOpportunityChatter(Trigger.new);
          
        }
        
        if(Trigger.isBefore && Trigger.isUpdate) {
            //Added by Madhuri - R-24033 : If the opportunity owner is already into the Deal Team then throw an error
            if(!Util_GE_OG.isFromOppTriggerInsert){
                aotm.updateOpportunityAccessLevel(idSet);
                aotm.checkOppOwnerInsertUpdate(Trigger.new, idSet,trigger.oldmap);
            }
        }
        
     }
    if(trigger.isdelete){
        AddOpportunityTeamMemberAutomation_GE_OG aotm = new AddOpportunityTeamMemberAutomation_GE_OG();
        //Added by Gourav
        OpportunityChatterFollow_GE_OG otmFollow = new OpportunityChatterFollow_GE_OG();
       
        Set<Id> idSet = new Set<Id>();
        
        for(OpportunityTeamMember otm: Trigger.old){
            idSet.add(otm.opportunityId);
        }
        aotm.deleteCommercialManagerCheck(Trigger.old, idSet);
        //Added by Gourav
        Boolean isDelete= true;
        otmFollow.unfollowOpptyChatter(Trigger.old, isDelete);
    }
}