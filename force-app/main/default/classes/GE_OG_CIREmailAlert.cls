public class GE_OG_CIREmailAlert 
{
        public void ciremailalertnotification(list<task> newlist,map<id,task> oldlist)
        {
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

            set<id> caseid = new set<id>();
             set<id> userid= new set<id>();
            for(task t:newlist)
            {
            if(t.whatid!=null)
            {
            if(string.valueof(t.whatid).contains('500'))
            {
            caseid.add(t.whatid);
            userid.add(t.ownerid);
            }
            }
            }
            
            map<id,case> mapcase = new map<id,case>();
            for(case c:[select id , recordTypeId ,GE_OG_Business_CIR__c,GE_OG_Escalation_Level_CIR__c,Subject,CaseNumber, OwnerId, AccountId,GE_OG_CIR_Site_Name__c,Owner.name,Account.name from case WHERE Id IN : caseId])
            {
                mapcase.put(c.id,c);
            }
            map<id,user> mapuser = new map<id,user>();
            for(user u :[select id,name from user where id in:userid])
            {
            mapuser.put(u.id,u);
            }
          
            
            for(task t:newlist)
            {
                if(mapcase.containskey(t.whatid)==true)
                {
                    if(t.status=='Completed' &&t.recordtypeid==Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId())
                    {
                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
                    mail.setSubject('The SFDC task ' + t.Subject +  ' has been completed');
                    mail.setTargetObjectId(mapcase.get(t.WhatId).OwnerId);
                    mail.setHtmlBody('<HTML><BODY> Task Description: '+t.Description + '<br/><br/> Task Due Date: '+t.ActivityDate + '<br/><br/> Task Closure Forecast Date: '+t.Task_Closure_Forecast_Date__c + '<br/><br/> O&G Business: '+ mapcase.get(t.WhatId).GE_OG_Business_CIR__c + '<br/><br/> Case Escalation Level: '+ mapcase.get(t.WhatId).GE_OG_Escalation_Level_CIR__c + '<br/><br/> Task Subject: '+ t.Subject + '<br/><br/> Case Number: '+ mapcase.get(t.WhatId).CaseNumber + '<br/><br/> Case Manager: '+mapcase.get(t.WhatId).Owner.name + '<br/><br/> Customer name: '+mapcase.get(t.WhatId).Account.name + '<br/><br/> Site name: '+mapcase.get(t.WhatId).GE_OG_CIR_Site_Name__c + '<br/><br/><br/><br/><br/>General Electric Company<br/><br/>GE imagination at work<br/><br/>This is an auto generated email sent from an unmonitored mail box.Please do not reply to this email.</BODY></HTML>');  
                    mail.setSaveAsActivity(false); 
                    mails.add(mail);
                    }
                    
                   if(t.ownerid!=oldlist.get(t.id).ownerid)
                    {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String URL=URL.getSalesforceBaseUrl().toExternalForm();
                    mail.setSubject('The SFDC task ' + t.Subject +  ' has been forwarded to ' + mapuser.get(t.ownerid).name);
                    mail.setTargetObjectId(mapcase.get(t.WhatId).OwnerId);
                    mail.setHtmlBody('<HTML><BODY> Task Description: '+t.Description + '<br/><br/> Task Due Date: '+t.ActivityDate + '<br/><br/> Task Closure Forecast Date: '+t.Task_Closure_Forecast_Date__c + '<br/><br/> O&G Business: '+ mapcase.get(t.WhatId).GE_OG_Business_CIR__c + '<br/><br/> Case Escalation Level: '+ mapcase.get(t.WhatId).GE_OG_Escalation_Level_CIR__c + '<br/><br/> Task Subject: '+ t.Subject + '<br/><br/> Case Number: <a href="'+URL+'/'+mapcase.get(t.WhatId).Id+'">'+ mapcase.get(t.WhatId).CaseNumber+'</a> ' + '<br/><br/> Case Manager: '+mapcase.get(t.WhatId).Owner.name + '<br/><br/> Customer name: '+mapcase.get(t.WhatId).Account.name + '<br/><br/> Site name: '+mapcase.get(t.WhatId).GE_OG_CIR_Site_Name__c + '<br/><br/><br/><br/><br/>General Electric Company<br/><br/>GE imagination at work<br/><br/>This is an auto generated email sent from an unmonitored mail box.Please do not reply to this email.</BODY></HTML>');  
                    mail.setSaveAsActivity(false); 
                    mails.add(mail);
                    
                    }
                    
                    if(oldlist.get(t.id).Task_Closure_Forecast_Date__c!=t.Task_Closure_Forecast_Date__c)
                    {
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                        String URL=URL.getSalesforceBaseUrl().toExternalForm(); 
                        mail.setSubject('The Resolution Forecast date for SFDC task ' + t.Subject +  ' has been updated by ' + mapuser.get(t.ownerid).name);
                        mail.setTargetObjectId(mapcase.get(t.WhatId).OwnerId);
                        mail.setHtmlBody('<HTML><BODY> Task Description: '+t.Description + '<br/><br/> Task Due Date: '+t.ActivityDate + '<br/><br/> Task Closure Forecast Date: '+t.Task_Closure_Forecast_Date__c + '<br/><br/> O&G Business: '+ mapcase.get(t.WhatId).GE_OG_Business_CIR__c + '<br/><br/> Case Escalation Level: '+ mapcase.get(t.WhatId).GE_OG_Escalation_Level_CIR__c + '<br/><br/> Task Subject: '+ t.Subject + '<br/><br/> Case Number: <a href="'+URL+'/'+mapcase.get(t.WhatId).Id+'">'+ mapcase.get(t.WhatId).CaseNumber+'</a> ' + '<br/><br/> Case Manager: '+mapcase.get(t.WhatId).Owner.name + '<br/><br/> Customer name: '+mapcase.get(t.WhatId).Account.name + '<br/><br/> Site name: '+mapcase.get(t.WhatId).GE_OG_CIR_Site_Name__c + '<br/><br/><br/><br/><br/>General Electric Company<br/><br/>GE imagination at work<br/><br/>This is an auto generated email sent from an unmonitored mail box.Please do not reply to this email.</BODY></HTML>');  
                        mail.setSaveAsActivity(false); 
                        mails.add(mail);
                    }
                
                }
            }
            Messaging.sendEmail(mails );               
        }

}