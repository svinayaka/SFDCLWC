public class InvitationHistoryController{
@InvocableMethod(label='InvitationHistoryController' description='InvitationHistoryController')

public static void parseInvitationHistory(List<String> activityInput) {
    Id taskId = Id.valueOf(activityInput[0]);
    List<SObject> lstCMRTask = new List<SObject>();
    Task objectTask = [SELECT Id, subject,Invitation_Status__c, WhoId,WhatId
                            FROM Task
                            WHERE id=: taskId 
                            LIMIT 1];
    String strSubject = objectTask.subject;
    Id contactId = objectTask.WhoId;
    
    List<String> subjString = strSubject.split('\\^');
    if(!subjString.isEmpty() && subjString[0].contains('INVHISTFRMMARKT')){
        String strCamPaign = subjString[1];
        Id campaignId = Id.valueOf(strCamPaign);
        String strStatus = subjString[3];
        
        objectTask.Invitation_Status__c = strStatus;
        objectTask.WhatId = campaignId;
        Integer subSize = subjString.size()-1;
        String strDate = subjString[subSize];
        objectTask.Invitation_Status_Date__c = Datetime.valueOf(strDate);
        CampaignMember objCmr = [SELECT id,FirstName,LastName,Invitation_Status__c
                                FROM CampaignMember 
                                WHERE CampaignId =: campaignId AND contactId=: contactId 
                                LIMIT 1];
        if(objCmr != null){
            objectTask.Campaign_Lead_ID_ge_og__c = objCmr.Id;
            objCmr.Invitation_Status__c = strStatus;
            lstCMRTask.add(objCmr);
        }
        objectTask.Is_Created_from_Marketo__c = true;
        lstCMRTask.add(objectTask);
        try{
            if(!lstCMRTask.isEmpty()){
                update lstCMRTask;
            }
        }
        catch(Exception e){
            system.debug('Error while updating task');
        }
    }
    else{
        return;
    }
}
}