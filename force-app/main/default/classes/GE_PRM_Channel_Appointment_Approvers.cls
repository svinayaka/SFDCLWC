public class GE_PRM_Channel_Appointment_Approvers
{
    
    String ChAFAApprovalId ;    
    public Id userId;
    public Boolean isApprover{get;set;}
    public String currentUserId{get;set;}
    GE_PRM_Channel_Appointment__c ChannelAppointment;
    GE_PRM_Channel_Appointment_Approver__c ChannelAppointmentApprover;
    List<PermissionSetAssignment> pSet = new List<PermissionSetAssignment>();
    Boolean isChannelMgr;
    Boolean isMaster;
    
    public GE_PRM_Channel_Appointment_Approvers(ApexPages.StandardController controller) 
    {
   
        userId=UserInfo.getUserId();
        String CAId = ApexPages.currentPage().getParameters().get('retURL');
        ChAFAApprovalId = ApexPages.currentPage().getParameters().get('Id');  
        currentUserId = UserInfo.getUserId();    


    } 
  
   
    public PageReference redirectChAppApproval()
    {
        
        PageReference pageRef; 
        boolean isPermissionAssign = false; 
        list<permissionset> lstPerm = new list<permissionset>([select id from permissionset where name='GE_PRM_Delegate_Approvers' limit 1]);
        system.debug('lstPerm ==='+lstPerm );
        if(lstPerm.size()>0)
        {
            for(PermissionSetAssignment objPSA :[select id from PermissionSetAssignment where AssigneeId=:userid and PermissionSetId =:lstPerm[0].id])
            {
                system.debug('came here===');
                isPermissionAssign = true;
            }
        }
       

        if(ChAFAApprovalId != null)
            ChannelAppointmentApprover= [Select id, GE_PRM_Delegated_User__c, GE_PRM_Approvers__c, GE_PRM_Channel_Appointment__c,GE_PRM_Channel_Appointment__r.ownerid,GE_PRM_Status__c from GE_PRM_Channel_Appointment_Approver__c where id=: ChAFAApprovalId];
        
        if(ChannelAppointmentApprover!= null)    
            ChannelAppointment= [select id, name,GE_PRM_Current_Status__c from GE_PRM_Channel_Appointment__c where id=: ChannelAppointmentApprover.GE_PRM_Channel_Appointment__c];
           if( isPermissionAssign == true)
           {
                isApprover=true;
              
               pageRef = new PageReference('/'+ChAFAApprovalId +'/e?nooverride=1&retURL=%2F'+ChannelAppointmentApprover.GE_PRM_Channel_Appointment__c);
               system.debug(pageRef);
               pageRef.setRedirect(true);
               return pageRef;
           }
           if(userid != ChannelAppointmentApprover.GE_PRM_Approvers__c&& userid != ChannelAppointmentApprover.GE_PRM_Delegated_User__c && userid != ChannelAppointmentApprover.GE_PRM_Channel_Appointment__r.ownerid)
           {
               
               isApprover=false;
               ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'You do not have necessary privileges to edit the ChannelAppointment Approval.');
               ApexPages.addMessage(myMsg); 
               
               return null;
           }
           else if(ChannelAppointmentApprover.GE_PRM_Status__c == 'Approved' || ChannelAppointment.GE_PRM_Current_Status__c == 'Rejected')
           {
              
               string str = ChannelAppointmentApprover.GE_PRM_Status__c == 'Approved' ? 'Cannot edit since the record has already been approved.' : 'Cannot Edit since the ChannelAppointment is rejected.';
               isApprover=false;
               ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, str);
               ApexPages.addMessage(myMsg); 
               
               return null;
           }
           else if((userid == ChannelAppointmentApprover.GE_PRM_Channel_Appointment__r.ownerid && ChannelAppointmentApprover.GE_PRM_Status__c == 'Need More Info') ||  (userid == ChannelAppointmentApprover.GE_PRM_Approvers__c) || ( userid == ChannelAppointmentApprover.GE_PRM_Delegated_User__c))
           {
              
               isApprover=true;
              
             pageRef = new PageReference('/'+ChAFAApprovalId +'/e?nooverride=1&retURL=%2F'+ChannelAppointmentApprover.GE_PRM_Channel_Appointment__c);
               system.debug(pageRef);
               pageRef.setRedirect(true);
               return pageRef;
           }
           
           else{
           
           isApprover=false;
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'You do not have necessary privileges to edit the ChannelAppointment Approval.');
           ApexPages.addMessage(myMsg); 
           return null;
           } 
              
        }  
  
     public PageReference goBack()
     {
       PageReference back= new PageReference('/' +ChannelAppointmentApprover.GE_PRM_Channel_Appointment__c);
       back.setRedirect(true);
       return back;
     }
}