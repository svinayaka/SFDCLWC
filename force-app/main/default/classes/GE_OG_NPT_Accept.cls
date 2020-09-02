Global with sharing class GE_OG_NPT_Accept
{
    
    public String CaseId {get;set;}
    
    public Boolean isBlank_SubType  {get;set;}
    Public String CaseOwner = '';
    public Boolean ValidationException {get;set;}
    Public String redirectURL{get;set;}
    
    
    Public void ChangeOwnerName() 
    {
        CaseId = ApexPages.currentPage().getParameters().get('CaseId'); 
        Case currentCase = [select RecordTypeId,OwnerId,status,origin from case where id =:CaseId];
        try {
        if(currentCase.origin== null ||currentCase.origin== ''||(currentCase.origin!= null && currentCase.Origin !='OG_ECCR' && currentCase.Origin !='TMS NC System' && currentCase.Origin !='askDrilling System'))
        {
        CaseOwner = currentCase.OwnerId;
        Id CurrentUserId = UserInfo.getUserId();
        /*user u=[select id,profileid from user where id=: UserInfo.getUserId()];
        profile p = [select id,name from profile where id=:u.profileid];
        if(p.name=='GE_OG_Super User'&&currentCase.status=='New')
        {
         isBlank_SubType = false;
        currentCase.Ownerid = UserInfo.getUserId();
        currentCase.status= 'Open';
         update currentCase;
           redirectURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + CaseId;
        }
       else if(p.name=='GE_OG_Super User'&&currentCase.status!='New')
       {
       isBlank_SubType = false;
        currentCase.Ownerid = UserInfo.getUserId();
      
         update currentCase;
           redirectURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + CaseId;
       }
        else
        {*/
        if(CaseOwner.contains('00G')){
            List<GroupMember> groups = [select Id from GroupMember where Group.Type = 'Queue' and GroupId =:CaseOwner and UserOrGroupId =:CurrentUserId ];
            if(groups.size()>0) {
               isBlank_SubType = false;
                currentCase.Ownerid = UserInfo.getUserId();
                if(currentCase.status == 'New')
                {                 currentCase.status= 'Open'; }
                update currentCase;
                redirectURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + CaseId;
            }
            else{
                isBlank_SubType = True;
                redirectURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + CaseId;
                
            }
        }  
        else{
             currentCase.Ownerid = UserInfo.getUserId();
                
                isBlank_SubType = false;
               if(currentCase.status == 'New')
                {                 currentCase.status= 'Open'; }
                update currentCase;
            redirectURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + CaseId;
        }      
              
      
       }
        }
        catch(exception e)
        {
                                    ValidationException = true;
                                    //currentCase.adderror(e.getMessage());
                                    system.debug('NPT Teting-----------'+e.getMessage());
                                    redirectURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + CaseId;
                    }
                   
        
    }
    
    
}