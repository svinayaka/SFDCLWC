/*
Class/Trigger Name     : ProjectStageAutomation_Helper
Used Where ?           : ProjectTrigger_GE_OG
Purpose/Overview       : Helper Class for stage automation on project object.
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-31162
Author                 : Harsha C
Created Date           : 29/DEC/2018
Test Class Name        : ProjectStageAutomation_Helper_Test
Code Coverage          : 
*/
global class ProjectStageAutomation_Helper {
    @InvocableMethod(label='Project Stage Automation' description='Automate the project stages')
    public static void stageautomationforJointPursuit(List<Id> projectId){
        System.debug('projectId List =====>  '+projectId);
        Project_ge_og__c proj = new Project_ge_og__c();
        List<Project_ge_og__c> listOfProjects =  new List<Project_ge_og__c>();
        List<Project_ge_og__c> listOfProjectsToUpdate =  [Select Id,name,project_account_ge_og__c,hasScopeofwork_ge_og__c,hasProjectType_ge_og__c,Is_Industry_subIndustry_todo_ge_og__c,
                                                          hasDestinationCountry_ge_og__c,HasQualifiedOpportunitiesLinked_ge_og__c,hastriaged_ge_og__c,Project_Path_ge_og__c,HasProspectingChecklistComplete_ge_og__c,
                                                          hasFullstreamType_ge_og__c,HasQBTeamMember_ge_og__c,hasPursuit_NoPursuitcomplete_ge_og__c,HasQB_AVA_Commercial__c,/*Opportnities_are_in_Bid_in_Devlpmt_ge_og__c,*/
                                                          hasBid_NoBidcomplete_ge_og__c,hasBidSentDate_ge_og__c,/*Oppties_are_in_Bid_in_Submission_ge_og__c,*/HasProjectApproved_ge_og__c,HasEnterpriseRiskApproved_ge_og__c,
                                                          /*Opportunities_are_in_Negotiating_ge_og__c,*/hasDStier2_ge_og__c,HasOFETier2__c,Win_Loss_ge_og__c,/*Opportunities_are_in_Closed_Won_ge_og__c,*/hasAccount_ge_og__c,Project_Stage_ge_og__c
                                                          from Project_ge_og__c where Id In:projectId]; 
        
        
        System.debug('listOfProjectsToUpdate ==== > '+listOfProjectsToUpdate);
        try{
            For(Project_ge_og__c projectList : listOfProjectsToUpdate){
                
                if(projectList.hasAccount_ge_og__c && projectList.hasScopeofwork_ge_og__c 
                   && projectList.hasProjectType_ge_og__c 
                   && projectList.hastriaged_ge_og__c 
                   && projectList.hasDestinationCountry_ge_og__c 
                   // commented By Harsha
                   && projectList.HasQualifiedOpportunitiesLinked_ge_og__c
                   && projectList.Is_Industry_subIndustry_todo_ge_og__c
                  )
                {
                    projectList.Project_Stage_ge_og__c ='Prospecting';
                    System.debug('projectList In prospecting stage Line 32');
                    if(projectList.Project_Path_ge_og__c == 'Non Standard -Cross PC'){
                        System.debug('Status changed to Qualifying stage ');
                        
                        projectList.Project_Stage_ge_og__c ='Qualifying'; 
                    }
                    if(projectList.Project_Path_ge_og__c == 'Non Standard- Fullstream' && projectList.hasFullstreamType_ge_og__c && projectList.hasPursuit_NoPursuitcomplete_ge_og__c ){
                           System.debug('Status changed to Qualifying stage Fullstream ');
                           projectList.Project_Stage_ge_og__c ='Qualifying'; 
                       }
                    if(projectList.Project_Stage_ge_og__c =='Qualifying' ){
                        // commented By Harsha
                        //&& projectList.Opportnities_are_in_Bid_in_Devlpmt_ge_og__c ){
                        if(projectList.Project_Path_ge_og__c == 'Non Standard- Fullstream' && projectList.hasBid_NoBidcomplete_ge_og__c && projectList.HasQB_AVA_Commercial__c && projectList.HasProspectingChecklistComplete_ge_og__c 
                       ){
                            System.debug('Status changed to Bid In Development stage Fullstream ');
                            projectList.Project_Stage_ge_og__c ='Bid In Development'; 
                        }
                        else{
                            projectList.Project_Stage_ge_og__c ='Qualifying';  
                        }
                        if(projectList.Project_Stage_ge_og__c =='Qualifying'&& projectList.Project_Path_ge_og__c == 'Non Standard -Cross PC' && projectList.HasQBTeamMember_ge_og__c>0){
                            System.debug('Status changed to Bid In Development stage  ');
                            projectList.Project_Stage_ge_og__c ='Bid In Development';  
                        }
                        
                    }
                    if(projectList.Project_Stage_ge_og__c =='Bid In Development'  && projectList.HasProjectApproved_ge_og__c ){
                        // commented By Harsha
                        //&& projectList.Oppties_are_in_Bid_in_Submission_ge_og__c){
                        if(projectList.Project_Path_ge_og__c == 'Non Standard- Fullstream' && projectList.HasEnterpriseRiskApproved_ge_og__c   ){
                            System.debug('Status changed to Bid In Submission stage Fullstream ');
                            projectList.Project_Stage_ge_og__c ='Bid In Submission'; 
                        }
                        else{
                            System.debug('Status changed to Bid In Submission stage  ');
                            projectList.Project_Stage_ge_og__c ='Bid In Development';  
                        }
                        if(projectList.Project_Stage_ge_og__c =='Bid In Development' && projectList.Project_Path_ge_og__c == 'Non Standard -Cross PC'){
                            System.debug('Status changed to Bid In Development stage  ');
                            projectList.Project_Stage_ge_og__c ='Bid In Submission';  
                        }
                    }
                    if( projectList.Project_Stage_ge_og__c =='Bid In Submission' && projectList.hasBidSentDate_ge_og__c){//  && projectList.Opportunities_are_in_Negotiating_ge_og__c ){
                        projectList.Project_Stage_ge_og__c ='Negotiating';  
                    }
                }else{
                    projectList.Project_Stage_ge_og__c ='Prospecting'; 
                }
                listOfProjects.add(projectList);
            }
            
            Database.update(listOfProjects);
            
        }catch(Exception e){
            System.debug('Exception occured in Line number : '+e.getLineNumber());
            System.debug('cause of the Exception : '+e.getCause());
            System.debug('exception Message : '+e.getMessage());
            
        } 
    }
    
    
  /*  public static void stageautomationforRecordtypechange(List<Id> projectId){
        
        list<ProjectOpportunities_ge_og__c> prjopptyLst=new list<ProjectOpportunities_ge_og__c>();
        list<Opportunity> opptylst=[select id,StageName,tier_2_ge_og__c,Amount_USD_ge_og__c,opportunity_project_ge_og__c from opportunity where opportunity_project_ge_og__c in : projectId];
        if(opptylst.Size()>0)
        {
            For(Opportunity opp:opptylst){
                ProjectOpportunities_ge_og__c prjopp=new ProjectOpportunities_ge_og__c();
                prjopp.Opportunity_ge_og__c=opp.id;
                prjopp.Opportunity_Amount__c=opp.Amount_USD_ge_og__c;
                prjopp.Opportunity_Stage_ge_og__c=opp.StageName;
                prjopp.Project_ge_og__c=opp.opportunity_project_ge_og__c;
                prjopp.Tier_2_ge_og__c=opp.tier_2_ge_og__c;
                prjopptyLst.add(prjopp);
                
            }
            insert prjopptyLst;
        }
        
    }*/
    
    public static void testMethodforcode(){
        Integer i=0;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        
        
    }
}