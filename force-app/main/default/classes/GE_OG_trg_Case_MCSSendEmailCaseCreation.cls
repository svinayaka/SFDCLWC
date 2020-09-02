/*
Type Name [Class/Trigger/Page Name] : Class - GE_OG_trg_MCSSendEmailCaseCreation
Purpose                             : Sending Email alert for Cases raised against critical accounts
Functional Area                     : Service
Author                              : CaseTeam
Created Date                        : 9 March 2013
Test Class                          : Test_GE_OG_Case_Related--67%
*/

/*
S.NO         MethodName                                       operation
1.           mcsSendEmailOnCaseCreation         afterinsert,afterupdate

*/


public class GE_OG_trg_Case_MCSSendEmailCaseCreation
{

/*
  this method is for 'afterinsert','afterupdate'
  Modified from Trigger:GE_MCS_SendEmail_On_Case_Creation
  
*/
public String caseOrigin {get;set;}

public void mcsSendEmailOnCaseCreation(List<Case> newcaseList,Map<Id,Case>  newMapCase,Map<Id,Case>  oldMapCase)
{


         List<Case>    newcaseList1= (List<Case>)newcaseList;
         Map<Id,Case>  oldMapCase1=(Map<Id,Case>)oldMapCase;
         Map<Id,Case>  newMapCase1=(Map<Id,Case>)newMapCase;

    String caseType = '';
    List<String> caseTypeArray = new List<String>();
    list<Case> lstCase = new List<Case>();
    List<Id> lstAccountId = new List<Id>();
    
    List<CaseHistory> lstCaseHistory = [Select c.Id, c.CaseId From CaseHistory c where caseid =: newMapCase1.keyset()];
        for(Case c :newcaseList1){
    
            if(newMapCase1.get(c.id).origin != null ){
                caseOrigin = newMapCase1.get(c.id).origin ;
                caseType = caseOrigin.split('-')[0].trim() ;
                caseTypeArray = caseOrigin.split('-');
     
            }
        
        
        
   
        if(oldMapCase1 != null )
        {
             
                    if(caseType == 'Email' && caseTypeArray.size() == 1  )
                    {        
              
                        if (newMapCase1.get(c.id).accountid != oldMapCase1.get(c.id).accountid )
                        {
                  
                            lstCase.add(c);
                            lstAccountId.add(c.accountid);
                        }
                    } 
                    else if(caseType == 'Email' && caseTypeArray.size() > 1)
                    {
                
                 
                    List<CaseHistory> lstCurrentCaseHistory = new List<CaseHistory>();
                    
                        for(CaseHistory csh:lstCaseHistory){
                            if(csh.caseid == newMapCase1.get(c.id).id ){
              
                                lstCurrentCaseHistory.add(csh);
                            }
                        }
            
                        if (newMapCase1.get(c.id).accountid != oldMapCase1.get(c.id).accountid  &&  lstCurrentCaseHistory.size() != 0)
                        {
                            
                            lstCase.add(c);
                            lstAccountId.add(c.accountid);
                        }
                        
                
                    }
        } else 
        {    
                if(newMapCase1.get(c.id).accountid != null )
                {       
                  lstCase.add(c);
                  lstAccountId.add(c.accountid);
                }
            
        }

    }

    List<Id> lstUserEmail = new List<Id>();
    
    Map<id,Account> mapAccount = new Map<id,Account>([Select id , name ,GE_HQ_Request_Status__c,Case_Notification__c  from Account where id =:lstAccountId limit 50000]) ;
    List<AccountTeamMember> lstAccountMember = [Select id,TeamMemberRole,UserId,accountid from AccountTeamMember where accountid =: mapAccount.keyset()];
        for(Case c:lstCase){
            if( c.accountId != null && ( c.status == 'New' || c.status == 'Open' ) ){
                
            
            
            system.debug('*********mapAccount.get(c.accountid).GE_HQ_Request_Status__c*********'+mapAccount.get(c.accountid).GE_HQ_Request_Status__c+'***** mapAccount.get(c.accountid).Case_Notification__c == true********'+ mapAccount.get(c.accountid).Case_Notification__c );
                if( mapAccount.get(c.accountid).GE_HQ_Request_Status__c == 'CMF Approved' && mapAccount.get(c.accountid).Case_Notification__c == true ){
                       if(lstAccountMember.size() > 0){
                    for(AccountTeamMember actMember:lstAccountMember){
                        if(actMember.accountid ==  c.accountId ){
                        if(actMember.TeamMemberRole == 'Account Manager'){
                            lstUserEmail.add(actMember.UserId);
                            }
                            }
                    }
                    }
                }
            } 
        }
        
         Map<id,User> mapUser = new Map<id,User>([Select id , case_notification__c from user where id =:lstUserEmail ]) ;
            for(Case c:lstCase){       
               
                
                if(lstUserEmail.size()>0){

                    for(Id userId : lstUserEmail){
                
                        if(mapUser.get(userId).case_notification__c == true){
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(userId);
                        mail.setSenderDisplayName('Case Managment');
                        mail.saveAsActivity = false;
                        mail.setUseSignature(false) ; 
                        mail.setSubject('New Case created for Account '+mapAccount.get(c.accountid).name);
                        mail.setHtmlBody('A new case - '+ c.casenumber+ ' - '+ 'has been created against your flagged case notification account '+ mapAccount.get(c.accountid).name+' .'
                        +'<br/><br/>Subject: '+ c.subject+'<br/><br/>'
                        + 'You can receive any future updates notifications on this case, but only if you go to the case in Salesforce and “Follow” it in Chatter' 
                        +  '<br/><br/>Click  <a href=https://geog--ogdev.cs11.my.salesforce.com/'+c.Id+'> HERE </a> to go to the Case.'
                        +'<br/><br/>You have received this new case creation notification email only because <br/><br/>'
                        +'1.   Your My Personal Information User Setup has its “Case Notification” checkbox checked'
                        +'<br/>2.   The referred Account has its “Case notification” checkbox checked'
                        +'<br/>3.   You are in the Account Team for the referred Account with the role “Account Manager”'
                        ) ;
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                        }

                    }


                }

            }
}
}