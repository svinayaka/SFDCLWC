/*
Class/Trigger Name     : PreBidEvaluationTrigger_GE_OG
Purpose/Overview       : This trigger is called before delete of Pre_Bid_Evaluation_ge_og__c records
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23666
Author                 : Sanath Kumar Dheram
Created Date           : 29/OCT/2015
Test Class Name        :  
Code Coverage          : 
*/
trigger PreBidEvaluationTrigger_GE_OG on Pre_Bid_Evaluation_ge_og__c (before delete) 
{
    PreBidEvaluationHandler_GE_OG objHandler = new PreBidEvaluationHandler_GE_OG();
    
    if(trigger.isBefore)
    {
        if(trigger.isDelete)
        {
            objHandler.preventDeletionOfGERecord(trigger.old);
        }
    }
}