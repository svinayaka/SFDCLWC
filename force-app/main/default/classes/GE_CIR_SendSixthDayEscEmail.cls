global class GE_CIR_SendSixthDayEscEmail implements Database.Batchable<sObject> {
public String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
Public String OpenStatus = 'Open';
Public String EccrOrigin= 'OG_ECCR';
Public String TMSOrigin = 'TMS NC System';
Public String Escalated= 'Escalated';


public string query = 'select Id,IS_CIR_Sixth_Day_Esc_Email_Sent__c  from Case where recordtypeid = :cirRecID AND  Status = :OpenStatus AND Origin != :EccrOrigin AND Origin !=  :TMSOrigin  AND((GE_OG_Resolution_Committed_date_CIR__c != null AND Variance_To_Commited__c = 7) OR (GE_OG_Resolution_Committed_date_CIR__c = null AND Aging__c = 7)) AND IS_CIR_Sixth_Day_Esc_Email_Sent__c = false AND GE_OG_Escalation_Level_CIR__c = :Escalated AND IS_CIR_sixthday_Notification_Sent__c = false ';
global database.querylocator start(Database.BatchableContext BC)
{
    return Database.getQueryLocator(query);
}

global void execute(Database.BatchableContext BC, Sobject[] scope)
{   
  

    //EmailTemplate emailTemplate = [select Id, Body  from EmailTemplate where DeveloperName = 'GE_OG_CIR_Case_Escalated_Template'];
    List<Case> lstCaseUpdate = new List<Case>();

    for (Case item : (List<Case>)scope) {
                System.debug(item.id);
                /* 
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                       email.setToAddresses(new String[] {Label.CIR_TMS_Escalation_Email_DL});
                        email.setSaveAsActivity(false);
                        //email.setTargetObjectId(item.OwnerId);
                        email.setTemplateId(emailTemplate.Id);
                        email.setWhatId(item.Id);
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                           */
                         if(item.IS_CIR_Sixth_Day_Esc_Email_Sent__c == false)
                         {
                         System.debug('Updating Cases    '+item.id);
                        item.IS_CIR_Sixth_Day_Esc_Email_Sent__c = true;
                        lstCaseUpdate.add(item);
                        }
            }
          
    
    if(!lstCaseUpdate.isEmpty() && lstCaseUpdate.size() > 0) {
       
        update lstCaseUpdate;
    }       
}

global void finish(Database.BatchableContext BC) {

}


}