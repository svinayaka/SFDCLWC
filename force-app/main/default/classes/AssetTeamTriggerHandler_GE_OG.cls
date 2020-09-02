/*
Class Name     : AssetTeamTriggerHandler_GE_OG
Purpose/Overview       : Whenever new team member has beed added to the team , the team member will get email notification
Scrum Team             : 
Created Date           : 20/11/2018
Modified Date          : 
Modified By            : Harsha C
Test Class Name        : 
Code Coverage          : 
*/
public class AssetTeamTriggerHandler_GE_OG {
    public void after_Insert_Functionality(List<BHGE_Asset_Team_ge_og__c > ListAssetTeamMember){
        set<Id> setAssetIds = new set<Id>();
        Set<BHGE_Asset_Team_ge_og__c> setAssetTeam = new Set<BHGE_Asset_Team_ge_og__c>();
        for(BHGE_Asset_Team_ge_og__c assetteam : ListAssetTeamMember){
            setAssetIds.add(assetteam.Asset__c);
            setAssetTeam.add(assetteam);
        } 
        if(setAssetIds.size()>0){   
            ListofUserforAssetEmailNotification(setAssetIds,setAssetTeam); }  
    }
    
    public void after_Update_Functionality(List<BHGE_Asset_Team_ge_og__c > ListAssetTeamMember,Map<ID,BHGE_Asset_Team_ge_og__c > oldAssetTeamMap){
        set<Id> setAssetIds = new set<Id>();
        Set<BHGE_Asset_Team_ge_og__c> setAssetTeam = new Set<BHGE_Asset_Team_ge_og__c>();
        for(BHGE_Asset_Team_ge_og__c assetTeamMember: ListAssetTeamMember){
            if(assetTeamMember.User__c != oldAssetTeamMap.get(assetTeamMember.Id).User__c){
                setAssetIds.add(assetTeamMember.Asset__c);
                setAssetTeam.add(assetTeamMember);
            }                            
        }
        if(setAssetIds.size()>0){   
            ListofUserforAssetEmailNotification(setAssetIds,setAssetTeam); }  
    }
    
    public void ListofUserforAssetEmailNotification(Set<Id> setAssetIds,Set<BHGE_Asset_Team_ge_og__c> assetTeamMember )
    {  
        AssetTeamHelper_GE_OG EmailNotification = new AssetTeamHelper_GE_OG();     
        List<Asset> ListAsset = new List<Asset>();
        
        for(Asset assetOwner : [Select Id,ownerId from Asset WHERE id IN: setAssetIds]){
            ListAsset.add(assetOwner);
        }  
        Map<Id, List<Id>> MapListOfUsers = new Map<Id, List<Id>>();    
        /* for(Asset newUser : ListAsset) {
if(MapListOfUsers.containsKey(newUser.Id)) {
MapListOfUsers.get(newUser.Id).add(newUser.OwnerId);
} else {
MapListOfUsers.put(newUser.Id, new List<Id>{newUser.OwnerId});
}
} */
        for(BHGE_Asset_Team_ge_og__c newUser : assetTeamMember) {
            if(MapListOfUsers.containsKey(newUser.Id)) {
                for(Asset asst : ListAsset){
                    if(asst.Id == newUser.Asset__c ){
                        MapListOfUsers.get(newUser.Id).add(asst.OwnerId);
                    }
                    
                }
                // MapListOfUsers.get(newUser.Id).add(newUser.Asset__r.OwnerId);
                //MapListOfUsers.get(newUser.Id).add(newUser.OwnerId);
            } else {
                for(Asset asst : ListAsset){
                    if(asst.Id == newUser.Asset__c ){
                        MapListOfUsers.put(newUser.Id, new List<Id>{asst.OwnerId});
                    }
                    // MapListOfUsers.put(newUser.Id, new List<Id>{newUser.Asset__r.OwnerId});
                    //MapListOfUsers.put(newUser.Id, new List<Id>{newUser.OwnerId});
                }
            }
            system.debug('$$$$$$$$MapListOfUsers$$$$$$$$'+MapListOfUsers+'%%%%%%%%'+ListAsset);   
            System.debug('%%%%%%%ListProject%%%%%%%'+ListAsset);           
            EmailNotification.EmailNotificationToAssetTeamMemebrs(MapListOfUsers,assetTeamMember);  
        }
    }
}