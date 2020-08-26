/*Trigger Name : GEOGAssignPermissionSet
Purpose/Overview : Assign the Permission set to User on basis of User field :GE_OG_Functional_Profile__c
Author: Seema Rani
Created Date: 20th December 2013
Test Class Name :GEOGAssignPermissionSet_Test
*/
 
trigger GEOGAssignPermissionSet on User (After Insert, After Update)
{
    Set<String> FProf = new Set<String>();
    Map<Id,User> mapUser = new Map<id,User>();
    Map<String,ID> mapPemissionSetNameToID = new Map<String,ID>();
    
    Map<Id, PermissionSetAssignment> AddPermissionSet  = new Map<Id,PermissionSetAssignment>();
    Map<Id, User> mapUsersTodeleteOldPermissionSet = new Map<Id, User>();
    
    
    for (User usr : trigger.new){
        if( usr.GE_OG_functional_Profile__c != null && trigger.isInsert ){
            FProf.add(usr.GE_OG_functional_Profile__c);
            mapUser.put(Usr.id,Usr);
        }
        
        if(trigger.isupdate && usr.GE_OG_functional_Profile__c !=  trigger.oldmap.get(usr.Id).GE_OG_functional_Profile__c){
            
            if(usr.GE_OG_functional_Profile__c != null){
                FProf.add(usr.GE_OG_functional_Profile__c);
                mapUser.put(Usr.id,Usr);
            }
            
            
            if(trigger.oldmap.get(usr.Id).GE_OG_functional_Profile__c != null){
               FProf.add(trigger.oldmap.get(usr.Id).GE_OG_functional_Profile__c);
               mapUsersTodeleteOldPermissionSet.put(Usr.id,trigger.oldmap.get(usr.Id) );
               
                          }
        }
        
    }

    List<GE_Profile__C> Profs  = new List<GE_Profile__C>();
    if(FProf.size() > 0 )
        Profs  = new List<GE_Profile__c>([SELECT Functional_Profile_Name__c, Permission_Set_Name__c 
                                                              FROM GE_Profile__c where Functional_Profile_Name__c IN :FProf]);

   
    Map<String,String> MapProfileToPermissionSetName = new Map<String,String>();
    
    for(GE_Profile__c cs:Profs){
        MapProfileToPermissionSetName.put(cs.Functional_Profile_Name__c,cs.Permission_Set_Name__c);
    }
    
    List<PermissionSet> Plist = new List<PermissionSet>();
    
    if(MapProfileToPermissionSetName.size() > 0 ){
         Plist = new List<PermissionSet>([SELECT id,name FROM PermissionSet WHERE name IN :MapProfileToPermissionSetName.values()]);
    }
    
    
    
    for(PermissionSet ps:Plist){
        mapPemissionSetNameToID.put(ps.name,ps.id);
    }
    
    
    
    if(mapUsersTodeleteOldPermissionSet != null && trigger.isupdate ){
        
        Map<Id,Id> MapUserIdtoDeletePermissionSetId = new Map<Id,Id>();
        
        
        for( User user :  mapUsersTodeleteOldPermissionSet.values() ){
    
            if(trigger.Oldmap.get(user.Id).GE_OG_functional_Profile__c != null && 
               MapProfileToPermissionSetName.get(trigger.Oldmap.get(user.Id).GE_OG_functional_Profile__c) != null ){
            
               MapUserIdtoDeletePermissionSetId.put(user.Id, mapPemissionSetNameToID.get(MapProfileToPermissionSetName.get(trigger.Oldmap.get(user.Id).GE_OG_functional_Profile__c)) );
            
            }
    
        }
    
        List<PermissionSetAssignment> lstOldAssignments = [Select AssigneeId , PermissionSetId,PermissionSet.Name from PermissionSetAssignment where AssigneeId IN :mapUsersTodeleteOldPermissionSet.keyset() Order by AssigneeId ];
       
        Map<Id, Map<Id,Id>> mapUserIdToOldPermissionSetAssignmentRecords = new Map<Id, Map<Id,Id>> ();
        
        for( PermissionSetAssignment PSA    : lstOldAssignments){
        
            if(mapUserIdToOldPermissionSetAssignmentRecords.get(PSA.AssigneeId) != null ){
               Map<Id,Id> mapPermissionSetAssignments = mapUserIdToOldPermissionSetAssignmentRecords.get(PSA.AssigneeId);
               mapPermissionSetAssignments.put(PSA.PermissionSetId,PSA.Id);
               mapUserIdToOldPermissionSetAssignmentRecords.put(PSA.AssigneeId,mapPermissionSetAssignments);
            
           }else{
            
                Map<Id,Id> mapPermissionSetAssignments = new Map<Id,Id>();
                mapPermissionSetAssignments.put(PSA.PermissionSetId,PSA.Id);
                mapUserIdToOldPermissionSetAssignmentRecords.put(PSA.AssigneeId,mapPermissionSetAssignments);
            }
            
        }
        
        List<PermissionSetAssignment> deletePermissionSet = new List<PermissionSetAssignment>();
        
        for( Id UId   :  MapUserIdtoDeletePermissionSetId.keyset() ){
        
            if( mapUserIdToOldPermissionSetAssignmentRecords.get(Uid) != null ) {
                Map<Id,Id> mapPP =  mapUserIdToOldPermissionSetAssignmentRecords.get(Uid) ;
                
                if(mapPP.get(MapUserIdtoDeletePermissionSetId.get(UId)) != null ){
                   PermissionSetAssignment PSAOld = new PermissionSetAssignment(Id= (mapPP.get(MapUserIdtoDeletePermissionSetId.get(UId))));
                   deletePermissionSet.add(PSAOld);
                }
            }
            
        }
        
        
        if(deletePermissionSet.size() > 0 ){
            delete deletePermissionSet;
        }
        

    }
    
    for( User UserInstant   : mapUser.values() ){
          if( MapProfileToPermissionSetName.get(UserInstant.GE_OG_functional_Profile__c) != null 
             && mapPemissionSetNameToID.get(MapProfileToPermissionSetName.get(UserInstant.GE_OG_functional_Profile__c) ) != null  ){
          PermissionSetAssignment passign = new  PermissionSetAssignment();
          passign.AssigneeId= UserInstant.id;
          passign.PermissionSetId =  mapPemissionSetNameToID.get(MapProfileToPermissionSetName.get(UserInstant.GE_OG_functional_Profile__c));
          AddPermissionSet.put(UserInstant.id, Passign);
          }
    }
    
    if(AddPermissionSet.size() > 0 ){
        insert AddPermissionSet.values();
    }
                                                
}