/***********************************************************************************************************************

Class/Trigger Name     : AddOpportunityToAsset_GE_OG
Used Where ?           : OpportunityTrigger_GE_OG
Purpose/Overview       :  Whenever new Asset has beed added to the Opportunity ,

Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-30035
Author                 : Harsha C
Created Date           : 15/NOV/2018
Test Class Name        : AddOpportunityToAsset_Helper
Code Coverage          : 85%

* *************************************************************************************************************************/

public class AddOpportunityToAsset_GE_OG {
    public void after_Insert_Functionality(List<Opportunity > OpportunityList){
        System.debug('after_Insert_Functionality + AddOpportunityToAsset_GE_OG');
        set<Id> opptyIdSet = new set<Id>();
        List<String> opptyEmailSet = new List<String>();
        
        Map<Id,List<Id>> optyandUserMap = new Map<Id,List<Id>>();
        for(Opportunity opp : OpportunityList){
            if(opp.Opportunity_Asset_ge_og__c != null)
            {
                opptyIdSet.add(opp.id);
                opptyEmailSet.add(opp.ownerId);
                optyandUserMap.put(opp.Id,opptyEmailSet);
            }
        } 
        if(!optyandUserMap.isEmpty()){
            
            AddOpportunityToAsset_GE_OG.getoptyTeamMember(opptyIdSet, opptyEmailSet,optyandUserMap);   
        }
        
    }
    
    
    public void after_Update_Functionality(List<Opportunity > OpportunityList ,Map<ID,Opportunity > oldopptyTeamMap, Map<ID,Opportunity > newOpptyMap ){
        System.debug(LoggingLevel.Info,'after_Update_Functionality + AddOpportunityToAsset_GE_OG');
        set<Id> opptyIdSet = new set<Id>();
        List<String> opptyEmailList = new List<String>();
        Map<Id,List<Id>> optyandUserMap = new Map<Id,List<Id>>();
        for(Opportunity opp : OpportunityList){ 
            if(opp.Opportunity_Asset_ge_og__c != null && opp.Opportunity_Asset_ge_og__c != oldopptyTeamMap.get(opp.Id).Opportunity_Asset_ge_og__c){
                {
                    opptyIdSet.add(opp.id);
                    opptyEmailList.add(opp.ownerId);
                    if(opp.Opportunity_Asset_ge_og__r.ownerId != null && opp.Opportunity_Asset_ge_og__r.ownerId != ''){
                        
                        opptyEmailList.add(newOpptyMap.get(opp.Id).Opportunity_Asset_ge_og__r.ownerId); 
                        //opptyEmailList.add(opp.Opportunity_Asset_ge_og__r.ownerId);
                        System.debug(LoggingLevel.Info,'newOpptyMap.get(opp.Id).Opportunity_Asset_ge_og__r.ownerId>>>>>'+newOpptyMap.get(opp.Id).Opportunity_Asset_ge_og__r.ownerId);
                        
                    }
                    
                    optyandUserMap.put(opp.Id,opptyEmailList);
                    System.debug(LoggingLevel.Info,'optyandUserMap >>>>'+optyandUserMap);
                }
            } 
            List<Opportunity> opty = [Select Id,Opportunity_Asset_ge_og__r.ownerId from Opportunity where Id IN : opptyIdSet and Opportunity_Asset_ge_og__r.ownerId != null];
            
            if(opty != null){
                for(Opportunity op :opty){
                    if(optyandUserMap.containsKey(op.Id)){
                        List<Id> opetylist = new List<Id>();
                        opetylist.addAll(optyandUserMap.get(op.Id));
                        opetylist.add(op.Opportunity_Asset_ge_og__r.ownerId);             
                        optyandUserMap.put(opp.Id,opetylist);
                    }
                }}
            if(!optyandUserMap.isEmpty()){
                
                AddOpportunityToAsset_GE_OG.getoptyTeamMember(opptyIdSet, opptyEmailList,optyandUserMap);   
            }
        }
    }
    public static void getoptyTeamMember(Set<Id> opptyIdSet ,List<String > opptyEmailSet, Map<Id,List<Id>> optyandUserMap ){
        System.debug(LoggingLevel.Info,'optyandUserMap >>>>'+optyandUserMap);
        System.debug(LoggingLevel.Info,'opptyIdSet >>>>'+opptyIdSet);
        AddOpportunityToAsset_Helper addopptytoasset = new AddOpportunityToAsset_Helper();
        List <OpportunityTeamMember> optyTeamMemeber = [Select Id,Name,OpportunityId,UserId,TeamMemberRole from OpportunityTeamMember where OpportunityId IN : opptyIdSet and TeamMemberRole = 'Commercial Primary Resource'];
        for( OpportunityTeamMember optm : optyTeamMemeber){
            if(optyandUserMap.containsKey(optm.OpportunityId)){
                List<Id> opptyList = new List<Id>();
                opptyList.addAll(optyandUserMap.get(optm.OpportunityId));
                opptyList.add(optm.UserId);
                optyandUserMap.put(optm.OpportunityId,opptyList);
                System.debug(LoggingLevel.Info,'optyandUserMap >>>>'+optyandUserMap);
            }
            
        }
        addopptytoasset.EmailNotificationonOptyAndAsset(optyandUserMap);
    } 
}