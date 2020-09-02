@isTest
public class Test_Clone_Account_Planning_Controller {


    public static Account_Planning__c ac_plan = AccountTestDataFactory.createAccountPlanning('2050','Active');
    public static Key_Customer_Contacts__c test_kcc= AccountTestDataFactory.createKCC(ac_plan.id);
    public static Key_Project_ge_og__c test_proj= AccountTestDataFactory.createKeyProject(ac_plan.id);
    public static Key_Asset_ge_og__c test_asset= AccountTestDataFactory.createKeyAsset(ac_plan.id);
    public static Customer_Strategy_Map_item__c test_csmi= AccountTestDataFactory.createCSMI(ac_plan.id);
    public static Customer_Strategy_Map_Contacts__c test_csmi_contact= AccountTestDataFactory.createCSMI_contact(test_csmi.id);
    public static Customer_Strategy_Map_Users__c test_csmi_user= AccountTestDataFactory.createCSMI_user(test_csmi.id);

    public static Testmethod void clone_Accountplan(){
    //Clone_Account_Planning_Controller clonecontroller = new Clone_Account_Planning_Controller();
    string accountPlanId = ac_plan.id;
    Clone_Account_Planning_Controller.cloneParameters acp_param = new Clone_Account_Planning_Controller.cloneParameters();
        acp_param.Plan_status = 'Active';
        acp_param.Plan_year = '2040';
        acp_param.sourceId = accountPlanId;
        
    List<Clone_Account_Planning_Controller.cloneParameters> paramlist = new List<Clone_Account_Planning_Controller.cloneParameters>();
       paramlist.add(acp_param);
      //  try{
       Clone_Account_Planning_Controller.copyChildRecords(paramlist);
      //  }
      /*  catch(Exception e)
        {
            system.debug('------');
        }*/
        }
    
  /*  public static Testmethod void clone_Accountplan_errors(){
        string accountPlanId = ac_plan.id;
    Clone_Account_Planning_Controller.cloneParameters acp_param = new Clone_Account_Planning_Controller.cloneParameters();
        acp_param.Plan_status = 'Active';
        acp_param.Plan_year = '';
        acp_param.sourceId = accountPlanId;
        
    List<Clone_Account_Planning_Controller.cloneParameters> paramlist = new List<Clone_Account_Planning_Controller.cloneParameters>();
       paramlist.add(acp_param);
       
       Clone_Account_Planning_Controller.copyChildRecords(paramlist);
 
    }

*/    
}