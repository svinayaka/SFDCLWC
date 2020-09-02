public class SD_Send_Email_InvocableMethod {
    
	@InvocableMethod(label='Send an email for Design&Plan Job' description='sends an email')
    public static void sendEmailForDesignPlanJob(List<Id> lstId){
		Map<Id,List<Id>> MapListOfUsers = new Map<Id,List<Id>>();
        MapListOfUsers = getListOfJobTeamMember(lstId);
        MapListOfUsers = getCordinatorAndManagerId(lstId,MapListOfUsers);
        EmailNotificationToJobTeamMemebrs(MapListOfUsers,'SD_EmailTemplateForDesignPlan_VF','servicedeliveryadmins@ge.com');
    }
    
    public static Map<Id,List<Id>> getCordinatorAndManagerId(List<Id> lstId,Map<Id,List<Id>> MapListOfUsers){
        List<FX5__Job__c> JobList = new List<FX5__Job__c>();
        JobList = [Select OwnerId,id,SD_Account_Manager__c,SD_Job_Coordinator__c,SD_Account_Manager__r.Id,SD_Job_Coordinator__r.id from FX5__Job__c where Id IN :lstId]; 
        for(FX5__Job__c newUser : JobList) {
        	if(MapListOfUsers.containsKey(newUser.ID)) {
				if(newUser.SD_Account_Manager__c != null && !MapListOfUsers.get(newUser.ID).contains(newUser.SD_Account_Manager__r.ID))
            		MapListOfUsers.get(newUser.ID).add(newUser.SD_Account_Manager__r.ID);
				if(newUser.SD_Job_Coordinator__c != null && !MapListOfUsers.get(newUser.ID).contains(newUser.SD_Job_Coordinator__r.ID))
            		MapListOfUsers.get(newUser.ID).add(newUser.SD_Job_Coordinator__r.ID);
            }else{
                if(newUser.SD_Account_Manager__c != null){
                    if(MapListOfUsers.containsKey(newUser.ID) && !MapListOfUsers.get(newUser.ID).contains(newUser.SD_Account_Manager__r.ID)){
                    	MapListOfUsers.get(newUser.ID).add(newUser.SD_Account_Manager__r.ID);
                    }else{
                        MapListOfUsers.put(newUser.ID, new List<Id>{newUser.SD_Account_Manager__r.ID});
                    }
                }
				if(newUser.SD_Job_Coordinator__c != null){
					if(MapListOfUsers.containsKey(newUser.ID) && !MapListOfUsers.get(newUser.ID).contains(newUser.SD_Job_Coordinator__r.ID)){
						MapListOfUsers.get(newUser.ID).add(newUser.SD_Job_Coordinator__r.ID);
					}else{
						MapListOfUsers.put(newUser.ID, new List<Id>{newUser.SD_Job_Coordinator__r.ID});
					}
				}		
            }
        }
        return MapListOfUsers;
    }
    
    public static void EmailNotificationToJobTeamMemebrs(Map<Id, List<Id>> MapListOfUsers,String EmailTemplateName,String FromEmailAddress){  
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = :EmailTemplateName];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = :FromEmailAddress];
        for(Id ObjectRecordId : MapListOfUsers.keySet()){
            if(!MapListOfUsers.get(ObjectRecordId).isEmpty()){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.TargetObjectId = MapListOfUsers.get(ObjectRecordId)[0];
                message.WhatId = ObjectRecordId;
                message.optOutPolicy = 'FILTER';
                message.setTreatTargetObjectAsRecipient(false);
                message.toaddresses=MapListOfUsers.get(ObjectRecordId);
                message.setSaveAsActivity(false);
                message.TemplateId = emailTemp.Id;
                if ( owea.size() > 0 ) {
                	message.setOrgWideEmailAddressId(owea.get(0).Id);
                }
                mails.add(message);
            }   
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        if(!results.isEmpty()){
            if (results[0].success) {
                    System.debug('The email was sent successfully.');
                } else {
                    System.debug('The email failed to send: '
                                 + results[0].errors[0].message);
                }
        }else{
            System.debug('The email failed to send');
        }
                
    }
    
    public static Map<Id, List<Id>> getListOfJobTeamMember(List<Id> lstId){        
        List<SD_JobTeam__c> JobTeamList = new List<SD_JobTeam__c>();
        JobTeamList = [Select OwnerId,id,SD_Job__r.ID,SD_JobTeam_Member__r.ID,SD_JobTeam_Member__c from SD_JobTeam__c where SD_Job__c IN :lstId];
        Map<Id, List<Id>> MapListOfUsers = new Map<Id, List<Id>>();    
        for(SD_JobTeam__c newUser : JobTeamList) {
        	if(MapListOfUsers.containsKey(newUser.SD_Job__r.ID)) {
                  MapListOfUsers.get(newUser.SD_Job__r.ID).add(newUser.SD_JobTeam_Member__r.ID);
            }else{
                if(newUser.SD_JobTeam_Member__c != null)
                        MapListOfUsers.put(newUser.SD_Job__r.Id, new List<Id>{newUser.SD_JobTeam_Member__r.ID});
            }
        } 
        return MapListOfUsers; 
    }
}