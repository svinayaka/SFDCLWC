/*    
Class Name        : Test_AccountRequestsearchController 
Purpose/Overview  : Test class for AccountRequestsearchController 
Author            : Chetan Vaidya
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : Old Releases  : Chetan Vaidya      : Created : Created for coveraga of the class
                  : 8th Sep 2011  : Jayadev Rath       : Updated to increase the coverage
*/
@isTest
Private Class Test_AccountRequestsearchController {
    Public Static testMethod void TestAccReqSrchCnt(){
        
        Account acc = new Account(name='Ramchejulalin',GE_HQ_Nts_Comments__c='Test');
        insert acc;
        Account_Request__c accReq = new Account_Request__c(GE_HQ_Account__c = acc.id, GE_HQ_Nts_Comments__c='Test1');
        insert accReq;
        Account_Request_Note__c arn = new Account_Request_Note__c();
        arn.Comments__c=acc.GE_HQ_Nts_Comments__c;
        insert arn;
        
        PageReference pageRef = Page.AccountRequestSearch;
        pageRef.getParameters().put('id',accReq.id); // Passing the account id as a parameter to the VF page
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController stdOppObj= new ApexPages.standardController(accReq);
        AccountRequestsearchController accReqCont = new AccountRequestsearchController(stdOppObj);
        accReqCont.Link1(); accReqCont.Link();
        // Setting the variables of the controller object
        accReqcont.str=accReq ;
        accReqcont.FromTest = True;
        AccountIntegrationWrapper.wsdlstatus = 'Failed';
        //accReqCont.ModifyAccReq.wsdlstatus = 'Failed';
       
      
        
        accReqCont.Submit();
       // accReqCont.ModifyAccReq.wsdlstatus = 'SUCCESS';
         AccountIntegrationWrapper.wsdlstatus = 'SUCCESS'; 
        
        accReqCont.Submit(); // Calling again to invoke the else conditions
        accReqCont.Cancel();
        
    }
}