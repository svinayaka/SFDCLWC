/*
Class Name     : ProjectTeamTriggerHandler_GE_OG
Purpose/Overview       : Whenever new team member has beed added to the team , All the team member will get email notification
Scrum Team             : Transformation - Project MGMT
Created Date           : 14/July/2017
Modified Date          : 10/Jan/2018
Modified By            : Sonali Rathore
Test Class Name        : TestProjectTeamTriggerHandler_GE_OG
Code Coverage          : 
*/
public class ProjectTeamTriggerHandler_GE_OG{
 
    public void after_Insert_Functionality(List<Project_Team_Member_GE_OG__c > ListProjTeamMember){
          set<Id> setProjIds = new set<Id>();
          set<Id> setNonStdProjIds = new set<Id>();
          string joint=Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId();
          //Id NonStdRecordTypeId = Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint_Pursuit_Project').getRecordTypeId();
          //string joint=Label.Joint_Pursuit_RecordtypeID;
          list<Project_Team_Member_GE_OG__c> Recordtypeid;
          
          for(Project_Team_Member_GE_OG__c projteam : ListProjTeamMember){
                  setProjIds.add(projteam.Project_ge_og__c);
                  system.debug('Joint'+joint);
                  Recordtypeid=[select Project_ge_og__r.RecordTypeId from Project_Team_Member_GE_OG__c where id =: projteam.id];
                  system.debug('Joint nonstd'+Recordtypeid);
                 
                  }
                  for(Project_Team_Member_GE_OG__c recordtype:Recordtypeid){
                   if(recordtype.Project_ge_og__r.RecordTypeId == joint){
                  //system.debug('Joint nonstd'+projteam.Project_ge_og__r.RecordTypeId);
                    setNonStdProjIds.add(recordtype.Project_ge_og__c);
                  }
                  }
           if(setProjIds.size()>0 )
          {
           ListofUserforEmailNotification(setProjIds);
           
          } 
          if(setNonStdProjIds.size()>0)
          {
             ListofALLUserforEmailNotification(setNonStdProjIds,ListProjTeamMember); 
          } 
    }
  
  
     public void after_Update_Functionality(List<Project_Team_Member_GE_OG__c > ListProjTeamMember,Map<ID,Project_Team_Member_GE_OG__c > oldProjTeamMap){
          set<Id> setProjIds = new set<Id>();
          for(Project_Team_Member_GE_OG__c ProjTeamMember: ListProjTeamMember){
                   if(ProjTeamMember.User_ge_og__c != oldProjTeamMap.get(ProjTeamMember.Id).User_ge_og__c){
                           setProjIds.add(ProjTeamMember.Project_ge_og__c);
                   }                            
                }
           if(setProjIds.size()>0){   
           ListofUserforEmailNotification(setProjIds); }  
    }
     public void ListofUserforEmailNotification(Set<Id> setProjIds)
      {  
           ProjectTeamMember_Helper_GE_OG EmailNotification = new ProjectTeamMember_Helper_GE_OG();     
           List<Project_ge_og__c> ListProject = new List<Project_ge_og__c>();
          
           for(Project_ge_og__c ProjOwner : [Select Id,ownerId from Project_ge_og__c WHERE id IN: setProjIds]){
                    ListProject.add(ProjOwner);
           }  
           Map<Id, List<Id>> MapListOfUsers = new Map<Id, List<Id>>();    
                for(Project_ge_og__c newUser : ListProject) {
                    if(MapListOfUsers.containsKey(newUser.Id)) {
                        MapListOfUsers.get(newUser.Id).add(newUser.OwnerId);
                    } else {
                        MapListOfUsers.put(newUser.Id, new List<Id>{newUser.OwnerId});
                    }
                } 
           system.debug('$$$$$$$$MapListOfUsers$$$$$$$$'+MapListOfUsers+'%%%%%%%%'+ListProject);   
           System.debug('%%%%%%%ListProject%%%%%%%'+ListProject);           
           EmailNotification.EmailNotificationToProjTeamMemebrs(MapListOfUsers,ListProject);  
       }
       public void ListofALLUserforEmailNotification(Set<Id> setProjIds,List<Project_Team_Member_GE_OG__c > ListProjTeamMember)
      {  
           ProjectTeamMember_Helper_GE_OG EmailNotification = new ProjectTeamMember_Helper_GE_OG();     
           
             List<string> toEmailUser = new List<string>();
             List<Messaging.SingleEmailMessage> sendEmailrecords=new List<Messaging.SingleEmailMessage> ();
            List<Project_Team_Member_GE_OG__c> ListProjectTeam = new List<Project_Team_Member_GE_OG__c>();
            ListProjectTeam=[select id,Project_ge_og__r.name,Project_ge_og__r.ownerId,Project_ge_og__r.project_account_ge_og__r.name, Project_ge_og__r.Project_Id_ge_og__c,Project_ge_og__r.Project_Stage_ge_og__c, User_ge_og__r.email from Project_Team_Member_GE_OG__c  WHERE Project_ge_og__c IN: setProjIds];
           Map<Project_Team_Member_GE_OG__c, List<string>> prjTeamusermap = new  Map<Project_Team_Member_GE_OG__c, List<string>>(); 
                for(Project_Team_Member_GE_OG__c prjteam : ListProjectTeam) {
                       if(prjteam.Project_ge_og__r.ownerId!=prjteam.User_ge_og__c){
                       toEmailUser.add(prjteam.User_ge_og__r.Email);
                    }
                    }
                    
                    for(Project_Team_Member_GE_OG__c newuser:ListProjTeamMember)
                    {
                        if(toEmailUser.size()>0)
                        {
                              prjTeamusermap.put(newuser, toEmailUser);
                        }
                    }
                     Messaging.SingleEmailMessage email;
                     EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Prj_Team_notify_to_all_on_new_memb_addn'];
        
            
          //send mail to treshold users
          for( Project_Team_Member_GE_OG__c op : prjTeamusermap.keyset()){
                       
                       if(prjTeamusermap.get(op)!=null){
                       //system.debug('opmap-----'+opptyusermap.get(op));
                       //string fromaddress=op.owner.email;                    
                       email = Messaging.renderStoredEmailTemplate(emailTemp.id, null, op.id);
                       email.setToAddresses(prjTeamusermap.get(op));
                       //email.setOrgWideEmailAddressId(owea.get(0).id);
                       //email.setReplyTo(fromaddress);
                       email.saveAsActivity = false;
                       sendEmailrecords.add(email);
                       }
                       }
                       Messaging.SendEmailResult[] results = Messaging.sendEmail(sendEmailrecords);
               
       }
     
