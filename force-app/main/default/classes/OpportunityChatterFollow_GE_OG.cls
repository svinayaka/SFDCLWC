/*
Class/Trigger Name     : OpportunityChatterFollow_GE_OG
Used Where ?           : OpportunityTeamMemberTrigger_GE_OG
Purpose/Overview       : OpportunityTeamMember to follow and unfollow chatter for a Opportunity
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-24532
Author                 : Gourav Anand
Created Date           : 06/Apr/2016
Test Class Name        : OpportunityChatterFollow_GE_OG_Test
Code Coverage          : 90%
Changes                :                   
*/

public without sharing class OpportunityChatterFollow_GE_OG {

   //Method to enable new TeamMember with role as Following to follow the chatter 
    public void followOpportunityChatter(List<OpportunityTeamMember> newOTMList){
            List<EntitySubscription> entList = new List<EntitySubscription>();
            Map<String,List<EntitySubscription>> mEntitySubscription= new Map<String,List<EntitySubscription>>();
            Set<Id> sParentIds = new Set<Id>();
            for(OpportunityTeamMember otm: newOTMList)
            {
                sParentIds.add(otm.OpportunityId);
            }
            for(EntitySubscription oEntitySubscription : [Select Id,
                                                                 ParentId, SubscriberId 
                                                            from EntitySubscription where ParentId In : sParentIds])
            {
                if(mEntitySubscription.get(oEntitySubscription.ParentId+'~'+oEntitySubscription.SubscriberId)==null)
                        mEntitySubscription.put(oEntitySubscription.ParentId+'~'+oEntitySubscription.SubscriberId,new List<EntitySubscription>());
                mEntitySubscription.get(oEntitySubscription.ParentId+'~'+oEntitySubscription.SubscriberId).add(oEntitySubscription);
            }
            for (OpportunityTeamMember otm: newOTMList){     
                    System.debug('Into the OpportunityTeamMember object before addition-------->');   
           
                    if( mEntitySubscription.get(otm.OpportunityId+'~'+otm.UserId)==null && otm.TeamMemberRole=='Following')  
                              entList.add(new EntitySubscription(ParentId = otm.OpportunityId,SubscriberId= otm.UserId));
           
           }
         
           if(entList.size()>0)   
                 insert entList;    
       
    }
    
    //Method to enable existing TeamMember to follow or unfollow the chatter based on new updated role 
    public void updFollowChatter(List<OpportunityTeamMember> newOTMList, List<OpportunityTeamMember> oldOTMList){
       
            List<EntitySubscription> entSubList = new List<EntitySubscription>();
            OpportunityTeamMember otm = newOTMList.get(0);
                
            System.debug('Into the OpportunityTeamMember role ----------------->'+oldOTMList.get(0).TeamMemberRole);
            List<EntitySubscription> existingFollower= [Select Id,ParentId, SubscriberId from EntitySubscription 
                                                 where ParentId=:otm.OpportunityId and SubscriberId=: otm.UserId];
            System.debug('Into the OpportunityTeamMember Update object addition-------->');
             
            if(existingFollower.size()==0 && otm.TeamMemberRole=='Following')  { 
                   System.debug('Into the OpportunityTeamMember object following chatter-------->');
                   entSubList.add(new EntitySubscription(ParentId = otm.OpportunityId,SubscriberId= otm.UserId));
            }
                
            else if(otm.TeamMemberRole!='Following' && oldOTMList.get(0).TeamMemberRole=='Following'){
                     System.debug('Unfollowing chatter on role change-------->'); 
                     Boolean isDelete = false;  
                     unfollowOpptyChatter(newOTMList,isDelete);
            }
          
              
           if(entSubList.size()>0){
                  System.debug('Following chatter & entSubList size:-------->'+entSubList.size());   
                  insert entSubList;    
           }
        
    }
    
    //Method to enable existing TeamMember to unfollow chatter based On new updated role apart from Following
    //or On deleting the TeamMember with role as Following
    public void unfollowOpptyChatter(List<OpportunityTeamMember> existingOTMList, Boolean isDel){
      
          System.debug('Process to unfollow on delete-------->');
          List<EntitySubscription> entitySubsList = new List<EntitySubscription>();
          List<EntitySubscription> chkentitySubs = new List<EntitySubscription>();
          
          OpportunityTeamMember otm = existingOTMList.get(0);
         
          chkentitySubs = [select parentId,subscriberId from EntitySubscription where subscriberId=:otm.UserId and parentId=:otm.OpportunityId];
          system.debug('##### ' + chkentitySubs);
          
          if(ChkentitySubs!=null && ChkentitySubs.size()>0)
          {
              if((!isDel)||(isDel && otm.TeamMemberRole=='Following')){
                  EntitySubscription entSubsEx =[Select parentId,subscriberId from EntitySubscription where 
                                                           parentId=:otm.OpportunityId and subscriberId=:otm.UserId];
                  
                  entitySubsList.add(entSubsEx);
                  
              }  
         }
        
          if(entitySubsList.size()>0){
                  System.debug('Get deleteRec size-------->'+entitySubsList.size());
                  delete entitySubsList;
          }
        
    }
}