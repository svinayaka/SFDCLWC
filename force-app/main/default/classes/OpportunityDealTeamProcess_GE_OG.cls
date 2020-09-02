/*
Class/Trigger Name     : OpportunityDealTeamProcess_GE_OG
Purpose/Overview       : Add/Delete/Modify Opp Deal Team
Scrum Team             : Oppty MGMT - Transformation
Requirement Number     : R-25948
Author                 : Mohit Maheshwari
Created Date           : 10/Feb/2016
Test Class Name        : OpportunityDealTeamProcess_GE_OG_Test
Code Coverage          : 90
*/
global without sharing class OpportunityDealTeamProcess_GE_OG{

    public OpportunityDealTeamProcess_GE_OG(ApexPages.StandardController controller) {

    }

    /*****
        methood to delete or update team member
    *****/
    webservice static List<String> AddEditDeleteDealTeamMember(String lstdealTeam){

    system.debug(' ==== \n\n\n lstdealTeam' + lstdealTeam + ' \n\n ==');

    List<OpportunityTeamMember> lstDelete = new List<OpportunityTeamMember>();
    List<OpportunityTeamMember> lstUpdate = new List<OpportunityTeamMember>();
    List<OpportunityTeamMember> lstInsert = new List<OpportunityTeamMember>();
        
    List<String> lstmsg = new List<String>();
    Savepoint spoint = Database.setSavepoint();
    
    OpportunityTeamMember objOTM = null;
            
    JSONParser newparser = JSON.createParser(lstdealTeam);
        
    system.debug('******************lstdealTeam**********:' + lstdealTeam );  
    while (newparser.nextToken() != null) {
        system.debug('******************First ' );  
        while (newparser.nextToken() != null) {
            system.debug('******************Second' );  
                
            if (newparser.getCurrentToken() == JSONToken.START_OBJECT) {
                    O_OpportunityDealTeamParser_GE_OG jopt = (O_OpportunityDealTeamParser_GE_OG)newparser.readValueAs(O_OpportunityDealTeamParser_GE_OG.class);
                    system.debug('******************jopt**********' + jopt );
                    
                   if(lstdealTeam.contains('__deleted')){
                       objOTM = new OpportunityTeamMember();    
                       String DTMid = newparser.getCurrentName();
                       objOTM.ID = DTMid;
                       lstDelete.add(objOTM);
                       system.debug('***************In Delete ' + objOTM + ' lstDelete' + lstDelete);       
                    }
                    else if(lstdealTeam.contains('OpportunityId')){
                      objOTM = new OpportunityTeamMember(); 
                      objOTM.OpportunityID = jopt.OpportunityID;
                      system.debug('In Insert:OpportunityId: ' + jopt.OpportunityID);
                    
                      objOTM.UserId = jopt.UserID;
                      system.debug('In Insert:User ID: ' + jopt.UserID);
                    
                      objOTM.TeamMemberRole = jopt.TeamMemberRole;
                      system.debug('In Insert:TeamMemberRole : ' + jopt.TeamMemberRole);
                        
                      lstInsert.add(objOTM);
                    }
                    else if(lstdealTeam.contains('TeamMemberRole')){
                      objOTM = new OpportunityTeamMember();     
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
}