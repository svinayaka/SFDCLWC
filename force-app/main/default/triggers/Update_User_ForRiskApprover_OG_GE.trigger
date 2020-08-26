trigger Update_User_ForRiskApprover_OG_GE on Deal_Reviewer_ge_og__c(
  before insert, after insert, 
  before update, after update, 
  before delete, after delete) {
    Opportunity_Trigger_Controller_ge_og__c custmObj = Opportunity_Trigger_Controller_ge_og__c.getValues('Update_User_ForRiskApprover_OG_GE');
 
 if(custmObj !=null && custmObj.Is_Active_ge_og__c && custmObj.Object_ge_og__c=='Deal_Reviewer_ge_og__c')
 {
      
      
      if (Trigger.isBefore) {
        if (Trigger.isInsert) {
        
          // Call class logic here!
        } 
        if (Trigger.isUpdate) {
          // Call class logic here!
        }
        if (Trigger.isDelete) {
          // Call class logic here!
        }
      }

      if (Trigger.IsAfter) {
        // Insertion of Deal Reviewer 
        if (Trigger.isInsert) 
        {
              GE_OG_Risk_Approver_Helper.afterinsert(Trigger.new);
              
        } 
        
        // Update of Deal Reviewer 
        if (Trigger.isUpdate) 
        {
            GE_OG_Risk_Approver_Helper.afterUpdate(Trigger.new,Trigger.old, Trigger.oldMap); 
        }
        if (Trigger.isDelete) {
        
            GE_OG_Risk_Approver_Helper.afterDelete(Trigger.Old); 
          // Call class logic here!
        }
      }
    }
}