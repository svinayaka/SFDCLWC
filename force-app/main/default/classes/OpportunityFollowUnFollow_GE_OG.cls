/*
Class/Trigger Name     : OpportunityFollowUnFollow_GE_OG
Purpose/Overview       : To Follow Or UnFollow an Opportunity from SKUID
Scrum Team             : Oppty MGMT - Transformation
Requirement Number     : 
Author                 : Mohit Maheshwari
Created Date           : 09/Feb/2016
Test Class Name        : 
Code Coverage          : 
*/
global without sharing class OpportunityFollowUnFollow_GE_OG{

    @InvocableMethod(label='Follow_Unfollow Opportunity' description='')
    public static void updateOpportunityAsFollow_UnFollow(List<Id> opptyId){
        
        
        List<OpportunityTeamMember> lstOTM = new List<OpportunityTeamMember>();
        List<OpportunityTeamMember> deleteOTM = new List<OpportunityTeamMember>();
        List<OpportunityTeamMember> followOTM = new List<OpportunityTeamMember>();
        
        Set<ID> setUserID = new Set<ID>();  
         
        ID loginUserID = UserInfo.getUserID();
        
        system.debug('=== \n\n loginUserID '+ loginUserID + ' \n\n ====');
        
        system.debug('=== \n\n  opptyId '+ opptyId + ' \n\n ====');
         
        lstOTM = [Select ID, Name, TeamMemberRole, OpportunityAccessLevel, UserID from OpportunityTeamMember where opportunityID in : opptyId and UserID =: loginUserID];
        
        for(OpportunityTeamMember objOTM : lstOTM){
            setUserID.add(objOTM.UserID);
            if(objOTM.UserID==loginUserID && objOTM.TeamMemberRole == 'Following'){
                deleteOTM.add(objOTM);  
            }
            else if(objOTM.UserID==loginUserID && objOTM.TeamMemberRole != 'Following'){
                objOTM.addError('User already a Team Member of Deal Team with ' + objOTM.TeamMemberRole + '.');
            }
        }
        
        if(deleteOTM.size()>0)
            delete deleteOTM;
        
        if(!setUserID.contains(loginUserID)){
            for(ID objOppID : opptyId){
                OpportunityTeamMember objOTM = new OpportunityTeamMember();
                objOTM.opportunityID = opptyId[0];
                objOTM.UserID = loginUserID;
                objOTM.TeamMemberRole = 'Following';
                followOTM.add(objOTM);
            }
            if(followOTM.size()>0){
                insert followOTM;
            }   
        }
        
    } 
      
}