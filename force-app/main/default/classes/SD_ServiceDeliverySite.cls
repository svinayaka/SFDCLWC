public class SD_ServiceDeliverySite {

    // public FX5__Crew_Planning__c pos{get;set;}
    public Id recId{get;set;}
    
    // public PageReference pr{get;set;}
    public ApexPages.StandardController ctrl;
    public ApexPages.StandardController ctrl1;
    public String radioValue {get; set;}
    // public String chkValue {get; set;}
    // public Boolean chkcheck { get; set; }
    public Boolean option {get;set;}
    public Boolean bool {get;set;}
    

   // public FX5__Job__c jox;
    public FX5__Crew_Planning__c obcps { get;set; }
    
    /* for site updte */
     
      public SD_ServiceDeliverySite(ApexPages.StandardController controller) {
      bool = false;

        ctrl = controller;
        ctrl1=controller;
        
        recId = ApexPages.CurrentPage().getParameters().get('crId');
        // recId2 = ApexPages.CurrentPage().getParameters().get('crId1');
        this.obcps = [SELECT id,Name ,SD_Reason_of_Rejection__c, FX5__Job__r.id,FX5__Job__r.Name,SD_Comments__c,
                      FX5__Job__r.SD_Job_Summary_New__c,FX5__Job__r.SD_Job_Summary__c, SD_Confirmed_by_FSE__c
                       FROM FX5__Crew_Planning__c WHERE Id =: recId];
        //System.debug('job id is' + cps.id);
          
          
          
    }

    
     public pageReference saveResponse()
    {
       String response;
       if(radioValue=='0'){
       response='Yes';
       obcps.SD_Confirmed_by_FSE__c = true;
       obcps.SD_Reason_of_Rejection__c=' ';
       }
       else{
       response='No';
       obcps.SD_Confirmed_by_FSE__c = false;
       }
        obcps.SD_Accept__c = response;
        
        //This job was rejected for the following reason:
        
   
        
        if(obcps.SD_Comments__c ==null || obcps.SD_Comments__c =='')
        {
          obcps.SD_Comments__c= ' This job was rejected for the following reason:  '+obcps.SD_Reason_of_Rejection__c;
        }
        else
        {
         
        obcps.SD_Comments__c = obcps.SD_Comments__c +' '+ '\n'+' This job was rejected for the following reason:  '+obcps.SD_Reason_of_Rejection__c;
        }
         // obcps.SD_Confirmed_by_FSE__c = true;
       update obcps;
       
        PageReference pageRef = Page.ServiceDeliverySitePageThanks;
        pageRef.setRedirect(true);
         
        return pageRef ;
    }
    
   // end of code 
   //for show/Hide 
    public void change()
    {
        if(option == true)
        {
            bool = true;
        }
        else
        {
            bool = false;
        }
    }
    
}