/*
Class/Trigger Name     : ProjectTriggerHandler_GE_OG
Purpose/Overview       : This class is used as a handler class for trigger on Project
Scrum Team             : Transformation - PROJECT MGMT
Requirement Number     : R-23831
Created Date           : 27/June/2017
Test Class Name        : ProjectTriggerHandlerTest_GE_OG
Code Coverage          : 93%
*/

public class ProjectTriggerHandler_GE_OG{
  
  
    public void beforeIsnertUpdateFunctionality(List<Project_ge_og__c>newList, Map<Id,Project_ge_og__c> oldMap){
        
        Set <Id> AccountIdSet =  new Set<Id>();
        for(Project_ge_og__c project : newList){
            AccountIdSet.add(project.project_account_ge_og__c);
        }
        Map<Id, Account> accountIndustryMap = new Map<Id, Account>([select id, Industry, GE_ES_Primary_Industry__c,Region_GEOG__c, ShippingCountry from Account where id in : AccountIdSet]);
         Id recordTypeId = [Select Id From RecordType Where DeveloperName = 'Joint_Pursuit_Project'].Id;
         
         system.debug('recortype id='+Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('O&G Project').getRecordTypeId());
         system.debug('recortypeeee id='+recordTypeId);
        
        for(Project_ge_og__c project : newList){
         //Added by vipin - R-23960
        if(project.project_Install_Country_ge_og__c!= null    ){
            project.project_region_ge_og__c = Util_GE_OG.regionPopulateByCountry(project.project_Install_Country_ge_og__c );
        }
        
         else if(accountIndustryMap !=null && accountIndustryMap.containskey(project.project_account_ge_og__c)  ){
                //project.project_region_ge_og__c = Util_GE_OG.regionPopulateByCountry(accountIndustryMap.containskey(project.project_account_ge_og__c).ShippingCountry);
                project.project_region_ge_og__c = (accountIndustryMap.containskey(project.project_account_ge_og__c) ? accountIndustryMap.get(project.project_account_ge_og__c).Region_GEOG__c : '');
         }
          /*  //Before Insert
            if(Trigger.isInsert && String.isBlank(project.project_Industry_ge_og__c) && accountIndustryMap.get(project.project_account_ge_og__c)!=null) {
               //null check before assigning value by Gourav
                if(accountIndustryMap.get(project.project_account_ge_og__c).GE_ES_Primary_Industry__c!=null && !String.isBlank(accountIndustryMap.get(project.project_account_ge_og__c).GE_ES_Primary_Industry__c) )
                    project.project_Industry_ge_og__c = accountIndustryMap.get(project.project_account_ge_og__c).GE_ES_Primary_Industry__c;
             } 
            //Before update
            if(trigger.isUpdate && project.project_Industry_ge_og__c== oldMap.get(project.id).project_Industry_ge_og__c && project.project_account_ge_og__c != oldMap.get(project.id).project_account_ge_og__c ) {
                if(accountIndustryMap.get(project.project_account_ge_og__c).GE_ES_Primary_Industry__c!=null && !String.isBlank(accountIndustryMap.get(project.project_account_ge_og__c).GE_ES_Primary_Industry__c) )
                    project.project_Industry_ge_og__c = accountIndustryMap.get(project.project_account_ge_og__c).GE_ES_Primary_Industry__c;
            }*/
        }
       
    }
    public void after_Insert_Functionality(List<Project_ge_og__c> newlstProj, map<id, Project_ge_og__c> newMapProj)
      {          
        // Tied to R-25898
        List<Project_ge_og__c> OGProjects = new List<Project_ge_og__c>();
          // Only process projects of type O&G Record type 
          for(Project_ge_og__c proj : newlstProj){
              if(proj.recordtypeid == Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('O&G Project').getRecordTypeId() || proj.recordtypeid == Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId()){ //Add your code here for fullstream project
                  OGProjects.add(proj);
              }
          }
          if(OGProjects.size()>0){
              Project_Helper_GE_OG.AddProjOwnerToProjectTeam(OGProjects, 'Insert', null);           
          }
          // end R-25898
       
       }
    
    public void after_Update_Functionality(List<Project_ge_og__c> newlstProj, map<id, Project_ge_og__c> newMapProj, List<Project_ge_og__c> oldlstProj, map<Id, Project_ge_og__c> oldMapProj){
        
        // Tied to R-25898
        List<Project_ge_og__c> OGProjects = new List<Project_ge_og__c>();
        // if of O&G record type and the owner has changed add it to the list of Projects to process
        for(Project_ge_og__c proj : newlstProj){
            if((proj.recordtypeid == Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('O&G Project').getRecordTypeId() || proj.recordtypeid == Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId())
               && proj.ownerId != oldMapProj.get(proj.Id).ownerId){
                   OGProjects.add(proj);
               }
        }
        if(OGProjects.size()>0){
            Project_Helper_GE_OG.AddProjOwnerToProjectTeam(OGProjects,'Update', oldMapProj);            
        }
        // end R-25898
        
    }
    
   }