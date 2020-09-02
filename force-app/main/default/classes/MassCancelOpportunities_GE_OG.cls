/*
Class Name			: MassCancelOpportunities_GE_OG
Used Where ? 		: Used for Mass cancel Opportunities Automation.
Purpose/Overview	: Automates the manual process of cancelling the opportunities.
Author				: Harsha C
Created Date		: 06/MAY/2019
Requirement			: R-31649
Test Class Name		: MassCancelOpportunities_GE_OG_Test
Code Coverage  		:
*/

public class MassCancelOpportunities_GE_OG {
    public static void massCancelOptyRecords(List<Upload_Request_ge_og__c> uploadRequestList){
        List<Opportunity> optyList = new List<Opportunity>();
        Set<Opportunity> optyset = new Set<Opportunity>();
        List<Upload_Request_ge_og__c> urlist = new List<Upload_Request_ge_og__c>();
        Integer totalopty = 0;
        Integer total = 0;
        Id loggedInUser = UserInfo.getUserId();
        
        if(!Test.isRunningTest()){
            user u = new User();
            u.id=loggedInUser;
            u.Disable_validations_for_MERGE__c = true;
            update u;
        }
        List<String> exception_List = new List<String>();
        List<String> success_List = new List<String>();
        Set<Id> failIds = new Set<Id>();
        Set<Id> successIds = new Set<Id>();
        String failedrecordsCsv = 'OpportunityId,Status\n';
        String successrecordsCsv ='OpportunityId,Status\n';
        
        Integer successOpportunitiesCount = 0;
        Integer failureOpportunitiesCount = 0;
        
        String[] csvfilelines = new String[]{};
            Set<Id> uploadId = new Set<Id>();
        for(Upload_Request_ge_og__c ureq :uploadRequestList){
            uploadId.add(ureq.Id);
        }
        
        
        //MassCancelOpportunities_GE_OG.processLoggedInUser(uploadId);
        
        List<Attachment> at =[SELECT Id, IsDeleted, ParentId, Name,ContentType,Body,Parent.Name,OwnerId FROM Attachment where ParentId IN :uploadRequestList];  
        try{
            for(Attachment att : at){
                Blob attachmentBody = att.Body;   
                String csvfileContent= attachmentBody.toString();  
                csvfilelines = csvfileContent.split('\n');
                
                for (Integer i=1;i<csvfilelines.size();i++)
                {
                    String[] inputvalues = new String[]{};
                        inputvalues = csvfilelines[i].split(',');
                    String opportunityId = inputvalues[0];
                    String winlossComments = inputvalues[1];
                    Opportunity opp = new Opportunity();
                    opp.id = opportunityId;
                    opp.disposition_comments_ge_og__c = winlossComments;
                    opp.stage_ge_og__c = 'Cancelled';
                    opp.primary_reason_code_ge_og__c = 'Mass Cancellation';
                    //optyList.add(opp);
                    optyset.add(opp);  
                    
                    
                }
                System.debug('optyset  >>>> '+optyset);
                optyList.addAll(optyset);
                
                Database.SaveResult[]  SaveResultListOpty;
                
                if(!optyList.isEmpty()){
                    SaveResultListOpty = Database.update(optyList, false);
                    totalopty = totalopty + optyList.size();
                    for(integer i =0; i<optyList.size();i++){
                        String msg11='';
                        String msg22='';
                        If(!SaveResultListOpty[i].isSuccess()){
                            failIds.add(optyList.get(i).id);
                            msg11 += 'Error: "';        
                            for(Database.Error err: SaveResultListOpty[i].getErrors()){  
                                msg11 += err.getmessage()+'\n';
                                failedrecordsCsv =failedrecordsCsv+ optyList.get(i).id + ','+msg11;
                                failureOpportunitiesCount = failureOpportunitiesCount +1;
                            } 
                        }else{
                            successIds.add(optyList.get(i).id);
                            successOpportunitiesCount = successOpportunitiesCount +1;
                            msg22= 'SUCCESS: Updated!';
                            successrecordsCsv = successrecordsCsv + optyList.get(i).id+','+msg22+'\n';
                        }
                        if(msg11!='')
                            exception_List.add(msg11);
                        if(msg22!='')
                            success_List.add(msg22);
                    }       
                }
                if(failedrecordsCsv.equalsIgnoreCase('OpportunityId,Status\n')){
                    
                }else{
                    Attachment attachment = new Attachment();
                    attachment.Body = Blob.valueOf(failedrecordsCsv);
                    attachment.Name = 'Error_'+att.Parent.Name+'.csv';
                    attachment.ParentId = att.ParentId; 
                    insert attachment;
                }
                
                if(successrecordsCsv.equalsIgnoreCase('OpportunityId,Status\n')){
                }else{
                    Attachment attachment = new Attachment();
                    attachment.Body = Blob.valueOf(successrecordsCsv);
                    attachment.Name = 'Success_'+att.Parent.Name+'.csv';
                    attachment.ParentId = att.ParentId; 
                    insert attachment;
                } 
                Upload_Request_ge_og__c ur =new Upload_Request_ge_og__c();
                ur.Id = att.ParentId;
                ur.Status__c = 'Completed';
                ur.Success_Records__c = successOpportunitiesCount;
                ur.Error_Records__c = failureOpportunitiesCount;
                ur.Total_Records__c = totalopty;
                ur.Trigger_Upload_Request_ge_og__c = false;
                urlist.add(ur);
                
                
            }
        } 
        catch(Exception e){
            
            System.debug('exception occured >>> '+e.getCause());
            System.debug('exception error message >>> '+e.getMessage());
            System.debug('exception occured in Line number >>> '+e.getLineNumber());
            
            
        }
        finally {
            if(urlist.size()>0){
                Database.SaveResult[]  UploadRequestResultList;
                UploadRequestResultList = Database.update(urlist);
                MassCancelOpportunities_GE_OG.processLoggedInUser();
            }
        }
    }
    @future
    public static void processLoggedInUser()
    {   
        Id loggedInUser = UserInfo.getUserId();
        User u = new User();
        u.Id = loggedInUser;
        u.Disable_validations_for_MERGE__c = false;
        update u;
    }
}