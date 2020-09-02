public class GE_DS_EventSubmitForApproval
{
    Public static boolean reEntry = false;
    public void EventSubmitForApproval(List<SVMXC__SVMX_Event__c> lsevents){
    ID recdtypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('Digital Solutions Technician').getRecordTypeId();
    if(!GE_DS_EventSubmitForApproval.reEntry){
    GE_DS_EventSubmitForApproval.reEntry = True;
    List<SVMXC__SVMX_Event__c> lstevents=[select id,SVMXC__Technician__c,SVMXC__Technician__r.RecordTypeId,GE_DS_Dispatcher_Not_Home_Territory__c,GE_DS_Approval_Status__c from SVMXC__SVMX_Event__c where id in:lsevents and SVMXC__Technician__r.RecordTypeId=:recdtypeId];
    for(SVMXC__SVMX_Event__c SmEvent : lstevents)
    {
    if (SmEvent.GE_DS_Dispatcher_Not_Home_Territory__c == True && SmEvent.GE_DS_Approval_Status__c !='Approved' && SmEvent.GE_DS_Approval_Status__c!='Rejected') {
    //create the new approval request to submit
      Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
      req.setComments('Submitted for approval. Please approve.');
      req.setObjectId(SmEvent.Id);
    //submit the approval request for processing
      Approval.ProcessResult result = Approval.process(req);
    //display if the reqeust was successful
      System.debug('Submitted for approval successfully: '+result.isSuccess());
       }
     }
   }
  }   
}