/*    
Class Name        :GE_ContractAddContentController
Purpose/Overview  :To restrict the user to add content to the Contract who doesnt have access to that
Author            : 
Created Date      :03-Feb-2014
Test Class        : 
*/

global class GE_ContractAddContentController
{
    public GE_ContractAddContentController(ApexPages.StandardController controller) 
    {
     }
    Webservice static boolean Originalpage(ID contractId)
    {
        integer i=0;
        boolean showMessage;
        String FName=UserInfo.getFirstName();
        String LName=UserInfo.getLastName();
        String Name=FName+' '+LName;
         list<PermissionSet> PSName;
         list<PermissionSetAssignment> psaName;
         psaName=[Select PermissionSet.Id from PermissionSetAssignment where Assignee.Name=:Name];
         PSName=[Select Id,Name, IsOwnedByProfile, Profile.Name, Label from PermissionSet where Name IN ('GE_OG_FA_Manager','PRM_Contractual_Team','GE_Super_PRM_Contractual_Team')];
         for(PermissionSetAssignment psa1Name:psaName)
         {
          for(PermissionSet pName:PSName)
           {
             if(pname.id==psa1Name.PermissionSet.Id){
              i=1;
             }            
           }
         }
         if(i==1)
         {
            showMessage = true;
         }
         else
         {
           showMessage=false;
         }
         return showMessage;
       
  }
}