/*
Class/Trigger Name     :  RecallRecord_GE_OG
Used Where ?           : "Recall" button on Pre Bid/ Deal Desk/ Risk Checklist
Purpose/Overview       : Used to Recall Pre Bid/ Deal Desk/ Risk Checklist record for approval
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-24385
Author                 : Madhuri Sharma
Created Date           : 15/MAR/2016
Test Class Name        : PreBid_GE_OG_Test
Code Coverage          : 80
*/
global class RecallRecord_GE_OG 
{
    // Method to recall Pre Bid/ Deal Desk/ Risk Checklist record
    @InvocableMethod(label='Recall Pre Bid/ Deal Desk/ Risk Checklist' description='Recall Pre Bid/ Deal Desk/ Risk Checklist record.')
    public static list<String> recall(List<Id> recordId)
    {
    system.debug('***********Inside RecallRecord_GE_OG.recall*********');
        List<String> successResult = new List<String>();
        successResult.add(recallRecord(recordId[0]));
        return successResult;
    }
    
    public static String recallRecord(String recordId)
    {
    system.debug('---------------RecallRecord_GE_OG.recallRecord()'+recordId);  
        List<ProcessInstance> procInstList=new List<ProcessInstance>();
        //Added below to be called by process builder to Recall Deal Desk when Risk checklist is regenerated
        	System.debug('recordId value before oppty check' +recordId);
        	if(recordId.subString(0,3) == '006'){
        		system.debug('RecordId is OpportunityId');
       			Id ddID = [select id from Deal_Desk_ge_og__c where deal_desk_opportunity_id_ge_og__c=:recordId and active_deal_desk_ge_og__c = true and Status_ge_og__c='Submitted'].Id;
        		system.debug('recordId inside opptyLoop' +recordId);
            	if(ddID!=null){
            		system.debug('ddid value if it is not null ' +ddID);
                       procInstList = new List<ProcessInstance>([select Id from ProcessInstance where TargetObjectId =:ddID]);  
                       system.debug('--------------------procInstList size' +procInstList.size());       
              	}
        	}   
        //End added below to be called by process builder to Recall Deal Desk when Risk checklist is regenerated
        else{
            procInstList = new List<ProcessInstance>([select Id from ProcessInstance where TargetObjectId =:recordId ORDER BY CreatedDate desc]);
        }
        List<ProcessInstanceWorkitem>  workitem; 
        
        if ((procInstList != null) && (procInstList.size() > 0))
            workitem = new List<ProcessInstanceWorkitem>([select Id from ProcessInstanceWorkitem where ProcessInstanceId = :procInstList[0].id]);
            system.debug('--------------------------workitem size' +workitem.size());
        
        String message = '';
        
        if ((workitem != null) && (workitem.size() > 0))
        {
            
            try{
            system.debug('------------------------approval call-------------------------------------');
                Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
                appRequest.setComments('Recall request');
                appRequest.setAction('Removed');
                appRequest.setWorkitemId(workitem[0].Id);
                Approval.ProcessResult result;
                
                if(!test.isRunningtest())
                result =  Approval.process(appRequest); 
                
                system.debug('------Recall result------>>>>>>>'+result);
                return 'Recall Success';
            }
            catch(Exception e){
                system.debug('\n\n -----Recall Exception----->>>>>>>>'+e);
                return 'Recall Failed';
            }
            
        }   
        return message;
    }

}