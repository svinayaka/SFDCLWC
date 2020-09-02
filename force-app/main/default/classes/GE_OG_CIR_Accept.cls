Global with sharing class GE_OG_CIR_Accept
{
    
    public String CaseId {get;set;}
    public String UserId {get;set;}
    public boolean isBlank_SubType{get;set;}
    public boolean isBlank_SubType1{get;set;}
    Public String CaseOwner = '';
    Public String redirectURL{get;set;}
    
    
    Public void ChangeOwnerName() 
    {
        CaseId = ApexPages.currentPage().getParameters().get('CaseId'); 
        Case currentCase = [select RecordTypeId,OwnerId,status,origin from case where id =:CaseId];
        if(currentCase.origin== null ||currentCase.origin== ''||(currentCase.origin!= null && currentCase.Origin !='OG_ECCR' && currentCase.Origin !='TMS NC System' && currentCase.Origin !='askDrilling System'))
        {
            CaseOwner = currentCase.OwnerId;
            Id CurrentUserId = UserInfo.getUserId();
            user u=[select id,profileid from user where id=: UserInfo.getUserId()];
            profile p = [select id,name from profile where id=:u.profileid];
            if(p.name=='GE_OG_Super User'&&currentCase.status=='New')
            {
                isBlank_SubType = false;
                isBlank_SubType1 = false;
                currentCase.Ownerid = UserInfo.getUserId();
                currentCase.status= 'Open';
                update currentCase;
                redirectURL = URL.getSalesforceBaseURL().toExternalForm() + '/' + CaseId;

            }
            else if(p.name=='GE_OG_Super User'&&currentCase.status!='New')
            {
                isBlank_SubType = false;
                isBlank_SubType1 = false;
                currentCase.Ownerid = UserInfo.getUserId();
              
                update currentCase;
                redirectURL = URL.getSalesforceBaseURL().toExternalForm() + '/' + CaseId;
            }
            else
            {
            if(CaseOwner.contains('00G'))
            {
                List<GroupMember> groups = [select Id from GroupMember where Group.Type = 'Queue' and GroupId =:CaseOwner and UserOrGroupId =:CurrentUserId ];
                if(groups.size()>0) 
                {
                    isBlank_SubType = false;
                    isBlank_SubType1 = false;
                    currentCase.Ownerid = UserInfo.getUserId();
                    currentCase.status= 'Open';
                    try
                    {
                        update currentCase;
                    }catch(Exception e)
                    {
                        currentCase.adderror(e);
                    }
                                             
                    
                    redirectURL = URL.getSalesforceBaseURL().toExternalForm() + '/' + CaseId;
                }
                else
                {
                    isBlank_SubType = true;
                    isBlank_SubType1 = false;
                    redirectURL = URL.getSalesforceBaseURL().toExternalForm() + '/' + CaseId;
                    
                }
            }           
            else
            {
                isBlank_SubType = true;
                isBlank_SubType1 = true;
                redirectURL = URL.getSalesforceBaseURL().toExternalForm() + '/' + CaseId;
            }      
                  
           } 
       }
    }
    
    
}