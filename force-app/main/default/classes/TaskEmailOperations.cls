public class TaskEmailOperations {
  private static Boolean isExecuted = false;
    
    
    private static Map<ID,Task> NewTasksMap = null;
    private static Map<ID,Task> OldTasksMap = null;
            
    public static void SendEmailOnStatusChange(Map<ID,Task> newTasks){        
      NewTasksMap = newTasks;
        SendEmailOnStatusChange();
    }    
    public static void SendEmailOnStatusChange(Map<ID,Task> oldTasks, Map<ID,Task> newTasks){
        OldTasksMap = oldTasks;
        NewTasksMap = newTasks;
        SendEmailOnStatusChange();
    } 
    
    private static void SendEmailOnStatusChange(){
        if(!isExecuted){
            List<Case> filteredCases = new List<Case>();
           
            Set<ID> caseIDs = new Set<ID>();
            for(Task t : NewTasksMap.values()){
                if(t.whatid!=null)
                {
                    if(String.valueOf(t.WhatId).StartsWith('500')){
                    
                        caseIDs.add(t.WhatId);
                       
                    }                   
                }                 
            }
            
            string recordTypeID =String.valueOf(Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId());
           
            //filteredCases = [Select ID,Contact.Email,GE_OG_CIR_Customer_Email__c,RecordTypeID,(Select ID,Subject,Status From Tasks WHERE ID IN : NewTasksMap.keySet()) From Case WHERE ID in :caseIDs AND RecordTypeID=:recordTypeId];
            filteredCases = [Select ID,Contact.Email,ownerid,GE_OG_CIR_Customer_Email__c,Description,RecordTypeID,Subject,GE_OG_Customer_Impact_CIR__c,GE_OG_Business_CIR__c,GE_OG_Escalation_Level_CIR__c,CaseNumber,GE_OG_Customer_Want_Date_CIR__c,GE_OG_Resolution_Forecasted_Date_CIR__c,GE_OG_Issue_Event_Date_CIR__c,GE_OG_CIR_Site_Name__c,(Select ID,Subject,Status From Tasks WHERE ID IN : NewTasksMap.keySet()) From Case WHERE ID in :caseIDs AND RecordTypeID=:recordTypeId];
            List<Messaging.SingleEmailMessage> lstEmails = new List<Messaging.SingleEmailMessage>();
            
             Set<ID> ownerids = new Set<ID>();
            for(case c:filteredCases)
            {
               ownerids.add(c.ownerid); 
            }
            
            map<id,user> mapuser = new map<id,user>();
            for(user u:[select id,email from user where id in:ownerids])
            {
             mapuser.put(u.id,u);
            }
            for(Case c : filteredCases){
                if(IsStatusChanged(c)){
                    
                    for(Task t :c.Tasks){                        
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
                        //System.debug('Contact Email' + c.Contact.Email);
                      if(c.contactid!=null&&mapuser.containskey(c.ownerid)==true){  
                            //System.debug('Email: ' + c.Contact.Email);
                            email.setToAddresses(new String[]{mapuser.get(c.ownerid).email});
                            email.setSubject('Task Status Changed');
                            email.setHTMLBody('<HTML><BODY>Dear Case Owner,<br/> The task has been updated with the following details.<br/> <br/>Subject: '+ t.Subject +'<br/>Problem Description: '+c.description +'<br/>Impact on Customer: '+ c.GE_OG_Customer_Impact_CIR__c +  '<br/>Business: ' + c.GE_OG_Business_CIR__c +  '<br/>Escalation Level: ' + c.GE_OG_Escalation_Level_CIR__c +  '<br/>Case Number: ' + c.CaseNumber +  '<br/>Customer Want Date: '  + c.GE_OG_Customer_Want_Date_CIR__c +  '<br/>Resolution Forecasted Date: '  + c.GE_OG_Resolution_Forecasted_Date_CIR__c + '<br/>Issue Event Date: '  + c.GE_OG_Issue_Event_Date_CIR__c + '<br/>Site name: '  + c.GE_OG_CIR_Site_Name__c + '<br/>Task Subject: '  + t.Subject +  '<br/>Task Status: ' + t.status +  '<br/><br/>GE Technical Support Services  <br/><br/>Bently Nevada:  techsupport@ge.com  <br/>Control Solutions: controlsconnect@ge.com   <br/>Measurement & Sensing: mstechsupport@ge.com  <br/>Inspection Technologies: ittechsupport@ge.com  <br/>M&C Global Technical Support <br/><br/>General Electric Company <br/>GE imagination at work <br/>This is an auto generated email sent from an unmonitored mail box. <br/>Please do not reply to this email. </BODY></HTML>');

                            //email.setTargetObjectId(c.ID);
                            lstEmails.add(email);
                      }
                        else if(mapuser.containskey(c.ownerid)==true)
                        {
                            //System.debug('Email: ' + c.GE_OG_CIR_Customer_Email__c);
                            email.setToAddresses(new String[]{mapuser.get(c.ownerid).email});
                            email.setSubject('Task Status Changed');
                            email.setHTMLBody('<HTML><BODY>Dear Case Owner,<br/> The task has been updated with the following details.<br/> <br/>Subject: '+ t.Subject + '<br/>Problem Description: '+c.description +'<br/>Impact on Customer: '+ c.GE_OG_Customer_Impact_CIR__c +  '<br/>Business: ' + c.GE_OG_Business_CIR__c +  '<br/>Escalation Level: ' + c.GE_OG_Escalation_Level_CIR__c +  '<br/>Case Number: ' + c.CaseNumber +  '<br/>Customer Want Date: '  + c.GE_OG_Customer_Want_Date_CIR__c +  '<br/>Resolution Forecasted Date: '  + c.GE_OG_Resolution_Forecasted_Date_CIR__c + '<br/>Issue Event Date: '  + c.GE_OG_Issue_Event_Date_CIR__c + '<br/>Site name: '  + c.GE_OG_CIR_Site_Name__c + '<br/>Task Subject: '  + t.Subject +  '<br/>Task Status: ' + t.status +  '<br/><br/>GE Technical Support Services  <br/><br/>Bently Nevada:  techsupport@ge.com  <br/>Control Solutions: controlsconnect@ge.com   <br/>Measurement & Sensing: mstechsupport@ge.com  <br/>Inspection Technologies: ittechsupport@ge.com  <br/>M&C Global Technical Support <br/><br/>General Electric Company <br/>GE imagination at work <br/>This is an auto generated email sent from an unmonitored mail box. <br/>Please do not reply to this email. </BODY></HTML>');

                           
                            lstEmails.add(email);
                       }
                    }  
                }                
            }  
            
            Messaging.sendEmail(lstEmails);
            isExecuted=true;
        }
    }
    
    private static Boolean IsStatusChanged(case c){
        Boolean statusChanged=false;
        for(Task t : c.Tasks){
            if(OldTasksMap!=null){
                if(OldTasksMap.get(t.Id).Status !=t.Status){
                    statusChanged=true;
                }
            }
            else{
                 statusChanged=true;
            }
        }        
        return statusChanged;
    }
}