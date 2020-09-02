global with sharing class GE_OG_MC_POnotReceivedAlert implements Database.Batchable<sObject>{
    
    Long noOfDays;
    Id RecId =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    List<SVMXC__Service_Order__c> woupdate=new List<SVMXC__Service_Order__c>();
    Date d = Date.today();
    Integer emailLimit;
    Integer emailUsed;
    List<String> userid=new List<String>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator([Select Id,createdby.Username,GE_OG_MC_ERP_Project_Number__c,CreatedById,GE_OG_MC_Subject__c,Name,OwnerId,GE_SM_HQ_Record_Type_Name__c,RecordTypeId,LastModifiedBy.Email,CreatedBy.Email, GE_OG_PO_Checked_On__c FROM SVMXC__Service_Order__c WHERE RecordTypeId=:RecId and GE_OG_PO_Checked_On__c!=null]);
    }
    global void execute(Database.BatchableContext BC, List<SVMXC__Service_Order__c> scope) {
        Messaging.SingleEmailMessage [] mail= new List<Messaging.SingleEmailMessage>();
        Messaging.Email[] allEmails = new List<Messaging.Email>();
        //System.debug('****'+wodetails+wodetails.Size());
        for(SVMXC__Service_Order__c wo:scope){
            System.debug('User name'+wo.createdby.Username);
            noOfDays = wo.GE_OG_PO_Checked_On__c.daysBetween(d);  
            System.debug('***********'+noOfDays );  
            If(noOfDays==7&&wo.createdby.Username!='mcssapwebmethods01@ge.com.ogdev'){
                System.debug('Inside for');
                System.debug('WO.Name'+wo.Name);
                wo.GE_OG_PO_Checked_On__c=d;
                woupdate.add(wo);           
                userid.add(wo.CreatedByID);
            } 
            if(userid.size()>0&&noOfDays==7){
                Messaging.SingleEmailMessage singleemail = new Messaging.SingleEmailMessage();
                singleemail.setTargetObjectId(wo.createdByID);
                singleemail.setSubject('PO not Received is checked for WorkOrder: '+wo.Name);
                //mail.setTemplateId(EMAIL_TEMPLATE_ID);
                singleemail.setSaveAsActivity(false);
                singleemail.setHtmlBody('A Purchase Order has not been received for ('+wo.Name+'/'+wo.GE_OG_MC_Subject__c+'). Please follow-up with the customer to ensure the receipt of this PO.');
                mail.add(singleemail);
            }       
        }
        emailUsed=Limits.getEmailInvocations();
        emailLimit=Limits.getLimitEmailInvocations();
        System.debug('Email Limit'+emailLimit);
        if(userid.size()>0){
            for( Integer i = 0; i < mail.size(); i++ )
            {
                allEmails.add(mail.get(i));
            }
            if (allEmails.size()>0&&emailUsed<emailLimit)
            {
                Messaging.sendEmail( allEmails );
            }
            
            update woupdate;
        }
        
    }
    global void finish(Database.BatchableContext BC) {
    }
}