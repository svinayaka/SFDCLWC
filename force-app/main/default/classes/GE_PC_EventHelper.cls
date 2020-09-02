public with sharing class GE_PC_EventHelper{
    
    public void afterInsertEvent(List<Event> newEvent){
   
   Set<Id> whatIds ;
   List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c>();
   List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
   for (Event evt:newEvent) {
                whatIds = new Set<Id>();
                whatIds.add(evt.whatId); 
    }
    if(whatIds!=null){
                woList = [SELECT Id,Name,GE_SM_HQ_Record_Type_Name__c,SVMXC__Site__r.Name,SVMXC__Company__r.Name,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,Region__c from SVMXC__Service_Order__c where Id in :whatIds];              
                
                   }
                   
                   If (woList!=null){
                       for(Event evt:newEvent)
                       {
                           for(SVMXC__Service_Order__c smaxWO: woList)
                           {
                               if(evt.whatid == smaxWO.id && smaxWO.GE_SM_HQ_Record_Type_Name__c == 'PC')
                               {
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                                  List<String> sendTo = new List<String>();                                                                                                   
                                   mail.setTargetObjectId(evt.OwnerId); 
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
 }