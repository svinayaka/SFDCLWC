/*
Class/Trigger Name  :   O_AssetHelper_GE_OG 
Purpose/Overview    :   Used to assign owner of the Asset as Sales Primary in BHGE Asset Team
Scrum Team          :   OPPTY MGMT
Requirement Number  : 
Author              :   Rupal Seth
Created Date        :   18/JUN/2018
Test Class Name     :   
Code Coverage       : 
*/
public class O_AssetHelper_GE_OG {
    public static void AddAssetOwnerToAssetTeam(List<Asset> newlstAsset, String action, Map<ID,Asset> oldAssetMap){
        
        ID recordTypeIdOG = schema.sObjectType.Asset.getRecordTypeInfosByName().get('Deal Machine Asset').getRecordTypeID();
        
        List<BHGE_Asset_Team_ge_og__c> lstAssetTeamMemberToInsert = new List<BHGE_Asset_Team_ge_og__c>();
        List<BHGE_Asset_Team_ge_og__c> lstAssetTeamMemberToUpdate = new List<BHGE_Asset_Team_ge_og__c>();
        Map<ID,Asset> newAssetMap = new  Map<ID,Asset>();
        Map<ID,Asset> existingAssetMap = new  Map<ID,Asset>();
        
        if(action == 'Insert'){
            for(Asset ast : newlstAsset)
                newAssetMap.put(ast.Id, ast);
        }
        else if(action == 'Update'){
            for(Asset ast : newlstAsset)
                existingAssetMap.put(ast.Id, ast);
        }
        
        
        if(newAssetMap != null && newAssetMap.size() > 0){            
            for(Asset ast:newAssetMap.values()){
                BHGE_Asset_Team_ge_og__c objastTeamMem = new BHGE_Asset_Team_ge_og__c();
                objastTeamMem.Asset__c= ast.Id;
                objastTeamMem.User__c= ast.OwnerId;
                objastTeamMem.Team_Role_ge_og__c= Label.Sales_Primary;
                lstAssetTeamMemberToInsert.add(objastTeamMem);                
            }
        }
        
        if(lstAssetTeamMemberToInsert.size() > 0){  
            try{
            insert lstAssetTeamMemberToInsert;  
        }
            catch(Exception e){
                system.debug('Could not insert team member'+e.getCause());
                throw e;
            }
        }
        
        lstAssetTeamMemberToInsert = new List<BHGE_Asset_Team_ge_og__c>();
        if(existingAssetMap != null && existingAssetMap.size() > 0){            
            List<BHGE_Asset_Team_ge_og__c> existingastTeamMember = [Select Id,Asset__c,Team_Role_ge_og__c,User__r.IsActive,User__c from BHGE_Asset_Team_ge_og__c where Asset__c IN:existingAssetMap.keyset()];
            Map<Id,BHGE_Asset_Team_ge_og__c> MapOfastectTeamMember = new Map<Id,BHGE_Asset_Team_ge_og__c>();
            for(BHGE_Asset_Team_ge_og__c astTeam : existingastTeamMember){
                MapOfastectTeamMember.put(astTeam.Asset__c,astTeam);
            }
            
            List<BHGE_Asset_Team_ge_og__c> existingastTeamMemberToDelete = new List<BHGE_Asset_Team_ge_og__c>();         
            List<BHGE_Asset_Team_ge_og__c> existingastTeamMemberRoleToUpdate = new List<BHGE_Asset_Team_ge_og__c>();
            
            //Check if the owner is already present in the astect Team
            for(BHGE_Asset_Team_ge_og__c btm:existingastTeamMember){                
                if(oldAssetMap.get(btm.Asset__c).OwnerId == btm.User__c && btm.Team_Role_ge_og__c == Label.Sales_Primary && btm.User__r.isActive && oldAssetMap.get(btm.Asset__c).Id == btm.Asset__c){
                    btm.Team_Role_ge_og__c= Label.Default_Team_Role_Sales ;
                    existingastTeamMemberRoleToUpdate.add(btm);
                }
                if(existingAssetMap.get(btm.Asset__c).OwnerId == btm.User__c && btm.User__r.isActive && oldAssetMap.get(btm.Asset__c).Id == btm.Asset__c){
                    btm.Team_Role_ge_og__c= Label.Sales_Primary; 
                    lstAssetTeamMemberToUpdate.add(btm);
                }
                else if(btm.User__r.isActive==false && btm.Team_Role_ge_og__c == Label.Sales_Primary &&  oldAssetMap.get(btm.Asset__c).Id == btm.Asset__c){
                    btm.Team_Role_ge_og__c = Label.Default_Team_Role_Sales ;
                    existingastTeamMemberToDelete.add(btm);
                }  
            }
            
            if(existingastTeamMemberRoleToUpdate.size() > 0 && !Test.isRunningTest()){
                try{
                update existingastTeamMemberRoleToUpdate;
                }
                catch(Exception e1){
                    system.debug('Could not update team member role'+e1.getCause());
                    throw e1;
                }
            }
            if(lstAssetTeamMemberToUpdate.size()>0){
                try{
                update lstAssetTeamMemberToUpdate;
                }
                catch(Exception e2){
                    system.debug('Could not update team member role'+e2.getCause());
                    throw e2;
                }
            }
            
            if(existingastTeamMemberToDelete.size() > 0 && !Test.isRunningTest()){
                try{
                    delete existingastTeamMemberToDelete;
                }
                catch(Exception e3){
                    system.debug('Could not delete team member'+e3.getCause());
                    throw e3;
                }
            } 
            set<Id> setastTeamMemberToUpdate =new set<Id>();
            for(Asset ast:existingAssetMap.values()){ 
                if(lstAssetTeamMemberToUpdate.size()==0){                   
                    BHGE_Asset_Team_ge_og__c objastTeamMem = new BHGE_Asset_Team_ge_og__c();
                    objastTeamMem.Asset__c = ast.Id;
                    objastTeamMem.User__c = ast.OwnerId;
                    objastTeamMem.Team_Role_ge_og__c = Label.Sales_Primary;
                    lstAssetTeamMemberToInsert.add(objastTeamMem);
                }                   
            }
            
            if(lstAssetTeamMemberToInsert.size() > 0){  
                try{
                insert lstAssetTeamMemberToInsert;  
                }
                catch(Exception e4){
                    system.debug('Could not insert team member'+e4.getCause());
                    throw e4;
                }
            }
            
        }
    }

}