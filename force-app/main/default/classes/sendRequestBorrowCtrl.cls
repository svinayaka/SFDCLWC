public class sendRequestBorrowCtrl {

     public Id recId{get;set;}
   
    // public PageReference pr{get;set;}
    public ApexPages.StandardController ctrl;
   
    public String radioValue {get; set;}
   // public FX5__Job__c jox;
    public FX5__Crew_Planning__c obs{ get;set;}
    // public FX5__Crew_Planning__c obcps{ get;set;}
    
    
    
    
    /* for site updte */
     
      public sendRequestBorrowCtrl(ApexPages.StandardController controller) {
        ctrl = controller;
       
        
        recId = ApexPages.CurrentPage().getParameters().get('jobid');
      
        this.obs = [SELECT id,Name ,SD_Reason_of_Rejection__c, FX5__Job__c, SD_Comments__c,
        SD_Approver_s_Initials__c,SD_Approver_s_Response__c,SD_Send_request_to_borrow__c,
                        SD_If_Approver_s_Response_is_no_why__c, 
                      FX5__Job__r.SD_Job_Summary_New__c,FX5__Job__r.SD_Job_Summary__c, SD_Confirmed_by_FSE__c, SD_Crew_Member__c,BaseURL__c,
                       FX5__Job__r.name,
                      FX5__Planned_End_Date__c,FX5__Planned_Start_Date__c
                     FROM FX5__Crew_Planning__c WHERE Id =: recId];
        //System.debug('job id is' + cps.id);
          
          
          
    }

    
     public pageReference doSubmit()
    {
       String response;
       if(radioValue=='0'){
       response='Yes';
       
       }
       else{ 
       response='No'; 
       
       }
        obs.SD_Approver_s_Response__c = response;
         
       update obs;
       
        PageReference pageRef = Page.SendRequestThanks;
        pageRef.setRedirect(true);
         
        return pageRef ;
    }
    
   // end of code 
    
    

}