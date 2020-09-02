/*
Class/Trigger Name     : AccountSuccessTeamProcess_AddEditDelete
Purpose/Overview       : Add/Delete/Modify Account Success Team
Requirement Number     : 
Author                 : Geetha KArmarkar
Test Class Name        : AccountSuccessTeamProcess_AddEditDelete_Test
Code Coverage          : 90
*/
global without sharing class AccountSuccessTeamProcess_AddEditDelete{

    public AccountSuccessTeamProcess_AddEditDelete(ApexPages.StandardController controller) {

    }

    /*****
        methood to delete or update team member
    *****/
    webservice static List<String> AddEditDeleteSuccessTeamMember(String lstdealTeam){

    system.debug(' ==== \n\n\n lstdealTeam' + lstdealTeam + ' \n\n ==');

    List<AccountTeamMember> lstDelete = new List<AccountTeamMember>();
    List<AccountTeamMember> lstUpdate = new List<AccountTeamMember>();
    List<AccountTeamMember> lstInsert = new List<AccountTeamMember>();
        
    List<String> lstmsg = new List<String>();
    Savepoint spoint = Database.setSavepoint();
    
    AccountTeamMember objOTM = null;
            
    JSONParser newparser = JSON.createParser(lstdealTeam);
        
    system.debug('******************lstdealTeam**********:' + lstdealTeam );  
    while (newparser.nextToken() != null) {
        system.debug('******************First ' );  
        while (newparser.nextToken() != null) {
            system.debug('******************Second' );  
                
            if (newparser.getCurrentToken() == JSONToken.START_OBJECT) {
                    AccountSuccessTeamParser_GE_OG jopt = (AccountSuccessTeamParser_GE_OG)newparser.readValueAs(AccountSuccessTeamParser_GE_OG.class);
                    system.debug('******************jopt**********' + jopt );
                    
                   if(lstdealTeam.contains('__deleted')){
                       objOTM = new AccountTeamMember();    
                       String DTMid = newparser.getCurrentName();
                       objOTM.ID = DTMid;
                       lstDelete.add(objOTM);
                       system.debug('***************In Delete ' + objOTM + ' lstDelete' + lstDelete);       
                    }
                    else if(lstdealTeam.contains('AccountId')){
                      objOTM = new AccountTeamMember(); 
                      objOTM.accountId = jopt.accountId;
                      system.debug('In Insert:AccountId: ' + jopt.accountId);
                    
                      objOTM.UserId = jopt.UserID;
                      system.debug('In Insert:User ID: ' + jopt.UserID);
                    
                      objOTM.TeamMemberRole = jopt.TeamMemberRole;
                      system.debug('In Insert:TeamMemberRole : ' + jopt.TeamMemberRole);
                        
                      lstInsert.add(objOTM);
                    }
                    else if(lstdealTeam.contains('TeamMemberRole')){
                      objOTM = new AccountTeamMember();     
                      String strOTMid = newparser.getCurrentName();
                      objOTM.ID = strOTMid;
                      objOTM.TeamMemberRole = jopt.TeamMemberRole;
                      lstUpdate.add(objOTM);
                      system.debug('*******************In Update objOTM ' + objOTM + ' lstUpdate'+lstUpdate);
                    }   
                    
                    String s = JSON.serialize(jopt);
                    system.debug('Serialized invoice: ' + s);
                    newparser.skipChildren();
                }
        }
    }
             
            if(lstDelete.size()>0){
                system.debug('\n\n ===== in Delete ==== ' + lstDelete + '\n\n\n');
                
                Database.DeleteResult[] lstresult = Database.Delete(lstDelete,false);
                
                for (Database.DeleteResult sr : lstresult) {
                    if (sr.isSuccess()) {
                        System.debug('Successfully Deleted : ');
                        //createTask(deletedId, deletedUserId,objAccount);
                    }
                    else {
                        // Operation failed, so get all errors                
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.' +  err.getMessage());                    
                            lstmsg.add(err.getMessage());
                        }
                    }
                }
                
                //Delete lstDelete;
            }
            
            if(lstUpdate.size()>0){
                system.debug('\n\n ===== in update ==== ' + lstUpdate + '\n\n\n');
                //Update lstUpdate;
                Database.SaveResult[] lstresult = Database.Update(lstUpdate,false);
                for (Database.SaveResult sr : lstresult) {
                    if (sr.isSuccess()) {
                        System.debug('Successfully Updated : '+sr.getID());
                    }
                    else {
                        // Operation failed, so get all errors                
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.' +  err.getMessage());                    
                            lstmsg.add(err.getMessage());
                        }
                    }
                }
            }
            
            if(lstInsert.size()>0){
                system.debug('\n\n ===== in insert ==== ' + lstInsert + '\n\n\n');
                //Insert lstInsert;
                Database.SaveResult[] lstresult = Database.Insert(lstInsert,false);
                for (Database.SaveResult sr : lstresult) {
                    if (sr.isSuccess()) {
                        System.debug('Successfully Inserted : '+sr.getID());
                    }
                    else {
                        // Operation failed, so get all errors                
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.' +  err.getMessage());                    
                            lstmsg.add(err.getMessage());
                        }
                    }
                }
            }
       // }
        if(lstmsg.size()>0){
            Database.rollback(spoint);
            return lstmsg;
        }
        else{
            lstmsg.add('isSuccess');
            return lstmsg;
            
        }
    }
    
    /*public static void createTask(Id deletedId, Id deletedUserId, Account objAccount){
        User objUser = [select id, name 
                        FROM User
                        WHERE id =: deletedUserId
                        LIMIT 1];
        Task newTask = new Task(Description = 'Account Team Member Deleted',
                                    Priority = 'Normal',
                                    Status = 'Completed',
                                    Type = 'To Do',
                                    Subject = objUser.name+' deleted from the Account',
                                    ActivityDate = System.today(),
                                    IsReminderSet = false,
                                    OwnerId = objAccount.ownerid,  
                                    WhatId = objAccount.Id
                                    );   
                                    
        insert newTask;   
    }*/
}