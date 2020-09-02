public class SVMX_Utility
{
    public static Boolean sendEmail = false;
    public static Boolean techUpd = true;
    public static Set<Id> idset = new Set<Id>();

    
    @Future(callout=true)
    public static void sendEmail(Id whatIdV, Id tId, Id uid, String emailV){
    
        SVMXC__Service_Order__c wo = [select id, GE_SM_HQ_Scheduled_Start_Date_Time__c, GE_SM_HQ_Scheduled_End_Date_Time__c,GE_DS_Service_Team_Leader_Email__c from SVMXC__Service_Order__c where id = :whatIdV];
        System.debug('wo is '+wo);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(tId);
        
        mail.setTargetObjectId(uid);
        mail.setWhatId(whatIdV) ;
        mail.setUseSignature(false);
        mail.setSaveAsActivity(false);
        //mail.setToAddresses(new String[] { wo.SVMXC__Contact__r.Email });
        if(wo.GE_DS_Service_Team_Leader_Email__c != Null){
            mail.setToAddresses(new String[] { emailV,wo.GE_DS_Service_Team_Leader_Email__c});
        }
        else{
            mail.setToAddresses(new String[] { emailV});
        }
        
        System.debug('mail is '+mail);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
    }
    
    @Future(callout=true)
    public static void sendApprovalEmail(Id whatIdV){
    
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Technician is assigned from outside region.');
        req1.setObjectId(whatIdV);
        Approval.ProcessResult result = Approval.process(req1);
    }
    
    
    @Future(callout=true)
    public static void sendEmailstoMCS(Id evtIdV, Id tId, Id uid, String emailV){
    
        SVMXC__SVMX_Event__c evOb = [Select ID, SVMXC__Technician__r.SVMXC__Email__c from SVMXC__SVMX_Event__c where id = :evtIdV];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(tId);
        mail.setTargetObjectId(uid);
        mail.setWhatId(evOb.id) ;
        mail.setUseSignature(false);
        mail.setSaveAsActivity(false);
        mail.setToAddresses(new String[] { evOb.SVMXC__Technician__r.SVMXC__Email__c});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        
    }
    
    //Below method is for sending Email for PC
    public static void sendEmailsToPC(List<SVMXC__SVMX_Event__c> newEvents,List<SVMXC__Service_Order__c> woList){
    
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    Set<Id> techSet = new Set<Id>();
    for(SVMXC__SVMX_Event__c sMaxev: newEvents)
    {
        techSet.add(sMaxev.SVMXC__Technician__c);
    }
    
     
    
    map<Id, SVMXC__Service_Group_Members__c > newTechMap = new map<Id, SVMXC__Service_Group_Members__c >([SELECT Id,SVMXC__Salesforce_User__c from SVMXC__Service_Group_Members__c WHERE Id IN :techSet]);
     
    for(SVMXC__SVMX_Event__c evt:newEvents)
    {
        for(SVMXC__Service_Order__c smaxWO: woList)
        {
            if(evt.SVMXC__WhatId__c == smaxWO.id && smaxWO.GE_SM_HQ_Record_Type_Name__c == 'PC')
            {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                List<String> sendTo = new List<String>();                                                                                                   
                mail.setTargetObjectId(newTechMap.get(evt.SVMXC__Technician__c).SVMXC__Salesforce_User__c); 
                mail.setSaveAsActivity(false);                                   
                                  
                mail.setSubject('You have been assigned to work order:'+ smaxWO.Name+' for '+smaxWO.SVMXC__Company__r.Name);

                String body = 'You have been assigned to ' +smaxWO.Name;
                body += '<br>';
                body += '<br>';
                if(smaxWO.GE_SM_HQ_Scheduled_Start_Date_Time__c!=null && smaxWO.GE_SM_HQ_Scheduled_End_Date_Time__c!=null ){
                                  
                body += 'This assignment is scheduled to start on '+(smaxWO.GE_SM_HQ_Scheduled_Start_Date_Time__c).format('EEEEE, MMMMM dd, YYYY')+', at '+(smaxWO.GE_SM_HQ_Scheduled_Start_Date_Time__c).format('hh:mm a z'); 
                                  
                 body += '&nbsp;and end on '+(smaxWO.GE_SM_HQ_Scheduled_End_Date_Time__c).format('EEEEE, MMMMM dd, YYYY')+', at '+(smaxWO.GE_SM_HQ_Scheduled_End_Date_Time__c).format('hh:mm a z');                               
                                  
                }
                body += '<br>';
                body += 'Account/Customer Name: '+smaxWO.SVMXC__Company__r.Name;  
                body += '<br>';
                body += 'Site: '+smaxWO.SVMXC__Site__r.Name;  
                body += '<br>';
                
                //R-26288 As a part of this, added Task Description and Driving Directions
                body += 'Task Description: '+smaxWO.GE_SM_HQ_Task_Description__c;  
                body += '<br>';
                body += 'Driving Directions: '+smaxWO.GE_PC_Driving_Directions__c;  
                
                body += '<br>';
                body += '<br>';
                body += 'If you have any questions, please contact your Service Manager for this assignment.';
                body += '<br>';
                body += '<br>';                                   
                if(smaxWO.Region__c=='MENAT'){
                body +='You may view the Work Order by using this link: ';
                body += '<br>';
                body +='<a href=';
                body +=URL.getSalesforceBaseUrl().toExternalForm()+'/'+smaxWO.id;
                body +='>'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+smaxWO.id+'<'+'/'+'a>';
                }
                mails = new List<Messaging.SingleEmailMessage>();  
                mail.setHtmlBody(body);
                if(mail!=null){
                 mails.add(mail);                                    
                }
                }
                              
                if (mails!=null)
                {              
                    Messaging.sendEmail(mails);                                   
                }
                }
                }
    
    }
          
    
}