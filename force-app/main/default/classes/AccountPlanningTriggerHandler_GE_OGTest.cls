/*
Class/Trigger Name     : AccountPlanningTriggerHandler_GE_OGTest 
Purpose/Overview       : Test Class to calculate the code coverage for the AccountPlanningTriggerHandler_GE_OG class
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : 
Author                 : Sonali Rathore
Created Date           : 22-MAR-2018

*/
@isTest 
public class AccountPlanningTriggerHandler_GE_OGTest 
{
    static testMethod void testMethod1() 
    {
    
    AccountPlanningTriggerHandler_GE_OG accplan = new AccountPlanningTriggerHandler_GE_OG();
    List<Account_Planning__c> accPlannew = new List<Account_Planning__c> ();
 
    Account_Planning__c testAccPlanning = new Account_Planning__c();
    testAccPlanning.Name='TestPlan Account' ;
    accPlannew.add(testAccPlanning);
    
    Account_Planning__c testAccPlanning2 = new Account_Planning__c();
    testAccPlanning2.Name='TestPlan Account 2' ;
    accPlannew.add(testAccPlanning2);
    
   // Product_Line_Assessment_Tier_2_ge_og__c platier2new=new Product_Line_Assessment_Tier_2_ge_og__c();
    //platier2new.Account_Planning_ge_og__c=testAccPlanning.id;
    //insert platier2new;
    
    Test.StartTest(); 
    accplan.plaTierUpdateFunctionality(accPlannew);   
    Test.StopTest();
    }
}