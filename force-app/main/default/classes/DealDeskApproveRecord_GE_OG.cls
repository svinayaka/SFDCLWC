/*
Class/Trigger Name     : DealDeskApproveRecord_GE_OG
Used Where ?           : "Approve Deal Desk" button on Deal desk
Purpose/Overview       :  Used to approve deal desk record 
Scrum Team             :  DEAL MGMT - Transformation
Requirement Number     : R-23474
Author                 : Sanath Kumar Dheram
Created Date           : 23/OCT/2015
Test Class Name        : DealDeskApproveRecord_Test_GE_OG
Code Coverage          : 88
*/
global class DealDeskApproveRecord_GE_OG 
{ 
    // Method to approve Deal desk record
    @InvocableMethod(label='Approve Deal Desk' description='Approve deal desk record.')
    public static list<String> approveDealDesk(List<Id> dealDeskId)
    {
       
        List<String> successResult = new List<String>();
        successResult.add(approveDealDeskLogic(dealDeskId[0]));
        return successResult;
        
    }
    
    
     webservice static string approveDealDesk(String dealDeskId)
     {
        return approveDealDeskLogic(dealDeskId);
        
     }
     
     
     public static String approveDealDeskLogic(String dealDeskId){
         
         Deal_Desk_ge_og__c objDealDesk = [SELECT Id, status_ge_og__c, 
                                           //Commented for DOA Revamp
                                           //total_risk_checklist_reviewed_ge_og__c, 
                                           //total_risk_checklist_ge_og__c, 
                                            active_deal_desk_ge_og__c, approver_comments_ge_og__c
                                           // Commented for DOA Revamp
                                           //dd_max_deviation_ge_og__c
                                            //deal_desk_opportunity_id_ge_og__r.risk_checklist_submitted_ge_og__c
                                             FROM Deal_Desk_ge_og__c WHERE Id =: dealDeskId] ;
        if(!objDealDesk.active_deal_desk_ge_og__c){
             return 'Deal desk is Inactive. You can not submit it.';
        }
        
        
        if(objDealDesk.status_ge_og__c =='Approved'){
            return 'Deal desk already approved';
             
        }
        
        if(objDealDesk.status_ge_og__c == 'Submitted'){
            return 'Deal desk already submitted';
        }
         
        if(objDealDesk.approver_comments_ge_og__c == Null){
            return 'Please fill approver Comment before Submission';
        }
        
        try
        {
             objDealDesk.status_ge_og__c = 'Approved';
             update objDealDesk;
             return 'Deal desk record approved';
        }
        catch(Exception ex)
        {
             system.debug('-----Exception----->>>>>>>>'+ex);
             return 'Deal desk approval failed';
        }
     
     }
}