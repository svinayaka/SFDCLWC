public class PRM_CreateCloneDueDiligence {
    
    public static void createDDfromPrevious(List<PRM_Due_Diligence__c> DDlst){
        List<PRM_Due_Diligence__c> newddlst = new List<PRM_Due_Diligence__c>();
        for(PRM_Due_Diligence__c dd : DDlst){
           // PRM_Due_Diligence__c clonedd = dd.clone();
           PRM_Due_Diligence__c clonedd = new PRM_Due_Diligence__c();
            clonedd.CA_Commercial_Manager__c = dd.CA_Commercial_Manager__c;
            clonedd.CA_Primary_Sales_Manager__c = dd.CA_Primary_Sales_Manager__c;
           clonedd.PRM_Active__c = true;
          	clonedd.PRM_Channel_Appointment__c = dd.PRM_Channel_Appointment__c;
            clonedd.PRM_Submitted_By__c = Userinfo.getUserId();
            clonedd.PRM_Submitted_Date__c = Date.today();
            clonedd.PRM_Is_Government_Certification_uploaded__c = 'Yes';
            clonedd.PRM_Due_Diligence_Status__c = 'Not Started';
           // clonedd.prm_
          /**  clonedd.PRM_KYC_DD_Completed_Date__c = null;
            clonedd.PRM_Active__c = true;
            clonedd.PRM_Due_Diligence_Status__c = null;
            clonedd.PRM_Due_Diligence_Comments__c = null;
            clonedd.PRM_KYC_Reviewer__c = null;
            clonedd.PRM_Submitted_By__c = null;
            clonedd.PRM_Submitted_Date__c = null;
            clonedd.PRM_Adverse_flags_in_Director_DD__c = null;
            clonedd.PRM_Adverse_flags_in_Legal_Proceedings__c = null;
            clonedd.PRM_Adverse_Flags_in_Member_DD__c = null;
            clonedd.PRM_Branch_issue_identified__c = null;
            clonedd.PRM_Legal_Entity_Address_Validation__c = null;
            clonedd.PRM_Subsidiary_issue_identified__c = null;
            clonedd.PRM_Subsidiaries_Validation__c  =null;
            clonedd.PRM_Sub_agent_Sub_dealer_Validation__c = null;
            clonedd.PRM_Legal_Entity_Name_Validation__c = null;
            clonedd.PRM_Legal_Entity_Address_Validation__c = null;
            clonedd.PRM_Legal_Proceedings_Check__c = null;
            clonedd.PRM_Negative_News_Search_Complete_Date__c = null;
            clonedd.PRM_Positive_WatchList_Alerts__c = null; **/
            newddlst.add(clonedd);
        }
        
        if(newddlst != null){
            insert newddlst;
        }
        
        if(newddlst != null)
        new PRMDueDiligenceHandler_GE_OG().emailNotificationOnDDInsertNotStarted(newddlst);
    }
}