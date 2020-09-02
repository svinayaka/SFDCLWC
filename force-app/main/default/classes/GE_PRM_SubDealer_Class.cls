public with sharing class GE_PRM_SubDealer_Class {
/**********
Class Name          : GE_PRM_SubDealer_Class 
Used Where ?        : This acts as Controller for GE_PRM_Channel_BranchOffice_sub page
Purpose/Overview    : for Subdealer details
Functional Area     : PRM
Author              : 
Created Date        : 
Test Class Name     : Test_GE_PRM_Channel_Appointment_Class
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
************/
    
    //** Variable declarations
    public String errorMessage {get;set;}
    public string schannelAppId;
    public Sub_Dealer__c branchOfficeObj {get; set;}
    private final Sub_Dealer__c branchOffice;
    //public Id userId;
   // public Id userprofileId;
   // public boolean bpartnerUser{get;set;}
   // public List<Profile> parnerprof = new List<Profile>();
    public string isnew_SB_from_URL;
   

    //** constructor
    public GE_PRM_SubDealer_Class(ApexPages.StandardController controller) 
    {      
        string sBranchId; 
        isnew_SB_from_URL = ApexPages.currentPage().getParameters().get('isNew');
        schannelAppId = ApexPages.currentPage().getParameters().get('ChannelAppointmentId');
        sBranchId = ApexPages.currentPage().getParameters().get('Id');
        this.branchOffice = (Sub_Dealer__c)controller.getRecord();  
        /* Start commented for PRM profile deletion R 22629
        userId= UserInfo.getUserId();  
        userprofileId = UserInfo.getProfileId();
        bpartnerUser=false;
        parnerprof = [Select Id from Profile where Name in ('Channel Partner DR/VAR/Reseller user','Channel Partner Leader user - DR','Channel Partner Leader user - SR','Channel Partner Sales Rep user')];
        for(Profile p : parnerprof)
        {
            if(p.id==userprofileId)
            {
                bpartnerUser=true; 
            }
        }  
        End R 22629
        */
        branchOfficeObj =   [select Id, GE_PRM_Unique_Id__c,GE_PRM_Affiliate_dependent_type__c,         
                             GE_PRM_Address_line_1__c,  
                             GE_PRM_Address_line_2__c,
                             GE_PRM_Authorized_commercial_lines__c,
                             GE_PRM_Channel_Appointment__c,
                             GE_PRM_City__c,
                             GE_PRM_City_of_registration__c,                 
                             GE_PRM_Country__c,
                             GE_PRM_Email__c,
                             GE_PRM_Legal_name__c,
                             GE_PRM_Mobile__c,
                             GE_PRM_Ownership__c,
                             GE_PRM_Phone__c,     
                             GE_PRM_Postal_code__c,
                             GE_PRM_Prinicipal_Conatct_Text__c
                             from Sub_Dealer__c where id=:sBranchId];
    }
    //** saving subdealer details
    public PageReference saveSubDealerDetails()
    { 
        Sub_Dealer__c newBO;
        String Cloneyes;
        
        Cloneyes = ApexPages.currentPage().getParameters().get('clone'); 
        // clicked on Commercial line Clone 
        if(Cloneyes !=null){            
            newBO = branchOfficeObj.clone(false,true);
            newBO.GE_PRM_Channel_Appointment__c=schannelAppId;        
            insert newBO;
            System.debug('new branchoffice'+newBO);            
        }
        errorMessage = '';
        try
        {
            update branchOffice;            
        }
        catch(Exception e)
        {   
              ApexPages.addMessages(e);
              errorMessage = 'Please Fill in Required Detail';
        }
        if(errorMessage.length() >1)
        {   
            
            return null;
        } 
        else
        {
            PageReference pageRef;
            pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_page1?Id='+schannelAppId+'#BranchOffice');
          
/* Start r22629
          if(bpartnerUser)
            {
                pageRef = new PageReference('/apex/GE_PRM_PartnerViewChannel_Appointment?Id='+schannelAppId+'&sfdc.override=1');
            }
                 End R-22629*/
            return pageRef;         
        }
    }
    //** method to redirect to channel appointment page
    public PageReference backToChApp()
    {
        PageReference updChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?Id='+schannelAppId);
        
     /* Start r22629
     if(bpartnerUser)
     {
            updChApp= new PageReference('/apex/GE_PRM_PartnerView_ChApp_page?Id='+schannelAppId+'&sfdc.override=1');
     }  
     End R-22629*/
        updChApp.setRedirect(True); 
        return updChApp;
    }
    public PageReference cancel() {
        PageReference pageRef;
        try{
            system.debug('true from url'+isnew_SB_from_URL  ); system.debug('before delete'+branchOffice);
            if(isnew_SB_from_URL == 'true'){
                delete branchOffice;
            }             
            system.debug('after delete'+branchOffice);
            pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?Id='+schannelAppId);
            return pageRef;
        }   
        catch(Exception e){
            system.debug('true from url'+isnew_SB_from_URL  ); system.debug('delete'+branchOffice);
            pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?Id='+schannelAppId);
            return pageRef;
        }
    }        
}