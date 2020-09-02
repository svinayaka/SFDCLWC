/*
Class Name             : SendMailToTresholdUser
Purpose/Overview       : Whenever new opportunity is created with amount greater than threshold value email alert should be sent to the threshold user.
Requirement Number     : R-30373 and R-30909
Scrum Team             : Opportunity team
Created Date           : 20/09/2018
Modified Date          : 22/11/2018
Modified By            : Megha Gavade
Test Class Name        : SendMailToTresholdUserTest
Code Coverage          : 98%
*/


global class SendMailToTresholdUser implements Database.Batchable<sObject>,Database.stateful
{
      global double min=0;
      global double amt=0;
      Exception[] errors = new Exception[0];
      
      //Get the minimum threshold value of all the users
      global  sendMailToTresholdUser()
      {
          AggregateResult[] groupedResults=[select MIN(BigDeal_Threshold__c) avg from user where BigDeal_Threshold__c!=null ];
          double min1=double.valueof(groupedResults[0].get('avg'));
          amt=min1*1000000;
          system.debug('amt-------'+amt);
         
      }
      
      
      global Database.QueryLocator start(Database.BatchableContext BC)
      {
        //String query = 'Select Id, Name, Email, BigDeal_Threshold__c from user where BigDeal_Threshold__c!=null';
        return Database.getQueryLocator([Select Id, Name, Email, BigDeal_Threshold__c from user where BigDeal_Threshold__c!=null]);
      }
      
      //query the opportunities and send mail to threshold users if the criteria meets. 
      global void execute(Database.BatchableContext BC, List<user> scope)
      {       
      
           system.debug('----inside method--');
            List<opportunity> oplst=new List<opportunity>();
            OrgWideEmailAddress[] owea = [select Id,DisplayName from OrgWideEmailAddress where DisplayName = 'BHGE Global Excellence'];
            List<Opportunity> optlst = [Select Id, Name,owner.email,BigDealAlertSentTo__c,Amount,AmountLastModified__c,CreatedDate,Amount_USD_ge_og__c,Big_Deal_Alert_Sent_ge_og__c from Opportunity where ( Amount_USD_ge_og__c>=:amt AND isclosed=false and  (StageName!='Closed Won' OR StageName!='Closed Lost') )AND (createddate=yesterday OR(AmountLastModified__c!=null AND AmountLastModified__c=yesterday))];
            EmailTemplate emailTemplate = [select Id, Body from EmailTemplate where DeveloperName = 'Big_Deal_Alerts']; //big deal alert
            Map<id,opportunity> oppmap = new Map<id,opportunity>();
            List<Messaging.SingleEmailMessage> sendEmailrecords=new List<Messaging.SingleEmailMessage> ();
            
            Map<Opportunity, List<string>> opptyusermap = new  Map<Opportunity, List<string>>();
           
          
           List<String> lstAlpha = new List<string>();
           
            if(optlst.size()>0){
                
               system.debug('opty list'+optlst);
            for(Opportunity op:optlst)
            {
             List<string> toemailuser  = new List<string>();
              set<string> setToRemove=new set<string>();
               List<string> toemailuserlist  = new List<string>();
             
              if(op.BigDealAlertSentTo__c!=null){
               lstAlpha = op.BigDealAlertSentTo__c.split(',');}
              
               for(user u : (List<user>)scope) 
               {
                   
                    if((double.valueOf(u.BigDeal_Threshold__c))*1000000  <= op.Amount_USD_ge_og__c )
                    {
                       //add user mail id's to the BigDealAlertSentTo__c field to achieve one mail per user
                       toemailuser.add(u.email);
                       if(string.isNotBlank(op.BigDealAlertSentTo__c)){
                       system.debug('---inside if---');
                           if(!op.BigDealAlertSentTo__c.contains(u.email)){
                             op.BigDealAlertSentTo__c+=','+u.email;
                             setToRemove.add(u.email);
                             }
                           
                       }
                       else{
                               op.BigDealAlertSentTo__c=u.email;
                               setToRemove.add(u.email);
                       }
                      
                          
                       
                       system.debug('tolist'+toemailuser);
                       
                       oplst.add(op);
                       system.debug('2nd if');
                    }
                }
                
             
                toemailuserlist.addAll(setToRemove);
                if(toemailuserlist.size()>0){
                opptyusermap.put(op, toemailuserlist);
                }
                
            
                oppmap.putall(oplst);
              
            }
            }
            
             // iterate opptyusermap
             system.debug('map data'+opptyusermap);
              Messaging.SingleEmailMessage email;
            
          //send mail to treshold users
          for( opportunity op : opptyusermap.keyset()){
                       
                       if(opptyusermap.get(op)!=null){
                       system.debug('opmap-----'+opptyusermap.get(op));
                       string fromaddress=op.owner.email;                    
                       email = Messaging.renderStoredEmailTemplate(emailTemplate.id, null, op.id);
                       email.setToAddresses(opptyusermap.get(op));
                       email.setOrgWideEmailAddressId(owea.get(0).id);
                       email.setReplyTo(fromaddress);
                       email.saveAsActivity = false;
                       sendEmailrecords.add(email);
          }
          }
          
            
            system.debug('--------'+ Messaging.sendEmail(sendEmailrecords));
          system.debug('----oppmap.size()---'+oppmap.size());
          if(oppmap.size()>0)
                {
                   system.debug('---update----');
                    list<Database.SaveResult> results=database.update(oppmap.values(),false);
                    system.debug('saveresult'+results);
                }
           
       }
           
    
    global void finish(Database.BatchableContext BC)
    {
        
                   
    }
}