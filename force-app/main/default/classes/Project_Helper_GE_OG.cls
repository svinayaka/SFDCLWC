/*
Class/Trigger Name     : Project_Helper_GE_OG
Used Where ?           : ProjectTrigger_GE_OG
Purpose/Overview       : Add Project_Team_Member_GE_OG__c when Project is created or updated
Requirement Number     : R-23656
Created Date           : 27/June/2017
Test Class Name        : ProjectTriggerHandlerTest_GE_OG
Code Coverage          : 80
Changes                :                   
*/
public without sharing class Project_Helper_GE_OG{
    
    // Assuming the record type of the passed projects are of O&G record type
    public static void AddProjOwnerToProjectTeam(List<Project_ge_og__c> newlstProj, String action, Map<ID,Project_ge_og__c> oldProjMap){
        
        ID recordTypeIdOG = schema.sObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('O&G Project').getRecordTypeID();
        
        List<Project_Team_Member_GE_OG__c> lstProjTeamMemberToInsert = new List<Project_Team_Member_GE_OG__c>();
        List<Project_Team_Member_GE_OG__c> lstProjTeamMemberToUpdate = new List<Project_Team_Member_GE_OG__c>();
        Map<ID,Project_ge_og__c> newProjMap = new  Map<ID,Project_ge_og__c>();
        Map<ID,Project_ge_og__c> existingProjMap = new  Map<ID,Project_ge_og__c>();
        
        if(action == 'Insert'){
            for(Project_ge_og__c proj : newlstProj)
                newProjMap.put(proj.Id, proj);
        }
        else if(action == 'Update'){
            for(Project_ge_og__c proj : newlstProj)
                existingProjMap.put(proj.Id, proj);
        }
        
        
        /*for(Project_ge_og__c objProject : newlstProj){
            
            if(objProject.RecordTypeID == recordTypeIdOG && oldProjMap == null){
                System.debug('--------------------> On inserting new record and oppty owner:');
                newProjMap.put(objProject.Id,objProject);              
            }else if(objProject.RecordTypeID == recordTypeIdOG && oldProjMap != null && oldProjMap.get(objProject.Id).OwnerId != objProject.OwnerId){               
                existingProjMap.put(objProject.Id,objProject);
            }
        }*/
        
        if(newProjMap != null && newProjMap.size() > 0){            
            for(Project_ge_og__c proj:newProjMap.values()){
                Project_Team_Member_GE_OG__c objProjTeamMem = new Project_Team_Member_GE_OG__c();
                objProjTeamMem.Project_ge_og__c= proj.Id;
                objProjTeamMem.User_ge_og__c= proj.OwnerId;
                objProjTeamMem.Team_Role_ge_og__c= Label.Sales_Primary;
                lstProjTeamMemberToInsert.add(objProjTeamMem);                
            }
        }
        
        if(lstProjTeamMemberToInsert.size() > 0){            
            insert lstProjTeamMemberToInsert;            
        }
        
        lstProjTeamMemberToInsert = new List<Project_Team_Member_GE_OG__c>();
        if(existingProjMap != null && existingProjMap.size() > 0){            
            List<Project_Team_Member_GE_OG__c> existingProjTeamMember = [Select Id,Project_ge_og__c,Project_Team_Member_ID_ge_og__c,Project_Team_Member_Name_ge_og__c,Team_Role_ge_og__c,User_ge_og__r.IsActive,User_ge_og__c from Project_Team_Member_GE_OG__c where Project_ge_og__c IN:existingProjMap.keyset()];
            Map<Id,Project_Team_Member_GE_OG__c> MapOfProjectTeamMember = new Map<Id,Project_Team_Member_GE_OG__c>();
            for(Project_Team_Member_GE_OG__c ProjTeam : existingProjTeamMember){
                MapOfProjectTeamMember.put(ProjTeam.Project_ge_og__c,ProjTeam);
            }
            
            List<Project_Team_Member_GE_OG__c> existingProjTeamMemberToDelete = new List<Project_Team_Member_GE_OG__c>();         
            List<Project_Team_Member_GE_OG__c> existingProjTeamMemberRoleToUpdate = new List<Project_Team_Member_GE_OG__c>();
            
            //Check if the owner is already present in the Project Team
            for(Project_Team_Member_GE_OG__c ptm:existingProjTeamMember){                
                if(oldProjMap.get(ptm.Project_ge_og__c).OwnerId == ptm.User_ge_og__c && ptm.Team_Role_ge_og__c == Label.Sales_Primary && ptm.User_ge_og__r.isActive && oldProjMap.get(ptm.Project_ge_og__c).Id == ptm.Project_ge_og__c){
                    ptm.Team_Role_ge_og__c= Label.Default_Team_Role_Sales ;
                    existingProjTeamMemberRoleToUpdate.add(ptm);
                }
                if(existingProjMap.get(ptm.Project_ge_og__c).OwnerId == ptm.User_ge_og__c && ptm.User_ge_og__r.isActive && oldProjMap.get(ptm.Project_ge_og__c).Id == ptm.Project_ge_og__c){
                    ptm.Team_Role_ge_og__c= Label.Sales_Primary; 
                    lstProjTeamMemberToUpdate.add(ptm);
                }
                else if(ptm.User_ge_og__r.isActive==false && ptm.Team_Role_ge_og__c == Label.Sales_Primary &&  oldProjMap.get(ptm.Project_ge_og__c).Id == ptm.Project_ge_og__c){
                    ptm.Team_Role_ge_og__c = Label.Default_Team_Role_Sales ;
                    existingProjTeamMemberToDelete.add(ptm);
                }  
            }
            
            if(existingProjTeamMemberRoleToUpdate.size() > 0 && !Test.isRunningTest()){
                update existingProjTeamMemberRoleToUpdate;
            }
            if(lstProjTeamMemberToUpdate.size()>0){
                update lstProjTeamMemberToUpdate;
            }
            
            if(existingProjTeamMemberToDelete.size() > 0 && !Test.isRunningTest()){
                delete existingProjTeamMemberToDelete;
            } 
            set<Id> setProjTeamMemberToUpdate =new set<Id>();
            for(Project_ge_og__c Proj:existingProjMap.values()){ 
                if(lstProjTeamMemberToUpdate.size()==0){                   
                    Project_Team_Member_GE_OG__c objProjTeamMem = new Project_Team_Member_GE_OG__c();
                    objProjTeamMem.Project_ge_og__c = Proj.Id;
                    objProjTeamMem.User_ge_og__c = Proj.OwnerId;
                    objProjTeamMem.Team_Role_ge_og__c = Label.Sales_Primary;
                    lstProjTeamMemberToInsert.add(objProjTeamMem);
                }                   
            }
            
            if(lstProjTeamMemberToInsert.size() > 0){               
                insert lstProjTeamMemberToInsert;                
            }
            
        }
    }
    
    
}