   /*
    public void ListofUserforEmailNotification(Set<Id> setProjIds)
      {  
           ProjectTeamMember_Helper_GE_OG EmailNotification = new ProjectTeamMember_Helper_GE_OG();     
           List<Project_Team_Member_GE_OG__c> ListProjectTeamMember = new List<Project_Team_Member_GE_OG__c>();
          
           for(Project_Team_Member_GE_OG__c ProjTeamMember : [Select Id,Project_ge_og__c,User_ge_og__c from Project_Team_Member_GE_OG__c WHERE Project_ge_og__c IN: setProjIds]){
                    ListProjectTeamMember.add(ProjTeamMember);
           }  
           Map<Id, List<Id>> MapListOfUsers = new Map<Id, List<Id>>();    
                for(Project_Team_Member_GE_OG__c newUser : ListProjectTeamMember) {
                    if(MapListOfUsers.containsKey(newUser.Project_ge_og__c)) {
                        MapListOfUsers.get(newUser.Project_ge_og__c).add(newUser.User_ge_og__c);
                    } else {
                        MapListOfUsers.put(newUser.Project_ge_og__c, new List<Id>{newUser.User_ge_og__c});
                    }
                } 
           system.debug('$$$$$$$$MapListOfUsers$$$$$$$$'+MapListOfUsers+'%%%%%%%%'+ListProjectTeamMember);   
           System.debug('%%%%%%%ListProjectTeamMember%%%%%%%'+ListProjectTeamMember);           
           EmailNotification.EmailNotificationToProjTeamMemebrs(MapListOfUsers,ListProjectTeamMember);  
       }
     */
      
}