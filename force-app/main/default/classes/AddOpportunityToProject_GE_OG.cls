/***********************************************************************************************************************
* Class Name:         AddOpportunityToProject_GE_OG
* Purpose:            Tied to R-25901 - send email to project team members when an opportunity is tied to the project
* Author:             Matt Koshay
* Date:               07/2017
* Last Modified By:   Sonali Rathore R-26690 to notify Project Owner, Opportunity Sales Primary, Opportunity Commercial Primary Resource 
* Last Modified Date: 28/Nov/2017
* Test Class:         OpportunityStagesAutomation_GE_OG_Test
* *************************************************************************************************************************/

global class AddOpportunityToProject_GE_OG {
    
    @future
    public static void emailProjectTeamofAddedOpportunities(List<ID> recordIds)
    {   
        Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'Opportunity_Project_Email_Notification' limit 1];
        
        boolean isEnabled = true;
        
        if(triggerToggle != null)
            isEnabled = triggerToggle.isEnabled__c;
        
        if(isEnabled){
            Set<Id> projId= new Set<Id>();
            system.debug('recordIds%%%%%%%%'+recordIds);
            List<opportunity> opportunities = new list<opportunity>();
            opportunities = [select Id,opportunity_project_ge_og__c,ownerId from opportunity where Id IN : recordIds];
            system.debug('opportunities &&&&&&&&'+opportunities );
            
            for(opportunity o : opportunities ){
                projId.add(o.opportunity_project_ge_og__c) ;
            }
            
            List<Project_ge_og__c> projOwner=[select id,name,ownerid from project_ge_og__c where id in :projId];
            
            //  Added by Harsha R-31015.
            
            Map<Id,Opportunity> optyMap = new Map<Id, Opportunity>();
            Map<Opportunity,List<Id>> opportunityMap = new Map<Opportunity,List<Id>>();
            for(Opportunity opp : opportunities ){
                for(Project_ge_og__c proj :projOwner){
                    if(opp.opportunity_project_ge_og__c == proj.Id){
                        List<Id> ownerIds = new List<Id>();
                        ownerIds.add(proj.OwnerId);
                        optyMap.put(opp.Id,opp);
                        opportunityMap.put(opp,ownerIds);
                    }     
                }
                
            }
            
            
            
            if(opportunities.size() > 0){
               /* System.debug('Found ' + opportunities .size() + ' records of O&G projects to process');
                
                Map<Project_ge_og__c, List<Id>> opptyTeams = new Map<Project_ge_og__c, List<Id>>();
                Map<Id, Project_ge_og__c> projectMap = new Map<Id, Project_ge_og__c>();
                
                for(Project_ge_og__c proj : projOwner){
                    List<Id> projownerId = new List<Id>();
                    projownerId.add(proj.OwnerId);
                    opptyTeams.put(proj,projownerId);
                    projectMap.put(proj.Id, proj);
                }*/
                
                List<OpportunityTeamMember> teamMembers = new List<OpportunityTeamMember >();
                teamMembers = [select Id,UserId,Opportunity.opportunity_project_ge_og__c,Opportunity.Id from OpportunityTeamMember where OpportunityId in : opportunities AND TeamMemberRole in ('Commercial Primary Resource','Sales - Primary')];
                
                System.debug('teamMembers'+teamMembers);
                
                // Add the project team member to the associated 
                
                for(OpportunityTeamMember otm : teamMembers){
                    opportunityMap.get(optyMap.get(otm.Opportunity.Id)).add(otm.UserId);
                    System.debug('otm '+otm );
                }
             /*Commented By Harsha   
              
                for(OpportunityTeamMember otm : teamMembers){
                    opptyTeams.get(projectMap.get(otm.Opportunity.opportunity_project_ge_og__c)).add(otm.UserId);
                    System.debug('otm '+otm );
                } 
			*/
                
               // System.debug('opptyTeams'+opptyTeams);
                
                EmailTemplate emTemplate = [select Id from emailtemplate where developerName = 'OpportunitiesAddedToProjects'];
                List<Messaging.SingleEmailMessage> projmails = new List<Messaging.SingleEmailMessage>();
                // for each project, send an email to the project team members
           /*************
            * *****commented By Harsha   
            
				for(Project_ge_og__c theProject : opptyTeams.keySet()){
                    for(Id UserId : opptyTeams.get(theProject)){
                        System.debug('Sending email to Project: ' + theProject.name + ' to User: ' + UserId);
                        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                        message.TargetObjectId = UserId;
                        message.WhatId = theProject.Id;
                        message.optOutPolicy = 'FILTER';
                        message.setSaveAsActivity(false);
                        message.TemplateId = emTemplate.Id;
                        /*Messaging.SingleEmailMessage[] messages = 
						new List<Messaging.SingleEmailMessage> {message};
						Messaging.SendEmailResult[] results = Messaging.sendEmail(messages); */
                    /*Commented By Harsha    
                     projmails.add(message); */
                        
                 
                 //Added By Harsha   
                    for(Opportunity theopty : opportunityMap.keySet()){
                    for(Id UserId : opportunityMap.get(theopty)){
                       // System.debug('Sending email to Project: ' + theopty.name + ' to User: ' + UserId);
                        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                        message.TargetObjectId = UserId;
                        message.WhatId = theopty.Id;
                        message.optOutPolicy = 'FILTER';
                        message.setSaveAsActivity(false);
                        message.TemplateId = emTemplate.Id;
                        /*Messaging.SingleEmailMessage[] messages = 
new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);*/
                        projmails.add(message); 
                        
                    }
                    
                }
                
                
                Messaging.SendEmailResult[] results = Messaging.sendEmail(projmails);
                if (results[0].success) {
                    System.debug('The email was sent successfully.');
                } else{
                    System.debug('The email failed to send: '
                                 + results[0].errors[0].message);
                } 
            }
            else
                System.debug('No project records of O&G type, exiting method');
        }
    }
}