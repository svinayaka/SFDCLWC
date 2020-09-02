@isTest
public class COMM_Controller_UT {

	static testmethod void COMM_Controller_Test() {
	
		ApexPages.StandardController controller = new ApexPages.StandardController(new Account());
		COMM_Controller objCOMMController = new COMM_Controller(controller);
		objCOMMController.CreateActivity();
		objCOMMController.CreateServicePricebook();
		objCOMMController.CreateService();
		objCOMMController.CreateServiceCatalog();		
		objCOMMController.CreateWorkTemplate();
		objCOMMController.CreatePMPlanTemplate();		
	}
}