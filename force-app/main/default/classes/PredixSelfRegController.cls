Global class PredixSelfRegController{

    public PredixSelfRegController(ApexPages.StandardController controller) {
    
   objAccReq = new  Predix_Community_Access_Request__c();

    }
 public PredixSelfRegController()
 {
 
 objAccReq = new  Predix_Community_Access_Request__c();
 }
Global Predix_Community_Access_Request__c objAccReq {get;set;}



Global void PredixSelfRegController()
{}
 

Global void PredixSelfRegController(ApexPages.StandardController controller){
   objAccReq = new  Predix_Community_Access_Request__c();
}

public Pagereference submitRequest()
{
      
       objAccReq.GE_OG_Predix_Request_Status__c ='Submitted';
       try{
        insert objAccReq;
        }
         catch(Exception e)
                {
                    
              
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: We already have A Request with this Email ID, Please provide any other Email id to request for community access.');
            ApexPages.addMessage(myMsg);
            return null;
                    }
                    
        Approval.ProcessSubmitRequest req1 = 
        new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(objAccReq.id);
       
        // Submit the approval request for the Predix Request
        Approval.ProcessResult result = Approval.process(req1);
        
        // Verify the result
        System.assert(result.isSuccess());
        
        System.assertEquals(
            'Pending', result.getInstanceStatus(), 
            'Instance Status'+result.getInstanceStatus());
        
        return new Pagereference('/apex/Predix_Request_Confirmation_Page');
        }
      
public Pagereference cancel()
{  
      return new Pagereference('https://sandbox1-geog.cs9.force.com/Predix/login');
}
}