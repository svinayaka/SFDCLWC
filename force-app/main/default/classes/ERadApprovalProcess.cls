/*
Class/Trigger Name     : ERadApprovalProcess 
Used For               : calling Approval process on Erad
Purpose/Overview       : On click of Button on Erad, this class is Called and Standard Approval Process works
Scrum Team             : Transformation - oppSS MGMT
Requirement Number     : R-23908
Author                 : Nitish Pandey
Created Date           : 28-Dec-2015
Test Class             : GE_OG_eRad_Creation_Test
test Coverage          : 
*/


Global class ERadApprovalProcess {
    
    
    webservice static String submitErad(Id eRadId) {

         List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest>();
         
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting request');
        req.setObjectId(eRadId);
        requests.add(req);
        List<Approval.ProcessResult> results; 
        
        if(!test.isRunningTest())
        results = Approval.process(requests);
        
        if(results != null && results[0].isSuccess())
            return 'Submitted SuccessFully';
         else
             return 'Submission Failed';
                
    }
}